DROP PROCEDURE if exists kmeans;
DELIMITER //
CREATE PROCEDURE kmeans(IN k int)

BEGIN
    DROP TEMPORARY TABLE if exists `centroid`;
    CREATE TEMPORARY TABLE `centroid`
    (
        id        int PRIMARY KEY AUTO_INCREMENT,
        latitude  float,
        longitude float
    );
    INSERT INTO `centroid` (latitude, longitude)
    SELECT cams.latitude, cams.longitude
    FROM cams
    ORDER BY RAND()
    LIMIT k;

    DROP TEMPORARY TABLE if exists `temp_points`;
    CREATE TEMPORARY TABLE temp_points
    (
        p_id int,
        c_id int,
        dist float
    );
    DROP TEMPORARY TABLE if exists centroid_clone;

    points:
    while true
        DO
            CREATE TEMPORARY TABLE if not exists centroid_clone
            (
                id        int PRIMARY KEY AUTO_INCREMENT,
                latitude  float,
                longitude float
            );
            if (EXISTS(SELECT c1.id
                       FROM centroid as c1
                       WHERE (longitude, latitude) in
                             (SELECT c2.longitude, c2.latitude FROM centroid_clone as c2 WHERE c1.id = c2.id)))
            THEN
                leave points;
            else
                DELETE
                FROM centroid_clone
                WHERE true;
            end if;
            DROP TEMPORARY TABLE if exists temp_points;
            CREATE TEMPORARY TABLE if not exists temp_points
            (
                p_id int,
                c_id int,
                dist float
            );
            ALTER TABLE temp_points
                add PRIMARY KEY (p_id, c_id);
#         Заполнение точек
            INSERT INTO temp_points (p_id, c_id, dist)
            SELECT cams.id, c.id, sqrt(pow(cams.latitude - c.latitude, 2) + pow(cams.longitude - c.longitude, 2))
            FROM cams,
                 centroid as c;

            DROP TEMPORARY TABLE IF EXISTS temp_points_clone;
            CREATE TEMPORARY TABLE temp_points_clone
            SELECT * FROM temp_points;

            CREATE INDEX p_id_index on temp_points (p_id);
            CREATE INDEX p_id_index on temp_points_clone (p_id);

            UPDATE centroid JOIN (SELECT
                                    ROUND(AVG(cams.longitude), 4) as longit,
                                    ROUND(AVG(cams.latitude), 4) as latit,
                                     temp_points.c_id as c_id_n
                              FROM temp_points
                              JOIN cams ON cams.id = temp_points.p_id
                              WHERE dist = (SELECT MIN(dist) as min
                                            FROM temp_points_clone
                                            WHERE temp_points.p_id = temp_points_clone.p_id
                                            GROUP BY p_id)
                              GROUP BY temp_points.c_id) as f ON (f.c_id_n = centroid.id)
            SET centroid.longitude = longit,
                centroid.latitude  = latit
            WHERE centroid.id = f.c_id_n;

            DROP TEMPORARY TABLE if exists temp_points_clone;

            DROP INDEX p_id_index on temp_points;

            DELETE FROM centroid_clone WHERE true;
            INSERT INTO centroid_clone (latitude, longitude)
            SELECT latitude, longitude
            FROM centroid;


        end while;
    CREATE TEMPORARY TABLE temp_points_clone
    SELECT * FROM temp_points;

    CREATE INDEX p_id_ind ON temp_points_clone (p_id);
    #     SELECT cams.id, cams.latitude, cams.longitude, c_id
#     FROM temp_points
#              JOIN cams ON p_id = cams.id
#     WHERE (dist) in (SELECT MIN(temp_points_clone.dist) as min_dist
#                      FROM temp_points_clone
#                      WHERE temp_points.p_id = temp_points_clone.p_id
#                      GROUP BY p_id);
    UPDATE cams join temp_points ON p_id = cams.id
    SET cluster = c_id
    WHERE (dist) = (SELECT MIN(temp_points_clone.dist) as min_dist
                     FROM temp_points_clone
                     WHERE temp_points.p_id = temp_points_clone.p_id
                     GROUP BY p_id);


    #     SELECT c_id, COUNT(*) FROM temp_points JOIN cams ON p_id = cams.id
#     WHERE (dist) in (SELECT MIN(temp_points_clone.dist) as min_dist FROM temp_points_clone WHERE temp_points.p_id = temp_points_clone.p_id GROUP BY p_id)
#     GROUP BY c_id;
    DROP INDEX p_id_ind on temp_points_clone;

END//

CALL kmeans(5);

create definer = user@`%` trigger block_userDevice
	after insert
	on command_table
	for each row
	BEGIN
    IF (NOT EXISTS(SELECT *
                   FROM blocked_user
                   WHERE NEW.DEVICE_ID = blocked_user.device_id
                     and NEW.user_id = blocked_user.user_id
                     and NOW() < end_blocked)) THEN

        IF ((SELECT COUNT(*) as count
             FROM command_table
             WHERE MINUTE(TIMEDIFF(NOW(), DATE_TIME)) < 1
               and NEW.user_id = command_table.user_id) > 15) THEN
            INSERT INTO blocked_user (user_id, device_id)
            VALUES (NEW.user_id, NEW.DEVICE_ID);
        END IF;
    END IF;
end;

create definer = user@`%` trigger block_device
	after insert
	on history_deviceaction
	for each row
	BEGIN
    IF (NOT EXISTS(SELECT *
                   FROM blocked_device
                   WHERE NEW.DEVICE_ID = blocked_device.device_id
                     and NOW() < end_blocked)) THEN

        IF ((SELECT COUNT(*) as count
             FROM history_deviceAction
             WHERE MINUTE(TIMEDIFF(NOW(), datetime)) < 1) > 15) THEN
            INSERT INTO blocked_device (device_id)
            VALUES (NEW.DEVICE_ID);
        END IF;
    END IF;
end;

create definer = user@`%` trigger logs_out_stateINSERT
	after insert
	on out_state_table
	for each row
	BEGIN
    CALL logs_device(NEW.DEVICE_ID, 'OUT_STATE', NEW.OUT_STATE);
end;

create definer = user@`%` trigger logs_out_stateUpdate
	after update
	on out_state_table
	for each row
	BEGIN
    CALL logs_device(NEW.DEVICE_ID, 'OUT_STATE', NEW.OUT_STATE);
end;

create definer = user@`%` trigger logs_temperatureInsert
	after insert
	on temperature_table
	for each row
	BEGIN
    CALL logs_device(NEW.DEVICE_ID, 'TEMPERATURE', NEW.TEMPERATURE);
end;

create definer = user@`%` trigger logs_temperatureUpdate
	after update
	on temperature_table
	for each row
	BEGIN
    CALL logs_device(NEW.DEVICE_ID, 'TEMPERATURE', NEW.TEMPERATURE);
end;

















create definer = user@`%` procedure logs_device(IN device_id int, IN type varchar(100), IN value int)
begin
    INSERT INTO history_deviceAction (device_id, type, value) VALUES
                                                           (device_id, type, value);
end;

create definer = user@`%` procedure returnHistory(IN device_id int, IN user_id int)
BEGIN
    (SELECT 'COMMAND' as type,COMMAND as value, DATE_TIME as dateTime, user_id as user, name as userName FROM command_table JOIN users USING (user_id)
    WHERE command_table.DEVICE_ID = device_id and users.user_id = user_id
    ORDER BY DATE_TIME DESC, ID DESC);

end;


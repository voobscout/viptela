-- Add User

-- Create connection
INSERT INTO guacamole_connection (connection_name, protocol) VALUES ('test', 'vnc');
SET @id = LAST_INSERT_ID();

-- Add parameters
INSERT INTO guacamole_connection_parameter VALUES (@id, 'hostname', 'localhost');
INSERT INTO guacamole_connection_parameter VALUES (@id, 'port', '5901');

CREATE USER 'dashboard'@'localhost' IDENTIFIED BY 'dashboard';
CREATE USER 'dashboard'@'%' IDENTIFIED BY 'dashboard';

GRANT ALL PRIVILEGES ON dashboard . * TO 'dashboard'@'localhost';
GRANT ALL PRIVILEGES ON dashboard . * TO 'dashboard'@'%';
FLUSH PRIVILEGES;
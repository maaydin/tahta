CREATE USER 'dashboard'@'%' IDENTIFIED BY 'dashboard';

GRANT ALL PRIVILEGES ON dashboard . * TO 'dashboard'@'%';
FLUSH PRIVILEGES;
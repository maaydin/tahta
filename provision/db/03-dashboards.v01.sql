USE dashboard;

DROP TABLE IF EXISTS dashboards;

CREATE TABLE dashboards
(
   id int NOT NULL AUTO_INCREMENT,
   name varchar(16) NOT NULL,
   title varchar(128) NOT NULL,
   PRIMARY KEY (id)
);

INSERT INTO dashboards VALUES(1,'demo','Demo Dashboard');

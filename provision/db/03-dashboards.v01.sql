USE dashboard;

DROP TABLE IF EXISTS dashboards;

CREATE TABLE dashboards
(
   DASHBOARD_ID int NOT NULL AUTO_INCREMENT,
   NAME varchar(16) NOT NULL,
   TITLE varchar(128) NOT NULL,
   PRIMARY KEY (DASHBOARD_ID)
);

INSERT INTO dashboards VALUES(1,'demo','Demo Dashboard');

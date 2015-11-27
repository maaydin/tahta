USE dashboard;

DROP TABLE IF EXISTS widgets;

CREATE TABLE widgets
(
   WIDGET_ID int NOT NULL AUTO_INCREMENT,
   DASHBOARD_ID int NOT NULL,
   TITLE varchar(128) NOT NULL,
   TYPE varchar(16) NOT NULL,
   CONFIG varchar(2048),
   PRIMARY KEY (WIDGET_ID)
);

INSERT INTO widgets VALUES(1, 1, 'CPU', 'status', '{"x": "1", "y": "1", "query" : "service =~ \\"cpu%\\""}');
INSERT INTO widgets VALUES(2, 1, 'Memory', 'status', '{"x": "2", "y": "2", "query" : "service =~ \\"cpu%\\""}');
INSERT INTO widgets VALUES(3, 1, 'Load', 'status', '{"x": "3", "y": "3", "query" : "service =~ \\"load%\\""}');
INSERT INTO widgets VALUES(4, 1, 'Apache Health', 'status', '{"x": "2", "y": "2", "query" : "service =~ \\"httpd health%\\""}');
INSERT INTO widgets VALUES(5, 1, 'Nginx Health', 'status', '{"x": "1", "y": "1", "query" : "service =~ \\"nginx health%\\""}');
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

INSERT INTO widgets VALUES(1, 1, 'Status Widget 1', 'status', '{"x": "1", "y": 1, "query" : "tagged like \"status\""}');
INSERT INTO widgets VALUES(2, 1, 'Status Widget 2', 'status', '{"x": "2", "y": 2, "query" : "tagged like \"status\""}');
INSERT INTO widgets VALUES(3, 1, 'Status Widget 3', 'status', '{"x": "3", "y": 3, "query" : "tagged like \"status\""}');
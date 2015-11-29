USE dashboard;

DROP TABLE IF EXISTS widgets;

CREATE TABLE widgets
(
   id int NOT NULL AUTO_INCREMENT,
   dashboard_id int NOT NULL,
   `index` int NOT NULL,
   colspan int NOT NULL,
   rowspan int NOT NULL,
   title varchar(128) NOT NULL,
   widget_type varchar(16) NOT NULL,
   instant_data_provider_id int,
   instant_data_query varchar(512),
   persistent_data_provider_id int,
   persistent_data_query varchar(1024),
   config varchar(2048),
   PRIMARY KEY (id)
);

INSERT INTO widgets VALUES(1, 1, 0, 1, 1, 'CPU', 'StatusWidget', 1, 'service =~ \"cpu%\"', 1, '',  '{}');
INSERT INTO widgets VALUES(2, 1, 1, 2, 2, 'Memory', 'StatusWidget', 1, 'service =~ \"memory%\"', 1, '',  '{}');
INSERT INTO widgets VALUES(3, 1, 2, 3, 3, 'Load', 'StatusWidget', 1, 'service =~ \"load%\"', 1, '',  '{}');
INSERT INTO widgets VALUES(4, 1, 3, 2, 2, 'Apache Health', 'StatusWidget', 1, 'service =~ \"httpd health%\"', 1, '',  '{}');
INSERT INTO widgets VALUES(5, 1, 4, 1, 1, 'Nginx Health', 'StatusWidget', 1, 'service =~ \"nginx health%\"', 1, '',  '{}');
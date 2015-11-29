USE dashboard;

DROP TABLE IF EXISTS persistent_data_providers;

CREATE TABLE persistent_data_providers
(
   id int NOT NULL AUTO_INCREMENT,
   name varchar(128) NOT NULL,
   adapter varchar(16) NOT NULL,
   `host` varchar(512) NOT NULL,
   port int,
   username varchar(16),
   `password` varchar(16),
   `database` varchar(16),
   query_statement varchar(1024),
   PRIMARY KEY (id)
);

INSERT INTO persistent_data_providers VALUES(1, 'MySQL', 'MySQL', 'localhost', 3306, 'dashboard', 'dashboard', 'dashboard' , 'SELECT * FROM events WHERE tags like ?');
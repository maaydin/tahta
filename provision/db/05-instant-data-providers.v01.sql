USE dashboard;

DROP TABLE IF EXISTS instant_data_providers;

CREATE TABLE instant_data_providers
(
   id int NOT NULL AUTO_INCREMENT,
   name varchar(128) NOT NULL,
   adapter varchar(16) NOT NULL,
   connection_string varchar(512),
   PRIMARY KEY (id)
);

INSERT INTO instant_data_providers VALUES(1, 'Riemann', 'Riemann', 'ws://localhost:5556/index?subscribe=true&query=');
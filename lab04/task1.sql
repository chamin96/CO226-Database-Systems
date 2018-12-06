SHOW DATABASES;
CREATE DATABASE E15154lab04;
USE E15154lab04;

CREATE TABLE MOVIE(
	movie_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    released INT,
    director VARCHAR(30)
    );
    
ALTER TABLE MOVIE AUTO_INCREMENT=101;

INSERT INTO MOVIE (title,released,director)
	VALUES ("Gone with the Wind",1939,"Victor Fleming");
INSERT INTO MOVIE (title,released,director)
	VALUES ("Star Wars",1977,"George Lucas");
INSERT INTO MOVIE (title,released,director)
	VALUES ("The Sound of Music",1965,"Robert Wise");
INSERT INTO MOVIE (title,released,director)
	VALUES ("E.T.",1982,"Steven Spielberg");
INSERT INTO MOVIE (title,released,director)
	VALUES ("Titanic",1997,"James Cameron");
INSERT INTO MOVIE (title,released)
	VALUES ("Snow White",1937);
INSERT INTO MOVIE (title,released,director)
	VALUES ("Avatar",2009,"James Cameron");
INSERT INTO MOVIE (title,released,director)
	VALUES ("Raiders of the Lost Ark",1981,"Steven Spielberg");

SELECT * FROM MOVIE;

CREATE TABLE REVIEWER(
	rev_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rev_name VARCHAR(50)
    );

ALTER TABLE REVIEWER AUTO_INCREMENT=201;

INSERT INTO REVIEWER (rev_name)
	VALUES ("Sarah Martinez");
INSERT INTO REVIEWER (rev_name)
	VALUES ("Daniel Lewis");
INSERT INTO REVIEWER (rev_name)
	VALUES ("Britanny Harris");
INSERT INTO REVIEWER (rev_name)
	VALUES ("Mike Anderson");
INSERT INTO REVIEWER (rev_name)
	VALUES ("Chris Jackon");
INSERT INTO REVIEWER (rev_name)
	VALUES ("Elizabeth Thomas");
INSERT INTO REVIEWER (rev_name)
	VALUES ("James Cameron");
INSERT INTO REVIEWER (rev_name)
	VALUES ("Ashley White");


SELECT * FROM REVIEWER;

CREATE TABLE RATING(
	rev_id INT,
    movie_id INT,
    stars INT,
    rating_date DATE
    );


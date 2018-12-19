#task 01
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

INSERT INTO RATING VALUES (201,101,2,'2011-01-22');
INSERT INTO RATING VALUES (201,101,4,'2011-01-27');
INSERT INTO RATING VALUES (202,106,4,NULL);
INSERT INTO RATING VALUES (203,103,2,'2011-01-20');
INSERT INTO RATING VALUES (203,108,4,'2011-01-12');
INSERT INTO RATING VALUES (203,108,2,'2011-01-30');
INSERT INTO RATING VALUES (204,101,3,'2011-01-09');
INSERT INTO RATING VALUES (205,103,3,'2011-01-27');
INSERT INTO RATING VALUES (205,104,2,'2011-01-22');
INSERT INTO RATING VALUES (205,108,4,NULL);
INSERT INTO RATING VALUES (206,107,3,'2011-01-15');
INSERT INTO RATING VALUES (206,106,5,'2011-01-19');
INSERT INTO RATING VALUES (207,107,5,'2011-01-20');
INSERT INTO RATING VALUES (208,104,3,'2011-01-02');

SELECT * FROM RATING;

ALTER TABLE RATING
ADD FOREIGN KEY(movie_id)
REFERENCES MOVIE(movie_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE RATING
ADD FOREIGN KEY(rev_id)
REFERENCES REVIEWER(rev_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

#task02
#01
SELECT * FROM MOVIE;

#02
SELECT * FROM MOVIE WHERE director="James Cameron";

#03
SELECT * FROM MOVIE WHERE director="James Cameron" AND released>=2000;

#04
SELECT stars FROM RATING;

#05
SELECT DISTINCT stars FROM RATING;

#06
SELECT movie_id,director FROM MOVIE;

#07
SELECT movie_id,title,released FROM MOVIE WHERE director="Steven Spielberg";

#08
SELECT * FROM MOVIE CROSS JOIN RATING;

#09
SELECT MOVIE.movie_id,MOVIE.title,RATING.movie_id,RATING.rev_id,RATING.stars FROM MOVIE CROSS JOIN RATING;

#10
SELECT MOVIE.movie_id,MOVIE.title,RATING.rev_id,RATING.stars FROM MOVIE
	INNER JOIN RATING
    ON MOVIE.movie_id=RATING.movie_id;

#11
SELECT MOVIE.movie_id,MOVIE.title,RATING.rev_id,RATING.stars FROM MOVIE
	INNER JOIN RATING 
    ON MOVIE.movie_id=RATING.movie_id
    WHERE RATING.stars<=3;

#12
SELECT MOVIE.movie_id,MOVIE.title,RATING.rev_id,RATING.stars FROM MOVIE 
	INNER JOIN RATING 
    ON MOVIE.movie_id=RATING.movie_id
    WHERE RATING.stars<=4 AND RATING.stars>=2;

#13
SELECT rev_id,movie_id FROM RATING;

#14
SELECT DISTINCT rev_id,movie_id FROM RATING;

#15
SELECT RATING.movie_id,MOVIE.title,RATING.rev_id,REVIEWER.rev_name,RATING.stars FROM RATING 
	CROSS JOIN MOVIE ON RATING.movie_id=MOVIE.movie_id
    CROSS JOIN REVIEWER ON RATING.rev_id=REVIEWER.rev_id;
    
#16
SELECT RATING.movie_id,MOVIE.title,RATING.rev_id,REVIEWER.rev_name,RATING.stars FROM RATING 
	INNER JOIN MOVIE ON RATING.movie_id=MOVIE.movie_id
    INNER JOIN REVIEWER ON RATING.rev_id=REVIEWER.rev_id
    WHERE stars=5;
    
#17
SELECT MOVIE.title,REVIEWER.rev_name,RATING.stars FROM RATING
	INNER JOIN REVIEWER
    ON RATING.rev_id=REVIEWER.rev_id
    INNER JOIN MOVIE
    ON RATING.movie_id=MOVIE.movie_id
    WHERE RATING.rating_date IS NULL;
    
#18
SELECT concat(MOVIE.director) dir_rev_name
FROM MOVIE
WHERE director IS NOT NULL
    UNION
SELECT REVIEWER.rev_name
FROM REVIEWER
WHERE rev_name IS NOT NULL;

#19
SELECT * FROM REVIEWER
	WHERE rev_name LIKE '%Martinez';
    
#20
SELECT * FROM RATING
	WHERE rating_date LIKE '%____\-__\-0%';

#21
SELECT * FROM RATING
	WHERE date_format(rating_date,'%d')<'10';

#22
UPDATE RATING
	SET stars=stars-1
    WHERE rev_id=(SELECT rev_id FROM REVIEWER WHERE rev_name='Brittany Harris');
SELECT * FROM RATING;

#23
SELECT MOVIE.title,REVIEWER.rev_name,RATING.stars FROM RATING
	INNER JOIN REVIEWER
    ON RATING.rev_id=REVIEWER.rev_id
    INNER JOIN MOVIE
    ON RATING.movie_id=MOVIE.movie_id
    ORDER BY MOVIE.title;

#24
SELECT MOVIE.title,RATING.stars,RATING.rating_date FROM RATING
    INNER JOIN MOVIE
    ON RATING.movie_id=MOVIE.movie_id
    ORDER BY MOVIE.title;

SELECT MOVIE.title,RATING.stars,RATING.rating_date FROM RATING
    INNER JOIN MOVIE
    ON RATING.movie_id=MOVIE.movie_id
    ORDER BY RATING.stars DESC;

SELECT MOVIE.title,RATING.stars,RATING.rating_date FROM RATING
    INNER JOIN MOVIE
    ON RATING.movie_id=MOVIE.movie_id
    ORDER BY RATING.rating_date DESC;
    
#25
SELECT DISTINCT director AS dir_and_rev FROM MOVIE
	WHERE director=(SELECT DISTINCT rev_name FROM REVIEWER INNER JOIN MOVIE ON REVIEWER.rev_name=MOVIE.director);

#-----------------------------------------------------------------------------------------------------------------
#LAB05
#01
SELECT DISTINCT * FROM MOVIE
	WHERE director=(SELECT DISTINCT rev_name FROM REVIEWER INNER JOIN MOVIE ON REVIEWER.rev_name=MOVIE.director);

SELECT DISTINCT * FROM MOVIE
	WHERE director NOT IN (SELECT DISTINCT rev_name FROM REVIEWER INNER JOIN MOVIE ON REVIEWER.rev_name=MOVIE.director);
    
#02
SELECT * FROM RATING
	WHERE rev_id=(SELECT rev_id FROM REVIEWER WHERE rev_name="Sarah Martinez");

SELECT * FROM RATING
	WHERE rev_id NOT IN (SELECT rev_id FROM REVIEWER WHERE rev_name="Sarah Martinez");

#03
SELECT DISTINCT movie_id FROM RATING 
	WHERE stars<(SELECT MIN(stars) FROM RATING WHERE movie_id=103);

SELECT DISTINCT movie_id FROM RATING 
	WHERE stars<=(SELECT MIN(stars) FROM RATING WHERE movie_id=103);

SELECT DISTINCT movie_id FROM RATING 
	WHERE stars IN (SELECT stars FROM RATING WHERE (movie_id=103));
    
SELECT DISTINCT movie_id FROM RATING 
	WHERE stars>(SELECT MAX(stars) FROM RATING WHERE movie_id=103);

SELECT DISTINCT movie_id FROM RATING 
	WHERE stars>=(SELECT MAX(stars) FROM RATING WHERE movie_id=103);
    
SELECT DISTINCT movie_id FROM RATING 
	WHERE stars NOT IN (SELECT stars FROM RATING WHERE (movie_id=103));

#04
SELECT DISTINCT rev_id FROM RATING
	WHERE movie_id IN (SELECT movie_id FROM RATING) AND
    stars IN (SELECT stars FROM RATING) AND
    rating_date='2011-01-12';

#05
SELECT rating_date FROM RATING
	WHERE stars=4 OR stars=5
    ORDER BY rating_date;

SELECT rating_date FROM RATING
	WHERE stars IN (SELECT stars WHERE stars>=4)
    ORDER BY rating_date;
    
#06
SELECT title FROM MOVIE
	WHERE movie_id NOT IN (SELECT movie_id FROM RATING);

SELECT title FROM MOVIE m
	WHERE movie_id NOT IN (SELECT r.movie_id FROM RATING r WHERE r.movie_id = m.movie_id);

#07
SELECT rev.rev_name FROM REVIEWER rev
	INNER JOIN RATING r
    ON rev.rev_id=r.rev_id
    WHERE r.rating_date IS NULL;

SELECT rev_name FROM REVIEWER
	WHERE rev_id IN
    (SELECT rev_id FROM RATING WHERE rating_date IS NULL);


#08
SELECT m.title,MAX(r.stars) FROM RATING r, MOVIE m WHERE r.movie_id=m.movie_id GROUP BY r.movie_id ORDER BY m.title;

SELECT m.title,MIN(r.stars) FROM RATING r, MOVIE m WHERE r.movie_id=m.movie_id GROUP BY r.movie_id ORDER BY m.title;

SELECT m.title,AVG(r.stars) FROM RATING r, MOVIE m WHERE r.movie_id=m.movie_id GROUP BY r.movie_id ORDER BY m.title;

SELECT m.title,SUM(r.stars) FROM RATING r, MOVIE m WHERE r.movie_id=m.movie_id GROUP BY r.movie_id ORDER BY m.title;

SELECT m.title,COUNT(r.stars) FROM RATING r, MOVIE m WHERE r.movie_id=m.movie_id GROUP BY r.movie_id ORDER BY m.title;

#09
SELECT rev.rev_name FROM REVIEWER rev,RATING r  WHERE r.rev_id=rev.rev_id  GROUP BY rev.rev_name HAVING COUNT(r.rev_id)>=3;

SELECT rev_name FROM REVIEWER WHERE rev_id IN (SELECT rev_id FROM RATING GROUP BY rev_id HAVING COUNT(*)>=3);

SELECT rev_name FROM REVIEWER rev WHERE rev.rev_id IN (SELECT r.rev_id FROM RATING r GROUP BY r.rev_id HAVING COUNT(*)>=3);

SELECT m.title,SUM(r.stars) FROM RATING r, MOVIE m WHERE r.movie_id=m.movie_id GROUP BY r.movie_id ORDER BY m.title;



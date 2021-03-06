SHOW DATABASES;
USE E15154lab04;

#01
CREATE TABLE Student(
  name VARCHAR(20) NOT NULL,
  reg_num INT NOT NULL PRIMARY KEY,
  gpa FLOAT(3,2),
  con_reg_num INT,
  class VARCHAR(50)
);

INSERT INTO Student(name,reg_num,gpa) VALUES
("Sameera",425,3.25),
("Kasun",210,3.40),
("Kalpa",201,3.10),
("Chathura",312,3.85),
("Lakmali",473,3.75),
("Sidath",352,3.30),
("Kumudu",111,3.70),
("Nalin",456,3.05),
("Rohani",324,3.70),
("Chithra",231,3.30);

#02
CREATE TABLE Convocation(
  last_name VARCHAR(25),
  address VARCHAR(50),
  age INT(3),
  reg_num INT NOT NULL,
  con_reg_num INT,
  PRIMARY KEY(con_reg_num),
  FOREIGN KEY(reg_num) REFERENCES Student(reg_num)
);

#03
DELIMITER //
CREATE PROCEDURE stdInfo(
  IN last_name VARCHAR(25),
  IN address VARCHAR(50),
  IN age INT(3),
  IN reg_num INT,
  IN con_reg_num INT)
  BEGIN
    INSERT INTO Convocation(last_name,address,age,reg_num,con_reg_num)
    VALUES (last_name,address,age,reg_num,con_reg_num);
    UPDATE Student s SET s.con_reg_num=con_reg_num WHERE s.reg_num=reg_num;
  END //
DELIMITER ;

#04
SET SQL_SAFE_UPDATES = 0;
CALL stdInfo("Alwis","Jaffna",22,425,1);
CALL stdInfo("Diaz","Kandy",23,312,2);
CALL stdInfo("Gomez","Matara",24,473,3);
CALL stdInfo("Perera","Matale",22,352,4);
CALL stdInfo("Silva","Kegalle",21,456,5);

SELECT * FROM Student;

#05
CREATE VIEW Registered AS
  SELECT s.name,s.reg_num,s.gpa,c.con_reg_num,c.address,c.age
  FROM Student s
  INNER JOIN Convocation c
  ON s.con_reg_num=c.con_reg_num;

SELECT * FROM Registered;

#06
CREATE VIEW NotRegistered AS
  SELECT name,reg_num,gpa
  FROM Student
  WHERE reg_num NOT IN (SELECT reg_num FROM Convocation);

SELECT * FROM NotRegistered;

#07
CREATE TABLE LateRegistration(
  last_name VARCHAR(25),
  address VARCHAR(50),
  age INT(3),
  reg_num INT NOT NULL,
  con_reg_num INT,
  PRIMARY KEY(con_reg_num),
  FOREIGN KEY(reg_num) REFERENCES Student(reg_num)
);

#08
DELIMITER $$
CREATE TRIGGER late_convocation_register
    AFTER INSERT ON LateRegistration
    FOR EACH ROW
	BEGIN
		UPDATE Student
		SET con_reg_num = NEW.con_reg_num
        WHERE reg_num=NEW.reg_num;
	END$$
DELIMITER ;


#09
SET SQL_SAFE_UPDATES = 0;
INSERT INTO LateRegistration VALUES
  ("Kalhara","Colombo",29,210,6),
  ("Dilshan","Kandy",23,201,7),
  ("Kumari","Galle",20,111,8),
  ("Perera","Gampaha",19,324,9),
  ("Silva","Ampara",24,231,10);

SELECT * FROM Student;

#10
DELIMITER //
CREATE PROCEDURE setClass()
  BEGIN
    UPDATE Student SET class="First class honors" WHERE gpa>=3.7;
    UPDATE Student SET class="Second class honors-upper division" WHERE gpa<3.7 AND gpa>=3.3;
    UPDATE Student SET class="Second class honors-lower division" WHERE gpa<3.3 AND gpa>=2.7;
    UPDATE Student SET class="Third class honors" WHERE gpa<2.7 AND gpa>=2.0;
  END //
DELIMITER ;

CALL setClass();

SELECT * FROM Student;

-- Create hobby table
CREATE TABLE hobby (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL
);

-- Create employee table
CREATE TABLE employee (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  age INT NOT NULL,
  mobile_number VARCHAR(17) NOT NULL,
  address VARCHAR(75)
);

-- Create employee_salary table
CREATE TABLE employee_salary (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fk_employee_id INT NOT NULL,
  salary DECIMAL(10, 2) NOT NULL,
  DATE DATE NOT NULL,
  CONSTRAINT fk_employees FOREIGN KEY(fk_employee_id) REFERENCES employee(id)
);

-- Create employee_hobby table
CREATE TABLE employee_hobby (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fk_employee_id INT NOT NULL,
  fk_hobby_id INT NOT NULL,
  CONSTRAINT fk_employee FOREIGN KEY(fk_employee_id) REFERENCES employee(id),
  CONSTRAINT fk_hobby FOREIGN KEY(fk_hobby_id) REFERENCES hobby(id)
);

-- Insert data in hobby table
INSERT INTO hobby (`id`, `name`)
VALUES ('1', 'cricket'),
       ('2', 'music'),
       ('3', 'dancing');

-- Insert data in employee table
INSERT INTO employee (`id`, `first_name`, `last_name`, `age`, `mobile_number`, `address`)
VALUES ('101', 'Naitik', 'Bagdi', '24', '7854686544', 'pratapgarh'),
       ('102', 'jayesh', 'soni', '20', '7456985632', 'palanpur'),
       ('103', 'mukesh', 'sharma', '25', '9656985478', 'indore');

-- Insert data in employee_salary table
INSERT INTO employee_salary (`id`, `fk_employee_id`, `salary`, `date`)
VALUES ('1', '101', '50000', '2024-04-30'),
       ('2', '102', '40000', '2024-03-15'),
       ('3', '101', '10000', '2024-03-20');

-- Insert data in employee_hobby table
INSERT INTO employee_hobby (`id`, `fk_employee_id`, `fk_hobby_id`)
VALUES ('1', '101', '1'),
       ('2', '102', '2'),
       ('3', '103', '3'),
       ('4', '101', '2');

-- Update data of hobby tables
UPDATE hobby
SET name='football'
WHERE id = 1;

-- Update data of employee tables
UPDATE employee
SET first_name = 'Vishal', last_name = 'varma'
WHERE id = 103;

-- Update data of employee_salary tables
UPDATE employee_salary
SET salary = '700000', DATE = '2024-02-23'
WHERE id = 3;

-- Update data of employe_hobby tables
UPDATE employee_hobby
SET fk_employee_id = 102
WHERE id = 4;

-- Delete data of employee_hobby table
DELETE FROM employee_hobby
WHERE id = 3;

-- Delete data of hobby table
DELETE FROM hobby
WHERE id = 3;

-- Delete data of employee_salary table
DELETE FROM employee_salary
WHERE id = 2;

-- Delete data of employee table 
DELETE FROM employee
WHERE id = 103;

-- Alter employee_hobby
ALTER TABLE employee_hobby
DROP CONSTRAINT fk_hobby;

-- Alter employee_hobby table
ALTER TABLE employee_hobby ADD CONSTRAINT fk_hobby FOREIGN KEY (fk_hobby_id) REFERENCES hobby (id) ON DELETE CASCADE;

-- Alter employee_salary
ALTER TABLE employee_salary
DROP CONSTRAINT fk_employees;

-- Alter employee_hobby
ALTER TABLE employee_hobby
DROP CONSTRAINT fk_employee;

-- Alter employee_salary
ALTER TABLE employee_salary ADD CONSTRAINT fk_employees FOREIGN KEY(fk_employee_id) REFERENCES employee(id) ON DELETE CASCADE;

-- Delete employee_salary
DELETE FROM employee_salary
WHERE id = 3;

-- Truncate hobby tables
TRUNCATE TABLE hobby;

-- Truncate hobby tables
TRUNCATE TABLE employee;

-- Truncate hobby tables
TRUNCATE TABLE employee_hobby;

-- Truncate hobby tables
TRUNCATE TABLE employee_salary;

-- Create a separate select queries to get a hobby.
SELECT * FROM hobby;

-- Create a separate select queries to get a employee
SELECT * FROM employee;

-- Create a separate select queries to get a employee_hobby
SELECT * FROM employee_hobby;

-- Create a separate select queries to get a employee_salary
SELECT * FROM employee_salary;

-- Create a select single query to get all employee name, all hobby_name in single column.
SELECT CONCAT (first_name, ' ', last_name) AS employee_name FROM employee
UNION
SELECT hobby.name FROM hobby;

-- Create a select query to get employee name, his/her employee_salary
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, SUM(es.salary) AS salary
FROM employee e
INNER JOIN employee_salary es ON e.id = es.fk_employee_id GROUP BY es.fk_employee_id;

-- Create a select query to get employee name, total salary of employee, hobby name(comma-separated - you need to use subquery for hobby name).
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, SUM(es.salary) AS total_salary,
(SELECT GROUP_CONCAT(hobby.name) FROM hobby
INNER JOIN employee_hobby eh ON hobby.id = eh.fk_hobby_id WHERE eh.fk_employee_id = e.id) AS hobby
FROM employee e
LEFT JOIN employee_salary es ON e.id = es.fk_employee_id GROUP BY e.id;

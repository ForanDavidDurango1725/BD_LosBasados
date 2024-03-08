USE EMPRESA;

ALTER TABLE Employee
ADD CONSTRAINT FK_Department_Employee FOREIGN KEY (Dno) REFERENCES Department(Dnumber);


ALTER TABLE Dept_Locations
ADD CONSTRAINT FK_Department_Dept_Locations FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber);

ALTER TABLE Project
ADD CONSTRAINT FK_Department_Project FOREIGN KEY (Dnum) REFERENCES Department(Dnumber);


ALTER TABLE Works_On
ADD CONSTRAINT FK_Employee_Works_On FOREIGN KEY (Essn) REFERENCES Employee(Ssn);


ALTER TABLE Dependent_
ADD CONSTRAINT FK_Employee_Dependent FOREIGN KEY (Essn) REFERENCES Employee(Ssn);
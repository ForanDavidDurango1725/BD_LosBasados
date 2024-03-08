USE EMPRESA;


-- 1. ¿Cuántos empleados hay en total?
SELECT COUNT(*) AS TotalEmpleados FROM EMPLOYEE;

-- 2. ¿Cuál es el nombre del empleado que tiene el salario más alto?
SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE);

-- 3. ¿Cuántos departamentos hay en la organización?
SELECT COUNT(*) AS TotalDepartamentos FROM DEPARTMENT;

-- 4. ¿Cuáles son los proyectos ubicados en Houston?
SELECT Pname FROM PROJECT WHERE Plocation = 'Houston';

-- 5. ¿Cuál es la relación de dependencia para el empleado con SSN 333445555?
SELECT Dependent_name, Relationship FROM DEPENDENT_ WHERE Essn = 333445555;

-- 6. ¿Cuál es la ubicación del departamento con el número 5?
SELECT Dlocation FROM DEPT_LOCATIONS WHERE Dnumber = 5;

-- 7. ¿Cuál es el salario promedio de todos los empleados?
SELECT AVG(Salary) AS SalarioPromedio FROM EMPLOYEE;

-- 8. ¿Cuántos proyectos tiene cada departamento?
SELECT Dnum, COUNT(*) AS TotalProyectos FROM PROJECT GROUP BY Dnum;

-- 9. ¿Cuántas horas totales se han trabajado en cada proyecto?
SELECT Pno, SUM(Hours_) AS HorasTotales FROM WORKS_ON GROUP BY Pno;

-- 10. ¿Cuál es el salario total pagado por todos los departamentos?
SELECT Dno, SUM(Salary) AS SalarioTotal FROM EMPLOYEE GROUP BY Dno;

-- 11. ¿Cuál es el salario máximo y mínimo en cada departamento?
SELECT Dno, MAX(Salary) AS SalarioMaximo, MIN(Salary) AS SalarioMinimo FROM EMPLOYEE GROUP BY Dno;

-- 12. ¿Cuántos dependientes tiene cada empleado y cuál es su relación?
SELECT Essn, COUNT(*) AS TotalDependientes, STRING_AGG(Relationship, ', ') AS Relaciones FROM DEPENDENT_ GROUP BY Essn;


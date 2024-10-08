/*
Find count and employee names for given department ID. Retriving names using cursor.
*/

create or replace PROCEDURE find_all_department_emp (dept_id employees.departmentid%TYPE) IS
CURSOR emp_names IS SELECT firstname, lastname FROM employees e JOIN departments d ON e.departmentid = d.departmentid WHERE e.departmentid = dept_id;
emp_firstname employees.firstname%TYPE;
emp_lastname employees.lastname%TYPE;
cnt NUMBER;
BEGIN
    SELECT COUNT(employeeid) INTO cnt FROM employees e JOIN departments d ON e.departmentid = d.departmentid WHERE e.departmentid = dept_id; 


IF cnt <> 0 THEN
    DBMS_OUTPUT.PUT_LINE('Total count of employees for given department ID '||dept_id||' : '||cnt);
    DBMS_OUTPUT.PUT_LINE('Below listed employee names');
    OPEN emp_names;
    LOOP
    FETCH emp_names INTO emp_firstname, emp_lastname;
    EXIT WHEN emp_names%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(emp_firstname || ' ' ||emp_lastname);
    END LOOP;
    CLOSE emp_names;
ELSE 
    DBMS_OUTPUT.PUT_LINE('Department ID returns 0');
END IF;

EXCEPTION
WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('Error occured' || SQLERRM);
END;
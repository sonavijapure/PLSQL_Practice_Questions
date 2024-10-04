/*
Created procedure to calculate total number of employees for given department
*/
create or replace PROCEDURE total_no_dept_employees (dept_name departments.departmentname%TYPE) IS
cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO cnt FROM employees e JOIN departments d USING(departmentid)
    WHERE d.departmentname = dept_name;

    IF cnt = 0 THEN
    dbms_output.put_line('No department exist in system for provided department name');
    ELSIF cnt IS NOT NULL THEN
    dbms_output.put_line('Total no. of employees for given department '|| dept_name || ' is ' || cnt);
    ELSE NULL;
    END IF;

    EXCEPTION
    WHEN others THEN
    dbms_output.put_line('an error occured' || SQLERRM);
END;
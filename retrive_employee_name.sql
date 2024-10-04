/*
Retriving employee name using fucntion with emp_id as iN mode parameter
*/

create or replace FUNCTION retrive_employee_name(emp_id employees.employeeid%TYPE) RETURN VARCHAR2 IS
emp_name employees.FIRSTNAME%TYPE;
BEGIN
    SELECT firstname || ' ' || lastname INTO emp_name
    FROM employees
    WHERE employeeid = emp_id;
    DBMS_OUTPUT.PUT_LINE('Employee name for given employeeid ' || emp_id ||' is '||emp_name);
    RETURN NULL;

EXCEPTION
  when no_data_found then
  DBMS_OUTPUT.PUT_LINE('Employee not found with employeeid ' || emp_id);
    RETURN NULL;
    WHEN others then
    DBMS_OUTPUT.PUT_LINE ('An error occured' || SQLERRM);
    RETURN NULL;
END;
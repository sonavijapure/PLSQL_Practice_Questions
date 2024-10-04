CREATE OR REPLACE PROCEDURE promote_employees (
    emp_rank      employees.rank%TYPE,
    increase_rate NUMBER
) IS

    CURSOR cur_get_emp_detail IS
    ( SELECT
        e.employeeid,
        e.salary,
        e.rank
    FROM
             employees e
        JOIN reviews r ON e.employeeid = r.employeeid
    WHERE
            r.rating = 5
        AND e.rank IN ( 'Intern', 'Mid-Level', 'Senior' )
    );

    TYPE employee_old_details IS RECORD (
        emp_id           employees.employeeid%TYPE,
        emp_old_salary   employees.salary%TYPE,
        emp_old_position employees.rank%TYPE
    );
    emp_old_details employee_old_details;
    new_salary      employees.salary%TYPE;
    new_position    employees.rank%TYPE;
    cnt             NUMBER := 0; --to get count of total updated employees after promotion
BEGIN
    OPEN cur_get_emp_detail;
    LOOP
        FETCH cur_get_emp_detail INTO emp_old_details;
        EXIT WHEN cur_get_emp_detail%notfound;
    
--new salary calculation based on emp rank and increase rate
        new_salary := emp_old_details.emp_old_salary * ( 1 + increase_rate / 100 );
        
--upgrading interns to junior
        IF
            emp_rank = emp_old_details.emp_old_position
            AND emp_rank = 'Intern'
        THEN
            new_position := 'Junior';
           -- SELECT employeeid, salary, rank INTO info.emp_id, info.emp_old_salary, info.emp_old_position FROM employees where employeeid = info.emp_id AND rank = emp_rank;
            cnt := cnt + 1;
            dbms_output.put_line(emp_old_details.emp_id);
            UPDATE employees
            SET
                rank = new_position,
                salary = new_salary
            WHERE
                    employeeid = emp_old_details.emp_id
                AND rank = emp_rank;

            dbms_output.put_line(emp_old_details.emp_id
                                 || 'Interns promoted to Junior and their old salary - '
                                 || emp_old_details.emp_old_salary
                                 || ' vs new salary - '
                                 || new_salary);

                                 
--upgrading juniors to mid-level
        ELSIF
            emp_rank = emp_old_details.emp_old_position
            AND emp_rank = 'Junior'
        THEN
            new_position := 'Mid-Leve';
--            SELECT employeeid, salary, rank INTO info.emp_id, info.emp_old_salary, info.emp_old_position FROM employees where employeeid = info.emp_id AND rank = emp_rank;
            cnt := cnt + 1;
            UPDATE employees
            SET
                rank = new_position,
                salary = new_salary
            WHERE
                    employeeid = emp_old_details.emp_id
                AND rank = emp_rank;

            dbms_output.put_line(emp_old_details.emp_id
                                 || 'Juniors promoted to Mid-Level and their old salary - '
                                 || emp_old_details.emp_old_salary
                                 || ' vs new salary - '
                                 || new_salary);
                                 
--upgrading mid-levels to senior
        ELSIF
            emp_rank = emp_old_details.emp_old_position
            AND emp_rank = 'Mid-Level'
        THEN
            new_position := 'Senior';
--            SELECT employeeid, salary, rank INTO info.emp_id, info.emp_old_salary, info.emp_old_position FROM employees where employeeid = info.emp_id AND rank = emp_rank;
            cnt := cnt + 1;
            UPDATE employees
            SET
                rank = new_position,
                salary = new_salary
            WHERE
                    employeeid = emp_old_details.emp_id
                AND rank = emp_rank;

            dbms_output.put_line('Mid-Leve promoted to Senior and their old salary - '
                                 || emp_old_details.emp_old_salary
                                 || ' vs new salary - '
                                 || new_salary);
                                       -- Create a CSV line
                     
--closing nested if
        END IF;

    END LOOP;
   
--close cursor
    CLOSE cur_get_emp_detail;
        
    -- Output total number of promotions
    IF cnt = 0 THEN
        dbms_output.put_line('No employee promotions are allowed for this post this year');
    ELSE
        dbms_output.put_line('Total promoted employees: ' || cnt);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('An error occurred: ' || sqlerrm);
END promote_employees;
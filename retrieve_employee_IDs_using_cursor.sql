--PL/SQL block to retrieve employee IDs from a table named EMPLOYEES for available employees in the Development and QA department
DECLARE
    CURSOR unasgs_pr IS 
        SELECT PROJECT_ID, PROJECT_NAME 
        FROM PROJECTS 
        WHERE ASSIGNED_EMPLOYEE IS NULL;

    emp_id VARCHAR2(10);
BEGIN
            FOR i IN (SELECT employee_id 
              FROM EMPLOYEES3 
              WHERE status = 'Available' AND (department = 'Development' or department = 'QA')) LOOP
        emp_id := i.employee_id;
        DBMS_OUTPUT.PUT_LINE(emp_id);
    END LOOP;

    FOR r IN unasgs_pr LOOP
        BEGIN
            -- Find an available employee
            SELECT employee_id 
            INTO emp_id 
            FROM EMPLOYEES3 
            WHERE status = 'Available' AND (department = 'Development' or department = 'QA')
            AND ROWNUM = 1;  -- Get only one employee

            -- Update the project with the found employee
            UPDATE PROJECTS 
            SET ASSIGNED_EMPLOYEE = emp_id 
            WHERE PROJECT_ID = r.PROJECT_ID;

            -- Update employee status to busy and project to in progress
            UPDATE EMPLOYEES3 
            SET status = 'Busy' 
            WHERE employee_id = emp_id;
            
            UPDATE PROJECTS
            set STATUS = 'In Progress'
            where PROJECT_ID = r.PROJECT_ID;
            DBMS_OUTPUT.PUT_LINE( r.PROJECT_ID);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No available employee found for project ID: ' || r.PROJECT_ID);
        END;
    END LOOP;

    COMMIT; -- Commit changes after all updates
END;
/

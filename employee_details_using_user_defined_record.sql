DECLARE
--define user input for employeeid
        empid    employees.employeeid%TYPE := &empid;
--define user defined record types
    TYPE e_details IS RECORD (
        emp_id       employees.employeeid%TYPE,
        emp_fname    employees.firstname%TYPE,
        emp_lname    employees.lastname%TYPE,
        dept_name    departments.departmentname%TYPE,
        project_name projects.projectname%TYPE,
        skill        skills.skillname%TYPE
    );
        emp_info e_details;
BEGIN
    --dbms_output.put_line(empid);
    SELECT
        employeeid,
        firstname,
        lastname,
        departmentname,
        projectname,
        skillname
    INTO
        emp_info.emp_id,
        emp_info.emp_fname,
        emp_info.emp_lname,
        emp_info.dept_name,
        emp_info.project_name,
        emp_info.skill
    FROM
        (
            SELECT
                emp.employeeid,
                emp.firstname,
                emp.lastname,
                emp.departmentname,
                emp.projectname,
                LISTAGG(s.skillname, ',') WITHIN GROUP(
                ORDER BY
                    s.skillid
                ) skillname
            FROM
                     (
                    SELECT
                        e.employeeid,
                        e.firstname,
                        e.lastname,
                        d.departmentname,
                        p.projectname
                    FROM
                             employees e
                        JOIN departments d ON e.departmentid = d.departmentid
                        JOIN projects    p ON d.departmentid = p.departmentid
                                           AND e.projectid = p.projectid
                    WHERE
                        d.departmentname = 'Science Department'
                ) emp
                JOIN employee_skills es ON emp.employeeid = es.employeeid
                JOIN skills          s ON es.skillid = s.skillid
            GROUP BY
                emp.employeeid,
                emp.firstname,
                emp.lastname,
                emp.departmentname,
                emp.projectname
        )where employeeid = empid;

    dbms_output.put_line('Here are the details of given'||chr(10)|| 'Employeeid : '
                         || emp_info.emp_id
                         || chr(10)
                         || 'Employee name : '
                         || emp_info.emp_fname
                         || ' '
                         || emp_info.emp_lname
                         || chr(10)
                         || 'Employee department name: '
                         || emp_info.dept_name
                         ||chr(10)
                         || 'Employees project name: '
                         || emp_info.project_name
                         || chr(10)
                         || 'Employees skill set: '
                         || emp_info.skill);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No such EmployeeID - '||empid||' exist for Science Department! ');
    WHEN OTHERS THEN
        dbms_output.put_line('Error!');
END;
/
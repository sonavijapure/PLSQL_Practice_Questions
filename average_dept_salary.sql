/*
created function that gives average department salary for given department id.
*/

create or replace function average_dept_salary (
	dept_id departments.departmentid%type
) return number is
	avg_salary employees.salary%type;
begin
	select avg(e.salary)
	  into avg_salary
	  from employees e
	  join departments d 
	on e.departmentid = d.departmentid
	 where e.departmentid = dept_id;
RETURN avg_salary ;
exception
	when others then
		dbms_output.put_line('Error occured' || sqlerrm);
end;
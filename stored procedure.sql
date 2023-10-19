Use employees;
Drop procedure if exists out_params;

DELIMITER $$

CREATE PROCEDURE `out_params`(in p_emo_no Integer, out p_avg_sal decimal(10,2))
BEGIN
select
	avg(s.salary) into p_avg_sal
from employees e 
join salaries s on e.emp_no = s.emp_no;

END$$

DELIMITER ;
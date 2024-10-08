use twenty_eight;
DELIMITER &&
CREATE PROCEDURE test_proc_1 (IN tid INT)
BEGIN
select * from test_table where test_id = tid;
END &&
DELIMITER ;
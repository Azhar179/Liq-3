DELIMITER &&
CREATE PROCEDURE test_proc (IN tid INT)
BEGIN
select * from test_table where test_id = tid;
END &&
DELIMITER ;
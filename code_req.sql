/*
1. Создайте представление, которое для каждого курса выводит название, номер последнего потока, дату начала обучения последнего потока и среднюю успеваемость курса по всем потокам.
*/

CREATE VIEW 'courses_info' AS 
SELECT 
	courses.name AS 'Course_name', 
	streams.number AS 'Num_last_stream', 
	streams.started_at AS 'Data_last_stream', 
	AVG(grades.grade) AS 'Avg_grade_in_all_streams' 
FROM courses 
	INNER JOIN streams 
	ON courses.id = streams.course_id 
	INNER JOIN grades 
	ON streams.id = grades.stream_id 
	GROUP BY courses.name 
	HAVING MAX(streams.number);
	
	
/*
2. Удалите из базы данных всю информацию, которая относится к преподавателю с идентификатором, равным 3. Используйте транзакцию.
*/

BEGIN TRANSACTION;
DELETE FROM grades WHERE teacher_id = 3;
DELETE FROM teachers WHERE id = 3;
ROLLBACK;

/*
3. Создайте триггер для таблицы успеваемости, который проверяет значение успеваемости на соответствие диапазону чисел от 0 до 5 включительно.
*/

CREATE TRIGGER check_range_grade BEFORE INSERT 
ON grades
BEGIN
SELECT CASE
WHEN
NEW.grade NOT BETWEEN 1 AND 5 
THEN
RAISE(ABORT, 'Wrong range for grade!')
END;
END;

/*
4. Дополнительное задание. Создайте триггер для таблицы потоков, который проверяет, что дата начала потока больше текущей даты, а номер потока имеет наибольшее значение среди существующих номеров. При невыполнении условий необходимо вызвать ошибку с информативным сообщением.
*/

CREATE TRIGGER check_streams BEFORE INSERT 
ON streams
BEGIN
SELECT CASE
WHEN
(strftime('%s', NEW.started_at)) <= (strftime('%s', DATE('now')))
OR (NEW.number <= (SELECT MAX(number) FROM streams))
THEN
RAISE(ABORT, 'Wrong DATA or NUM_STREAM !')
END;
END;

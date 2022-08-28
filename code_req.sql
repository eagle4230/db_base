/*
1. Покажите информацию по потокам. В отчет выведите номер потока, название курса и дату начала занятий.
*/
SELECT 
	streams.number AS 'Номер потока',
	courses.name AS 'Название курса',
	streams.started_at AS 'Дата начала'
FROM streams
	INNER JOIN courses 
	ON streams.course_id = courses.id;
	
/*	
2. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем потокам курса.
*/
SELECT 
	courses.name AS 'Название курса',
	SUM(streams.student_amount) AS 'Количество учеников'
FROM courses INNER JOIN streams 
	ON courses.id = streams.course_id GROUP BY courses.name;
	
/*
3. Для всех учителей найдите среднюю оценку по всем проведённым потокам. В отчёт выведите идентификатор, фамилию и имя учителя, среднюю оценку по всем проведенным потокам. Важно чтобы учителя, у которых не было потоков, также попали в выборку.
*/
SELECT 
	teachers.id, 
	teachers.surname AS 'Фамилия', 
	teachers.name AS 'Имя', 
	AVG(grades.grade) AS 'Средняя оценка' 
FROM teachers LEFT JOIN grades 
	ON teachers.id = grades.teacher_id GROUP BY teachers.id;


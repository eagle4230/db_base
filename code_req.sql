/*
1. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем потокам курса. Решите задание с применением оконных функций.
*/

SELECT DISTINCT
	courses.name AS course_name, 
	SUM(streams.student_amount) OVER(PARTITION BY courses.name) AS total_amount 
FROM courses
	LEFT JOIN streams
	ON courses.id = streams.course_id;


/*
2. Найдите среднюю оценку по всем потокам для всех учителей. В отчёт выведите идентификатор, фамилию и имя учителя, среднюю оценку по всем проведённым потокам. Учителя, у которых не было потоков, также должны попасть в выборку. Решите задание с применением оконных функций.
*/

SELECT DISTINCT 
	teachers.id AS id, 
	teachers.surname ||' '|| teachers.name AS teacher, 
	AVG(grades.grade) OVER(PARTITION BY teachers.id) AS avg_grade 
FROM teachers 
	LEFT JOIN grades 
	ON teachers.id = grades.teacher_id;


/*
3. Какие индексы надо создать для максимально быстрого выполнения представленного запроса?
SELECT
  surname,
  name,
  number,
  performance
FROM academic_performance
  JOIN teachers 
    ON academic_performance.teacher_id = teachers.id
  JOIN streams
    ON academic_performance.stream_id = streams.id
WHERE number >= 200;
*/

CREATE INDEX teachers_surname_name_idx ON teachers(surname, name);



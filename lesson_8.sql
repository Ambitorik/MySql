-- 1) Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT concat (u.firstname, ' ', u.lastname) AS Name
FROM users u
JOIN messages m ON m.from_user_id = u.id AND m.to_user_id = 1
GROUP BY Name 
ORDER BY count(from_user_id) DESC 
LIMIT 1;

-- 2) Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT count(*) AS 'likes counter'
FROM users u 
JOIN likes l ON l.id = u.id 
JOIN profiles p ON p.user_id = u.id AND TIMESTAMPDIFF(year, birthday, now()) < 10;

-- 3) Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
CASE (gender)
		WHEN 'm' THEN 'мужчин'
		WHEN 'f' THEN 'женщин'
	END AS 'Who is more', count(*) AS 'Number of likes'
FROM users u 
JOIN likes l ON l.id = u.id 
JOIN profiles p ON p.user_id = u.id
GROUP BY gender 
LIMIT 1;

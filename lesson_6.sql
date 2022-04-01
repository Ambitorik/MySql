-- 1) Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений)

select firstname, lastname from users where id = (
select from_user_id
from messages 
where to_user_id = 1
group by from_user_id 
order by count(from_user_id) desc 
limit 1
);

-- 2) Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

select count(*) as 'likes counter'
from likes 
where user_id in (
select user_id
from profiles 
where TIMESTAMPDIFF(year, birthday, now()) < 10
);

-- 3)Определить кто больше поставил лайков (всего): мужчины или женщины.

select 
case (gender)
		when 'm' then 'мужчин'
		when 'f' then 'женщин'
	end as 'Who is more', count(*) as 'Number of likes'
from profiles
where user_id in (
		select user_id
		from likes
		)
group by gender
limit 1;




























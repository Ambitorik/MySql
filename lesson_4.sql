-- i. Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)
-- Сделал

-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
select distinct firstname
from users
order by firstname;

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

alter table vk.profiles 
add column is_active BIT default 1;

update profiles
set is_active = 0
where (birthday + interval 18 year) > now();

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
alter table vk.messages  
add column is_delete BIT default 0;

update messages  
set is_delete = 1
where created_at > now();

-- v. Написать название темы курсового проекта (в комментарии)
-- Я еще думаю, но скорей всего игровая платформа по типу Steam.





























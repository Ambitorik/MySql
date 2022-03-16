-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

-- 1) Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

INSERT INTO users (created_at, updated_at) VALUES (NOW(), NOW());

-- 2)Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в 
-- формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

UPDATE users SET created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;
  

-- 3)В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
-- если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

INSERT INTO storehouses_products
	(storehouse_id, product_id, value, created_at, updated_at) VALUES
	(1, 1, 2, now(), now()),
	(2, 2, 1, now(), now()),
	(3, 3, 5, now(), now()),
	(4, 4, 0, now(), now()),
	(5, 5, 4, now(), now()),
	(6, 6, 3, now(), now())
;

SELECT * FROM storehouses_products;


-- 4) (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')


SELECT * FROM users WHERE DATE_FORMAT(birthday_at,'%M') in ('may', 'august');


-- 5) (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs WHERE id in (5, 1, 2);
SELECT * FROM catalogs WHERE id in (5, 1, 2) ORDER BY field(5, 1, 2);


-- Практическое задание теме “Агрегация данных”


-- 1) Подсчитайте средний возраст пользователей в таблице users

SELECT AVG(age) FROM (SELECT YEAR(CURRENT_TIMESTAMP) - YEAR(birthday_at) as age FROM users) AS middle_age;


-- 2) Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, 
-- а не года рождения.

SELECT COUNT(*) as stats from (SELECT DAYOFWEEK(CONCAT(YEAR(NOW()),'-',MONTH(birthday_at),'-',DAYOFMONTH(birthday_at))) as date from users) as stats where date=1;

-- 3) (по желанию) Подсчитайте произведение чисел в столбце таблицы








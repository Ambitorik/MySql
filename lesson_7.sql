-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

insert into orders
  (id, user_id)
values
	(1, 1);

select users.id, users.name, users.birthday_at, orders.created_at from users
join orders on users.id = orders.user_id;

-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

ALTER TABLE shop.products CHANGE desription desсription text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'Описание';

INSERT INTO products
  (name, desсription, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060, 2);


select
	catalogs.name as catalog_name,
	products.name as product_name,
	products.price as products_price,
	products.desсription as product_description
from products
left join catalogs on catalogs.id = products.catalog_id;

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    `from` VARCHAR(50),
    `to` VARCHAR(50)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    label VARCHAR(50),
    name VARCHAR(50)
);

INSERT INTO flights (`from`, `to`) VALUES
			('moscow', 'omsk'),
			('novgorod', 'kazan'),
			('irkutsk', 'moscow'),
			('omsk', 'irkutsk'),
			('moscow', 'kazan');
			
INSERT INTO cities (label, name) VALUES
			('moscow', 'Москва'),
			('irkutsk', 'Иркутск'),
			('novgorod', 'Новгород'),
			('kazan', 'Казань'),
			('omsk', 'Омск');
			
SELECT
	id,
	(SELECT name FROM cities WHERE label = flights.`from`) AS 	`from`,
	(SELECT name FROM cities c WHERE label = flights.`to`) AS `to`
FROM flights;

-- Решение через JOIN
SELECT flights.id, `from`.name AS `from`, `to`.name AS `to`
FROM flights
JOIN cities AS `from` ON flights.`from` = `from`.label
JOIN cities AS `to` ON flights.`to` = `to`.label
ORDER BY id;


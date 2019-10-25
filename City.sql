update my_contacts
set location='San Fransisco, CA'
where location='San Fran, CA';
alter table my_contacts
add column City varchar(30);
update my_contacts
set my_contacts.City=substring_index(my_contacts.location, ',',1)
where my_contacts.City is null;
alter table my_contacts
add column City_ID varchar(30);
CREATE TABLE city (
  city_ID int(11) NOT NULL auto_increment,
  city VARCHAR(25) NOT NULL,
  PRIMARY KEY  (city_ID)
) AS
	SELECT DISTINCT city
	FROM my_contacts
	WHERE city IS NOT NULL
	ORDER BY city;
UPDATE my_contacts
	INNER JOIN city
	ON city.city = my_contacts.City
	SET my_contacts.City_ID = city.city_ID
	WHERE city.city IS NOT NULL;
SELECT mc.first_name, mc.last_name, mc.location, mc.City_ID, ct.city
	FROM city AS ct
		INNER JOIN my_contacts AS mc
	ON ct.city_ID = mc.City_ID;
alter table my_contacts
drop column City;
# ALTER TABLE my_contacts
# 	DROP COLUMN location;

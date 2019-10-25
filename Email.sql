update my_contacts
set email=replace(email,' ','');

update my_contacts
set email=replace(email,'\n','');

DROP TABLE IF EXISTS email;
CREATE TABLE email (
  email_ID int(11) NOT NULL auto_increment,
  email VARCHAR(40) NOT NULL,
  PRIMARY KEY  (email_ID)
) AS
	SELECT DISTINCT email
	FROM my_contacts
	WHERE email IS NOT NULL
	ORDER BY email;
ALTER TABLE my_contacts
	ADD COLUMN email_ID INT(11);

UPDATE my_contacts
	INNER JOIN email
	ON email.email = my_contacts.email
	SET my_contacts.email_ID = email.email_ID
	WHERE email.email IS NOT NULL;
SELECT mc.first_name, mc.last_name, mc.email_ID, em.email
	FROM email AS em
		INNER JOIN my_contacts AS mc
	ON em.email_ID = mc.email_ID;

# ALTER TABLE my_contacts
# 	DROP COLUMN email;
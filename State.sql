update my_contacts
set location='San Fransisco, CA'
where location='San Fran, CA';
alter table my_contacts
add column State varchar(3);
update my_contacts
set my_contacts.State=substring_index(my_contacts.location, ' ',-1)
where my_contacts.State is null;
alter table my_contacts
add column State_ID varchar(30);

CREATE TABLE state (
  state_ID int(10) NOT NULL auto_increment,
  state VARCHAR(2) NOT NULL,
  PRIMARY KEY  (state_ID)
) AS
	SELECT DISTINCT state
	FROM my_contacts
	WHERE state IS NOT NULL
	ORDER BY state;

UPDATE my_contacts
	INNER JOIN state
	ON state.state = my_contacts.state
	SET my_contacts.state_ID = state.state_ID
	WHERE state.state IS NOT NULL;

SELECT mc.first_name, mc.last_name, mc.location, mc.State_ID, st.state
	FROM state AS st
		INNER JOIN my_contacts AS mc
	ON st.state_ID = mc.State_ID;

 alter table my_contacts
  drop column State;
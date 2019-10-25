alter table my_contacts
    add column person_ID int(20) auto_increment NOT NULL primary key;
alter table my_contacts
add column interest1 varchar(30);
update my_contacts
set my_contacts.interest1=substring_index(my_contacts.interests, ', ',1)
where my_contacts.interest1 is null;

alter table my_contacts
add column test varchar(30);
update my_contacts
set my_contacts.test=trim( SUBSTR(interests, LOCATE(",", interests) + 1, CHAR_LENGTH(interests)))
where my_contacts.test is null;


alter table my_contacts
add column interest2 varchar(30);
update my_contacts
set my_contacts.interest2=substring_index(my_contacts.test, ', ',1)
where my_contacts.interest2 is null;

alter table my_contacts
add column interest3 varchar(30);
update my_contacts
set my_contacts.interest3=trim(SUBSTR(my_contacts.test, LOCATE(", ", my_contacts.test) + 1, CHAR_LENGTH(my_contacts.test)))
where my_contacts.interest3 is  null;

update my_contacts
set my_contacts.interest2=null
where my_contacts.interest1=my_contacts.interest2;

update my_contacts
set my_contacts.interest3=null
where my_contacts.interest1=my_contacts.interest3;

update my_contacts
set my_contacts.interest3=null
where my_contacts.interest2=my_contacts.interest3;

alter table my_contacts
drop column test;

create table interest(
    interest_ID int(10) primary key NOT NULL auto_increment,
    interest varchar(25) not null
) as
    select distinct interest1 as interest
from my_contacts
where interest1 is not null
union
select distinct interest2 as interest
from my_contacts
where interest2 is not null
union
select distinct interest3 as interest
from my_contacts
where interest3 is not null;

create table interest_contacts(
    person_ID int(25),
    interest_ID int (25),
    foreign key(person_ID) references my_contacts(person_ID),
    foreign key (interest_ID) references interest(interest_ID)
);

insert into interest_contacts(interest_ID,person_ID)
SELECT it.interest_ID, mc.Person_ID
from my_contacts mc
join interest  it
where it.interest=mc.interest1;

insert into interest_contacts(interest_ID,person_ID)
SELECT it.interest_ID, mc.Person_ID
from my_contacts mc
join interest  it
where it.interest=mc.interest2;

insert into interest_contacts(interest_ID,person_ID)
SELECT it.interest_ID, mc.Person_ID
from my_contacts mc
join interest  it
where it.interest=mc.interest3;

alter table normalization1.interest_contacts
order by person_ID asc;

alter table my_contacts
    drop column interest1;

alter table my_contacts
    drop column interest2;

alter table my_contacts
    drop column interest3;

#Alter table my-contacts
# drop column interests;
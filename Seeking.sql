alter table my_contacts
add column seeking1 varchar(30);
update my_contacts
set my_contacts.seeking1=substring_index(my_contacts.seeking, ', ',1)
where my_contacts.seeking1 is null;

alter table my_contacts
add column seeking2 varchar(30);
update my_contacts
set my_contacts.seeking2=trim( SUBSTR(seeking, LOCATE(",", seeking) + 1, CHAR_LENGTH(seeking)))
where my_contacts.seeking2 is null;

update my_contacts
set my_contacts.seeking2=null
where my_contacts.seeking1=my_contacts.seeking2;

create table seeking(
    seeking_ID int(10) primary key NOT NULL auto_increment,
    seeking varchar(50) not null
) as
    select distinct seeking1 as seeking
from my_contacts
where seeking1 is not null
union
select distinct seeking2 as seeking
from my_contacts
where seeking2 is not null;

create table seeking_contacts(
    person_ID int(25),
    seeking_ID int (25),
    foreign key(person_ID) references my_contacts(person_ID),
    foreign key (seeking_ID) references seeking(seeking_ID)
);
insert into seeking_contacts(seeking_ID,person_ID)
SELECT sk.seeking_ID, mc.Person_ID
from my_contacts mc
join seeking  sk
where sk.seeking=mc.seeking1;

insert into seeking_contacts(seeking_ID,person_ID)
SELECT sk.seeking_ID, mc.Person_ID
from my_contacts mc
join seeking  sk
where sk.seeking=mc.seeking2;

alter table normalization1.seeking_contacts
order by person_ID asc;

alter table my_contacts
    drop column seeking1;

alter table my_contacts
    drop column seeking2;

# Alter Table my_contacts
# drop column seeking
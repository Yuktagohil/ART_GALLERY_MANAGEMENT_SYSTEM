Drop user urbandusters CASCADE;

Create user urbandusters identified by DmddProject3;

grant connect to urbandusters;

grant resource to urbandusters;

alter user urbandusters quota 100M on data;

grant create view to urbandusters;
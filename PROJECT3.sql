BEGIN
EXECUTE IMMEDIATE 'DROP TABLE USERS';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE USER_ROLE';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/



/*BEGIN
EXECUTE IMMEDIATE 'DROP TABLE CONTACT';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ART_CATEGORY';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ARTWORK';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/*/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE SHIPPER';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ONLINE_EXHIBITION';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

Create table USER_ROLE(
RoleID integer NOT NULL PRIMARY KEY,
RoleName varchar(10) NOT NULL
);

Create table USERS(
UserID INTEGER NOT NULL PRIMARY KEY,
RoleID INTEGER NOT NULL,
CONSTRAINT fk_roleid
FOREIGN KEY (RoleID)
REFERENCES USER_ROLE(RoleID),
EmailID VARCHAR(45) NOT NULL,
UserName VARCHAR(20) NOT NULL,
Password VARCHAR(20) NOT NULL,
FirstName VARCHAR(45) NOT NULL,
LastName VARCHAR(45) NOT NULL,
Speciality VARCHAR(20),
Nationality VARCHAR(30));

Create table SHIPPER(
ShipperID integer NOT NULL PRIMARY KEY,
CompanyName varchar(45) NOT NULL,
ContactNumber varchar(10) NOT NULL,
EmailID varchar(45) NOT NULL
);

Create table ONLINE_EXHIBITION(
ExhibitionID integer NOT NULL PRIMARY KEY,
UserId integer REFERENCES USERS(UserId),
ExhibitionStartDateTime DATE NOT NULL,
ExhibitionEndDateTime DATE NOT NULL,
ExhibitionStatus varchar(10) NOT NULL
);
COMMIT;

truncate table USERS;
truncate table USER_ROLE;
truncate table SHIPPER;
truncate table ONLINE_EXHIBITION;

--truncate table USER_ROLE
insert into USER_ROLE values (1,'Admin');
insert into USER_ROLE values (2,'Artist');
insert into USER_ROLE values (3,'Customer');
COMMIT;

--truncate table USERS;
insert into USERS values (1,1,'artgalleryadmin@artgallery.com','admin','ArtLoverAdmin2023','Admin','Admin','','');           
insert into USERS values (2,2,'sillyartist@artgallery.com','Solomon25','SillySal23','Solomon','Williams','Sculpture','Australian');
insert into USERS values (3,2,'caseym15@artgallery.com','Caseycool','Paint66Love','Casey','Miller','Painting','German');
insert into USERS values (4,2,'antonio12@artgallery.com','JoieLePot','imperfect34Pot','Antonio','Conte','Pottery','Italian');
insert into USERS values (5,2,'Adamcruz18@artgallery.com','Adam18','Anime72Nation','Adam','Cruz','Digital','American');
insert into USERS values (6,3,'Annie90miles@artgallery.com','AnnMiles','BitterSweetArt1990','Annie','Miles','','');
COMMIT;


insert into SHIPPER VALUES(1, 'FedEx Corp', '5857643569','fedex@gmail.com');
insert into SHIPPER VALUES(2, 'UPS Inc', '6788943251','usps@gmail.com');
insert into SHIPPER VALUES(3, 'XPO Logistics', '8007552728','trailerinfo@xpo.com');
insert into SHIPPER VALUES(4, 'J.B. Hunt Transport', '8665167305','360shippersupport@jbhunt.com');
insert into SHIPPER VALUES(5, 'Knight-Swift Transport', '8665167325','knightswift@gmail.com');
insert into SHIPPER VALUES(6, 'YRC Worldwide', '8006106500','yrc@gmail.com');
insert into SHIPPER VALUES(7, 'Schneider', '8006106511','schneider@gmail.com');
insert into SHIPPER VALUES(8, 'Landstar System', '8008729400','landstar@gmail.com');
insert into SHIPPER VALUES(9, 'Old Dominion Freight Line', '8008729412','global.compliance@odfl.com');
insert into SHIPPER VALUES(10, 'TFI International', '8008729413','tfi@gmail.com');
COMMIT;

insert into Online_Exhibition VALUES(1, 2, TO_DATE('2023/05/03 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/06 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into Online_Exhibition VALUES(2, 3, TO_DATE('2023/03/21 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/26 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into Online_Exhibition VALUES(3, 3, TO_DATE('2023/04/28 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/02 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into Online_Exhibition VALUES(4, 2, TO_DATE('2023/03/20 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/04/05 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into Online_Exhibition VALUES(5, 4, TO_DATE('2023/05/20 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into Online_Exhibition VALUES(6, 5, TO_DATE('2023/03/18 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into Online_Exhibition VALUES(7, 4, TO_DATE('2023/06/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/06/30 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into Online_Exhibition VALUES(8, 5, TO_DATE('2023/05/04 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/08 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
COMMIT;

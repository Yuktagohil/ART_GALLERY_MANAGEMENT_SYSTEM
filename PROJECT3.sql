/*BEGIN
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

BEGIN
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

Create table SHIPPER(
ShipperID integer NOT NULL PRIMARY KEY,
CompanyName varchar(45) NOT NULL,
ContactNumber varchar(10) NOT NULL,
EmailID varchar(45) NOT NULL
);

Create table ONLINE_EXHIBITION(
ExhibitionID integer NOT NULL PRIMARY KEY,
UserId integer REFERENCES DEV1.USERS(UserId),
ExhibitionStartDateTime TIMESTAMP NOT NULL,
ExhibitionEndDateTime TIMESTAMP NOT NULL,
ExhibitionStatus varchar(10) NOT NULL
);

truncate table SHIPPER;
truncate table Online_Exhibition;

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



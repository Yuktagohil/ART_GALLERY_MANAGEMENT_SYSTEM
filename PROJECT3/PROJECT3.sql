SET SERVEROUTPUT ON;

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE USER_ROLE CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE USERS CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE CONTACT CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ORDERS CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ORDER_ITEMS CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ART_CATEGORY CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ARTWORK CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE SHIPPER CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ONLINE_EXHIBITION CASCADE CONSTRAINTS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/
  
Create table USER_ROLE(
RoleID integer NOT NULL PRIMARY KEY,
RoleName varchar(10) NOT NULL
);

Create table USERS(
UserID integer NOT NULL PRIMARY KEY,
RoleID integer NOT NULL,
FOREIGN KEY (RoleID)
REFERENCES USER_ROLE(RoleID),
EmailID varchar(45) NOT NULL,
UserName varchar(20) NOT NULL,
Password varchar(20) NOT NULL,
FirstName varchar(45) NOT NULL,
LastName varchar(45) NOT NULL,
Speciality varchar(45),
Nationality varchar(45));

CREATE table CONTACT(
ContactID integer NOT NULL PRIMARY KEY,
UserID integer NOT NULL,
FOREIGN KEY (UserID)
REFERENCES USERS (UserID),
ContactNumber varchar(10) UNIQUE NOT NULL,
AddressLine1 varchar(45) NOT NULL,
AddressLine2 varchar(45) NOT NULL,
City varchar(45) NOT NULL,
State varchar(45) NOT NULL,
Country varchar(45) NOT NULL,
ZipCode integer NOT NULL
);

Create table SHIPPER(
ShipperID integer NOT NULL PRIMARY KEY,
CompanyName varchar(45) NOT NULL,
ContactNumber varchar(10) NOT NULL,
EmailID varchar(45) NOT NULL
);

Create table ONLINE_EXHIBITION(
ExhibitionID integer NOT NULL PRIMARY KEY,
UserID integer NOT NULL,
FOREIGN KEY (UserID)
REFERENCES USERS(UserId),
ExhibitionStartDateTime DATE NOT NULL,
ExhibitionEndDateTime DATE NOT NULL,
ExhibitionStatus varchar(10) NOT NULL
);

Create table ORDERS(
OrderID integer NOT NULL PRIMARY KEY,
UserID integer NOT NULL,
FOREIGN KEY (UserID) 
REFERENCES USERS (UserID),
ShipperID integer NOT NULL,
FOREIGN KEY (ShipperID) 
REFERENCES SHIPPER (ShipperID),
TransactionID Number NOT NULL,
TransactionMethod varchar(45) NOT NULL,
TransactionStatus varchar(45) NOT NULL,
OrderStatus varchar(45) NOT NULL,
ShippingStatus varchar(80) NOT NULL,
ShippingAddress varchar(150) NOT NULL,
OrderDateTime DATE NOT NULL,
TotalAmount number NOT NULL
);


Create table ORDER_ITEMS(
OrderItemsID integer NOT NULL PRIMARY KEY,
OrderID integer NOT NULL,
FOREIGN KEY (OrderID) REFERENCES ORDERS (OrderID)
);

Create table ART_CATEGORY(
ArtCategoryID integer NOT NULL PRIMARY KEY,
ArtCategory varchar(45) NOT NULL
);

Create table ARTWORK(
ArtworkID integer NOT NULL PRIMARY KEY,
UserID integer NOT NULL,
FOREIGN KEY (UserID) 
REFERENCES USERS (UserID),
ArtCategoryID integer NOT NULL,
FOREIGN KEY (ArtCategoryID) 
REFERENCES ART_CATEGORY (ArtCategoryID),
ExhibitionID integer,
FOREIGN KEY (ExhibitionID) 
REFERENCES ONLINE_EXHIBITION (ExhibitionID),
OrderItemsID integer,
FOREIGN KEY (OrderItemsID) 
REFERENCES ORDER_ITEMS (OrderItemsID),
Name varchar(45) NOT NULL,
Description varchar(200) NOT NULL,
Amount number NOT NULL,
Status varchar(45) NOT NULL,
ArtworkImage BLOB NOT NULL
);
COMMIT;

truncate table USERS;
truncate table USER_ROLE;
truncate table ARTWORK;
truncate table ART_CATEGORY;
truncate table CONTACT;
truncate table SHIPPER;
truncate table ONLINE_EXHIBITION;
truncate table ORDERS;
truncate table ORDER_ITEMS;

--insert values in table USER_ROLE
insert into USER_ROLE values (1,'Admin');
insert into USER_ROLE values (2,'Artist');
insert into USER_ROLE values (3,'Customer');
COMMIT;

--insert values in table USERS;
insert into USERS values (1,1,'artgalleryadmin@artgallery.com','admin','ArtLoverAdmin2023','Admin','Admin','','');           
insert into USERS values (2,2,'sillyartist@artgallery.com','solomon25','SillySal23','Solomon','Williams','Sculpture','Australian');
insert into USERS values (3,2,'caseym15@artgallery.com','caseycool','Paint66Love','Casey','Miller','Painting','German');
insert into USERS values (4,2,'conte.antonio12@artgallery.com','joielepot','imperfect34Pot','Antonio','Conte','Pottery','Italian');
insert into USERS values (5,2,'adamcruz18@artgallery.com','adam18','Anime72Nation','Adam','Cruz','Digital','American');
insert into USERS values (6,3,'annie90miles@artgallery.com','annmiles','BitterSweetArt1990','Annie','Miles','','');
insert into USERS values (7,3,'maria27g@artgallery.com','maria27','ArtPopos55','Maria','Garcia','','');
insert into USERS values (8,3,'alexbrown@artgallery.com','alex22','BrownSugar22','Alexandar','Brown','','');
insert into USERS values (9,3,'hern.eric85@artgallery.com','eric16','Mission16travel','Eric','Hernandez','','');
insert into USERS values (10,3,'nancy1229@artgallery.com','nancy29','LordBlesseth92','Nancy','Kurian','','');
insert into USERS values (11,3,'vineeth.krishnan@artgallery.com','vinukrishnan','VinuK30mallu','Vineeth','Krishnan','','');
insert into USERS values (12,2,'thomas.shelby@artgallery.com','tomshelby','Coast23Love','Thomas','Shelby','Sketching','Scandinavian');
insert into USERS values (13,2,'cooper.sheldon@artgallery.com','sheldon7mo','MoLove8Shel','Sheldon','Cooper','Mosaic','Brazilian');
insert into USERS values (14,3,'hart.casie@artgallery.com','hart5ca','Belief1hart','Casie','hart','','');
insert into USERS values (15,3,'lock.simone@artgallery.com','lockesi85','Key2Locke','Simone','Locke','','');
insert into USERS values (16,2,'hardway.paige@artgallery.com','paigeway','Therasa4ever','Paige','Hardaway','Tapestry','Irish');
insert into USERS values (17,3,'dobrev.nina@artgallery.com','nina22dob','Sweet89Little','Nina','Dobrev','','');
insert into USERS values (18,2,'raja.zahid@artgallery.com','rajazahid','dragonlair69','Zahid','Raja','GlassArt','Moroccan');
insert into USERS values (19,3,'gerard.marcel@artgallery.com','gerardmarc','Pro27gerard','Marcel','Gerard','','');
insert into USERS values (20,2,'gardener.samuel@artgallery.com','gardenersam','Penguin4Sam','Samuel','Gardener','Sketching','American');
insert into USERS values (21,2,'thyag.jaya21@artgallery.com','jayabheem55','47JayegaeBharath','Jaya','Thyagarajan','Painting','Indian');
insert into USERS values (22,3,'guna.menula44@artgallery.com','menuguna44','Almighty4ever','Menula','Gunasekar','','');
insert into USERS values (23,3,'pitt.brad@artgallery.com','pitt66brad','benevolentGoat1','Brad','Pitt','','');
insert into USERS values (24,2,'hutch.fiona3@artgallery.com','fionahutch77','nbfajrg34r','Fiona','Hutchinson','Tapestry','Scottish');
insert into USERS values (25,3,'smith39jamie@artgallery.com','smithjames','eeecool1234','Jamie','Smith','','');
insert into USERS values (26,2,'chat30Anindhya@artgallery.com','anindchat45','Chakra65mela','Anindhya','Chattopadhyay','Wood Sculpture','Indian');
insert into USERS values (27,3,'tony13manasa@artgallery.com','manasatony','samosa4life','Manasa','Tony','','');
insert into USERS values (28,3,'conteadam1@artgallery.com','adamconte18','pasta7mammamia','Adam','Conte','','');
insert into USERS values (29,3,'mullaisrinivasan@artgallery.com','mullaisri85','malar21mullai','Mullai','Srinivasan','','');
insert into USERS values (30,2,'duss.jason4@artgallery.com','jasonduss','Jasonwill63Can','Jason','Dussault','Mosaic','Canadian');
COMMIT;

--insert values in table contact
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (1,1, 8572639860, '1575 Tremont street', 'APT 2', 'Boston', 'MA', 'USA', 02129);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (2,2, 8575689968, 'Roxbury crossing', 'APT 3', 'Boston', 'MA', 'USA', 02689);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (3,3, 6975698560, '15 Malden', 'APT 8', 'Los angeles', 'CA', 'USA', 5972);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (4,4, 5698742635, '1575 mango Street', 'APT 9', 'San Antonio', 'TX', 'USA', 8975);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (5,5, 5697895620, '857 Hungtionton Ave', 'Boylston', 'Boston', 'MA', 'USA', 5698);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (6,6, 5987895640, 'Newburg street', 'Dorchester', 'Dallas', 'TX', 'USA', 0219);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (7,7, 6987453026, '160 Alpine road', 'Brookline', 'Philadelphia', 'PA', 'USA', 2101);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (8,8, 5697854120, '12 Saint Fr. RD', 'Dorchester', 'San Diego', 'CA', 'USA', 9878);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (9,9, 5669842635, '60 Spine Road', 'Cambriegde', 'Dallas', 'TX', 'USA', 1203);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (10,10, 5656942635, '23 Brookline', 'Newport', 'Boston', 'MA', 'USA', 06897);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (11,11, 5698785063, '15 Cawfield street', 'Dorchester', 'Houston', 'TX', 'USA', 56890);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (12,12, 5695692635, '36 Washignton street', 'Nubian', 'Chicago', 'IL', 'USA', 06923);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (13,13, 8975692031, 'Apple Street', 'Dustun', 'Phoenix', 'AZ', 'USA', 03689);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (14,14, 6987894120, 'Manhatten street', 'George_mason RD', 'San Jose', 'CS', 'USA', 02369);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (15,15, 4895201698, 'Area 51', 'Washington square', 'Colrado', 'CO', 'USA', 03215);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (16,16, 6587420135, 'Swiss Street', 'Hartford', 'Buffalo', 'NY', 'USA', 04265);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (17,17, 369750359, 'Phoenix street', 'Virginia', 'Hollywood', 'FL', 'USA', 03698);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (18,18, 3697851026, 'Virginia street', 'Enterprise RD', 'Kansas', 'KS', 'USA', 01597);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (19,19, 6987562100, 'Mission Hill', 'Park Drive', 'Wichita', 'KS', 'USA', 06986);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (20,20, 3697895620, 'Mission Main', 'Dudely street', 'indianapolis', 'IN', 'USA', 03689);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (21,21, 5698795210, 'Columbia Rd', 'Blue hill', 'Lowell', 'MA', 'USA', 12368);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (22,22, 7894561230, 'Becon street', 'Strand Theater', 'New Orleans', 'LA', 'USA', 35974);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (23,23, 5789641203, 'Cooliegde Corner', 'Brookline', 'San Francisco', 'CA', 'USA', 57896);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (24,24, 5687410239, 'Tappan Street', 'clevanland Circle', 'Tucson', 'AZ', 'USA', 23697);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (25,25, 4597852013, 'Cambriedge', 'Bird St', 'Yonkers', 'NY', 'USA', 56974);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (26,26, 6574520139, 'Mass Avenue', 'Saint francis St', 'Montgomery', 'AL', 'USA', 60210);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (27,27, 4578956210, 'Fields Corner', '19 St', 'Detroit', 'MI', 'USA', 44597);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (28,28, 1267894560, 'Albama St', 'Rodester Ave', 'Greeley', 'CO', 'USA', 21382);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (29,29, 4578568920, 'Flemingo Circle', 'Red cherry Ave', 'Enterprise', 'NV', 'USA', 56875);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (30,30, 5742368901, 'Oberoi Rd', 'Huntington Ave', 'joliet', 'IL', 'USA', 12345);
COMMIT;

--insert values in table shipper
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

--insert values in table online_exhibition
insert into ONLINE_EXHIBITION VALUES(1, 2, TO_DATE('2023/05/03 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/06 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(2, 3, TO_DATE('2023/03/21 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/26 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(3, 3, TO_DATE('2023/04/28 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/02 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(4, 2, TO_DATE('2023/03/20 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/04/05 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(5, 4, TO_DATE('2023/05/20 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(6, 5, TO_DATE('2023/03/18 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(7, 4, TO_DATE('2023/06/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/06/30 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(8, 5, TO_DATE('2023/05/04 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/08 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(9, 12, TO_DATE('2023/05/09 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/14 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(10, 13, TO_DATE('2023/03/22 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/28 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(11, 12, TO_DATE('2023/06/04 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/06/08 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(12, 16, TO_DATE('2023/03/18 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/21 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(13, 18, TO_DATE('2023/05/14 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/05/18 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(14, 30, TO_DATE('2023/04/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/04/30 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(15, 26, TO_DATE('2023/03/23 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/29 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(16, 21, TO_DATE('2023/02/23 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/02/27 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
insert into ONLINE_EXHIBITION VALUES(17, 20, TO_DATE('2023/01/23 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/01/29 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
insert into ONLINE_EXHIBITION VALUES(18, 18, TO_DATE('2023/03/26 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/29 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(19, 30, TO_DATE('2023/02/13 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/02/19 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
insert into ONLINE_EXHIBITION VALUES(20, 18, TO_DATE('2023/03/03 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/09 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
COMMIT;

--inser values in table orders
INSERT INTO ORDERS
VALUES (1, 6, 3, 476523654824, 'wire transfer', 'complete', 'Confirmed', 'Shipped', '123 XYZ street', TO_DATE('20-MAR-2023 12:33:44', 'DD-MON-YYYY HH24:MI:SS'), 30);
INSERT INTO ORDERS
VALUES (2, 7, 4, 567252464393, 'net banking', 'complete', 'Confirmed', 'Shipped', '345 MNO street', TO_DATE('01-MAR-2023 13:30:00', 'DD-MON-YYYY HH24:MI:SS'), 35);
INSERT INTO ORDERS
VALUES (3, 8, 3, 545475937224, 'wire transfer', 'complete', 'Confirmed', 'Transit', '123 MNP street', TO_DATE('09-MAR-2023 12:54:40', 'DD-MON-YYYY HH24:MI:SS'), 60);
INSERT INTO ORDERS
VALUES (4, 9, 9, 527877595957, 'debit', 'complete', 'Confirmed', 'Shipped', '1 BC street', TO_DATE('08-MAR-2023 12:34:45', 'DD-MON-YYYY HH24:MI:SS'), 20);
INSERT INTO ORDERS
VALUES (5, 10, 1, 492865850176, 'wire transfer', 'complete', 'Confirmed', 'Transit', '30 ABC street', TO_DATE('07-MAR-2023 10:30:44', 'DD-MON-YYYY HH24:MI:SS'), 45);
INSERT INTO ORDERS
VALUES (6, 11, 6, 401636848464, 'Netbanking', 'complete', 'Confirmed', 'Preparing to be Shipped', '40 ION street', TO_DATE('20-MAR-2023 16:33:44', 'DD-MON-YYYY HH24:MI:SS'), 150);
INSERT INTO ORDERS
VALUES (7, 14, 3, 3045975648585, 'debit', 'complete', 'Confirmed', 'Shipped', '98 NILL street', TO_DATE('16-MAR-2023 19:06:00', 'DD-MON-YYYY HH24:MI:SS'), 59);
INSERT INTO ORDERS
VALUES (8, 15, 1, 4874500235552, 'Netbanking', 'complete', 'Confirmed', 'Preparing to be Shipped', '40 ION street', TO_DATE('19-MAR-2023 09:00:06', 'DD-MON-YYYY HH24:MI:SS'), 150);
INSERT INTO ORDERS
VALUES (9, 17, 3, 3858060877590, 'debit', 'complete', 'Confirmed', 'Shipped', '98 NILL street', TO_DATE('09-MAR-2023 07:33:40', 'DD-MON-YYYY HH24:MI:SS'), 59);
INSERT INTO ORDERS
VALUES (10, 19, 3, 476567598877, 'wire transfer', 'complete', 'Confirmed', 'Shipped', '9 NULL street',TO_DATE('21-MAR-2023 23:45:09', 'DD-MON-YYYY HH24:MI:SS'), 60);
INSERT INTO ORDERS
VALUES (11, 22, 5, 554685972838, 'debit', 'complete', 'Confirmed', 'Shipped', '8 ADC street', TO_DATE('08-MAR-2023 03:30:44', 'DD-MON-YYYY HH24:MI:SS'), 59);
INSERT INTO ORDERS
VALUES (12, 23, 7, 397978976870, 'net banking', 'complete', 'Confirmed', 'Shipped', '79 PEAK street', TO_DATE('20-MAR-2023 00:30:44', 'DD-MON-YYYY HH24:MI:SS'), 78);
INSERT INTO ORDERS
VALUES (13, 25, 2, 387970980824, 'debit', 'complete', 'Confirmed', 'Preparing to be Shipped', '134 SEEP street', TO_DATE('09-MAR-2023 10:30:44', 'DD-MON-YYYY HH24:MI:SS'), 90);
INSERT INTO ORDERS
VALUES (14, 27, 6, 198080453424, 'credit', 'complete', 'Confirmed', 'Shipped', '143 LOVE street',TO_DATE('22-MAR-2023 20:30:44', 'DD-MON-YYYY HH24:MI:SS'), 98);
INSERT INTO ORDERS
VALUES (15, 28, 5, 109904640844, 'debit', 'complete', 'Confirmed', 'Shipped', '98 MON street', TO_DATE('11-MAR-2023 18:03:44', 'DD-MON-YYYY HH24:MI:SS'), 56);
COMMIT;

--insert values in table orderitems
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(1,1);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(2,2);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(3,3);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(4,4);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(5,5);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(6,6);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(7,7);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(8,8);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(9,9);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(10,10);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(11,11);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(12,12);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(13,13);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(14,14);
INSERT INTO ORDER_ITEMS (OrderItemsID, OrderID)
VALUES(15,15);
COMMIT;

--insert values in table artcategory
insert into ART_CATEGORY VALUES(1, 'Painting');
insert into ART_CATEGORY VALUES(2, 'Sculpture');
insert into ART_CATEGORY VALUES(3, 'DigitalArt');
insert into ART_CATEGORY VALUES(4, 'Photography');
insert into ART_CATEGORY VALUES(5, 'Drawing');
insert into ART_CATEGORY VALUES(6, 'Tapestry');
insert into ART_CATEGORY VALUES(7, 'GlassArt');
insert into ART_CATEGORY VALUES(8, 'Mosaic');
insert into ART_CATEGORY VALUES(9, 'Wood Sculpture');
insert into ART_CATEGORY VALUES(10, 'Pottery');
COMMIT;

--insert values in table artwork
insert into ARTWORK VALUES(1,2, 2, 1, NULL, 'The Banjo Lesson', 'A Painting depicting an elderly man teaching a young boy how to play the banjo', 65, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(2,3, 1, 2, 2, 'Autumnal Equinox', 'A Painting depicting changing colors of autumn leaves against blue sky', 99, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(3,4, 10, 5, NULL, 'Dreamy Garden', 'A pottery piece with a whimsical design of flowers and vines', 140, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(4,5, 3, 6, 4, 'Synthetic Beauty', 'A digital artwork with an abstract design of geometric shapes and patterns', 75, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(5,16, 6, 12, 5, 'Mystical Forest', 'A tapestry with a dreamy design of a forest with mist and magic', 37, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(6,13, 8, 10, 6, 'The Underwater World', 'A mosaic artwork depicting an ocean scene with fish and plants', 55, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(7,3, 1, 2, 7, 'Reflections', 'A landscape painting of a serene lake surrounded by mountains', 115, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(8,12, 5, 5, NULL, 'The Power of Nature', 'A sketch of a tree with a sense of strength and resilience', 75, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(9,20, 5, 17, 4, 'Sketch of Dream', 'This artwork is a black and white pencil drawing of a surreal landscape', 126, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(10,21, 1, 16, 3, 'The Lonely Sailor', 'A portrait painting of a sailor standing on a rocky shore', 85, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp')); 
insert into ARTWORK VAlUES(11,24, 6, 11, NULL, 'Scared Cows', 'a series of tapestries featuring colorful, abstracted depictions of cows', 115, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(12,4, 10, 5, NULL, 'Timeless Tradition', 'A pottery piece with a classic design inspired by traditional pottery', 210, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(13,30, 8, NULL, 6, 'Renaissance Beauty', 'A mosaic artwork depicting a classical portrait of a woman with intricate details', 184, 'Not Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(14,12, 5, 9, NULL, 'The Leaf and the Fire', 'an abstract sketching featuring bold, gestural brushstrokes and a muted color palette', 55, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(15,30, 8, 14, NULL, 'Beneath the Waves', 'A mosaic artwork depicting an underwater scene with fish and coral', 250, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(16,4, 10, 5, NULL, 'Rustic Charm', 'A pottery piece with a rustic and natural texture', 275, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(17,5, 3, 6, 11, 'Digital Dreamscape', 'A digital painting of a dreamlike landscape with surreal colors and shapes', 110, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(18,13, 8, 10, 11, 'The Dance of Life', 'A mosaic artwork with a vibrant design of swirling colors and figures', 199, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(19,26, 9, 15, 1, 'Spirit of the Forest', 'A wood sculpture depicting a tree with a sense of life and energy', 142, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(20,2, 2, 1, NULL, 'Cosmic Ocean', 'A sculpture of a swirling galaxy made from wire and lights', 139, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(21,5, 3, 6, 12, 'Pixelated Paradise', 'A digital artwork with a retro, pixelated aesthetic of a tropical island scene', 135, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(22,21, 1, NULL, NULL, 'A Beautiful Mess', 'An abstract painting with vibrant colors and dynamic brushstrokes', 150, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(23,30, 8, 14, NULL, 'The Enchanted Forest', 'A mosaic artwork depicting a magical forest with trees and animals', 99, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(24,18, 7, 13, NULL, 'Underwater Garden', 'A glass sculpture of a coral reef with vibrant colors and intricate details', 75, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(25,3, 1, 2, 12, 'The Garden of Dreams', 'A surrealistic painting with fantastical imagery of plants and animals', 55, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(26,21, 1, 16, 2, 'Dark Horizons', 'A moody painting of a stormy sea with dark clouds overhead', 89, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(27,13, 8, 10, 13, 'Celestial Wonder', 'A mosaic artwork with an abstract design of stars and planets', 85, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(28,24, 3, 11, NULL, 'Rustic Charm', 'A tapestry with a cozy design of a cabin in the woods with trees and animals', 150, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(29,18, 7, 13, NULL, 'Rainbow Vortex', 'A glass sculpture of a swirling vortex with multiple colors and patterns', 221, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(30,26, 9, NULL, NULL, 'The Beauty of Chaos', 'A wood sculpture with a chaotic design of intersecting shapes and forms', 65, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(31,2, 2, 1, NULL, 'Glimmering Sea', 'A sculpture of a school of fish made from polished metal', 175, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(32,16, 6, 12, 13, 'Spectral Symphony', 'A tapestry with a colorful abstract design reminiscent of stained glass windows', 95, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(33,24, 3, 11, NULL, 'Tribal Rhythms', 'A tapestry with a bold pattern inspired by tribal designs in black and white', 80, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(34,18, 7, 13, NULL, 'Light and Shadow', 'A glass sculpture of an important technique to represent illusory space in painting', 214, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(35,20, 5, 17, NULL, 'Inner Turmoil', 'A sketch of a person struggling with inner conflict with expressive lines and shading', 160, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(36,16, 6, 12, 14, 'Floral Serenity', 'A tapestry with a peaceful design of flowers and leaves in soft colors', 123, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(37,26, 9, 15, 1, 'Nature Symphony', 'A wood sculpture depicting a forest with a sense of harmony and balance', 65, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(38,12, 5, 9, NULL, 'The City at Night', 'A sketch of a city skyline at night with a sense of energy and excitement', 143, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(39,20, 5, NULL, 5, 'The Wonder of Wildlife', 'A sketch of an animal with a sense of curiosity and wildness', 120, 'Not Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(40,30, 8, 14, NULL, 'Alexander Mosaic', 'A famous Roman mosaic depicting the Battle of Issus between Alexander the Great', 184, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(41,26, 9, 15, NULL, 'Dainichi Nyorai', 'A wooden sculpture of the Buddhist deity Dainichi Nyorai', 104, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(42,21, 1, 16, 2, 'The Creation of Adam', 'A fresco painting by Michelangelo depicting the biblical scene of God creating Adam', 120, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(43,20, 5, 17, NULL, 'The Human Condition', 'A sketch depicting a figure standing in front of a painting of a landscape', 95, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(44,18, 7, 18, NULL, 'Waterfall Chandelier', 'A grand chandelier made of crystal glass beads that simulate a waterfall', 50, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(45,30, 8, 19, NULL, 'Islamic Mosaic Art', 'A rich tradition of mosaic,featuring intricate geometric patterns and calligraphy', 250, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(46,18, 7, 20, 7, 'The Four Seasons', 'A series of stained-glass windows depicting scenes from the four seasons', 220, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(47,2, 2, NULL, 15, 'Venus de Milo', 'An ancient Greek statue believed to depict the goddess Aphrodite', 120, 'Not Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(48,16, 6, NULL, 14, 'The Lady and the Unicorn', 'A series of six tapestries from the late Middle Ages depicting a lady and a unicorn', 100, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(49,24, 6, NULL, 15, 'Autumn Landscape', 'a large tapestry that features a range of colors and textures, evoking the rich colors of fall foliage', 300, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(50,24, 6, NULL, 15, 'Beyond the Limit', 'a large-scale tapestry that features a grid of repeating patterns, evoking the idea of a labyrinth or maze', 290, 'Not Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(51,24, 6, NULL, 14, 'Sea Change', 'a delicate tapestry that features undulating waves and swirling patterns, for the love of the ocean', 200, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(52, 16, 1, 3, NULL, 'Ethereal Dreams', 'his painting features a whimsical, surrealistic landscape with floating islands and ethereal creatures', 167, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(53, 15, 7, 3, NULL, 'Oceanic Currents', 'This glass sculpture features intricate swirls and curves reminiscent of ocean waves and currents', 250, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(54, 12, 3, 3, NULL, 'Virtual Reality', 'his digital artwork explores the intersection of technology and the natural world, depicting a futuristic landscape with soaring skyscrapers and floating islands', 95, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(55, 6, 4, 4, 10, 'Reflections in the City', 'This photograph captures the vibrant, colorful reflections of a cityscape in a puddle on the ground', 65, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(56, 7, 5, 4, 3, 'Portrait of a Young Woman', 'his sketch depicts a young woman with delicate features and a slight smile on her lips', 85, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(57, 13, 5, 4, 10, 'Rose', 'This sketch depicts a delicate rose in fine detail, with careful shading and intricate linework to bring out its textures and contours', 220, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(58, 5, 4, 7, NULL, 'The Red Door', 'This photograph captures the vibrant red of an old door, with careful attention to light and shadow to create a sense of depth and texture', 250, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(59, 11, 4, 7, NULL, 'The Abandoned Building', 'This photograph explores the haunting beauty of an abandoned building, with stark contrasts and rich textures to evoke a sense', 199, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(60, 8, 5, 7, NULL, 'Cityscape', 'This sketch captures the bustling energy and architectural details of a cityscape, with fine lines and careful attention to perspective', 300, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(61, 17, 4, 8, NULL, 'Old Man and His Dog', 'This photograph features an elderly man walking with his dog, with both figures captured in a moment of contemplation and reflection', 250, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(62, 24, 3, 8, NULL, 'The Hidden City', 'This digital artwork features a fantastical cityscape hidden among the clouds, with sweeping curves and intricate details', 99, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(63, 18, 5, 8, NULL, 'Nostalgia', 'This sketch depicts a young woman gazing out a window with a wistful expression', 167, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(64, 9, 5, 11, NULL, 'The Dancer', 'This sketch features a dancer in motion, captured in mid-leap', 139, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(65, 10, 4, 11, NULL, 'The Lonely Tree', 'This photograph features a solitary tree on a vast desert landscape', 275, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(66, 5, 4, 11, NULL, 'The Lost City', 'This photograph captures the ruins of an ancient city, slowly being overtaken by nature', 221, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(67, 6, 3, 18, NULL, 'Frost', 'A digital painting of a winter forest, featuring intricate details of ice crystals and snow-covered trees.', 65, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(68, 15, 7, 19, 3, 'Seafoam', 'A delicate glass sculpture of a seashell, with intricate details that capture the beauty of the natural world', 75, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(69, 26, 7, 18, NULL, 'Celestial Bodies', 'A series of glass orbs in various sizes and colors, each one representing a different planet or celestial body in our solar system', 300, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(70, 12, 6, 20, 8, 'Waves', 'A large-scale tapestry that depicts the ebb and flow of ocean waves, with layers of blues and greens that create a sense of movement', 250, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(71, 22, 6, 19, 1, 'Moonlit Garden', 'A tapestry that captures the beauty of a nighttime garden, with delicate flowers and vines illuminated by the light of the moon', 275, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(72, 18, 3, 20, 8, 'The Phoenix', 'A vibrant glass sculpture of a bird in flight, with swirling colors that evoke the mythical creatures fiery rebirth', 85, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(73, 5, 3, NULL, 9, 'The Electric Garden', 'a digital painting featuring a surreal landscape with glowing flowers and swirling vines', 115, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(74, 1, 3, NULL, 9, 'Code Dreams', 'a digital painting of a woman dreaming in code, with lines of programming language flowing around her', 143, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(75, 17, 2, NULL, NULL, 'The Whispere', 'a bronze sculpture of a woman with flowing hair, leaning in to listen to a small bird perched on her hand', 275, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(76, 13, 4, NULL, 10, 'Elysium', 'A glass sculpture that features a series of overlapping, translucent layers that create a sense of depth and movement', 140, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
COMMIT;

--update exhibition status in table online exhibition based on current date
Update ONLINE_EXHIBITION OE SET OE.ExhibitionStatus = 'Completed' WHERE OE.ExhibitionStartDateTime < SYSDATE AND OE.ExhibitionEndDateTime < SYSDATE;
COMMIT;
Update ONLINE_EXHIBITION OE SET OE.ExhibitionStatus = 'Active'  WHERE OE.ExhibitionStartDateTime <= SYSDATE AND OE.ExhibitionEndDateTime >= SYSDATE;
COMMIT;
Update ONLINE_EXHIBITION OE SET OE.ExhibitionStatus = 'Upcoming'  WHERE OE.ExhibitionStartDateTime > SYSDATE;
COMMIT;

--list of upcoming exhibitions of an artist
CREATE OR REPLACE VIEW ARTIST_UPCOMING_EXHIBITIONS AS
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS FirstName,USERS.LastName AS LastName,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE USERS.FirstName = 'Thomas' AND USERS.LastName = 'Shelby' AND ONLINE_EXHIBITION.ExhibitionStartDateTime > SYSDATE;
COMMIT;

--list of all upcoming exhibtions
CREATE OR REPLACE VIEW ALL_UPCOMING_EXHIBITIONS AS
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS ARTIST_FIRST_NAME,USERS.LastName AS ARTIST_LAST_NAME,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE ONLINE_EXHIBITION.ExhibitionStartDateTime > SYSDATE;
COMMIT;

--list of users based on userrole (rolename can be Artist,Customer or Admin)
CREATE OR REPLACE VIEW USERPROFILE_BASED_ON_USERROLE AS
SELECT UserID,FirstName,LastName,EmailID,USER_ROLE.RoleName from USERS JOIN USER_ROLE ON USERS.ROLEID = USER_ROLE.ROLEID
WHERE USER_ROLE.RoleName = 'Artist';
COMMIT;

--list of active exhibitions of an artist
CREATE OR REPLACE VIEW ARTIST_ACTIVE_EXHIBITIONS AS
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS FirstName,USERS.LastName AS LastName,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE USERS.FirstName = 'Solomon' AND USERS.LastName = 'Williams' AND ONLINE_EXHIBITION.ExhibitionStartDateTime <= SYSDATE AND ONLINE_EXHIBITION.ExhibitionEndDateTime >= SYSDATE;
COMMIT;

--list of all active exhibtions
CREATE OR REPLACE VIEW ALL_ACTIVE_EXHIBITIONS AS
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS ARTIST_FIRST_NAME,USERS.LastName AS ARTIST_LAST_NAME,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE ONLINE_EXHIBITION.ExhibitionStartDateTime <= SYSDATE AND ONLINE_EXHIBITION.ExhibitionEndDateTime >= SYSDATE;
COMMIT;

--list of artist unsold artwork details
CREATE OR REPLACE VIEW ARTIST_UNSOLD_ARTWORK AS
SELECT USERS.FirstName,USERS.LastName,ARTWORK.ArtworkID, ARTWORK.Name, ARTWORK.Status,ARTWORK.Description, ARTWORK.Amount 
FROM ARTWORK
JOIN USERS ON USERS.UserID = ARTWORK.UserID
where USERS.FirstName = 'Fiona' AND USERS.LastName = 'Hutchinson' AND ARTWORK.Status='Available';
COMMIT;

--list of active exhibition artworks
CREATE OR REPLACE VIEW ACTIVE_EXHIBITION_ARTWORK AS
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus as Exhibition_status,ARTWORK.ArtworkID, ARTWORK.Name, ARTWORK.Description, ARTWORK.Amount
FROM ARTWORK
JOIN ONLINE_EXHIBITION ON ONLINE_EXHIBITION.ExhibitionID = ARTWORK.ExhibitionID
WHERE ONLINE_EXHIBITION.ExhibitionStatus = 'Active';
COMMIT;

--list of all unsold artwork details
CREATE OR REPLACE VIEW ALL_UNSOLD_ARTWORK AS
SELECT USERS.FirstName as ARTIST_FIRST_NAME,Users.LastName AS ARTIST_LAST_NAME,ARTWORK.Name,ARTWORK.Status,ARTWORK.Amount 
FROM ARTWORK
JOIN USERS ON USERS.UserID = Artwork.UserID
where ARTWORK.Status = 'Available';
COMMIT;

--list of all orders and their shipper info
CREATE OR REPLACE VIEW ORDER_SHIPPER_INFO AS
SELECT ORDERS.OrderID, Orders.ShipperID, Orders.ShippingStatus, SHIPPER.CompanyName as SHIPPER_COMPANY, SHIPPER.EmailID as SHIPPER_EMAIL , SHIPPER.ContactNumber as SHIPPER_CONTACT
FROM ORDERS
JOIN SHIPPER ON ORDERS.ShipperID = SHIPPER.ShipperID;
COMMIT;

--list of all unshipped orders
CREATE OR REPLACE VIEW UNSHIPPED_ORDER_INFO AS
SELECT ORDERS.OrderID, Orders.ShipperID, Orders.ShippingStatus, SHIPPER.CompanyName as SHIPPER_COMPANY, SHIPPER.EmailID as SHIPPER_EMAIL , SHIPPER.ContactNumber as SHIPPER_CONTACT
FROM ORDERS
JOIN SHIPPER ON ORDERS.ShipperID = SHIPPER.ShipperID
WHERE Orders.ShippingStatus='Preparing to be Shipped';
COMMIT;

--list of available artwork in onlineartgallery
CREATE OR REPLACE VIEW GALLERY_ARTWORK_INFO AS 
SELECT USERS.FirstName AS ARTIST_FIRSTNAME,USERS.LastName AS ARTIST_LASTNAME, ARTWORK.ExhibitionID, ARTWORK.ArtworkID, ARTWORK.Name,ARTWORK.Description,ARTWORK.Status,ARTWORK.Amount
FROM ARTWORK
JOIN USERS ON USERS.UserID = ARTWORK.UserID
Where ARTWORK.Status = 'Available' and ARTWORK.ExhibitionID is NULL;
COMMIT;

--list of all order detail of a particular customer
CREATE OR REPLACE VIEW CUSTOMER_ORDER AS
SELECT USERS.FirstName,USERS.LastName,ORDERS.OrderID, ORDERS.ShipperID, ORDERS.OrderDateTime, ORDERS.TransactionID, ORDERS.Transactionstatus, ORDERS.OrderStatus, ORDERS.ShippingStatus
FROM ORDERS
JOIN USERS ON USERS.UserID = ORDERS.UserID
WHERE USERS.FirstName = 'Annie' and USERS.LastName='Miles';
COMMIT;

--list of all online exhibition of an artist
CREATE OR REPLACE VIEW ARTIST_EXHIBITION AS
SELECT ONLINE_EXHIBITION.ExhibitionID, ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS ARTIST_FIRST_NAME, USERS.LastName AS ARTIST_LAST_NAME
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE USERS.FirstName = 'Solomon' and USERS.LastName='Williams';
COMMIT;


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
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ART_CATEGORY CASCADE CONSTRAINTS';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ARTWORK CASCADE CONSTRAINTS';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE SHIPPER CASCADE CONSTRAINTS';
EXCEPTION
WHEN OTHERS
THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ONLINE_EXHIBITION CASCADE CONSTRAINTS';
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
ContactID int NOT NULL PRIMARY KEY,
UserID int REFERENCES USERS (UserID),
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
UserID integer REFERENCES USERS(UserId),
ExhibitionStartDateTime DATE NOT NULL,
ExhibitionEndDateTime DATE NOT NULL,
ExhibitionStatus varchar(10) NOT NULL
);

Create table ART_CATEGORY(
ArtCategoryID integer NOT NULL PRIMARY KEY,
ArtCategory varchar(45) NOT NULL
);

Create table ARTWORK(
UserID integer NOT NULL,
ArtCategoryID integer NOT NULL,
ExhibitionID integer,
OrderItemsID integer NOT NULL,
Name varchar(45) NOT NULL,
Description varchar(100) NOT NULL,
Amount number NOT NULL,
Status varchar(45) NOT NULL,
ArtworkImage BLOB NOT NULL,
FOREIGN KEY (UserID) REFERENCES USERS (UserID),
FOREIGN KEY (ArtCategoryID) REFERENCES ART_CATEGORY (ArtCategoryID),
FOREIGN KEY (ExhibitionID) REFERENCES ONLINE_EXHIBITION (ExhibitionID)
--FOREIGN KEY (OrderItemsID) REFERENCES ORDER_ITEMS (OrderItemsID)
);
COMMIT;

truncate table USERS;
truncate table USER_ROLE;
truncate table ARTWORK;
truncate table ART_CATEGORY;
truncate table CONTACT;
truncate table SHIPPER;
truncate table ONLINE_EXHIBITION;

--Insert values in table USER_ROLE
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
insert into USERS values (21,3,'thyag.jaya21@artgallery.com','jayabheem55','47JayegaeBharath','Jaya','Thyagarajan','Painting','Indian');
insert into USERS values (22,2,'guna.menula44@artgallery.com','menuguna44','Almighty4ever','Menula','Gunasekar','','');
insert into USERS values (23,2,'pitt.brad@artgallery.com','pitt66brad','benevolentGoat1','Brad','Pitt','','');
insert into USERS values (24,3,'hutch.fiona3@artgallery.com','fionahutch77','nbfajrg34r','Fiona','Hutchinson','Tapestry','Scottish');
insert into USERS values (25,2,'smith39jamie@artgallery.com','smithjames','eeecool1234','Jamie','Smith','','');
insert into USERS values (26,3,'chat30Anindhya@artgallery.com','anindchat45','Chakra65mela','Anindhya','Chattopadhyay','Wood Sculpture','Indian');
insert into USERS values (27,2,'tony13manasa@artgallery.com','manasatony','samosa4life','Manasa','Tony','','');
insert into USERS values (28,2,'conteadam1@artgallery.com','adamconte18','pasta7mammamia','Adam','Conte','','');
insert into USERS values (29,2,'mullaisrinivasan@artgallery.com','mullaisri85','malar21mullai','Mullai','Srinivasan','','');
insert into USERS values (30,3,'duss.jason4@artgallery.com','jasonduss','Jasonwill63Can','Jason','Dussault','Mosaic','Canadian');
COMMIT;

--insert values in table contact
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (1,1, 8572639860, '1575 Tremont street', 'APT 2', 'Boston', 'MA', 'USA', 02129);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (2,2, 8575689968, 'Roxbury crossing', 'APT 3', 'Boston', 'MA', 'USA', 02689);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (3,2, 6975698560, '15 Malden', 'APT 8', 'Los angeles', 'CA', 'USA', 5972);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (4,2, 5698742635, '1575 mango Street', 'APT 9', 'San Antonio', 'TX', 'USA', 8975);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (5,2, 5697895620, '857 Hungtionton Ave', 'Boylston', 'Boston', 'MA', 'USA', 5698);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (6,2, 5987895640, 'Newburg street', 'Dorchester', 'Dallas', 'TX', 'USA', 0219);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (7,2, 6987453026, '160 Alpine road', 'Brookline', 'Philadelphia', 'PA', 'USA', 2101);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (8,2, 5697854120, '12 Saint Fr. RD', 'Dorchester', 'San Diego', 'CA', 'USA', 9878);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (9,2, 5669842635, '60 Spine Road', 'Cambriegde', 'Dallas', 'TX', 'USA', 1203);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (10,2, 5656942635, '23 Brookline', 'Newport', 'Boston', 'MA', 'USA', 06897);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (11,3, 5698785063, '15 Cawfield street', 'Dorchester', 'Houston', 'TX', 'USA', 56890);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (12,3, 5695692635, '36 Washignton street', 'Nubian', 'Chicago', 'IL', 'USA', 06923);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (13,3, 8975692031, 'Apple Street', 'Dustun', 'Phoenix', 'AZ', 'USA', 03689);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (15,3, 6987894120, 'Manhatten street', 'George_mason RD', 'San Jose', 'CS', 'USA', 02369);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (16,3, 4895201698, 'Area 51', 'Washington square', 'Colrado', 'CO', 'USA', 03215);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (17,3, 6587420135, 'Swiss Street', 'Hartford', 'Buffalo', 'NY', 'USA', 04265);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (18,3, 369750359, 'Phoenix street', 'Virginia', 'Hollywood', 'FL', 'USA', 03698);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (19,3, 3697851026, 'Virginia street', 'Enterprise RD', 'Kansas', 'KS', 'USA', 01597);
INSERT INTO CONTACT (Contactid, UserID, ContactNumber, Addressline1,Addressline2, city, state, country, zipcode)
VALUES (20,3, 6987562100, 'Mission Hill', 'Park Drive', 'Wichita', 'KS', 'USA', 06986);
COMMIT;

--insert values in table contact
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
insert into ONLINE_EXHIBITION VALUES(14, 16, TO_DATE('2023/04/25 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/04/30 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
insert into ONLINE_EXHIBITION VALUES(15, 20, TO_DATE('2023/03/23 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/29 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(16, 22, TO_DATE('2023/02/23 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/02/27 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
insert into ONLINE_EXHIBITION VALUES(17, 23, TO_DATE('2023/01/23 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/01/29 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
insert into ONLINE_EXHIBITION VALUES(18, 25, TO_DATE('2023/03/26 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/29 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Active');
insert into ONLINE_EXHIBITION VALUES(19, 27, TO_DATE('2023/02/13 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/02/19 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
insert into ONLINE_EXHIBITION VALUES(20, 28, TO_DATE('2023/03/03 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),
TO_DATE('2023/03/09 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Completed');
COMMIT;

--insert values in table artcategory
insert into ART_CATEGORY VALUES(1, 'Painting');
insert into ART_CATEGORY VALUES(2, 'Sculpture');
insert into ART_CATEGORY VALUES(3, 'DigitalArt');
insert into ART_CATEGORY VALUES(4, 'Photography');
insert into ART_CATEGORY VALUES(5, 'Drawing');
insert into ART_CATEGORY VALUES(6, 'Tapestry');
insert into ART_CATEGORY VALUES(7, 'GlassArt');
COMMIT;

--insert values in table srtwork
insert into ARTWORK VALUES(1, 1, 1, 1, 'The Banjo Lesson', 'A Painting depicting an elderly man teaching a young boy how to play the banjo', 65, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(2, 1, 1, 2, 'Autumnal Equinox', 'A Painting depicting changing colors of autumn leaves against blue sky', 99, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(3, 2, 2, 3, 'The Kiss', 'This sculpture portrays a couple in a romantic embrace', 140, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(4, 2, 1, 4, 'Lamentation', 'A series of larger than life bronze sculptures of human figures', 75, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(5, 3, 3, 5, 'Digital Nirvana', 'This artwork features a surreal landscape of a digital world', 37, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(6, 3, 2, 6, 'Junction', 'A digital simulation of a highway interchange in Texas', 55, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(7, 4, 7, 7, 'Fleeting Moment', 'This photograph captures a moment of stillness in a bustling city street', 115, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(8, 4, 4, 8, 'Migrant Mother', 'A photograph of a destitute mother and her children during the Great Depression', 75, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(9, 5, 5, 9, 'Sketch of Dream', 'This artwork is a black and white pencil drawing of a surreal landscape', 126, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(10, 6, 6, 10, 'Swedish Landscape', 'a large-scale tapestry depicting the rolling hills and forests of Sweden', 85, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp')); 
insert into ARTWORK VAlUES(11, 6, 3, 11, 'Scared Cows', 'a series of tapestries featuring colorful, abstracted depictions of cows', 115, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(12, 7, 4, 12, 'Honeycomb Bowl', ' a colorful glass vessel featuring a textured surface created by fusing and shaping glass threads', 210, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(13, 7, 4, 13, 'Sea Pod', 'a whimsical glass sculpture inspired by the shape and texture of sea creatures', 184, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(14, 1, 2, 14, 'The Leaf and the Fire', 'an abstract painting featuring bold, gestural brushstrokes and a muted color palette', 55, 'Not Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
insert into ARTWORK VALUES(15, 3, 1, 15, 'The Many Faces of Ebola', 'a series of digital prints exploring the visual language of medical imaging', 75, 'Not Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
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
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,USERS.FirstName AS FirstName,USERS.LastName AS LastName,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
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
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS FirstName,USERS.LastName AS LastName,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE ONLINE_EXHIBITION.ExhibitionStartDateTime <= SYSDATE AND ONLINE_EXHIBITION.ExhibitionEndDateTime >= SYSDATE;
COMMIT;

--list of artist unsold artwork details
CREATE OR REPLACE VIEW ARTIST_UNSOLD_ARTWORK AS
SELECT ARTWORK.Name, ARTWORK.Description, ARTWORK.Amount 
FROM ARTWORK
JOIN USERS ON USERS.UserID = Artwork.UserID
where USERS.FirstName = 'Maria' AND USERS.LastName = 'Garcia';
COMMIT;

--list of all unsold artwork details
CREATE OR REPLACE VIEW ALL_UNSOLD_ARTWORK AS
SELECT USERS.FirstName as ARTIST_FIRST_NAME,Users.LastName AS ARTIST_LAST_NAME,ARTWORK.Name,ARTWORK.Amount 
FROM ARTWORK
JOIN USERS ON USERS.UserID = Artwork.UserID
where ARTWORK.Status = 'Available';
COMMIT;

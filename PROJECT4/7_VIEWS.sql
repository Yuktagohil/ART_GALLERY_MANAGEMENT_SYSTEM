SET SERVEROUTPUT ON;
--list of upcoming exhibitions of an artist
CREATE OR REPLACE VIEW ARTIST_UPCOMING_EXHIBITIONS AS
SELECT ONLINE_EXHIBITION.ExhibitionID AS Exhibition_id,ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS FirstName,USERS.LastName AS LastName,ONLINE_EXHIBITION.ExhibitionStartDateTime AS Start_Date, ONLINE_EXHIBITION.ExhibitionEndDateTime AS End_Date
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE USERS.FirstName = 'Casey' AND USERS.LastName = 'Miller' AND ONLINE_EXHIBITION.ExhibitionStartDateTime > SYSDATE;
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
WHERE USERS.FirstName = 'Casey' AND USERS.LastName = 'Miller' AND ONLINE_EXHIBITION.ExhibitionStartDateTime <= SYSDATE AND ONLINE_EXHIBITION.ExhibitionEndDateTime >= SYSDATE;
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
where USERS.FirstName = 'Casey' AND USERS.LastName = 'Miller' AND ARTWORK.Status='Available';
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
SELECT USERS.FirstName as ARTIST_FIRST_NAME,ARTWORK.ARTWORKID,Users.LastName AS ARTIST_LAST_NAME,ARTWORK.Name,ARTWORK.Status,ARTWORK.Amount 
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
SELECT ONLINE_EXHIBITION.ExhibitionID, ONLINE_EXHIBITION.ExhibitionStatus,USERS.FirstName AS ARTIST_FIRST_NAME, USERS.LastName AS ARTIST_LAST_NAME, ONLINE_EXHIBITION.ExhibitionStartDateTime as STARTDATE,ONLINE_EXHIBITION.ExhibitionEndDateTime AS ENDDATE
FROM ONLINE_EXHIBITION
JOIN USERS ON USERS.UserID = ONLINE_EXHIBITION.UserID
WHERE USERS.FirstName = 'Casey' and USERS.LastName='Miller';
COMMIT;

SELECT * FROM ARTIST_UPCOMING_EXHIBITIONS;
SELECT * FROM ALL_UPCOMING_EXHIBITIONS;
SELECT * FROM USERPROFILE_BASED_ON_USERROLE;
SELECT * FROM ARTIST_ACTIVE_EXHIBITIONS;
SELECT * FROM ALL_ACTIVE_EXHIBITIONS;
SELECT * FROM ARTIST_UNSOLD_ARTWORK;
SELECT * FROM ACTIVE_EXHIBITION_ARTWORK;
SELECT * FROM ALL_UNSOLD_ARTWORK;
SELECT * FROM ORDER_SHIPPER_INFO;
SELECT * FROM UNSHIPPED_ORDER_INFO;
SELECT * FROM GALLERY_ARTWORK_INFO;
SELECT * FROM CUSTOMER_ORDER;
SELECT * FROM ARTIST_EXHIBITION;
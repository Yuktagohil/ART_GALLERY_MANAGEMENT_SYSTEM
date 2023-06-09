------------------Check if user already exists-----------------------------
PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;
declare
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from all_users where username='G_ARTIST';
    IF IS_TRUE > 0
    THEN
    EXECUTE IMMEDIATE 'DROP USER G_ARTIST CASCADE';
    END IF;
END;
/

declare
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from all_users where username='G_CUSTOMER';
    IF IS_TRUE > 0
    THEN
    EXECUTE IMMEDIATE 'DROP USER G_CUSTOMER CASCADE';
    END IF;
END;
/


--------------------Creating Project specific users----------------------------
CREATE USER G_ARTIST IDENTIFIED BY Artistartgallery004 QUOTA 200M ON DATA;
CREATE USER G_CUSTOMER IDENTIFIED BY Customerartgallery004 QUOTA 200M ON DATA;

---------------------Granting privileges to users--------------------------------
GRANT CONNECT TO G_ARTIST;
GRANT CREATE PROCEDURE TO G_ARTIST;
GRANT CREATE VIEW TO G_ARTIST;
GRANT EXECUTE ON VIEW_ART_CATEGORY TO G_ARTIST;
GRANT EXECUTE ON INSERT_ART_CATEGORY TO G_ARTIST;
GRANT EXECUTE ON UPDATE_ART_CATEGORY TO G_ARTIST;
GRANT EXECUTE ON VIEW_ART_CATEGORY TO G_ARTIST;
GRANT EXECUTE ON INSERT_ARTWORK TO G_ARTIST;
GRANT EXECUTE ON UPDATE_ARTWORK TO G_ARTIST;
GRANT EXECUTE ON DELETE_ARTWORK TO G_ARTIST;
GRANT EXECUTE ON VIEW_ARTWORKS TO G_ARTIST;
GRANT EXECUTE ON INSERT_EXHIBITION TO G_ARTIST;
GRANT EXECUTE ON UPDATE_EXHIBITION TO G_ARTIST;
GRANT EXECUTE ON VIEW_EXHIBITIONS TO G_ARTIST;
GRANT EXECUTE ON INSERT_USER TO G_ARTIST;
GRANT EXECUTE ON UPDATE_USER TO G_ARTIST;
GRANT EXECUTE ON view_users_details TO G_ARTIST;
GRANT EXECUTE ON INSERT_CONTACT TO G_ARTIST;
GRANT EXECUTE ON UPDATE_CONTACT TO G_ARTIST;
GRANT EXECUTE ON VIEW_CONTACTS TO G_ARTIST;
GRANT EXECUTE ON MANAGE_ARTWORKS TO G_ARTIST;
GRANT EXECUTE ON MANAGE_ORDERS TO G_ARTIST;
GRANT SELECT ON ARTIST_UPCOMING_EXHIBITIONS TO G_ARTIST;
GRANT SELECT ON ARTIST_ACTIVE_EXHIBITIONS TO G_ARTIST;
GRANT SELECT ON ARTIST_UNSOLD_ARTWORK TO G_ARTIST;
GRANT SELECT ON UNSHIPPED_ORDER_INFO TO G_ARTIST;
GRANT SELECT ON ARTIST_EXHIBITION TO G_ARTIST;

--------------------------------------------------------------------------------
GRANT CONNECT TO G_CUSTOMER;
GRANT CREATE PROCEDURE TO G_CUSTOMER;
GRANT CREATE VIEW TO G_CUSTOMER;
GRANT EXECUTE ON INSERT_ORDER TO G_CUSTOMER;
GRANT EXECUTE ON VIEW_ORDERS TO G_CUSTOMER;
GRANT EXECUTE ON VIEW_ART_CATEGORY TO G_CUSTOMER;
GRANT EXECUTE ON VIEW_ORDER_ITEMS TO G_CUSTOMER;
GRANT EXECUTE ON INSERT_ORDER_ITEM TO G_CUSTOMER;
GRANT EXECUTE ON INSERT_USER TO G_CUSTOMER;
GRANT EXECUTE ON UPDATE_USER TO G_CUSTOMER;
GRANT EXECUTE ON view_users_details TO G_CUSTOMER;
GRANT EXECUTE ON INSERT_CONTACT TO G_CUSTOMER;
GRANT EXECUTE ON UPDATE_CONTACT TO G_CUSTOMER;
GRANT EXECUTE ON VIEW_CONTACTS TO G_CUSTOMER;
GRANT EXECUTE ON VIEW_EXHIBITIONS TO G_CUSTOMER;
GRANT EXECUTE ON VIEW_ARTWORKS TO G_CUSTOMER;
GRANT EXECUTE ON PURCHASE_ARTWORK TO G_CUSTOMER;
GRANT EXECUTE ON MANAGE_ARTWORKS TO G_CUSTOMER;
GRANT EXECUTE ON MANAGE_ORDERS TO G_CUSTOMER;
GRANT SELECT ON CUSTOMER_ORDER TO G_CUSTOMER;
GRANT SELECT ON GALLERY_ARTWORK_INFO TO G_CUSTOMER;
GRANT SELECT ON ORDER_SHIPPER_INFO TO G_CUSTOMER;
GRANT SELECT ON ACTIVE_EXHIBITION_ARTWORK TO G_CUSTOMER;
GRANT SELECT ON ALL_ACTIVE_EXHIBITIONS TO G_CUSTOMER;

COMMIT;

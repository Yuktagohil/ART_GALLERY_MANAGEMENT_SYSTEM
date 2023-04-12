SET SERVEROUTPUT ON;

BEGIN
EXECUTE IMMEDIATE 'DROP PACKAGE MANAGE_ARTWORKS';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

CREATE OR REPLACE PACKAGE manage_artworks AS
    -- procedure to view artworks of an artist user
    PROCEDURE view_artist_artworks (
        p_user_id IN INTEGER
    );
    
    -- procedure to search artworks by art category for a customer user
    PROCEDURE search_artworks_by_category (
        p_category_name IN VARCHAR
    );
    
    -- procedure to view all artworks for an admin user
    PROCEDURE view_all_artworks;
END manage_artworks;
/

CREATE OR REPLACE PACKAGE BODY manage_artworks AS
    -- procedure to view artworks of an artist user
    PROCEDURE view_artist_artworks (
        p_user_id IN INTEGER
    ) AS  
    CURSOR c_artworks IS
    SELECT artworkid, name, amount, status
        FROM artwork
        WHERE userid = p_user_id;
        v_artworkid INTEGER;
        v_userid INTEGER;
        v_artcategoryid INTEGER;
        v_exhibitionid INTEGER;
        v_orderitemsid INTEGER;
        v_name VARCHAR(45);
        v_Amount NUMBER;
        v_status VARCHAR(45);
        v_artworkimage BLOB;
    BEGIN
    OPEN c_artworks;
    LOOP
        FETCH c_artworks INTO v_artworkid, v_name, v_amount, v_status;
        EXIT WHEN c_artworks%NOTFOUND;
        dbms_output.put_line('Artwork ID: ' || v_artworkid || ', Name: ' || v_name || ', Price: ' || v_amount || ', Status: ' || v_status);
    END LOOP;
    CLOSE c_artworks;
END VIEW_ARTIST_ARTWORKS;
    
    -- procedure to search artworks by art category for a customer user
    PROCEDURE search_artworks_by_category (
        p_category_name IN VARCHAR
    ) AS
        v_artworkid INTEGER;
        v_username VARCHAR(45);
        v_artcategory VARCHAR(100);
        CURSOR c_artworks IS
        SELECT a.artworkid, u.username, c.artcategory
        FROM ARTWORK a
        JOIN USERS u on a.userid = u.userid
        JOIN ART_CATEGORY c ON a.artcategoryid = c.artcategoryid
        WHERE c.artcategory = p_category_name;
    BEGIN
        OPEN c_artworks;
        LOOP
            FETCH c_artworks INTO v_artworkid, v_username, v_artcategory;
            EXIT WHEN c_artworks%NOTFOUND;
            dbms_output.put_line('Artwork ID: ' || v_artworkid || ', Artist Name: ' || v_username || ', Art Category: ' || v_artcategory);
        END LOOP;
        CLOSE c_artworks;
    END search_artworks_by_category;
    
    -- procedure to view all artworks for an admin user
    PROCEDURE view_all_artworks AS
        v_artworkid INTEGER;
        v_userid INTEGER;
        v_artcategory VARCHAR(45);
    BEGIN
        FOR rec IN (SELECT a.artworkid, a.userid, c.artcategory
                    FROM ARTWORK a
                    JOIN ART_CATEGORY c ON a.artcategoryid = c.artcategoryid)
        LOOP
            v_artworkid := rec.artworkid;
            v_userid := rec.userid;
            v_artcategory := rec.artcategory;
            
            -- Do something with the variables v_artworkid, v_userid, and v_artcategory
            dbms_output.put_line('Artwork ID: ' || v_artworkid || ', User ID: ' || v_userid || ', Art Category: ' || v_artcategory);
        END LOOP;
    END view_all_artworks;
END manage_artworks;
/

--testcase for g_artist
EXECUTE MANAGE_ARTWORKS.VIEW_ARTIST_ARTWORKS(2);

--testcase for g_customer
EXECUTE MANAGE_ARTWORKS.search_artworks_by_category('Painting');

--testcase for g_admin
EXECUTE MANAGE_ARTWORKS.VIEW_ALL_ARTWORKS;

CREATE OR REPLACE PROCEDURE INSERT_ART_CATEGORY (
    p_CategoryName IN ART_CATEGORY.ARTCATEGORY%TYPE
)
IS
    v_CategoryID ART_CATEGORY.ARTCATEGORYID%TYPE;
    IS_TRUE NUMBER;
BEGIN
select count(*) 
    INTO IS_TRUE
    from ART_CATEGORY where ARTCATEGORY = p_CategoryName;
    IF IS_TRUE > 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Category already exists.');
    ELSE
        INSERT INTO ART_CATEGORY (ARTCATEGORYID, ARTCATEGORY)
        VALUES (art_category_seq.NEXTVAL, p_CategoryName);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('New category added successfully.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Category does not exist in the database.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error while adding new category: ' || SQLERRM);
        ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE VIEW_ART_CATEGORY
IS
    v_CategoryID ART_CATEGORY.ARTCATEGORYID%TYPE;
    v_CategoryName ART_CATEGORY.ARTCATEGORY%TYPE;
BEGIN
    FOR c IN (SELECT ARTCATEGORYID, ARTCATEGORY FROM ART_CATEGORY)
    LOOP
        v_CategoryID := c.ARTCATEGORYID;
        v_CategoryName := c.ARTCATEGORY;
        DBMS_OUTPUT.PUT_LINE('Category ID: ' || v_CategoryID || ', Category Name: ' || v_CategoryName);
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE UPDATE_ART_CATEGORY (
    p_CategoryID IN ART_CATEGORY.ARTCATEGORYID%TYPE,
    p_CategoryName IN ART_CATEGORY.ARTCATEGORY%TYPE
)
IS
    v_CategoryID ART_CATEGORY.ARTCATEGORYID%TYPE;
BEGIN
    SELECT ARTCATEGORYID INTO v_CategoryID
    FROM ART_CATEGORY
    WHERE ARTCATEGORYID = p_CategoryID;

    IF v_CategoryID IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Category does not exist.');
    ELSE
        UPDATE ART_CATEGORY
        SET ARTCATEGORY = p_CategoryName
        WHERE ARTCATEGORYID = p_CategoryID;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Category updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error while updating category: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE DELETE_ART_CATEGORY (
    p_CategoryID IN ART_CATEGORY.ARTCATEGORYID%TYPE
)
IS
    v_CategoryID ART_CATEGORY.ARTCATEGORYID%TYPE;
BEGIN
    SELECT ARTCATEGORYID INTO v_CategoryID
    FROM ART_CATEGORY
    WHERE ARTCATEGORYID = p_CategoryID;

    IF v_CategoryID IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Category does not exist.');
    ELSE
        DELETE FROM ART_CATEGORY
        WHERE ARTCATEGORYID = p_CategoryID;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Category deleted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error while deleting category: ' || SQLERRM);
        ROLLBACK;
END;
/




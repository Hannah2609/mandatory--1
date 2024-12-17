-- Procedure for soft deleting user -- delimiter is used so we can replace ; with $$ since we have to in the query
DELIMITER $$

CREATE PROCEDURE SoftDeleteUser(IN UserID BIGINT UNSIGNED)
BEGIN
    UPDATE users
    SET user_deleted_at = UNIX_TIMESTAMP()
    WHERE user_pk = UserID;
END $$

DELIMITER ;

-- Run procedure:
CALL SoftDeleteUser('UserID');


-- Procedure for updating menu item prices
CDELIMITER $$

CREATE PROCEDURE UpdateItemPrice(IN ItemId BIGINT UNSIGNED, IN NewItemPrice DECIMAL(10, 2))
BEGIN
    UPDATE items
    SET price = NewItemPrice
    WHERE item_pk = ItemId;
END $$

DELIMITER ;

CALL UpdateItemPrice('ItemID', 'NewItemPrice');
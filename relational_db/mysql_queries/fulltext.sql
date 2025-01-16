-- creates the index
ALTER TABLE `items` ADD FULLTEXT idx_item_title(item_title);

-- search and show all results
SELECT * FROM items
    WHERE MATCH (item_title)
    AGAINST ('Pizza');


-- count number of results
SELECT COUNT(*) FROM item
    WHERE MATCH (item_title)
    AGAINST ('Pizza');


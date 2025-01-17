CREATE DATABASE Kindle;

USE Kindle;

CREATE TABLE Kindle_dataset
(
ASIN VARCHAR(255),
Author VARCHAR(255),
Rating FLOAT,
Number_of_reviews INT,
Price_in_dollars FLOAT,
Is_Kindle_Unlimited VARCHAR(255),
Is_Best_Seller VARCHAR(255),
Is_Editors_Pick VARCHAR(255),
Is_GoodReads_Choice VARCHAR(255),
Category VARCHAR(255)
);

LOAD DATA INFILE 'Kindle_dataset.csv' INTO TABLE Kindle_dataset
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * 
FROM Kindle_dataset;

SELECT DISTINCT *
FROM Kindle_dataset;

SELECT *
FROM Kindle_dataset
WHERE ASIN IS NOT NULL
AND Author IS NOT NULL
AND Rating IS NOT NULL
AND Number_of_reviews IS NOT NULL
AND Price_in_dollars IS NOT NULL
AND Is_Kindle_Unlimited IS NOT NULL
AND Is_Best_Seller IS NOT NULL
AND Is_Editors_Pick IS NOT NULL
AND Is_GoodReads_Choice IS NOT NULL
AND Category IS NOT NULL;

SELECT Author, COUNT(Is_Best_Seller)
FROM Kindle_dataset
GROUP BY Author
ORDER BY COUNT(Is_Best_Seller) DESC
LIMIT 10;

SELECT *
FROM Kindle_dataset
WHERE Author IS NULL;

SELECT *
FROM Kindle_dataset
WHERE Length(Author) != 0;

SELECT *
FROM Kindle_dataset
WHERE LENGTH(ASIN) != 0
AND LENGTH(Author) != 0
AND LENGTH(Rating) != 0
AND LENGTH(Number_of_reviews) != 0
AND LENGTH(Price_in_dollars) != 0
AND LENGTH(Is_Kindle_Unlimited) != 0
AND LENGTH(Is_Best_Seller) != 0
AND LENGTH(Is_Editors_Pick) != 0
AND LENGTH(Is_GoodReads_Choice) != 0
AND LENGTH(Category) != 0;

CREATE TABLE Kindle_dataset_updated
(
ASIN VARCHAR(255),
Author VARCHAR(255),
Rating FLOAT,
Number_of_reviews INT,
Price_in_dollars FLOAT,
Is_Kindle_Unlimited VARCHAR(255),
Is_Best_Seller VARCHAR(255),
Is_Editors_Pick VARCHAR(255),
Is_GoodReads_Choice VARCHAR(255),
Category VARCHAR(255)
);

LOAD DATA INFILE 'Kindle_dataset_updated.csv' INTO TABLE Kindle_dataset_updated
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * 
FROM Kindle_dataset_updated;

CREATE TABLE Kindle_dataset_category_ID
(
Category VARCHAR(255),
Category_ID INT
);

LOAD DATA INFILE 'Kindle_dataset_category_ID.csv' INTO TABLE Kindle_dataset_category_ID
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * 
FROM Kindle_dataset_category_ID;

WITH Category_wise_analysis AS
(
SELECT Category_ID, Kindle_dataset_updated.Category, COUNT(ASIN) AS Number_of_books, AVG(Rating) As Average_rating, AVG(Price_in_dollars) As Average_price
FROM Kindle_dataset_updated
INNER JOIN Kindle_dataset_category_ID
ON Kindle_dataset_updated.Category = Kindle_dataset_category_ID.Category
GROUP BY Category_ID, Kindle_dataset_updated.Category
ORDER BY Category_ID
)
SELECT *
FROM Category_wise_analysis;
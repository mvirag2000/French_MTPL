BEGIN
SET @@dataset_id = 'french_mtpl'; 

CREATE OR REPLACE TABLE Test_Set LIKE Combined; 
INSERT INTO Test_Set
SELECT * FROM Combined 
WHERE rand() < 0.10;

CREATE OR REPLACE TABLE Train_Set LIKE Combined; 
INSERT INTO Train_Set
SELECT t1.* FROM Combined AS t1
  LEFT JOIN Test_Set AS t2
    USING (IDpol)
WHERE t2.IDpol IS NULL; 

END
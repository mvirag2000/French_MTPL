BEGIN

DECLARE split1, split2 FLOAT64;
SET @@dataset_id = 'french_mtpl'; 
SET split1 = 0.10;
SET split2 = split1 / (1-split1); 

UPDATE Combined 
SET Split = 'TRAIN'
WHERE True;

UPDATE Combined 
SET Split = 'TEST'
WHERE rand() < split1 AND Split = 'TRAIN';

UPDATE Combined 
SET Split = 'VALIDATE'
WHERE rand() < split2 AND Split = 'TRAIN';

SELECT COUNT(IDpol) FROM Combined 
GROUP BY Split;

END
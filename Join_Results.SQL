CREATE OR REPLACE TABLE `french_mtpl.Combined_Results` AS 

SELECT Results.IDpol, probs.prob, Orig.ClaimAmount  
FROM `french_mtpl.Freq_Results` AS Results
INNER JOIN `french_mtpl.Combined` AS Orig 
ON Results.IDpol = Orig.IDpol, 

UNNEST(predicted_ClaimClass_probs) as probs
WHERE probs.label = "Claim"
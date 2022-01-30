UPDATE `french-cars.french_mtpl.Test_Set` AS test
SET Prob = (
WITH pred AS
(SELECT
    IDpol,
    predicted_ClaimClass_probs,
FROM 
    ML.PREDICT (
    MODEL `french-cars.french_mtpl.classifier1`,
    (
    SELECT
      IDpol,
      BonusMalus,
      Area,
      VehPower,
      VehAge,
      DrivAge,
      Exposure,
      VehBrand,
      VehGas,
      Density,
      Region
    FROM
    `french_mtpl.Test_Set`)))

SELECT probs.prob 
FROM pred, 
UNNEST(predicted_ClaimClass_probs) AS probs
WHERE probs.label = "Claim"
AND test.IDpol = pred.IDpol)
WHERE True 
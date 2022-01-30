BEGIN
SET @@dataset_id = 'french_mtpl'; 

DROP TABLE IF EXISTS Combined;
CREATE TABLE Combined AS
SELECT F.IDpol, ClaimNb, Exposure, Area, VehPower, VehAge, DrivAge, BonusMalus, VehBrand, VehGas, Density, Region, ClaimAmount
FROM
    Frequency AS F
LEFT JOIN (
  SELECT
    IDpol,
    SUM(ClaimAmount) AS ClaimAmount
  FROM
    Severity
  GROUP BY
    IDpol) AS S
ON
  F.IDpol = S.IDpol
ORDER BY
  Idpol;

UPDATE Combined
SET ClaimNb = 0
WHERE (ClaimAmount IS NULL AND ClaimNb >=1 );

UPDATE Combined
SET ClaimAmount = 0
WHERE (ClaimAmount IS NULL);

UPDATE Combined
SET ClaimNb = 1
WHERE ClaimNb > 4;

UPDATE Combined
SET Exposure = 1
WHERE Exposure > 1;

UPDATE Combined
SET ClaimAmount = 200000
WHERE ClaimAmount > 200000;

ALTER TABLE Combined
ADD COLUMN Premium NUMERIC;

UPDATE Combined
SET Premium = ClaimAmount / Exposure
WHERE True;

END
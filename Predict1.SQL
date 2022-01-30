SELECT
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
      `french-cars.french_mtpl.Frequency`
    WHERE Split = 'TEST'))
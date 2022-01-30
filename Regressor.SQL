CREATE OR REPLACE MODEL french_mtpl.linear_model
    TRANSFORM (
        ML.QUANTILE_BUCKETIZE(VehAge, 10) OVER() AS VehAge,
        ML.QUANTILE_BUCKETIZE(DrivAge, 10) OVER() AS DrivAge,
        CAST (VehPower AS string) AS VehPower,
        ML.STANDARD_SCALER(Log(Density)) OVER() AS Density,
        Area,
        BonusMalus,
        VehBrand,
        VehGas,
        Region,
        Premium
    )
OPTIONS (
    INPUT_LABEL_COLS = ['Premium'], 
    MODEL_TYPE = 'LINEAR_REG',
    CATEGORY_ENCODING_METHOD = 'ONE_HOT_ENCODING',
    MAX_ITERATIONS = 20,
    DATA_SPLIT_METHOD = 'Random',
    DATA_SPLIT_EVAL_FRACTION = 0.10
    )  
AS SELECT
  Area,
  VehPower,
  VehAge,
  DrivAge,
  BonusMalus,
  VehBrand,
  VehGas,
  Density,
  Region,
  Premium
FROM `french_mtpl.Combined`  
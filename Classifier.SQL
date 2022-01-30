CREATE OR REPLACE MODEL`french-cars.french_mtpl.classifier1`
    TRANSFORM (
        ML.QUANTILE_BUCKETIZE(VehAge, 10) OVER() AS VehAge,
        ML.QUANTILE_BUCKETIZE(DrivAge, 10) OVER() AS DrivAge,
        CAST (VehPower AS string) AS VehPower,
        ML.STANDARD_SCALER(Log(Density)) OVER() AS Density,
        Exposure,
        Area,
        BonusMalus,
        VehBrand,
        VehGas,
        Region,
        ClaimClass
    )
OPTIONS (
    INPUT_LABEL_COLS = ['ClaimClass'], 
    MODEL_TYPE = 'BOOSTED_TREE_CLASSIFIER',
    NUM_PARALLEL_TREE = 200,
    MAX_TREE_DEPTH = 4,
    TREE_METHOD = 'HIST',
    MAX_ITERATIONS = 20,
    DATA_SPLIT_METHOD = 'Random',
    DATA_SPLIT_EVAL_FRACTION = 0.10,
    CLASS_WEIGHTS = [STRUCT('NoClaim', 0.05), ('Claim', 0.95)]
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
  Exposure,
  Region, 
  ClaimClass
FROM `french-cars.french_mtpl.Frequency`
WHERE Split = 'TRAIN'
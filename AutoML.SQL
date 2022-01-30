CREATE OR REPLACE MODEL french_mtpl.auto_model
OPTIONS (
    INPUT_LABEL_COLS = ['Premium'], 
    MODEL_TYPE = 'AUTOML_REGRESSOR',
    OPTIMIZATION_OBJECTIVE = 'MINIMIZE_MAE',
    BUDGET_HOURS = 1.0
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
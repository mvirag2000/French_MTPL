EXPORT DATA
  OPTIONS( uri='gs://french_mtpl2/Test_Set*.csv',
    format='CSV',
    overwrite=TRUE,
    header=TRUE,
    field_delimiter=',') AS 
SELECT
  Weight,
  Premium,
  predicted_Premium.value 
FROM
  `french-cars.french_mtpl.Test_Set`  
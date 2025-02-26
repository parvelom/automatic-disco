from pyspark.sql import SparkSession
from pyspark.sql.functions import col, to_date, current_timestamp

# Configurar la sesión de Spark
spark = SparkSession.builder \
    .appName("ETL_Insurance_XYZ") \
    .getOrCreate()

# Definir la ruta base en Data Lake
base_path = "abfss://data@azdatadp900.dfs.core.windows.net/raw-data/CRM_SAMPLE/"

# Leer datos desde los archivos en Data Lake
clients_df = spark.read.option("header", "true").csv(base_path + "clients.csv")
policies_df = spark.read.option("header", "true").csv(base_path + "policies.csv")
claims_df = spark.read.option("header", "true").csv(base_path + "claims.csv")
external_factors_df = spark.read.option("header", "true").csv(base_path + "external_factors.csv")

# Función de limpieza de datos
def clean_dataframe(df):
    return df.dropDuplicates().na.fill("Unknown")

clients_df = clean_dataframe(clients_df)
policies_df = clean_dataframe(policies_df)
claims_df = clean_dataframe(claims_df)
external_factors_df = clean_dataframe(external_factors_df)

# Convertir columnas de fecha (maneja valores nulos para evitar errores)
claims_df = claims_df.withColumn("Claim_Date", to_date(col("Claim_Date"), "yyyy-MM-dd"))
policies_df = policies_df.withColumn("Start_Date", to_date(col("Start_Date"), "yyyy-MM-dd"))
policies_df = policies_df.withColumn("End_Date", to_date(col("End_Date"), "yyyy-MM-dd"))

# Agregar columna de timestamp de carga
for df in [clients_df, policies_df, claims_df, external_factors_df]:
    df = df.withColumn("Load_Timestamp", current_timestamp())

# Escribir los datos en el Data Warehouse bajo el esquema dbo
clients_df.write.mode("overwrite").format("delta").saveAsTable("default.Hub_clients")
policies_df.write.mode("overwrite").format("delta").saveAsTable("default.Hub_policies")
claims_df.write.mode("overwrite").format("delta").saveAsTable("default.Hub_claims")
external_factors_df.write.mode("overwrite").format("delta").saveAsTable("default.Hub_external_factors")

print("ETL completado exitosamente")
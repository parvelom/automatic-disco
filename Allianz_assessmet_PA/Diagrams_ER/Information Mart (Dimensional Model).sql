CREATE TABLE [Fact_Claims] (
  [Claim_ID] UUID PRIMARY KEY,
  [Policy_ID] UUID,
  [Client_ID] UUID,
  [Claim_Date] DATE,
  [Claim_Amount] DECIMAL,
  [Claim_Status] VARCHAR,
  [Fraud_Score] FLOAT,
  [Risk_Score] FLOAT
)
GO

CREATE TABLE [Fact_Policies] (
  [Policy_ID] UUID PRIMARY KEY,
  [Client_ID] UUID,
  [Premium_Amount] DECIMAL,
  [Start_Date] DATE,
  [End_Date] DATE,
  [Policy_Type] VARCHAR
)
GO

CREATE TABLE [Fact_Customer_Risk] (
  [Client_ID] UUID PRIMARY KEY,
  [Risk_Score] FLOAT,
  [Number_of_Claims] INT,
  [Premium_Amount] DECIMAL,
  [Economic_Index] FLOAT,
  [Weather_Conditions] TEXT
)
GO

CREATE TABLE [Dim_Clients] (
  [Client_ID] UUID PRIMARY KEY,
  [Client_Name] VARCHAR,
  [Address] VARCHAR,
  [Phone] VARCHAR,
  [Birth_Date] DATE,
  [Risk_Category] VARCHAR
)
GO

CREATE TABLE [Dim_Policies] (
  [Policy_ID] UUID PRIMARY KEY,
  [Policy_Type] VARCHAR,
  [Premium_Amount] DECIMAL,
  [Coverage_Details] TEXT
)
GO

CREATE TABLE [Dim_Claims] (
  [Claim_ID] UUID PRIMARY KEY,
  [Claim_Date] DATE,
  [Claim_Amount] DECIMAL,
  [Cause] VARCHAR,
  [Claim_Status] VARCHAR,
  [Fraud_Score] FLOAT
)
GO

CREATE TABLE [Dim_External_Factors] (
  [External_Data_ID] UUID PRIMARY KEY,
  [Economic_Index] FLOAT,
  [Weather_Conditions] TEXT
)
GO

ALTER TABLE [Fact_Claims] ADD FOREIGN KEY ([Claim_ID]) REFERENCES [Dim_Claims] ([Claim_ID])
GO

ALTER TABLE [Fact_Claims] ADD FOREIGN KEY ([Policy_ID]) REFERENCES [Dim_Policies] ([Policy_ID])
GO

ALTER TABLE [Fact_Claims] ADD FOREIGN KEY ([Client_ID]) REFERENCES [Dim_Clients] ([Client_ID])
GO

ALTER TABLE [Fact_Policies] ADD FOREIGN KEY ([Policy_ID]) REFERENCES [Dim_Policies] ([Policy_ID])
GO

ALTER TABLE [Fact_Policies] ADD FOREIGN KEY ([Client_ID]) REFERENCES [Dim_Clients] ([Client_ID])
GO

ALTER TABLE [Fact_Customer_Risk] ADD FOREIGN KEY ([Client_ID]) REFERENCES [Dim_Clients] ([Client_ID])
GO

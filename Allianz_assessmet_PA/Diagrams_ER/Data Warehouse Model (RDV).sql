CREATE TABLE [Hub_Clients] (
  [Client_ID] UUID PRIMARY KEY,
  [Client_Name] VARCHAR,
  [Address] VARCHAR,
  [Phone] VARCHAR,
  [Birth_Date] DATE,
  [Created_At] TIMESTAMP
)
GO

CREATE TABLE [Hub_Policies] (
  [Policy_ID] UUID PRIMARY KEY,
  [Client_ID] UUID,
  [Policy_Type] VARCHAR,
  [Start_Date] DATE,
  [End_Date] DATE,
  [Created_At] TIMESTAMP
)
GO

CREATE TABLE [Hub_Claims] (
  [Claim_ID] UUID PRIMARY KEY,
  [Policy_ID] UUID,
  [Claim_Date] DATE,
  [Cause] VARCHAR,
  [Created_At] TIMESTAMP
)
GO

CREATE TABLE [Hub_External_Data] (
  [External_Data_ID] UUID PRIMARY KEY,
  [Data_Type] VARCHAR,
  [Data_Source] VARCHAR,
  [Created_At] TIMESTAMP
)
GO

CREATE TABLE [Link_Client_Policy] (
  [Client_ID] UUID,
  [Policy_ID] UUID,
  [Created_At] TIMESTAMP UNIQUE PRIMARY KEY
)
GO

CREATE TABLE [Link_Policy_Claim] (
  [Policy_ID] UUID,
  [Claim_ID] UUID,
  [Created_At] TIMESTAMP UNIQUE PRIMARY KEY
)
GO

CREATE TABLE [Sat_Clients] (
  [Client_ID] UUID,
  [Risk_Score] FLOAT,
  [Income_Level] VARCHAR,
  [Last_Updated_At] TIMESTAMP
)
GO

CREATE TABLE [Sat_Policies] (
  [Policy_ID] UUID,
  [Premium_Amount] DECIMAL,
  [Coverage_Details] TEXT,
  [Last_Updated_At] TIMESTAMP
)
GO

CREATE TABLE [Sat_Claims] (
  [Claim_ID] UUID,
  [Claim_Amount] DECIMAL,
  [Claim_Status] VARCHAR,
  [Last_Updated_At] TIMESTAMP
)
GO

CREATE TABLE [Sat_External_Data] (
  [External_Data_ID] UUID,
  [Economic_Index] FLOAT,
  [Weather_Conditions] TEXT,
  [Last_Updated_At] TIMESTAMP
)
GO

ALTER TABLE [Hub_Policies] ADD FOREIGN KEY ([Client_ID]) REFERENCES [Hub_Clients] ([Client_ID])
GO

ALTER TABLE [Hub_Claims] ADD FOREIGN KEY ([Policy_ID]) REFERENCES [Hub_Policies] ([Policy_ID])
GO

ALTER TABLE [Link_Client_Policy] ADD FOREIGN KEY ([Client_ID]) REFERENCES [Hub_Clients] ([Client_ID])
GO

ALTER TABLE [Link_Client_Policy] ADD FOREIGN KEY ([Policy_ID]) REFERENCES [Hub_Policies] ([Policy_ID])
GO

ALTER TABLE [Link_Policy_Claim] ADD FOREIGN KEY ([Policy_ID]) REFERENCES [Hub_Policies] ([Policy_ID])
GO

ALTER TABLE [Link_Policy_Claim] ADD FOREIGN KEY ([Claim_ID]) REFERENCES [Hub_Claims] ([Claim_ID])
GO

ALTER TABLE [Sat_Clients] ADD FOREIGN KEY ([Client_ID]) REFERENCES [Hub_Clients] ([Client_ID])
GO

ALTER TABLE [Sat_Policies] ADD FOREIGN KEY ([Policy_ID]) REFERENCES [Hub_Policies] ([Policy_ID])
GO

ALTER TABLE [Sat_Claims] ADD FOREIGN KEY ([Claim_ID]) REFERENCES [Hub_Claims] ([Claim_ID])
GO

ALTER TABLE [Sat_External_Data] ADD FOREIGN KEY ([External_Data_ID]) REFERENCES [Hub_External_Data] ([External_Data_ID])
GO

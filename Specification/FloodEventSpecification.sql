-- Create schemas

-- Create tables
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CoreDisasterInformation'))
BEGIN
  CREATE TABLE CoreDisasterInformation
  (
    FloodEventID INT NOT NULL,
    FloodEventCode VARCHAR(20),
    GlideNumber VARCHAR(20),
    EventDate DATE,
    City VARCHAR(20),
    State VARCHAR(20),
    Country VARCHAR(20),
    FloodType VARCHAR(20),
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HydraulicsAndHydrology'))
BEGIN
  CREATE TABLE HydraulicsAndHydrology
  (
    FloodEventID INT NOT NULL,
    Duration NUMERIC(10, 2),
    FlowVelocity NUMERIC(10, 2),
    TriggeringFactor VARCHAR(20),
    Frequency VARCHAR(20),
    Intensity VARCHAR(20),
    FloodedRiver VARCHAR(20),
    FloodExtentMap GEOMETRY,
    FloodDepthMap RASTER,
    FloodVelocityMap RASTER,
    ReferencePoint VARCHAR(20),
    PeakDischarge NUMERIC(10, 2),
    PeakDischargeTime TIMESTAMP,
    PeakWaterLevel NUMERIC(10, 2),
    PeakWaterLevelTime TIMESTAMP,
    StationLocation GEOMETRY,
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Meteorology'))
BEGIN
  CREATE TABLE Meteorology
  (
    FloodEventID INT NOT NULL,
    ReferenceStation VARCHAR(20),
    StationLocation GEOMETRY,
    TotalPrecipitation NUMERIC(10, 2),
    PrecipitationDuration NUMERIC(10, 2),
    TotalPrecipitationMap RASTER,
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DemographicImpact'))
BEGIN
  CREATE TABLE DemographicImpact
  (
    FloodEventID INT NOT NULL,
    Fatalities INT,
    Injured INT,
    Missing INT,
    IndirectAffected INT,
    Displaced INT,
    Evacuated INT,
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EnvironmentalImpact'))
BEGIN
  CREATE TABLE EnvironmentalImpact
  (
    FloodEventID INT NOT NULL,
    WaterQuality VARCHAR(200),
    SoilContamination VARCHAR(200),
    SoilLoss VARCHAR(200),
    Landslide VARCHAR(200),
    Habitat VARCHAR(200),
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EconomicImpact'))
BEGIN
  CREATE TABLE EconomicImpact
  (
    FloodEventID INT NOT NULL,
    DestroyedProperty INT,
    TotalDamagedBuildings INT,
    FloodedResidential INT,
    FloodedBusiness INT,
    FloodedPublicBuildings INT,
    FloodedVehicles INT,
    FloodedAgriculturalLand NUMERIC(20, 2),
    PerishedCattle INT,
    PerishedOvine INT,
    PerishedPoultry INT,
    DamageInfrastructure VARCHAR(200),
    TotalDirectEconomicLoss NUMERIC(20, 2),
    DirectResidentialLoss NUMERIC(20, 2),
    DirectBusinessLoss NUMERIC(20, 2),
    DirectAgriculturalLoss NUMERIC(20, 2),
    DirectPublicLoss NUMERIC(20, 2),
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Resources'))
BEGIN
  CREATE TABLE Resources
  (
    FloodEventID INT NOT NULL,
    ResourceID INT,
    Type VARCHAR(200),
    Website VARCHAR(200),
    File BINARY(4000),
    Description VARCHAR(200),
    PRIMARY KEY(FloodEventID)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Location'))
BEGIN
  CREATE TABLE Location
  (
    FloodEventID INT NOT NULL,
    District VARCHAR(40),
    Vicinity VARCHAR(40),
    Area GEOMETRY,
    Location GEOMETRY,
    PRIMARY KEY(FloodEventID)
  )
END;


-- Create FKs
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES HydraulicsAndHydrology(FloodEventID)
;
    
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES Meteorology(FloodEventID)
;
    
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES EnvironmentalImpact(FloodEventID)
;
    
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES DemographicImpact(FloodEventID)
;
    
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES EconomicImpact(FloodEventID)
;
    
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES Resources(FloodEventID)
;
    
ALTER TABLE CoreDisasterInformation
    ADD    FOREIGN KEY (FloodEventID)
    REFERENCES Location(FloodEventID)
;
    

-- Create Indexes


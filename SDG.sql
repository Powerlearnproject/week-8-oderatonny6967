CREATE TABLE Communities (
    CommunityID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(100),
    Population INT
);

CREATE TABLE WaterSources (
    SourceID INT PRIMARY KEY,
    CommunityID INT,
    SourceType VARCHAR(50),
    Latitude DECIMAL(10, 8),
    Longitude DECIMAL(11, 8),
    FOREIGN KEY (CommunityID) REFERENCES Communities(CommunityID)
);

CREATE TABLE WaterQualityTests (
    TestID INT PRIMARY KEY,
    SourceID INT,
    TestDate DATE,
    ContaminantLevel DECIMAL(5, 2),
    pH DECIMAL(3, 1),
    BacteriaCount INT,
    FOREIGN KEY (SourceID) REFERENCES WaterSources(SourceID)
);

CREATE TABLE WaterAccess (
    AccessID INT PRIMARY KEY,
    CommunityID INT,
    HouseholdsWithAccess INT,
    HouseholdsWithoutAccess INT,
    FOREIGN KEY (CommunityID) REFERENCES Communities(CommunityID)
);
INSERT INTO Communities VALUES (1, 'Village A', 'Region 1', 5000);
INSERT INTO Communities VALUES (2, 'Village B', 'Region 2', 3000);

INSERT INTO WaterSources VALUES (1, 1, 'River', -1.28333, 36.81667);
INSERT INTO WaterSources VALUES (2, 2, 'Well', -1.2921, 36.8219);

INSERT INTO WaterQualityTests VALUES (1, 1, '2024-08-01', 15.2, 7.1, 120);
INSERT INTO WaterQualityTests VALUES (2, 2, '2024-08-05', 5.8, 6.9, 80);

INSERT INTO WaterAccess VALUES (1, 1, 1000, 4000);
INSERT INTO WaterAccess VALUES (2, 2, 1500, 1500);
SELECT C.Name, WQ.ContaminantLevel
FROM WaterQualityTests WQ
JOIN WaterSources WS ON WQ.SourceID = WS.SourceID
JOIN Communities C ON WS.CommunityID = C.CommunityID
ORDER BY WQ.ContaminantLevel DESC
LIMIT 5;
SELECT C.Name, 
       (WA.HouseholdsWithoutAccess * 100.0 / (WA.HouseholdsWithAccess + WA.HouseholdsWithoutAccess)) AS PercentageWithoutAccess
FROM WaterAccess WA
JOIN Communities C ON WA.CommunityID = C.CommunityID
ORDER BY PercentageWithoutAccess DESC;


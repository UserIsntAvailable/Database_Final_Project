CREATE DATABASE AEC;

USE AEC;

GO

--Table to store Contact Information
CREATE TABLE ContactInfo
(
    ContactInfoId INT IDENTITY(10001, 1) PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
	Email VARCHAR(320) NOT NULL,

	CONSTRAINT CHECK_ContactInfo_PhoneNumber CHECK(PhoneNumber LIKE '+% %-%-%'),
	CONSTRAINT CHECK_ContactInfo_Email CHECK(Email LIKE '%@%.%')
);

INSERT INTO ContactInfo VALUES
('Lily', 'Wilson', '+1 701-620-9168', 'lily.wilson@example.com'),
('Louise', 'Ramirez', '+1 595-687-2674', 'louise.ramirez@example.com'),
('Maurice', 'Martin', '+1 805-724-2035', 'maurice.martin@example.com'),
('Michael', 'Watson', '+1 537-474-3522', 'michael.watson@example.com'),
('Jackson', 'Smith', '+1 856-521-5541', 'jackson.smith@example.com');


CREATE TABLE Candidate
(
	CandidateId INT IDENTITY(10001, 1) PRIMARY KEY,
	SSN VARCHAR(11) NOT NULL,
	HomeAddress NVARCHAR(100) NOT NULL,
	ContactInfoId INT FOREIGN KEY REFERENCES ContactInfo(ContactInfoId),

	CONSTRAINT CHECK_Candidate_SSN CHECK(SSN LIKE '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]')
);

INSERT INTO Candidate VALUES 
('408-31-8616', 'Ypsilanti, MI 48197, USA', 10002),
('433-38-8293', '8546 Hunters Creek Dr, Plymouth, MI 48170, USA', 10001),
('363-10-4267', '7701 Walnut Hl Ln, Dallas, TX 75230, USA', 10003);


CREATE TABLE Qualification
(
	QualificationId INT IDENTITY(10001, 1) PRIMARY KEY,
	[Name] VARCHAR(60)
);

INSERT INTO Qualification VALUES
('Microsoft Office 365 Certificate'),
('C# Certificate'),
('Professional Certificate in Graphic Design');


CREATE TABLE Company
(
	CompanyId INT IDENTITY(10001, 1) PRIMARY KEY,
	[Name] NVARCHAR(15) NOT NULL,
	[Address] NVARCHAR(100) NOT NULL
);

INSERT INTO Company VALUES
('Amazon', '410 Terry Ave N, Seattle 98109, WA'),
('Microsoft', 'One Microsoft Way. Redmond. Washington. 98052-6399. USA'),
('ShinaStudios', '7943 Belmont Road Manassas, VA 20109');

CREATE TABLE CompanyRequestingEmployees
(
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	ContactInfoId INT FOREIGN KEY REFERENCES ContactInfo(ContactInfoId),

	CONSTRAINT PK_COMP_CONT PRIMARY KEY (CompanyId, ContactInfoId)
);

INSERT INTO CompanyRequestingEmployees VALUES
(10003, 10005),
(10001, 10004);


CREATE TABLE JobHistory
(
	JobHistoryId INT IDENTITY(10001, 1) PRIMARY KEY,
	StartDate DATE NOT NULL,
	EndDate DATE NULL,
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT CHECK_JobHistory_EndDate CHECK (EndDate >= StartDate)
);

INSERT INTO JobHistory VALUES
('2018-12-16', '2019-06-11', 10001, 10002, 10002);


CREATE TABLE CandidateQualification
(
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT PK_CAND_QUAL PRIMARY KEY(CandidateId, QualificationId)
);

INSERT INTO CandidateQualification VALUES
(10001, 10002),
(10002, 10003),
(10003, 10001);


CREATE TABLE JobOpening
(
	OpeningId INT IDENTITY(10001, 1) PRIMARY KEY,
	StartingDate DATE NOT NULL,
	EndingDate DATE NOT NULL,
	HourlyRate NUMERIC(3,1) NOT NULL,
	IsAvailable VARCHAR(20) DEFAULT 'AVAILABLE',
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT CHECK_Opening_EndingDate CHECK(EndingDate >= StartingDate),
	CONSTRAINT CHECK_Opening_IsAvailable CHECK(IsAvailable IN('AVAILABLE', 'NOT AVAILABLE'))
);

INSERT INTO JobOpening VALUES
('2022-01-15', '2022-07-15', 25.0, DEFAULT, 10001, 10003),
('2022-06-01', '2022-08-24', 14.0, DEFAULT, 10003, 10001);


CREATE TABLE JobHistory
(
	JobHistoryId INT IDENTITY(10001, 1) PRIMARY KEY,
	StartDate DATE NOT NULL,
	EndDate DATE NULL,
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT CHECK_JobHistory_EndDate CHECK (EndDate >= StartDate)
);

INSERT INTO JobHistory VALUES
('2018-12-16', '2019-06-11', 10001, 10002, 10002);


CREATE TABLE JobPlacement
(
	OpeningId INT FOREIGN KEY REFERENCES JobOpening(OpeningId),
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	TotalHours INT DEFAULT 0 NOT NULL,

	CONSTRAINT PK_OPEN_CAND PRIMARY KEY(OpeningId, CandidateId),
	CONSTRAINT Check_JobPlacement_TotalHours CHECK(TotalHours >= 0)
);

--1. List all the qualifications for a specific candidate
--All qualifications regarding the specific candate with the Id 10001

SELECT Q.Name, Q.QualificationId, C.CandidateId
FROM Qualification Q 
JOIN CandidateQualification CQ ON Q.QualificationId = CQ.QualificationId
JOIN Candidate C ON C.CandidateId = CQ.CandidateId
WHERE C.CandidateId = '10001'

--2. Get details of all job openings for a given company lists.
--This gives all job openings for a given company.

SELECT JO.OpeningId, JO.StartingDate, JO.EndingDate,JO.HourlyRate, JO.IsAvailable, JO.CompanyId, JO.QualificationId, C.Name, C.Address
FROM JobOpening JO
JOIN COMPANY C ON JO.CompanyId = C.CompanyId
JOIN CompanyRequestingEmployees CRE ON CRE.CompanyId = JO.CompanyId

--3. Get details of all current and past job openings.

SELECT * FROM JobOpening

--4. Get the number of candidates that are without any job history

SELECT COUNT(C.CandidateId) AS NumOfCandidates
FROM Candidate C
JOIN JobHistory JH ON C.CandidateId = JH.CandidateId


/*
	5. When the job is assigned (i.e., an entry is made in the Placement table), create a trigger
	named trg_updatestatus to update the opening_available column in the openings table to 'NOT AVAILABLE.'
*/

CREATE TRIGGER trg_updatestatus 
ON JobPlacement 
AFTER INSERT
AS
BEGIN
	UPDATE JobOpening
	SET IsAvailable = 'NOT AVAILABLE'
	FROM JobOpening JO
	JOIN INSERTED I ON JO.OpeningId = I.OpeningId;
END;

INSERT INTO JobPlacement VALUES(10001, 10002, DEFAULT);

SELECT *
FROM JobOpening;





USE AEC;

CREATE TABLE Candidate
(
	CandidateId INT IDENTITY(10001, 1) PRIMARY KEY,
	SSN VARCHAR(11) NOT NULL,
	HomeAddress NVARCHAR(100) NOT NULL,
	ContactInfoId INT FOREIGN KEY REFERENCES ContactInfo(ContactInfoId),

	CONSTRAINT CHECK_Candidate_SSN CHECK(SSN LIKE '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]')
);

GO;

INSERT INTO Candidate VALUES 
('408-31-8616', 'Ypsilanti, MI 48197, USA', 10002),
('433-38-8293', '8546 Hunters Creek Dr, Plymouth, MI 48170, USA', 10001),
('363-10-4267', '7701 Walnut Hl Ln, Dallas, TX 75230, USA', 10003);
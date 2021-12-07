USE AEC;

CREATE TABLE Qualification
(
	QualificationId INT IDENTITY(10001, 1) PRIMARY KEY,
	[Name] NVARCHAR(100)
);

GO;

INSERT INTO Qualification VALUES
('Microsoft Office 365 Certificate'),
('C# Certificate'),
('Professional Certificate in Graphic Design'),
USE AEC;

CREATE TABLE Company
(
	CompanyId INT IDENTITY(10001, 1) PRIMARY KEY,
	[Name] NVARCHAR(15) NOT NULL,
	[Address] NVARCHAR(100) NOT NULL
);

GO;

INSERT INTO Company VALUES
('Amazon', '410 Terry Ave N, Seattle 98109, WA'),
('Microsoft', 'One Microsoft Way. Redmond. Washington. 98052-6399. USA'),
('ShinaStudios', '7943 Belmont Road Manassas, VA 20109');
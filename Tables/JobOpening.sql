USE AEC;

CREATE TABLE JobOpening
(
	OpeningId INT IDENTITY(10001, 1) PRIMARY KEY,
	StartingDate DATE NOT NULL,
	EndingDate DATE NOT NULL,
	HourlyRate NUMERIC(3,1) NOT NULL,
	IsAvailable VARCHAR(20) DEFAULT 'AVAILABLE',
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT CHECK_Opening_EndingDate CHECK(EndingDate >= StartingDate)
	CONSTRAINT CHECK_Opening_IsAvailable CHECK(IsAvailable IN('AVAILABLE', 'NOT AVAILABLE'))
);

GO;
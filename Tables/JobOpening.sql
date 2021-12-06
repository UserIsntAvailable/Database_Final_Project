USE AEC;

CREATE TABLE JobOpening
(
	OpeningId INT IDENTITY(10001, 1) PRIMARY KEY,
	StartingDate DATE NOT NULL,
	EndingDate DATE NOT NULL,
	HourlyRate NUMERIC(3,1) NOT NULL,
	IsAvailable VARCHAR(15) NOT NULL,
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	QualificationName INT FOREIGN KEY REFERENCES Qualification(QualificationName),

	CONSTRAINT CHECK_Opening_EndingDate CHECK(EndingDate >= StartingDate)
	CONSTRAINT CHECK_Opening_IsAvailable CHECK(IsAvailable IN("AVAILABLE", "NOT AVAILABLE"))
);

GO;
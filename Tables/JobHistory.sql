USE AEC;

CREATE TABLE JobHistory
(
	JobHistoryId INT IDENTITY(10001, 1) PRIMARY KEY,
	StartDate DATE NOT NULL,
	EndDate DATE NULL,
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	QualificationName INT FOREIGN KEY REFERENCES Qualification(QualificationName),

	CONSTRAINT CHECK_JobHistory_EndDate CHECK (EndDate >= StartDate)
);

GO;
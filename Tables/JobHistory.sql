USE AEC;

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

GO;

INSERT INTO JobHistory VALUES
('2018-12-16', '2019-06-11', 10001, 10002, 10002);
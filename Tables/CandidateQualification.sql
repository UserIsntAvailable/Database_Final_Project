USE AEC;

CREATE TABLE CandidateQualification
(
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT PK_CAND_QUAL PRIMARY KEY(CandidateId, QualificationId)
);

GO;

INSERT INTO CandidateQualification VALUES
(10001, 10002),
(10002, 10003),
(10003, 10001);
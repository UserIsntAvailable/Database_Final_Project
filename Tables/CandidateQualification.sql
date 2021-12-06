USE AEC;

CREATE TABLE CandidateQualification
(
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	QualificationId INT FOREIGN KEY REFERENCES Qualification(QualificationId),

	CONSTRAINT PK_CAND_QUAL PRIMARY KEY(CandidateId, QualificationId)
);

GO;
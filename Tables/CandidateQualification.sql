USE AEC;

CREATE TABLE CandidateQualification
(
    CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
    QualificationName INT FOREIGN KEY REFERENCES Qualification(QualificationName),

    CONSTRAINT PK_CAND_QUAL PRIMARY KEY(CandidateId, QualificationName)
);

GO;
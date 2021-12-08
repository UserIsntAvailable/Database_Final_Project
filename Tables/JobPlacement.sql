USE AEC;

CREATE TABLE JobPlacement
(
	OpeningId INT FOREIGN KEY REFERENCES JobOpening(OpeningId),
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	TotalHours INT DEFAULT 0 NOT NULL,

	CONSTRAINT PK_OPEN_CAND PRIMARY KEY(OpeningId, CandidateId),
	CONSTRAINT Check_JobPlacement_TotalHours CHECK(TotalHours >= 0)
);

GO;
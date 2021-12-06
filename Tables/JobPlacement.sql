USE AEC;

CREATE TABLE JobPlacement
(
	OpeningId INT FOREIGN KEY REFERENCES JobOpening(OpeningId),
	CandidateId INT FOREIGN KEY REFERENCES Candidate(CandidateId),
	TotalHours INT NOT NULL
);

GO;
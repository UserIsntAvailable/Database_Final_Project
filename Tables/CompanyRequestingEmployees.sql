USE AEC;

-- Maybe too long name?
CREATE TABLE CompanyRequestingEmployees
(
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	ContactInfoId INT FOREIGN KEY REFERENCES ContactInfo(ContactInfoId),

	CONSTRAINT PK_COMP_CONT PRIMARY KEY (CompanyId, ContactInfoId)
);

GO;

INSERT INTO CompanyRequestingEmployees VALUES
(10003, 10005),
(10001, 10004)
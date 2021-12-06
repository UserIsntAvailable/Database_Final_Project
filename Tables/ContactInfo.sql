USE AEC;

CREATE TABLE ContactInfo
(
    ContactInfoId INT IDENTITY(10001, 1) PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
	Email VARCHAR(320) NOT NULL,

	CONSTRAINT CHECK_ContactInfo_PhoneNumber CHECK(PhoneNumber LIKE '+% %-%-%'),
	CONSTRAINT CHECK_ContactInfo_Email CHECK(Email LIKE '%@%.%')
);

GO;
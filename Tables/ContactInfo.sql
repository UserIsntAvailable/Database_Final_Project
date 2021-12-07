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

INSERT INTO ContactInfo VALUES
('Lily', 'Wilson', '+1 701-620-9168', 'lily.wilson@example.com'),
('Louise', 'Ramirez', '+1 595-687-2674', 'louise.ramirez@example.com'),
('Maurice', 'Martin', '+1 805-724-2035', 'maurice.martin@example.com'),
('Michael', 'Watson', '+1 537-474-3522', 'michael.watson@example.com'),
('Jackson', 'Smith', '+1 856-521-5541', 'jackson.smith@example.com');
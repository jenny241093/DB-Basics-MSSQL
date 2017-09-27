
CREATE TABLE Directors (
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NTEXT
)

CREATE TABLE Genres (
	Id INT PRIMARY KEY IDENTITY,
	GenreName VARCHAR(50) NOT NULL,
	Notes NTEXT
)

CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	CategoryName VARCHAR(50) NOT NULL,
	Notes NTEXT
)

CREATE TABLE Movies (
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(50) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear INT NOT NULL,
	[Length] DECIMAL(5, 2) NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating DECIMAL(2, 1),
	Notes NTEXT,
)

INSERT INTO Directors (DirectorName, Notes)
VALUES
('Jenny', 'Jennys Note'),
('Ivaylo', 'Ivaylos Note'),
('George', 'George Note'),
('Ivan', NULL),
('Samat', 'Stamats Note')

INSERT INTO Genres (GenreName, Notes)
VALUES
('Thriller', 'A novel, play, or film with an exciting plot, typically involving crime or espionage'),
('Horror', 'Horror is a genre of fiction which is intended to, or has the capacity to frighten, scare, disgust, or startle '),
('Drama', 'Drama film is a genre that relies on the emotional and relational development of realistic characters.'),
('Romance', 'Genre of popular fiction in which characters fall in love or begin a romantic relationship'),
('War', 'A genre is best defined as a movie in which a fictionalized or fact-based story is told about an actual historical war.')

INSERT INTO Categories(CategoryName,  Notes)
VALUES
('Category1', 'Note for Category1'),
('Category2', 'Note for Category2'),
('Category3', NULL),
('Category4', NULL),
('Category5', 'Note for Category5')


INSERT INTO Movies (Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes)
VALUES
('It', 1, 2017, 130.20, 1, 1, 4.2, 'Meet the Stars of Stephen Kings It.'),
('Mother!', 2, 1997, 120, 1, 2, 9.9, NULL),
('The Shape of Water', 3, 1999, 130.20, 2, 3, 7.5, 'The Shape of Water Cast Revels in the Magic of Guillermo del Toro'),
('American Assassin', 4, 2017, 100, 5, 4, 3.5, NULL),
('Baby Driver', 5, 1999, 130, 3, 5, 6.5, 'Edgar Wrights Top 10 Heist Movies')

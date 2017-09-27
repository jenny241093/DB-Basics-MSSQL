CREATE TABLE Users
(
Id INT  PRIMARY KEY IDENTITY,
Username NVARCHAR(30) NOT NULL,
[Password] NVARCHAR(26)NOT NULL,
ProfilePicture VARBINARY(900),
LastLoginTime SMALLDATETIME,
IsDeleted BIT DEFAULT 1

)

INSERT INTO Users(Username,[Password],ProfilePicture,LastLoginTime,IsDeleted)VALUES
('g_ivanov','123455',NULL,'2017-9-24',-1),
('p_stamatov','123355',NULL,'2017-9-23',-1),
('g_ivanov','123332455',NULL,'2017-9-24',-1),
('g_master','12345455',NULL,'2017-9-23',-1),
('l_dev','123422255',NULL,'2017-9-24',-1)
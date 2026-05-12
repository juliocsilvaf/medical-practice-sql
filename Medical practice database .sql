--Part 3: Use views and stored procedures
--To complete this part of the assessment, you are required to complete the practical tasks described. These tasks require you to develop the SQL code that addresses the requirements of each task.
--These practicals may be observed by your Assessor. The code developed by you in each task will be used by your Assessor to assess you, and you must submit your code as evidence for this assessment.
--Note: You will create one script file that includes all the queries for Part 3. Save your script file as yourInitials_TASK3.sql.
--Tasks

-- 1.	Create a view (called vwNurseDays) with the name and phone details of any nurse (registered or not)
-- and the days that they work. Execute the SQL statements to create the view.
USE MEDICALPRACTICE;
GO

DROP VIEW IF EXISTS vwNurseDays;
GO

CREATE VIEW vwNurseDays
AS
SELECT FirstName, LastName, HomePhone, MobilePhone, WeekDayName_Ref
FROM Practitioner INNER JOIN Availability
ON Practitioner.Practitioner_ID=Availability.Practitioner_Ref
WHERE PractitionerType_Ref LIKE '%Nurse%';
GO
  
-- 2.	Using your view, write a query to retrieve the name and phone number details 
-- of all nurses who are scheduled to work on a Wednesday.
--FirstName      LastName       HomePhone  MobilePhone WorkDay---------
--Jason          Lithdon        0298785645 0317896453  Wednesday

SELECT *
FROM vwNurseDays
WHERE WeekDayName_Ref = 'Wednesday';
GO

-- 3.	Create a view (called vwNSWPatients) that contains all patient details for patients 
-- whose address is in NSW. Execute the SQL statements to create the view.
--Patient_ID  Title       FirstName      MiddleInitial LastName       HouseUnitLotNum Street         Suburb         State PostCode HomePhone  MobilePhone MedicareNumber   DateOfBirth Gender
--10000       Mr          Mackenzie      J    Fleetwood      233    Dreaming Street         Roseville      NSW   2069     0298654743 0465375486  7253418356478253 2000-03-12  male
--10001       Ms          Jane           P    Killingsworth           34     Southern Road           Yarramundi     NSW   2753     0234654345 0342134679  9365243640183640 1943-04-08  female
--10002       Mr          Peter          D    Leons          21     Constitution Drive      West Hoxton    NSW   2171     0276539183 0125364927  1873652945578932 1962-07-08  male
--10003       Mr          Phill          B    Greggan        42     Donn Lane      Killara        NSW   2071     0276548709 1234326789  6473645782345678 1971-08-31  male
--10004       Dr          John           W    Ward           332    Tomorrow Road           Chatswood      NSW   2488     4847383848 4838382728  4738294848484838 1978-02-12  male
--10005       Mrs         Mary           D    Brown          Lot23  Johnston Road           Warwick Farm            NSW   2170     0297465243 0417335224  9356273321176546 1972-03-05  female
--10006       Mr          Terrence       D    Hill           43     Somerland Road          La Perouse     NSW   2987     0266645432 0365243561  6363525353535356 2005-10-04  male
--10007       Master      Adrian         B    Tamerkand      44     The Hill Road           Macquarie Fields        NSW   2756     0276546783 4848473738  9863652527637332 2008-12-12  male
--10008       Ms          Joan           D    Wothers        32     Slapping Street         Mount Lewis    NSW   2343     1294848777 8484737384  9484746125364765 1997-06-12  female
--10010       Mrs         Wendy          J    Pilington      182    Parramatta Road         Lidcombe       NSW   2345     4837383848 8473838383  8483727616273838 1985-09-17  female

DROP VIEW IF EXISTS vwNSWPatients;
GO

CREATE VIEW vwNSWPatients
AS
SELECT *
FROM Patient
WHERE State = 'NSW';
GO

-- 4.	Create a stored procedure (called spSelect_vwNSWPatients) to retrieve all records 
-- and columns from vwNSWPatients in postcode order ascending. Execute the stored procedure.

DROP PROCEDURE IF EXISTS spSelect_vwNSWPatients;
GO

CREATE PROCEDURE spSelect_vwNSWPatients
AS
SELECT *
FROM vwNSWPatients
ORDER BY PostCode ASC;
GO

/* Execute the stored procedure. */

EXECUTE spSelect_vwNSWPatients;
GO

--Patient_ID  Title       FirstName      MiddleInitial LastName       HouseUnitLotNum Street         Suburb         State PostCode HomePhone  MobilePhone MedicareNumber   DateOfBirth Gender
--10000       Mr          Mackenzie      J    Fleetwood      233    Dreaming Street         Roseville      NSW   2069     0298654743 0465375486  7253418356478253 2000-03-12  male
--10003       Mr          Phill          B    Greggan        42     Donn Lane      Killara        NSW   2071     0276548709 1234326789  6473645782345678 1971-08-31  male
--10005       Mrs         Mary           D    Brown          Lot23  Johnston Road           Warwick Farm            NSW   2170     0297465243 0417335224  9356273321176546 1972-03-05  female
--10002       Mr          Peter          D    Leons          21     Constitution Drive      West Hoxton    NSW   2171     0276539183 0125364927  1873652945578932 1962-07-08  male
--10008       Ms          Joan           D    Wothers        32     Slapping Street         Mount Lewis    NSW   2343     1294848777 8484737384  9484746125364765 1997-06-12  female
--10010       Mrs         Wendy          J    Pilington      182    Parramatta Road         Lidcombe       NSW   2345     4837383848 8473838383  8483727616273838 1985-09-17  female
--10004       Dr          John           W    Ward           332    Tomorrow Road           Chatswood      NSW   2488     4847383848 4838382728  4738294848484838 1978-02-12  male
--10001       Ms          Jane           P    Killingsworth           34     Southern Road           Yarramundi     NSW   2753     0234654345 0342134679  9365243640183640 1943-04-08  female
--10007       Master      Adrian         B    Tamerkand      44     The Hill Road           Macquarie Fields        NSW   2756     0276546783 4848473738  9863652527637332 2008-12-12  male
--10006       Mr          Terrence       D    Hill           43     Somerland Road          La Perouse     NSW   2987     0266645432 0365243561  6363525353535356 2005-10-04  male


-- 5.	Create a stored procedure (called spInsert_vwNSWPatients) to insert a new record 
-- into vwNSWPatients, using parameters for all relevant data. 
-- Execute the stored procedure inserting a record for a new patient named Mr Mickey M Mouse from 1 Smith St, Smithville, NSW 2222. 

DROP PROCEDURE IF EXISTS spInsert_vwNSWPatients;
GO

CREATE PROCEDURE spInsert_vwNSWPatients
	@Title NVARCHAR(20),
	@FirstName NVARCHAR(50),
	@MiddleInitial NCHAR(1),
	@LastName NVARCHAR(50),
	@HouseUnitLotNum NVARCHAR(5),
	@Street NVARCHAR(50),
	@Suburb NVARCHAR(50),
	@State NVARCHAR(3),
	@PostCode NCHAR(4),
	@HomePhone NCHAR(10),
	@MobilePhone NCHAR(10),
	@MedicareNumber NCHAR(16),
	@DateOfBirth DATE,
	@Gender NCHAR(20)

AS
BEGIN
	INSERT INTO vwNSWPatients
	VALUES(@Title, @FirstName, @MiddleInitial, @LastName, @HouseUnitLotNum, @Street, @Suburb, @State, @PostCode, 
	@HomePhone, @MobilePhone, @MedicareNumber, @DateOfBirth, @Gender)
END;
GO


/* Execute the stored procedure inserting a record for a new patient named 
Mr Mickey M Mouse from 1 Smith St, Smithville, NSW 2222.  */

EXECUTE spInsert_vwNSWPatients
@Title='Mr',
@FirstName='Mickey',
@MiddleInitial='M',
@LastName='Mouse',
@HouseUnitLotNum='1',
@Street='Smith St',
@Suburb='Smithville',
@State='NSW',
@PostCode='2222',
@HomePhone='0222222222',
@MobilePhone='0444444444',
@MedicareNumber='242424242424',
@DateOfBirth='1940-01-01',
@Gender='male';
GO


/* Run a query to verify that the record has been added to the Patient table. */

SELECT *
FROM Patient
WHERE FirstName = 'Mickey' AND LastName = 'Mouse';
GO

DELETE FROM Patient
WHERE Patient_ID = 10012;
GO

--Patient_ID	Title	FirstName	MiddleInitial	LastName	HouseUnitLotNum	Street	Suburb	State	PostCode	HomePhone	MobilePhone	MedicareNumber	DateOfBirth	Gender	LastContactDate
--10011	Mr	Mickey	M	Mouse	1	Smith St	Smithveille	NSW	2222	0222222222	0444444444	242424242424    	1940-01-01	Male                	NULL


---- 6.	Create a stored procedure (called spModify_PractitionerMobilePhone) using the 
-- Practitioner table to change a practitioner’s mobile phone number, using the Practitioner ID 
-- and the new mobile number as parameters. Execute the stored procedure to change Hilda Brown’s 
-- mobile number to 0412345678.

DROP PROCEDURE IF EXISTS spModify_PractitionerMobilePhone;
GO

CREATE PROCEDURE spModify_PractitionerMobilePhone
@Mobile VARCHAR(10), @PractitionerID INT
AS
BEGIN
	UPDATE Practitioner
	SET MobilePhone = @Mobile
	WHERE Practitioner_ID = @PractitionerID
END;
GO


/* Execute the stored procedure to change Hilda Brown’s mobile number to 0412345678. */

EXECUTE spModify_PractitionerMobilePhone @Mobile='0412345678', @PractitionerID=10001;
GO



-- Run a query to verify that the record has been updated in the Practitioner table.
SELECT *
FROM Practitioner
WHERE Practitioner_ID = 10001;
GO


--Practitioner_ID	Title	FirstName	MiddleInitial	LastName	HouseUnitLotNum	Street	Suburb	State	PostCode	HomePhone	MobilePhone	MedicareNumber	MedicalRegistrationNumber	DateOfBirth	Gender	PractitionerType_Ref	DriversLicenceHash
--10001	Mrs	Hilda	D	Brown	32	Argyle Street	Bonnels Bay	NSW	2264	0249756544	0412345678	4635278435099921	37876273849	1993-12-03	female	Registered nurse	NULL


---- 7.	Manipulate the Practitioner table to store a driver’s licence number. 
-- For privacy and security purposes this data needs to be encrypted. 
-- Name the new column DriversLicenceHash. For encrypting the column, use a one-way hashing algorithm. 
-- Execute the statement to create the new column.

ALTER TABLE Practitioner
ADD DriversLicenceHash BINARY(64);
GO


-- Add the driver's licence number of 1066AD Dr Ludo Vergenargen’s (Practitioner ID 10005) drivers licence using a SHA hashing function.

UPDATE Practitioner
SET DriversLicenceHash = HASHBYTES('SHA2_512','1066AD')
WHERE Practitioner_ID=10005;
GO


-- Display Dr Vertenargen’s record to view the hashed number.

SELECT *
FROM Practitioner
WHERE Practitioner_ID=10005;
GO


--Practitioner_ID	Title	FirstName	MiddleInitial	LastName	HouseUnitLotNum	Street	Suburb	State	PostCode	HomePhone	MobilePhone	MedicareNumber	MedicalRegistrationNumber	DateOfBirth	Gender	PractitionerType_Ref	DriversLicenceHash
--10005	Dr	Ludo	V	Vergenargen	27	Pembleton Place	Redfern	NSW	2049	9383737627	8372727283	8484737626278884	84737626673	1986-05-15	male	Medical Practitioner (Doctor or GP)	0x984D108008E9FD88FEFA9E0E40DF4300AE9E0B4519109087B5D7DA7F9BEC2F241D6FD3F5DF6D7BCFA4CF22F41B92DD7F6C571BF6A603F99FD8B795B412F9C593

-- 8.	Manipulate the Patient table to add a new column that will store a date value 
-- which is the last date they made contact. The default value should be the date of record creation. 
-- Name the new column LastContactDate. Execute the statement to create the new column.

ALTER TABLE Patient
ADD LastContactDate Date;
GO

-- 9.	Create a trigger on the Appointment table that will update LastContactDate 
-- on the Patient table each time a new record is added to the Appointment table. 
-- The value of the LastContactDate should be the date the record is added. 
-- Name the trigger tr_Appointment_AfterInsert.

DROP TRIGGER IF EXISTS tr_Appointment_AfterInsert;
GO

CREATE TRIGGER tr_Appointment_AfterInsert
ON Appointment
AFTER Insert
AS
BEGIN
	DECLARE @PatientRef INTEGER
	SELECT @PatientRef = Patient_Ref FROM inserted;

	UPDATE Patient
	SET LastContactDate = CURRENT_TIMESTAMP
	WHERE Patient_ID = @PatientRef;
END;
GO

/* Add an appointment for Mr Terrence Hill (Patient ID 10006) with Ms Paula Yates (Practitioner ID 10004) for the 21st December 2024 at 9:15am. */

INSERT INTO Appointment
VALUES(10004,'20241221','9:15',10006);
GO


/* Check the trigger on the Patient Table)  */

SELECT *
FROM Patient
WHERE Patient_ID=10006;
GO



--Patient_ID	Title	FirstName	MiddleInitial	LastName	HouseUnitLotNum	Street	Suburb	State	PostCode	HomePhone	MobilePhone	MedicareNumber	DateOfBirth	Gender	LastContactDate
--10006	Mr	Terrence	D	Hill	43	Somerland Road	La Perouse	NSW	2987	0266645432	0365243561	6363525353535356	2005-10-04	male	2025-03-24

-- 10.	Delete the view vwNurseDays from the database.

DROP VIEW IF EXISTS vwNurseDays;
GO

-- 11.	Delete the stored procedure spSelect_vwNSWPatients from the database.

DROP PROCEDURE IF EXISTS spSelect_vwNSWPatients;
GO
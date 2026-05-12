use MedicalPractice;
Go

--Q1
-- List the first name and last name of female
-- patients who live in St Kilda or Lidcombe.

SELECT FirstName, LastName
FROM Patient
WHERE Gender = 'female' AND (Suburb = 'St Kilda' or Suburb = 'Lidcombe');
GO


--FirstName	LastName
--Caroline	Barrette
--Wendy	Pilington

--Q2
-- List the first name, last name, state
-- and Medicare Number of any patients who do not live in NSW.

SELECT FirstName, LastName, State, MedicareNumber
FROM Patient
WHERE NOT  State = 'NSW';
GO

--FirstName	LastName	State	MedicareNumber
--Caroline	Barrette	VIC	1234565725463728

--Q3 
-- List each patient's first name, last name, 
-- Medicare Number and date of birth. Sort the list 
-- by date of birth, listing the youngest patients first.

SELECT FirstName, LastName, MedicareNumber, DateOfBirth
FROM Patient
ORDER BY DateOfBirth DESC;
GO

--FirstName	LastName	MedicareNumber	DateOfBirth
--Adrian	Tamerkand	9863652527637332	2008-12-12
--Terrence	Hill	6363525353535356	2005-10-04
--Mackenzie	Fleetwood	7253418356478253	2000-03-12
--Joan	Wothers	9484746125364765	1997-06-12
--Wendy	Pilington	8483727616273838	1985-09-17
--John	Ward	4738294848484838	1978-02-12
--Mary	Brown	9356273321176546	1972-03-05
--Phill	Greggan	6473645782345678	1971-08-31
--Caroline	Barrette	1234565725463728	1965-04-04
--Peter	Leons	1873652945578932	1962-07-08
--Jane	Killingsworth	9365243640183640	1943-04-08

--Q4
-- For each practitioner, list their ID, first name, last name, 
-- the total number of days and the total number of hours they are scheduled 
-- to work in a standard week at the Medical Practice. Assume a workday is nine hours long.

SELECT p.Practitioner_ID, p.FirstName, p.LastName, COUNT(a.WeekDayName_Ref) as Days,
COUNT(a.WeekDayName_Ref)*9 as Hours
FROM Practitioner as p INNER JOIN Availability as a
ON p.Practitioner_ID = a.Practitioner_Ref
GROUP BY p.Practitioner_ID, p.FirstName, p.LastName;
GO

--Practitioner_ID	FirstName	LastName	TotalHours
--10000	Mark	Huston	27
--10001	Hilda	Brown	18
--10002	Jennifer	Dunsworth	18
--10003	Jason	Lithdon	27
--10004	Paula	Yates	18
--10005	Ludo	Vergenargen	18
--10006	Anne	Funsworth	9
--10007	Leslie	Gray	18
--10008	Adam	Moody	27

--Q5
-- List the Patient's first name, last name and the appointment date and time, 
-- for all appointments held on 18/09/2019 by Dr Anne Funsworth.

SELECT p.FirstName, p.LastName, a.AppDate, a.AppStartTime
FROM Patient as p INNER JOIN Appointment as a
ON p.Patient_ID = a.Patient_Ref
WHERE a.AppDate = '20190918' AND a.Practitioner_Ref = (SELECT Practitioner_ID FROM Practitioner WHERE FirstName = 'Anne' AND LastName='Funsworth');
GO

--FirstName	LastName	AppDate	AppStartTime
--Wendy	Pilington	2019-09-18	09:30:00.0000000
--Mackenzie	Fleetwood	2019-09-18	10:00:00.0000000
--Mackenzie	Fleetwood	2019-09-18	10:15:00.0000000
--Mackenzie	Fleetwood	2019-09-18	10:30:00.0000000
--Mackenzie	Fleetwood	2019-09-18	10:45:00.0000000
--Mackenzie	Fleetwood	2019-09-18	11:00:00.0000000

--Q6
-- List the ID and date of birth of any patient who has not had an appointment 
-- and was born before 1950.

SELECT p.Patient_ID, p.DateOfBirth
FROM Patient as p LEFT OUTER JOIN Appointment as a
ON p.Patient_ID = a.Patient_Ref
WHERE a.AppDate IS NULL AND YEAR(p.DateOfBirth) < 1950;
GO

--Patient_ID	DateOfBirth
--10001	1943-04-08

--Q7
-- List the patient ID, first name, last name and the number of appointments 
-- for patients who have had at least three appointments. List the patients in 
-- 'number of appointments' order from most to least.

SELECT p.Patient_ID, p.FirstName, p.LastName, COUNT(a.AppStartTime) as noAppointment
FROM Patient as p INNER JOIN Appointment as a
ON p.Patient_ID = a.Patient_Ref
GROUP BY p.Patient_ID, p.FirstName, p.LastName
HAVING COUNT(a.AppStartTime) >= 3
ORDER BY noAppointment DESC;
GO

--Patient_ID	FirstName	LastName	noOfAppt
--10000	Mackenzie	Fleetwood	6
--10010	Wendy	Pilington	4
--10008	Joan	Wothers	3

--Q8
-- List the first name, last name, gender, and the number of days 
-- since the last appointment of each patient and 23/09/2019.

SELECT p.FirstName, p.LastName, p.Gender, DATEDIFF(day,MAX(a.AppDate),'20190923') as daysLastApp
FROM Patient as p INNER JOIN Appointment as a
ON p.Patient_ID = a.Patient_Ref
GROUP BY p.FirstName, p.LastName, p.Gender;
GO

--FirstName	LastName	Gender	noDays
--Caroline	Barrette	female	6
--Joan	Wothers	female	5
--Mackenzie	Fleetwood	male	5
--Mary	Brown	female	5
--Peter	Leons	male	6
--Phill	Greggan	male	5
--Terrence	Hill	male	5
--Wendy	Pilington	female	5

--Q9
-- List the full name and full address of each practitioner in the following format exactly.
-- Dr Mark P. Huston. 21 Fuller Street SUNSHINE, NSW 2343
-- Make sure you include the punctuation and the suburb in upper case.
-- Sort the list by last name, then first name, then middle initial.

SELECT CONCAT(Title,' ',FirstName,' ',MiddleInitial,'. ',LastName,'. ',HouseUnitLotNum,' ',Street,' ',UPPER(Suburb),', ',State,' ',PostCode,' ')
FROM Practitioner
ORDER BY LastName, FirstName, MiddleInitial;
GO

--NameAddress
--Mrs Hilda D. Brown,32 Argyle Street BONNELS BAY, NSW 2264
--Mrs Jennifer J. Dunsworth,45 Dora Street MORRISET, NSW 2264
--Dr Anne D. Funsworth,4/89 Pacific Highway ST LEONARDS, NSW 2984
--Mrs Leslie V. Gray,98 Dandaraga Road MIRRABOOKA, NSW 2264
--Mr Leslie Y. Gray,3 Dorwington Place ENMORE, NSW 2048
--Dr Mark P. Huston,21 Fuller Street SUNSHINE, NSW 2343
--Mr Jason D. Lithdon,43 Fowler Street CAMPERDOWN, NSW 2050
--Dr Adam J. Moody,35 Mullabinga Way BRIGHTWATERS, NSW 2264
--Dr Ludo V. Vergenargen,27 Pembleton Place REDFERN, NSW 2049
--Ms Paula D. Yates,89 Tableton Road NEWTOWN, NSW 2051

--Q10
--List the patient id, first name, last name and date of birth of the fifth oldest patient(s). 

SELECT Patient_ID, FirstName, LastName, DateOfBirth
FROM Patient
ORDER BY DateOfBirth ASC
OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY;
GO

--Patient_ID	FirstName	LastName	DateOfBirth
--10000	Mackenzie	Fleetwood	2000-03-12

--Q11
--11.	List the patient ID, first name, last name, appointment date 
-- (in the format 'Tuesday 17 September, 2019') and appointment time (in the format '14:15 PM') 
-- for all patients who have had appointments on any Tuesday after 10:00 AM.

SELECT p.Patient_ID, p.FirstName, p.LastName, FORMAT(a.AppDate,'dddd dd MMMM, yyyy') as AppDate, FORMAT(CAST(a.AppStartTime as datetime2),'HH:mm tt') as AppTime
FROM Patient as p INNER JOIN Appointment as a
ON p.Patient_ID = a.Patient_Ref
WHERE FORMAT(a.AppDate,'dddd dd MMMM, yyyy') Like 'Tuesday%' AND a.AppStartTime > '10:00';
GO

--Patient_ID	FirstName	LastName	(No column name)	(No column name)
--10010	Wendy	Pilington	Tuesday 17 September, 2019	10:15 AM


--Q12
--12.	Create an address list for a special newsletter to all patients and practitioners. 
-- The mailing list should contain all relevant address fields for each household. 
-- Note that each household should only receive one newsletter.

SELECT CONCAT(HouseUnitLotNum,' ',Street,' ',UPPER(Suburb),', ',State,' ',PostCode) as MailingAddress 
FROM Patient
UNION
SELECT CONCAT(HouseUnitLotNum,' ',Street,' ',UPPER(Suburb),', ',State,' ',PostCode) as MailingAddress 
FROM Practitioner;
GO

--NameAddress
--182 Parramatta Road Lidcombe,NSW 2345
--21 Constitution Drive West Hoxton,NSW 2171
--21 Fuller Street Sunshine,NSW 2343
--233 Dreaming Street Roseville,NSW 2069
--27 Pembleton Place Redfern,NSW 2049
--3 Dorwington Place Enmore,NSW 2048
--32 Argyle Street Bonnels Bay,NSW 2264
--32 Slapping Street Mount Lewis,NSW 2343
--332 Tomorrow Road Chatswood,NSW 2488
--34 Southern Road Yarramundi,NSW 2753
--35 Mullabinga Way Brightwaters,NSW 2264
--4/89 Pacific Highway St Leonards,NSW 2984
--42 Donn Lane Killara,NSW 2071
--43 Fowler Street Camperdown,NSW 2050
--43 Somerland Road La Perouse,NSW 2987
--44 Biggramham Road St Kilda,VIC 4332
--44 The Hill Road Macquarie Fields,NSW 2756
--45 Dora Street Morriset,NSW 2264
--89 Tableton Road Newtown,NSW 2051
--98 Dandaraga Road Mirrabooka,NSW 2264
--Lot23 Johnston Road Warwick Farm,NSW 2170


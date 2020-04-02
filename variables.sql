
/*NAME: Ryan Nguyen
Lesson: Working with Variables
DATE: 11/17/2019
*/

-- 2.

select count(Ontime) as Late from flights
where Ontime = 0;

set @LateFlights = 3;

select @LateFlights;

select * from flights;
-- 3. 

SET @LateFee = 1029;

Set @TotalLateFee = @LateFee * @LateFlights;

Select @TotalLateFee;

-- 4.

SET @TotalProfit = 45000;

Set @total = @TotalProfit - @TotalLateFee;
Select @total;  

-- 5.

SET @EarlyFlightDate = (SELECT MIN(FlightDateTime) FROM Flights);

SET @tenyears = (Select date_add(@EarlyFlightDate,Interval 10 Year));

select @EarlyFlightDate;

Select @tenyears;

set @finalten = (Select @EarlyFlightDate, date_add(@EarlyFlightDate, Interval 10 Year) From Flights);

set @finalten2 = @EarlyFlightDate, @tenyears;

select @EarlyFlightDate, @tenyears;

select * from flights;

-- 6. 

CREATE TABLE flightstemp 
(   FlightDepartureCity 	varchar(50),
    State	VarChar(50),
    FlightDestinationCity 	varchar(50),
    Ontime 					int
);

-- 7.

CREATE temporary table Flightstemporary 
(	FlightID 				INT NOT NULL AUTO_INCREMENT,
	FlightDatetime			datetime,
    FlightDepartureCity 	varchar(50),
    FlightDestinationCity 	varchar(50),
    Ontime 					int,
  PRIMARY KEY (FlightID)
);
	FlightDatetime			datetime,
    FlightDepartureCity 	varchar(50),
    FlightDestinationCity 	varchar(50),
    Ontime 					int,
  PRIMARY KEY (FlightID)
);

 -- 8.
 
 Insert into flightstemporary
 select * 
 from flights
 where Ontime = 1;
 
 select * from flightstemporary;


-- 9

select * from hospitalstaff;

set @Totalemployees = (select count(empid) as Employees from hospitalstaff);

set @TexasEmployees = (Select count(location) from hospitalstaff where location like '%-T%'); 

select @Totalemployees, @Texas;

-- 10.

set @TotalTexasDrs = (Select Count(NameJob) from hospitalstaff where NameJob like 'Dr.%');

select @TotalTexasDrs;

-- 11.

CREATE temporary table HospitalStaffTemp
(	name varchar(50),
    Job 	varchar(50) ,
	HireDate 	datetime NULL,
    City	Varchar(50),
    State	VarChar(50)
);

-- a, b, c, d


insert into HospitalStaffTemp (name, Job, HireDate, City, State )
select substring_index(NameJob, '_', 1),
substring_index(NameJob, '_', -1),
HireDate,
substring_index(Location, '-', - 1),
substring_index(Location, '-', 1) from hospitalstaff;

select * from hospitalstaffTemp;
select * from hospitalstaff;


-- 12.

Create Temporary Table VariableTable 
(	NameJob	Varchar(50), 
	DateYear	Varchar(50), 
	DateMonth	VarChar(50), 
	DateDay	Varchar(50)
);

-- a, b, c, d

insert into VariableTable (NameJob, DateYear, DateMonth, DateDay)
select NameJob,
Year(HireDate),
Month(HireDate),
Day(HireDate) from hospitalstaff;

select * from VariableTable;

extract(Year from Datetime),
extract(Month From DateTime),
extract(Day From DateTime) from hospitalstaff;
/*NAME: Ryan Nguyen
Lesson: 14. Working with data from MySQL in Tableau for data analysis and visualization 
DATE: 11/26/2019
*/


-- 1.

create table cars (
CarID		int,
CarMake		varchar(50),
CarModel	Varchar(50),
CarYear		INT
);

create table carsales (
SalesID		INT,
CardID		INT,
SalesDate	Datetime,
SalesAmount	INT,
Tax			INT,
discount	int
);

-- 6.

insert into cars (CarMake, CarModel, CarYear, carprice)
values
('Ford', 'Mustang', 2006, 200),
('Chevy', 'Camaro', 2005, 300),
('Tesla', 'Model x', 2015, 400),
('Tesla', 'Model s', 2017, 700),
('Mercedes', 'SL320', 2008, 800),
('Nissan', '350Z', 2001, 1000),
('Nissan', '370Z', 2012, 200),
('Honda', 'CRV', 2010, 300),
('Honda', 'Accord', 2002, 300),
('Chevy', 'Silverado', 2009, 600);


insert into carsales(CarID, SalesAmount, Tax, discount)
values
(1,  1000, 5.8, 2.1),
(2,  2000, 5.8, 2.1),
(3,  3000, 5.8, 2.1),
(4,  4000, 5.8, 2.1 ),
(5,  5000, 5.8, 2.1),
(6,  7000, 5.8, 2.1),
(7,  8000, 5.8, 2.1),
(8,  9000, 5.8, 2.1),
(9, 10000, 5.8, 2.1),
(10,  11000, 5.8, 2.1);

select * from cars;

select * from carsales;

-- 7.

delete from carsales
where CarID = 1 or CarID = 2;


-- 8. 

update cars
set CarModel = 'civic'
where carID = 4 or 5 or 6;

-- 9.

select * from cars
where carprice = 200;

-- 10
select * from carsales;

select (carmake), sum(carprice) from cars 
group by carmake
having sum(carprice) >= 200;

-- 11.

select * from carsales
where carID in (3, 4, 5, 6)
order by salesamount desc;

-- 12.

select * from carsales
where SalesDate like '2019%';

-- 13.

select * from carsales
where substr(SalesAmount, 1, 3) = 300;

-- 14.

create table cars2 (
CarID		int,
CarMake		varchar(50),
CarModel	Varchar(50),
CarYear		INT
);

-- 15.

truncate table cars2;

-- 16.

drop table cars2;

-- 17.

select carmake, sum(salesamount)
from carsales
inner join cars
on cars.CarID = carsales.CarID
group by CarMake;

-- 18. 

select * from carsales
order by SalesAmount desc limit 5;

-- 19.

USE `ryan_nguyen`;
DROP procedure IF EXISTS `MaxSalesAmount`;

DELIMITER $$
USE `ryan_nguyen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MaxSalesAmount`(in MaxSales_input int)
BEGIN

select carmake, carmodel, carsales.SalesAmount
from cars
inner join carsales
on cars.CarID = carsales.CarID
where carsales.SalesAmount < MaxSales_input;


END$$

DELIMITER ;

call MaxSalesAmount(5000);



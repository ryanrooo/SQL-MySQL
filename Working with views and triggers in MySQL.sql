/*NAME: Ryan Nguyen
Lesson: Working with views and triggers in MySQL
DATE: 11/23/2019
*/

-- 1.

truncate table toys;

-- 2.

create table toytracking (
ToyID	int,
ToyName	Varchar(50),
ToyCost	Decimal	,
ToyAction	Varchar(50),
ActionDate	Datetime
);

-- 3.

USE `ryan_nguyen`;

DELIMITER $$

DROP TRIGGER IF EXISTS ryan_nguyen.toys_BEFORE_INSERT$$
USE `ryan_nguyen`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ryan_nguyen`.`toys_BEFORE_INSERT` BEFORE INSERT ON `toys` FOR EACH ROW
BEGIN
INSERT INTO `ryan_nguyen`.`toytracking` (toyId, ToyName, ToyCost, Toyaction, ActionDate)
    VALUES (new.toyid, new.Toyname, new.Toycost, 'INSERT', now());
END$$
DELIMITER ;

select * from toys;

insert into toys (ToyID, ToyName, ToyCost)
values
(1,'car',20),
(2,'truck',30);

select * from toytracking;

truncate table toytracking;

-- 4.

USE `ryan_nguyen`;

DELIMITER $$

DROP TRIGGER IF EXISTS ryan_nguyen.toys_AFTER_UPDATE$$
USE `ryan_nguyen`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ryan_nguyen`.`toys_AFTER_UPDATE` AFTER UPDATE ON `toys` FOR EACH ROW
BEGIN
INSERT INTO `ryan_nguyen`.`toytracking` (toyId, ToyName, ToyCost, Toyaction, ActionDate)
    VALUES (new.toyid, new.Toyname, new.Toycost, 'UPDATE', now());
END$$
DELIMITER ;

Update toys 
set Toyname = 'house'
where ToyID = 3;

select * from toytracking;

-- 5.

USE `ryan_nguyen`;

DELIMITER $$

DROP TRIGGER IF EXISTS ryan_nguyen.toys_BEFORE_DELETE$$
USE `ryan_nguyen`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ryan_nguyen`.`toys_BEFORE_DELETE` BEFORE DELETE ON `toys` FOR EACH ROW
BEGIN
INSERT INTO `ryan_nguyen`.`toytracking` (toyId, ToyName, ToyCost, Toyaction, ActionDate)
    VALUES (old.toyid, old.Toyname, old.Toycost, 'DELETE', now());
END$$
DELIMITER ;

delete from toys
where ToyID = 1;


select * from toytracking;

insert into toys (ToyID, ToyName, ToyCost)
values
(4,'cat',20),
(5,'Mouse',30),
(6,'plane',50);

update toys
set toyname = 'golf'
where ToyID = 4;

update toys
set toyname = 'golf'
where ToyID = 5;

update toys
set toyname = 'golf'
where ToyID = 6;

delete from toys
where ToyID = 3;

delete from toys
where ToyID = 2;

delete from toys
where ToyID = 5;

select * from viewprac;
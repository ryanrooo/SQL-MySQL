
/*NAME: Ryan Nguyen
Lesson: Developing Stored Procedures in MySQL - I
DATE: 11/25/2019
*/

-- 1.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_FemaleEmployees`;

DELIMITER $$
USE `adventureworks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_FemaleEmployees`()
BEGIN

	Select * from employee
    where maritalstatus = 's' and Gender = 'F';
    
END$$

DELIMITER ;

call proc_FemaleEmployees;

-- 2.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_CCNumbersexpmonthyear`;

DELIMITER $$
USE `adventureworks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CCNumbersexpmonthyear`()
BEGIN

	Select cardtype, cardnumber, expmonth, expyear from creditcard;

END$$

DELIMITER ;


call proc_CCNumbersexpmonthyear;

-- 3.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_BikesAndAccessRevenue`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_BikesAndAccessRevenue` ()
BEGIN
	select productcategory.name, salesorderdetail.LineTotal
from salesorderdetail
inner join product
on product.ProductID = salesorderdetail.ProductID
inner join productsubcategory
on product.ProductSubcategoryID = productsubcategory.ProductSubcategoryID
inner join productcategory
on productcategory.ProductCategoryID = productsubcategory.ProductCategoryID
where productcategory.name = 'Bikes' or 'Accessories';

END$$

DELIMITER ;

call proc_BikesAndAccessRevenue;

-- 4.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_MarriedEmployeeCnt_ByGender`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_MarriedEmployeeCnt_ByGender` (in gender_status varchar(50))
BEGIN

	Select count(Gender) from employee
	where maritalstatus = 'M' and gender = gender_status;

END$$

DELIMITER ;



call proc_MarriedEmployeeCnt_ByGender('F');

-- 5.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_CCexpCntByMonthYear`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_CCexpCntByMonthYear` (in expmonth_input int, in expyear_input int)
BEGIN

	Select count(cardnumber), expmonth, expyear from creditcard
    where expmonth = expmonth_input and expyear = expyear_input;

END$$

DELIMITER ;

call proc_CCexpCntByMonthYear(11,2006);

-- 6.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_SalesByTerritory_InputTerritoryGroup`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_SalesByTerritory_InputTerritoryGroup` (group_input varchar(50))
BEGIN

	select sum(salesorderheader.TotalDue) as total, salesterritory.Group  
	from salesorderheader
	inner join salesterritory
	on salesorderheader.TerritoryID = salesterritory.TerritoryID
    where salesterritory.group = group_input;
    

END$$

DELIMITER ;

call proc_SalesByTerritory_InputTerritoryGroup('North America');

-- 7.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_EmpCntByDeptGroup`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_EmpCntByDeptGroup` (in group_input varchar(50), in marital_input varchar(50), in gender_input varchar(50))
BEGIN

select department.GroupName, count(employeedepartmenthistory.DepartmentID)
from department
inner join employeedepartmenthistory
on department.DepartmentID = employeedepartmenthistory.DepartmentID
inner join employee
on employee.EmployeeID = employeedepartmenthistory.EmployeeID
where employee.MaritalStatus = marital_input and employee.Gender = gender_input and department.GroupName = group_input
group by department.GroupName;


END$$

DELIMITER ;

call proc_EmpCntByDeptGroup('Research and Development', 'M', 'F');

-- 8.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_TotalSalesByCcTypeTerritoryShipMethod`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_TotalSalesByCcTypeTerritoryShipMethod` (in territory_input  varchar(50), in cardtype_input varchar(50), in shipmethod_input int)
BEGIN

SELECT creditcard.CardType, sum(salesorderheader.TotalDue) as TotalSalesPerCard
FROM SalesOrderHeader  
Inner JOIN CreditCard
ON salesorderheader.CreditCardID = creditcard.CreditCardID
inner join salesterritory
on salesterritory.TerritoryID = salesorderheader.TerritoryID
inner join shipmethod
on shipmethod.ShipMethodID = salesorderheader.ShipMethodID
where salesterritory.Name = territory_input and creditcard.CardType = cardtype_input and shipmethod.ShipMethodID = shipmethod_input
group by creditcard.cardtype;

END$$

DELIMITER ;

call proc_TotalSalesByCcTypeTerritoryShipMethod;

-- 9.

USE `adventureworks`;
DROP procedure IF EXISTS `proc_SalesByShipOrBillState`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_SalesByShipOrBillState` (in state_input varchar(50))
BEGIN
select stateprovince.Name, Sum(salesorderheader.TotalDue)
from salesorderheader
inner join stateprovince
on stateprovince.TerritoryID = salesorderheader.TerritoryID
where salesorderheader.ShipDate is not null and stateprovince.Name = state_input;

END$$

DELIMITER ;


call proc_SalesByShipOrBillState('Alaska');


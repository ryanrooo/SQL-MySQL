/*NAME: Ryan Nguyen
Lesson: Developing Stored Procedures in MySQL - II
DATE: 11/26/2019
*/

-- 1. Create a Stored Procedure that Total Sales by Input parameter ProductSubCategory

select * from salesorderheader;
select * from salesorderdetail;
select * from productsubcategory;

USE `adventureworks`;
DROP procedure IF EXISTS `proc_TotalSalesByProductSubCategory`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_TotalSalesByProductSubCategory` (in subcategory_input varchar(50), out linetotal_output int)
BEGIN

select sum(salesorderdetail.LineTotal) into linetotal_output
from salesorderdetail
inner join product
on product.ProductID = salesorderdetail.ProductID
inner join productsubcategory
on product.ProductSubcategoryID = productsubcategory.ProductSubcategoryID
where productsubcategory.Name = subcategory_input;

END$$

DELIMITER ;

set @subcategory_input = 'Mountain Bikes';
call proc_TotalSalesByProductSubCategory(@subcategory_input, @linetotal_output);
select @linetotal_output;

-- 2. 

select * from product;
select * from shipmethod;
select * from salesorderdetail;
select * from salesorderheader;
select * from productcategory;
select * from productsubcategory;

USE `adventureworks`;
DROP procedure IF EXISTS `proc_TotalSalesBikesShippedGroundByProductColor`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_TotalSalesBikesShippedGroundByProductColor` (in color_input varchar(50), out total_output int)
BEGIN

select SUM(salesorderdetail.LineTotal) as TotalSalesAmount into total_output
from salesorderdetail 
inner join product 
on salesorderdetail.ProductID = product.ProductID
inner join productsubcategory
on productsubcategory.ProductSubcategoryID = Product.ProductSubcategoryID
inner join productcategory
on productcategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
inner join salesorderheader
on salesorderheader.SalesOrderID = salesorderdetail.SalesOrderID
inner join shipmethod
on shipmethod.ShipMethodID = salesorderheader.ShipMethodID
where productcategory.Name = 'Bikes' and shipmethod.ShipMethodID = 1 and product.Color = color_input
group by productcategory.Name;

END$$

DELIMITER ;

set @color_input = 'Black';
call proc_TotalSalesBikesShippedGroundByProductColor(@color_input, @total_output);
select @total_output;


-- 3.

select * from salesorderheader;
-- SalesID TerrID, shiptoaddid
select * from salesorderdetail;
 
select * from product;
-- provid
 
select * from stateprovince;
-- stateprovID TerrID
select * from salesterritory;
-- TerrID
select * from address;
-- stateid

USE `adventureworks`;
DROP procedure IF EXISTS `proc_OrdersShippedAndBilledToDifferentStates`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_OrdersShippedAndBilledToDifferentStates` ()
BEGIN

select 			salesorderheader.SalesOrderID
from 			salesorderheader
inner join 		salesorderdetail
on 				salesorderheader.SalesOrderID = salesorderdetail.SalesOrderID
inner join 		salesterritory
on 				salesterritory.TerritoryID = salesorderheader.TerritoryID
inner join 		stateprovince
on 				stateprovince.TerritoryID = salesterritory.TerritoryID
inner join 		address
on 				address.AddressID = salesorderheader.ShipToAddressID
where 			StateProvince.StateProvinceID != address.StateProvinceID
group by SalesOrderID;



END$$

DELIMITER ;

call proc_OrdersShippedAndBilledToDifferentStates;


-- 4.		

USE `adventureworks`;
DROP procedure IF EXISTS `proc_MarriedEmployeeCntOutput_ByGender`;

DELIMITER $$
USE `adventureworks`$$
CREATE PROCEDURE `proc_MarriedEmployeeCntOutput_ByGender` (in gender_input varchar(50), out marital_output int)
BEGIN

select count(MaritalStatus) into marital_output
from employee
where Gender = gender_input;

END$$

DELIMITER ;
 
 
set @gender_input = 'M';
call proc_MarriedEmployeeCntOutput_ByGender(@gender_input, @marital_output);
select @marital_output;

-- 5.

select * from creditcard;

USE `adventureworks`;
DROP procedure IF EXISTS `proc_CCexpCntOutputByMonthYear`;

DELIMITER $$
USE `adventureworks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CCexpCntOutputByMonthYear`(in month_input int, in year_input int, out count_out int)
BEGIN

select count(creditcard.CreditCardID) into count_out
FROM creditcard
WHERE ExpMonth = month_input and expyear = year_input; 



END$$

DELIMITER ;

set @month_input = 1;
set @year_input = 2006;
call proc_CCexpCntOutputByMonthYear(@month_input,@year_input,@count_out);
select @count_out;

select * from salesorderheader;

select * from creditcard;

/*NAME: Ryan Nguyen
Lesson: Combining data with Joins in MySQL - II
DATE: 11/23/2019
*/

-- 1.

select * from salesorderheader;


select sum(salesorderheader.TotalDue) as TotalSalesPerCard, creditcard.CardType
from salesorderheader
inner join creditcard
on creditcard.CreditCardID = salesorderheader.CreditCardID
group by creditcard.CardType;

-- 2.

select * from product;
select * from salesorderdetail;

select product.Name as ProductName, sum(salesorderdetail.LineTotal)
from product
inner join salesorderdetail
on product.ProductID = salesorderdetail.ProductID
group by product.name 
having sum(salesorderdetail.LineTotal);

-- 3.

select * from salesorderheader;

select * from salesorderdetail;

select salesorderheader.ShipDate, sum(totaldue)
from salesorderheader
group by salesorderheader.ShipDate;
 
-- 4.

select * from salesterritory;

select `group` , sum(SalesYTD) from salesterritory
group by `group`;

-- 5 

select * from shipmethod;

select * from salesorderheader;

select  shipmethod.ShipMethodID, shipmethod.Name, SUM(salesorderheader.totaldue)  
from salesorderheader
inner join  shipmethod
on shipmethod.ShipMethodID = salesorderheader.ShipMethodID
group by shipmethod.Name;

-- 6

select * from productcategory;
select * from productsubcategory;
select * from product;
select * from salesorderdetail;


select sum(salesorderdetail.LineTotal)
from salesorderdetail
inner join product
on product.ProductID = salesorderdetail.ProductID
inner join productsubcategory
on product.ProductSubcategoryID = productsubcategory.ProductSubcategoryID
inner join productcategory
on productcategory.ProductCategoryID = productcategory.ProductCategoryID;

-- 7

select * from employeedepartmenthistory;

select * from department;

select * from employee;

select department.Name, count(employeedepartmenthistory.EmployeeID) as EmployeeCount
from department
inner join employeedepartmenthistory
on department.DepartmentID = employeedepartmenthistory.DepartmentID
where department.Name = 'Research and Development'; 

-- 8

select * from employeedepartmenthistory;

select * from department;

select * from employee;

select department.Name, count(employeedepartmenthistory.EmployeeID) as EmployeeCount, department.GroupName, count(employeedepartmenthistory.DepartmentID)
from department
left join employeedepartmenthistory
on department.DepartmentID = employeedepartmenthistory.DepartmentID
group by department.Name, employeedepartmenthistory.DepartmentID;

-- 9.

select * from product;

select * from salesorderdetail;

select count(s.SalesOrderDetailID) TotalSalesDetails, sum(s.LineTotal) as TotalSalesAmount, p.color 
from salesorderdetail s
inner join product p
on s.ProductID = p.ProductID
group by p.Color
having TotalSalesAmount 
order by totalsalesamount desc;

-- 10.

select * from employee;

select employee.EmployeeID, employee.LoginID, employee.ManagerID from employee
where EmployeeID = 8;

-- 11.

select * from department;
select * from employeedepartmenthistory;
select * from employee;

select department.DepartmentID, department.Name, employee.MaritalStatus, Count(employee.MaritalStatus)
from department
inner join employeedepartmenthistory
on department.DepartmentID = employeedepartmenthistory.DepartmentID
inner join employee
on employee.EmployeeID = employeedepartmenthistory.EmployeeID
where Department.DepartmentID = 13 and maritalStatus = 'S';

-- 12
select * from employee;
select * from shift;
select * from employeepayhistory;
select * from employeedepartmenthistory;

select shift.ShiftID, shift.Name, count(employeedepartmenthistory.ShiftID)
from shift
inner join employeedepartmenthistory
on shift.ShiftID = employeedepartmenthistory.ShiftID
where employeedepartmenthistory.EndDate is null
group by shift.shiftID;

-- 13.

select * from countryregion;
select * from stateprovince;
select * from salesterritory;
select * from salesorderheader;

select salesterritory.CountryRegionCode, sum(salesorderheader.TotalDue)
from salesterritory
inner join salesorderheader
on salesorderheader.TerritoryID = salesterritory.TerritoryID
group by salesterritory.CountryRegionCode;

-- 14. Find Total Sales from Billed States with an A in the name

select * from salesorderdetail;

select stateprovince.StateProvinceCode, sum(salesorderheader.TotalDue)
from stateprovince
inner join salesorderheader
on stateprovince.TerritoryID = salesorderheader.TerritoryID
where stateprovince.StateProvinceCode like  'A%'
group by stateprovince.StateProvinceCode;

-- 15.Find all ProductCategory’s and their total rejected Qty

select * from product;
select * from productcategory;
select * from productsubcategory;
select * from workorder;

select (workorder.ScrappedQty)
from product
inner join workorder
on workorder.ProductID = product.ProductID
inner join productsubcategory
on product.ProductSubcategoryID = productsubcategory.ProductSubcategoryID
where workorder.ScrappedQty != 0;



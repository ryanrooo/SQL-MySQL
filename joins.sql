select * from creditcard;

select * from salesorderheader;

-- 1.

SELECT creditcard.CardType, COUNT(*) as `October 2002 purchases made using Vista`
FROM SalesOrderHeader  
Inner JOIN CreditCard
ON salesorderheader.CreditCardID = creditcard.CreditCardID
WHERE  creditcard.CardType = 'Vista' AND extract(Month from salesorderheader.OrderDate) = 10
GROUP BY creditcard.CardType;

-- 2. 

SELECT @Variabless := count(creditcard.CardType) as `October 2002 purchases made using Vista`
FROM SalesOrderHeader  
Inner JOIN CreditCard
ON salesorderheader.CreditCardID=creditcard.CreditCardID
WHERE creditcard.CardType = 'Vista' AND extract(Month from salesorderheader.OrderDate) = 10
GROUP BY creditcard.CardType;

select @variabless

-- 3.

set @startdate = '2001-10-1 00:00:00';

set @Enddate = '2001-10-31 23:59:59';

select count(creditcard.CardType) as `October 2002 purchases made using Vista`
FROM SalesOrderHeader  
Inner JOIN CreditCard
ON salesorderheader.CreditCardID=creditcard.CreditCardID
WHERE creditcard.CardType = 'Vista' AND salesorderheader.OrderDate between (@startdate) and (@enddate);

-- 4.

select * from salesorderheader;

select * from salesterritory;

select * from salesterritoryhistory;

select SUM(salesorderheader.TotalDue) as total20022004, salesterritory.Group  
from salesorderheader
inner join salesterritory
on salesorderheader.TerritoryID = salesterritory.TerritoryID
inner join salesterritoryhistory
on salesterritoryhistory.TerritoryID = salesterritory.TerritoryID
where salesterritory.Group = 'North America' and extract(year from salesterritoryhistory.ModifiedDate) between 2002 and 2004;

-- 5. 

select * from salestaxrate;


Select * from stateprovince;


select stateprovince.StateProvinceID, stateprovince.CountryRegionCode, stateprovince.StateProvinceCode, taxrate as TexasTaxRate
from salestaxrate 
inner join stateprovince
on salestaxrate.StateProvinceID=stateprovince.StateProvinceID
where StateProvinceCode = 'TX' and CountryRegionCode = 'US';

-- 6.

select stateprovince.StateProvinceID, stateprovince.CountryRegionCode, stateprovince.StateProvinceCode, @TaxRateVariable := taxrate as TexasTaxRate
from salestaxrate 
inner join stateprovince
on salestaxrate.StateProvinceID=stateprovince.StateProvinceID
where StateProvinceCode = 'TX' and CountryRegionCode = 'US';

select @taxratevariable;

-- 7. 
select * from product;

select * from salesorderdetail;

select count(s.SalesOrderDetailID) TotalSalesDetails, SUM(s.OrderQty * s.UnitPrice) as TotalSalesAmount, p.color 
from salesorderdetail s
inner join product p
on s.ProductID = p.ProductID
group by p.Color
having TotalSalesAmount > 50000 and p.color is not null
order by totalsalesamount asc;



WITH itemCTE (Item_ID, Item_Name, Item_Price,MarketRate,Date)
AS
(
    SELECT Item_ID, Item_Name, Item_Price ,'Present Price' as MarketRate,Date  
    FROM ItemDetails  
	UNION ALL
	 SELECT Item_ID as Item_ID, Item_Name,(Item_Price + (Item_Price *10 )/100) as Item_Price,
	 'Future Price' as MarketRate,  dateadd(YEAR, 1, Date) as Date
    FROM ItemDetails
    
)
-- Define the outer query referencing the CTE name.
Insert into ItemHistory(oldITEMID ,Item_Name,Item_Price,MarketRate,Date)  
SELECT Item_ID, Item_Name, Item_Price,MarketRate,year(Date) from itemCTE Order by Item_Name,Date


/****************** Load data into SQL Pool table using COPY INTO ***********************/

-- 1. FactTransaction
COPY INTO wwi.FactTransaction
(TransactionKey 1, DateKey 2, CustomerKey 3, BillToCustomerKey 4, SupplierKey 5, TransactionTypeKey 6, PaymentMethodKey 7, [WWICustomerTransaction ID] 8, [WWISupplierTransaction ID] 9, WWIInvoiceID 10, WWIPurchaseOrderID 11, SupplierInvoiceNumber 12, TotalExcludingTax 13, TaxAmount 14, TotalIncludingTax 15, OutstandingBalance 16, IsFinalized 17, LineageKey 18)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-facttransaction.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO


-- 2. FactStockHolding

COPY INTO wwi.FactStockHolding
(StockHoldingKey 1, StockItemKey 2, QuantityOnHand 3, BinLocation 4, LastStocktakeQuantity 5, LastCostPrice 6, ReorderLevel 7, TargetStockLevel 8, LineageKey 9)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-factstockholding.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO


-- 3. FactSale
COPY INTO wwi.FactSale
(SaleKey 1, CityKey 2, CustomerKey 3, BillToCustomerKey 4, StockItemKey 5, InvoiceDateKey 6, DeliveryDateKey 7, SalespersonKey 8, WWIInvoiceID 9, Description 10, Package 11, Quantity 12, UnitPrice 13, TaxRate 14, TotalExcludingTax 15, TaxAmount 16, Profit 17, TotalIncludingTax 18, TotalDryItems 19, TotalChillerItems 20, LineageKey 21)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-factsale.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)
GO


-- 4. FactPurchase
COPY INTO wwi.FactPurchase
(PurchaseKey 1, DateKey 2, SupplierKey 3, StockItemKey 4, WWIPurchaseOrderID 5, OrderedOuters 6, OrderedQuantity 7, ReceivedOuters 8, Package 9, IsOrderFinalized 10, LineageKey 11)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-factpurchase.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO


--5. FactOrder
COPY INTO wwi.FactOrder
(OrderKey 1, CityKey 2, CustomerKey 3, StockItemKey 4, OrderDateKey 5, PickedDateKey 6, SalespersonKey 7, PickerKey 8, WWIOrderID 9, WWIBackorderID 10, Description 11, Package 12, Quantity 13, UnitPrice 14, TaxRate 15, TotalExcludingTax 16, TaxAmount 17, TotalIncludingTax 18, LineageKey 19)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-factorder.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 3
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)
GO

-- 6. [FactMovement]
COPY INTO wwi.FactMovement
(MovementKey 1, DateKey 2, StockItemKey 3, CustomerKey 4, SupplierKey 5, TransactionTypeKey 6, WWIStockItemTransactionID 7, WWIInvoiceID 8, WWIPurchaseOrderID 9, Quantity 10, LineageKey 11)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-factmovement.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)
GO

--7. DimTransactionType
COPY INTO wwi.DimTransactionType
(TransactionTypeKey 1, WWITransactionTypeID 2, TransactionType 3, ValidFrom 4, ValidTo 5, LineageKey 6)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimtransactiontype.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--8. DimSupplier
COPY INTO wwi.DimSupplier
(SupplierKey 1, WWISupplierID 2, Supplier 3, Category 4, PrimaryContact 5, SupplierReference 6, PaymentDays 7, PostalCode 8, ValidFrom 9, ValidTo 10, LineageKey 11)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimsupplier.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--9. DimStockItem
COPY INTO wwi.DimStockItem
--(StockItemKey 1, WWIStockItemID 2, Stock Item 3, Color 4, SellingPackage 5, Buying Package 6, Brand 7, Size 8, LeadTimeDays 9, QuantityPerOuter 10, IsChillerStock 11, Barcode 12, TaxRate 13, UnitPrice 14, RecommendedRetailPrice 15, TypicalWeightPerUnit 16, ValidFrom 17, ValidTo 18, LineageKey 19)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimstockitem.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--10. DimPaymentMethod
COPY INTO wwi.DimPaymentMethod
(PaymentMethodKey 1, WWIPaymentMethodID 2, PaymentMethod 3, ValidFrom 4, ValidTo 5, LineageKey 6)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimpaymentmethod.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--11. DimEmployee
COPY INTO wwi.DimEmployee
(EmployeeKey 1, WWIEmployeeID 2, Employee 3, PreferredName 4, IsSalesperson 5, ValidFrom 6, ValidTo 7, LineageKey 8)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimemployee.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--12. DimDate
COPY INTO wwi.DimDate
(Date 1, DayNumber 2, Day 3, Month 4, ShortMonth 5, CalendarMonthNumber 6, CalendarMonthLabel 7, CalendarYear 8, CalendarYearLabel 9, FiscalMonthNumber 10, FiscalMonthLabel 11, FiscalYear 12, FiscalYearLabel 13, ISOWeekNumber 14)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimdate.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--13. DimCity
COPY INTO wwi.DimCity
(CityKey 1, WWICityID 2, City 3, StateProvince 4, Country 5, Continent 6, SalesTerritory 7, Region 8, Subregion 9, LatestRecordedPopulation 10, ValidFrom 11, ValidTo 12, LineageKey 13)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimcity.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--14. DimCustomer
COPY INTO wwi.DimCustomer
(CustomerKey 1, WWICustomerID 2, Customer 3, BillToCustomer 4, Category 5, BuyingGroup 6, PrimaryContact 7, PostalCode 8, ValidFrom 9, ValidTo 10, LineageKey 11)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/wwi-dimcustomer.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = '|'
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO


--15. [PostalCodes]
COPY INTO [wwi].[PostalCodes]
([City] 1, [State] 2,	[Zip] 3,	[Latitude] 4,	[Longitude] 5,	[Timezone] 6)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/postalcodes.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = ','
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)

GO

--16.EmployeePIIData
COPY INTO wwi.EmployeePIIData
(Id 1, FirstName 2, LastName 3, Company 4, Address 5, City 6, County 7, State 8, Phone 9, email 10, SSN 11)
FROM 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/WWI/EmployeePIIData20K.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIELDQUOTE = '"'
	,FIELDTERMINATOR = ','
	,FIRSTROW = 2
	,ERRORFILE = 'https://<ADLSGen2 storage account>.dfs.core.windows.net/rawdata/'
	,IDENTITY_INSERT = 'OFF'
)
--END
GO

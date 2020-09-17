
/************************************ Create Tables*********************************/


create schema wwi
Go

 -- 1. Create [FactTransaction] table

CREATE TABLE [wwi].[FactTransaction]
( 
	[TransactionKey] [bigint]  NOT NULL,
	[DateKey] [date]  NOT NULL,
	[CustomerKey] [int]  NULL,
	[BillToCustomerKey] [int]  NULL,
	[SupplierKey] [int]  NULL,
	[TransactionTypeKey] [int]  NOT NULL,
	[PaymentMethodKey] [int]  NULL,
	[WWICustomerTransaction ID] [int]  NULL,
	[WWISupplierTransaction ID] [int]  NULL,
	[WWIInvoiceID] [int]  NULL,
	[WWIPurchaseOrderID] [int]  NULL,
	[SupplierInvoiceNumber] [nvarchar](20)  NULL,
	[TotalExcludingTax] [decimal](18,2)  NOT NULL,
	[TaxAmount] [decimal](18,2)  NOT NULL,
	[TotalIncludingTax] [decimal](18,2)  NOT NULL,
	[OutstandingBalance] [decimal](18,2)  NOT NULL,
	[IsFinalized] [nvarchar](5)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [CustomerKey] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

-- 2. [FactStockHolding]
CREATE TABLE [wwi].[FactStockHolding]
( 
	[StockHoldingKey] [bigint]  NOT NULL,
	[StockItemKey] [int]  NOT NULL,
	[QuantityOnHand] [int]  NOT NULL,
	[BinLocation] [nvarchar](20)  NOT NULL,
	[LastStocktakeQuantity] [int]  NOT NULL,
	[LastCostPrice] [decimal](18,2)  NOT NULL,
	[ReorderLevel] [int]  NOT NULL,
	[TargetStockLevel] [int]  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [StockItemKey] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

-- 3.  [FactSale]
CREATE TABLE [wwi].[FactSale]
( 
	[SaleKey] [bigint]  NOT NULL,
	[CityKey] [int]  NOT NULL,
	[CustomerKey] [int]  NOT NULL,
	[BillToCustomerKey] [int]  NOT NULL,
	[StockItemKey] [int]  NOT NULL,
	[InvoiceDateKey] [date]  NOT NULL,
	[DeliveryDateKey] [date]  NULL,
	[SalespersonKey] [int]  NOT NULL,
	[WWIInvoiceID] [int]  NOT NULL,
	[Description] [nvarchar](100)  NOT NULL,
	[Package] [nvarchar](50)  NOT NULL,
	[Quantity] [int]  NOT NULL,
	[UnitPrice] [decimal](18,2)  NOT NULL,
	[TaxRate] [decimal](18,3)  NOT NULL,
	[TotalExcludingTax] [decimal](18,2)  NOT NULL,
	[TaxAmount] [decimal](18,2)  NOT NULL,
	[Profit] [decimal](18,2)  NOT NULL,
	[TotalIncludingTax] [decimal](18,2)  NOT NULL,
	[TotalDryItems] [int]  NOT NULL,
	[TotalChillerItems] [int]  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [CustomerKey] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

-- 4. [FactPurchase]

CREATE TABLE [wwi].[FactPurchase]
( 
	[PurchaseKey] [bigint]  NOT NULL,
	[DateKey] [date]  NOT NULL,
	[SupplierKey] [int]  NOT NULL,
	[StockItemKey] [int]  NOT NULL,
	[WWIPurchaseOrderID] [int]  NULL,
	[OrderedOuters] [int]  NOT NULL,
	[OrderedQuantity] [int]  NOT NULL,
	[ReceivedOuters] [int]  NOT NULL,
	[Package] [nvarchar](50)  NOT NULL,
	[IsOrderFinalized] [nvarchar](5)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [SupplierKey] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

-- 5. [FactOrder]
CREATE TABLE [wwi].[FactOrder]
( 
	[OrderKey] [bigint]  NOT NULL,
	[CityKey] [int]  NOT NULL,
	[CustomerKey] [int]  NOT NULL,
	[StockItemKey] [int]  NOT NULL,
	[OrderDateKey] [date]  NOT NULL,
	[PickedDateKey] [date]  NULL,
	[SalespersonKey] [int]  NOT NULL,
	[PickerKey] [int]  NULL,
	[WWIOrderID] [int]  NOT NULL,
	[WWIBackorderID] [int]  NULL,
	[Description] [nvarchar](100)  NOT NULL,
	[Package] [nvarchar](50)  NOT NULL,
	[Quantity] [int]  NOT NULL,
	[UnitPrice] [decimal](18,2)  NOT NULL,
	[TaxRate] [decimal](18,3)  NOT NULL,
	[TotalExcludingTax] [decimal](18,2)  NOT NULL,
	[TaxAmount] [decimal](18,2)  NOT NULL,
	[TotalIncludingTax] [decimal](18,2)  NOT NULL,
	[LineageKey] [int]  NULL
)
WITH
(
	DISTRIBUTION = HASH ( [CustomerKey] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

--6. [FactMovement]
CREATE TABLE [wwi].[FactMovement]
( 
	[MovementKey] [bigint]  NOT NULL,
	[DateKey] [date]  NOT NULL,
	[StockItemKey] [int]  NOT NULL,
	[CustomerKey] [int]  NULL,
	[SupplierKey] [int]  NULL,
	[TransactionTypeKey] [int]  NOT NULL,
	[WWIStockItemTransactionID] [int]  NOT NULL,
	[WWIInvoiceID] [int]  NULL,
	[WWIPurchaseOrderID] [int]  NULL,
	[Quantity] [int]  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [CustomerKey] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

--7. [DimTransactionType]
CREATE TABLE [wwi].[DimTransactionType]
( 
	[TransactionTypeKey] [int]  NOT NULL,
	[WWITransactionTypeID] [int]  NOT NULL,
	[TransactionType] [nvarchar](50)  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--8. DimSupplier
CREATE TABLE [wwi].[DimSupplier]
( 
	[SupplierKey] [int]  NOT NULL,
	[WWISupplierID] [int]  NOT NULL,
	[Supplier] [nvarchar](100)  NOT NULL,
	[Category] [nvarchar](50)  NOT NULL,
	[PrimaryContact] [nvarchar](50)  NOT NULL,
	[SupplierReference] [nvarchar](20)  NULL,
	[PaymentDays] [int]  NOT NULL,
	[PostalCode] [nvarchar](10)  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--9. [DimStockItem]

CREATE TABLE [wwi].[DimStockItem]
( 
	[StockItemKey] [int]  NOT NULL,
	[WWIStockItemID] [int]  NOT NULL,
	[Stock Item] [nvarchar](100)  NOT NULL,
	[Color] [nvarchar](20)  NOT NULL,
	[SellingPackage] [nvarchar](50)  NOT NULL,
	[Buying Package] [nvarchar](50)  NOT NULL,
	[Brand] [nvarchar](50)  NOT NULL,
	[Size] [nvarchar](20)  NOT NULL,
	[LeadTimeDays] [int]  NOT NULL,
	[QuantityPerOuter] [int]  NOT NULL,
	[IsChillerStock] [nvarchar](5)  NOT NULL,
	[Barcode] [nvarchar](50)  NULL,
	[TaxRate] [decimal](18,3)  NOT NULL,
	[UnitPrice] [decimal](18,2)  NOT NULL,
	[RecommendedRetailPrice] [decimal](18,2)  NULL,
	[TypicalWeightPerUnit] [decimal](18,3)  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--10. DimPaymentMethod
CREATE TABLE [wwi].[DimPaymentMethod]
( 
	[PaymentMethodKey] [int]  NOT NULL,
	[WWIPaymentMethodID] [int]  NOT NULL,
	[PaymentMethod] [nvarchar](50)  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--11. [DimEmployee]
CREATE TABLE [wwi].[DimEmployee]
( 
	[EmployeeKey] [int]  NOT NULL,
	[WWIEmployeeID] [int]  NOT NULL,
	[Employee] [nvarchar](50)  NOT NULL,
	[PreferredName] [nvarchar](50)  NOT NULL,
	[IsSalesperson] [nvarchar](5)  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--12. DimDate
CREATE TABLE [wwi].[DimDate]
( 
	[Date] [date]  NOT NULL,
	[DayNumber] [int]  NOT NULL,
	[Day] [nvarchar](10)  NOT NULL,
	[Month] [nvarchar](10)  NOT NULL,
	[ShortMonth] [nvarchar](3)  NOT NULL,
	[CalendarMonthNumber] [int]  NOT NULL,
	[CalendarMonthLabel] [nvarchar](20)  NOT NULL,
	[CalendarYear] [int]  NOT NULL,
	[CalendarYearLabel] [nvarchar](10)  NOT NULL,
	[FiscalMonthNumber] [int]  NOT NULL,
	[FiscalMonthLabel] [nvarchar](20)  NOT NULL,
	[FiscalYear] [int]  NOT NULL,
	[FiscalYearLabel] [nvarchar](10)  NOT NULL,
	[ISOWeekNumber] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--13. [DimCity]
CREATE TABLE [wwi].[DimCity]
( 
	[CityKey] [int]  NOT NULL,
	[WWICityID] [int]  NOT NULL,
	[City] [nvarchar](50)  NOT NULL,
	[StateProvince] [nvarchar](50)  NOT NULL,
	[Country] [nvarchar](60)  NOT NULL,
	[Continent] [nvarchar](30)  NOT NULL,
	[SalesTerritory] [nvarchar](50)  NOT NULL,
	[Region] [nvarchar](30)  NOT NULL,
	[Subregion] [nvarchar](30)  NOT NULL,
	[LatestRecordedPopulation] [bigint]  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--14. [DimCustomer]
CREATE TABLE [wwi].[DimCustomer]
( 
	[CustomerKey] [int]  NOT NULL,
	[WWICustomerID] [int]  NOT NULL,
	[Customer] [nvarchar](100)  NOT NULL,
	[BillToCustomer] [nvarchar](100)  NOT NULL,
	[Category] [nvarchar](50)  NOT NULL,
	[BuyingGroup] [nvarchar](50)  NOT NULL,
	[PrimaryContact] [nvarchar](50)  NOT NULL,
	[PostalCode] [nvarchar](10)  NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL,
	[LineageKey] [int]  NOT NULL
)
WITH
(
	DISTRIBUTION = REPLICATE,
	CLUSTERED COLUMNSTORE INDEX
)
GO

--15. [PostalCodes]
CREATE TABLE [wwi].[PostalCodes]
( 
	[City] [nvarchar](30)  NULL,
	[State] [nvarchar](30)  NULL,
	[Zip] [nvarchar](10)  NULL,
	[Latitude] [nvarchar](30)  NULL,
	[Longitude] [nvarchar](30)  NULL,
	[Timezone] [nvarchar](5)  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

 --16. Employee PII Data
 CREATE TABLE [wwi].[EmployeePIIData]
( 
	[Id] [int]  NULL,
	[FirstName] [nvarchar](30)  NULL,
	[LastName] [nvarchar](30)  NULL,
	[Company] [nvarchar](30)  NULL,
	[Address] [nvarchar](30)  NULL,
	[City] [nvarchar](30)  NULL,
	[County] [nvarchar](30)  NULL,
	[State] [nvarchar](10)  NULL,
	[Phone] [varchar](100)  NULL,
	[email] [varchar](100)  NULL,
	[SSN] [nvarchar](30)  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
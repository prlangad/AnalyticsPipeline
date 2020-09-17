--Returns records for CA state
EXECUTE AS USER ='someone@domain.com'
SELECT 
    Count(*) as EmployeeCount
FROM 
    wwi.EmployeePIIData;

SELECT 
    [FirstName]
    ,[LastName]
    ,[State]
    ,[Phone]
    ,[Email]
FROM 
    wwi.EmployeePIIData ;
revert



--Returns records for PA and NY state
EXECUTE AS USER ='youralias@domain.com'
SELECT 
    Count(*) as EmployeeCount
FROM 
    wwi.EmployeePIIData;

SELECT 
    [FirstName]
    ,[LastName]
    ,[State]
    ,[Phone]
    ,[Email]    
FROM 
    wwi.EmployeePIIData;
revert
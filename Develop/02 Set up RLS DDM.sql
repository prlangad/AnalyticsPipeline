
/*****************************************************************************************************************/
-- 1. Setting up Dynamic Data Masking on EmailId column of wwi.EmployeePIIData

        ALTER TABLE wwi.EmployeePIIData  
        ALTER COLUMN EmailId varchar(100) MASKED WITH (FUNCTION = 'email()'); 

        ALTER TABLE wwi.EmployeePIIData  
        ALTER COLUMN Phone varchar(100) MASKED WITH (FUNCTION = 'partial(0,"XXX-XXX-XX",2)'); 

/*****************************************************************************************************************/

-- 2. Setting up Row Level Security on State

        --Create User and Grant Select Permissions
        CREATE USER [youralias@domain.com] FROM EXTERNAL PROVIDER
        GRANT SELECT ON wwi.EmployeePIIData TO [youralias@domain.com] 
        EXEC sp_addrolemember 'db_datareader', 'youralias@domain.com'

        CREATE USER [youralias@domain.com] FROM EXTERNAL PROVIDER
        GRANT SELECT ON wwi.EmployeePIIData TO [youralias@domain.com] 
        EXEC sp_addrolemember 'db_datareader', 'youralias@domain.com'


        --Grant Impersonate permissions for AAD login 
        GRANT IMPERSONATE ON USER::[youralias@domain.com] TO [youralias@domain.com];
        GRANT IMPERSONATE ON USER::[youralias@domain.com] TO [youralias@domain.com];

        --Create roles as values present in column 
        --CREATE ROLE [DE]; --This role already exists for SQL login
        CREATE ROLE [CA];
        CREATE ROLE [PA];
        CREATE ROLE [NY];
       
        -- Add AAD users to roles      
        EXEC sp_addrolemember 'NY', 'youralias@domain.com';
        EXEC sp_addrolemember 'PA', 'youralias@domain.com';
        EXEC sp_addrolemember 'CA', 'youralias@domain.com';


        CREATE FUNCTION wwi.fn_securitypredicate_rolemember(@State AS sysname)  
        RETURNS TABLE  
        WITH SCHEMABINDING  
        AS  
        RETURN SELECT 1 AS fn_securitypredicate_result   
        WHERE 
            (@State = 'NY' and IS_ROLEMEMBER('NY') = 1) 
        or (@State = 'CA' and IS_ROLEMEMBER('CA') = 1) 
        or (@State = 'PA' and IS_ROLEMEMBER('PA') = 1)
        or IS_ROLEMEMBER('dbo') = 1; 

        --Create Security Policy to filter rows based on column values 
        CREATE SECURITY POLICY StateFilter_rolemember 
        ADD FILTER PREDICATE wwi.fn_securitypredicate_rolemember([state])   
        ON  wwi.EmployeePIIData 
        WITH (STATE = ON); 


        --Test Runs
        select USER_NAME()
        select top 100 * from wwi.EmployeePIIData 
        EXECUTE AS USER ='youralias@domain.com'
        select user_name() as UserName, is_rolemember('NY') As IsALCustomer, is_rolemember('CA') As IsCACustomer
        select top 100 * from wwi.EmployeePIIData ;
        revert
        EXECUTE AS USER ='youralias@domain.com'
        select user_name() as UserName, is_rolemember('NY') As IsALCustomer, is_rolemember('CA') As IsCACustomer
        select top 100 [State], * from wwi.EmployeePIIData ;
        revert
        select user_name() as UserName, is_rolemember('NY') As IsALCustomer, is_rolemember('CA') As IsCACustomer
        select top 100 * from wwi.EmployeePIIData ;



--      DROP SECURITY POLICY StateFilter_rolemember; 
--      DROP FUNCTION Security.fn_securitypredicate_rolemember
--      DROP SCHEMA Security;
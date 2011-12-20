--Set the database to which these functions will be installed
use master
GO

--Enable CLR Integration
exec sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

--Drop the functions if they already exist
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RegExIsMatch]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_RegExIsMatch]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RegExReplace]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_RegExReplace]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RegExMatches]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_RegExMatches]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RegExSplit]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_RegExSplit]
GO

--Drop the assembly if it already exists
IF EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'SqlRegEx')
DROP ASSEMBLY [SqlRegEx]
GO

--Create the assembly
CREATE ASSEMBLY [SqlRegEx] FROM 'C:\SqlRegEx.dll' WITH PERMISSION_SET = SAFE
GO

--Create the functions
CREATE FUNCTION [dbo].[ufn_RegExIsMatch] (@Input NVARCHAR(MAX), @Pattern NVARCHAR(MAX), @IgnoreCase BIT)								RETURNS BIT																AS EXTERNAL NAME SqlRegEx.[SqlClrTools.SqlRegEx].RegExIsMatch
GO
CREATE FUNCTION [dbo].[ufn_RegExReplace] (@Input NVARCHAR(MAX), @Pattern NVARCHAR(MAX), @Replacement NVARCHAR(MAX), @IgnoreCase BIT)	RETURNS NVARCHAR(MAX)													AS EXTERNAL NAME SqlRegEx.[SqlClrTools.SqlRegEx].RegExReplace
GO
CREATE FUNCTION [dbo].[ufn_RegExMatches] (@Input NVARCHAR(MAX), @Pattern NVARCHAR(MAX), @IgnoreCase BIT)								RETURNS TABLE (Match NVARCHAR(MAX), MatchIndex INT, MatchLength INT)	AS EXTERNAL NAME SqlRegEx.[SqlClrTools.SqlRegEx].RegExMatches
GO
CREATE FUNCTION [dbo].[ufn_RegExSplit]   (@Input NVARCHAR(MAX), @Pattern NVARCHAR(MAX), @IgnoreCase BIT)								RETURNS TABLE (Match NVARCHAR(MAX))										AS EXTERNAL NAME SqlRegEx.[SqlClrTools.SqlRegEx].RegExSplit
GO

--Execute sample cases
SELECT dbo.ufn_RegExIsMatch('Hello World', 'w', 1)			--Ignores Case
SELECT dbo.ufn_RegExIsMatch('Hello World', 'w', 0)			--Case Sensitive

SELECT dbo.ufn_RegExReplace('Hello -World', '$', '\1J', 1)		--Ignores Case
SELECT dbo.ufn_RegExReplace('Hello World', 'h', 'J', 0)		--Case Sensitive

SELECT * FROM dbo.ufn_RegExMatches('Hello World', 'L', 1)	--Ignores Case
SELECT * FROM dbo.ufn_RegExMatches('Hello World', 'L', 0)	--Case Sensitive

SELECT * FROM dbo.ufn_RegExSplit('Hello World', 'L', 1)		--Ignores Case
SELECT * FROM dbo.ufn_RegExSplit('Hello World', 'L', 0)		--Case Sensitive
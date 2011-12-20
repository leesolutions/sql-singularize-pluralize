/*
 * The list of regular expressions is adopted from Rails/ActiveSupport/Inflector.Inflections class
 */

use master

go

if object_id('tsql_singularize_pluralize')>0
  drop table dbo.tsql_singularize_pluralize

create table dbo.tsql_singularize_pluralize ( id int identity(1,1), type varchar(15), find varchar(1000), replace varchar(1000) )

insert into dbo.tsql_singularize_pluralize select 'plural', '$', 's';
insert into dbo.tsql_singularize_pluralize select 'plural', 's$', 's';
insert into dbo.tsql_singularize_pluralize select 'plural', '(ax|test)is$', '\1es';
insert into dbo.tsql_singularize_pluralize select 'plural', '(octop|vir)us$', '\1i';
insert into dbo.tsql_singularize_pluralize select 'plural', '(octop|vir)i$', '\1i';
insert into dbo.tsql_singularize_pluralize select 'plural', '(alias|status)$', '\1es';
insert into dbo.tsql_singularize_pluralize select 'plural', '(bu)s$', '\1ses';
insert into dbo.tsql_singularize_pluralize select 'plural', '(buffal|tomat)o$', '\1oes';
insert into dbo.tsql_singularize_pluralize select 'plural', '([ti])um$', '\1a';
insert into dbo.tsql_singularize_pluralize select 'plural', '([ti])a$', '\1a';
insert into dbo.tsql_singularize_pluralize select 'plural', 'sis$', 'ses';
insert into dbo.tsql_singularize_pluralize select 'plural', '(?:([^f])fe|([lr])f)$', '\1\2ves';
insert into dbo.tsql_singularize_pluralize select 'plural', '(hive)$', '\1s';
insert into dbo.tsql_singularize_pluralize select 'plural', '([^aeiouy]|qu)y$', '\1ies';
insert into dbo.tsql_singularize_pluralize select 'plural', '(x|ch|ss|sh)$', '\1es';
insert into dbo.tsql_singularize_pluralize select 'plural', '(matr|vert|ind)(?:ix|ex)$', '\1ices';
insert into dbo.tsql_singularize_pluralize select 'plural', '([m|l])ouse$', '\1ice';
insert into dbo.tsql_singularize_pluralize select 'plural', '([m|l])ice$', '\1ice';
insert into dbo.tsql_singularize_pluralize select 'plural', '^(ox)$', '\1en';
insert into dbo.tsql_singularize_pluralize select 'plural', '^(oxen)$', '\1';
insert into dbo.tsql_singularize_pluralize select 'plural', '(quiz)$', '\1zes';

insert into dbo.tsql_singularize_pluralize select 'singular', 's$', '';
insert into dbo.tsql_singularize_pluralize select 'singular', '(n)ews$', '\1ews';
insert into dbo.tsql_singularize_pluralize select 'singular', '([ti])a$', '\1um';
insert into dbo.tsql_singularize_pluralize select 'singular', '((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$', '\1\2sis';
insert into dbo.tsql_singularize_pluralize select 'singular', '(^analy)ses$', '\1sis';
insert into dbo.tsql_singularize_pluralize select 'singular', '([^f])ves$', '\1fe';
insert into dbo.tsql_singularize_pluralize select 'singular', '(hive)s$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '(tive)s$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '([lr])ves$', '\1f';
insert into dbo.tsql_singularize_pluralize select 'singular', '([^aeiouy]|qu)ies$', '\1y';
insert into dbo.tsql_singularize_pluralize select 'singular', '(s)eries$', '\1eries';
insert into dbo.tsql_singularize_pluralize select 'singular', '(m)ovies$', '\1ovie';
insert into dbo.tsql_singularize_pluralize select 'singular', '(x|ch|ss|sh)es$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '([m|l])ice$', '\1ouse';
insert into dbo.tsql_singularize_pluralize select 'singular', '(bus)es$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '(o)es$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '(shoe)s$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '(cris|ax|test)es$', '\1is';
insert into dbo.tsql_singularize_pluralize select 'singular', '(octop|vir)i$', '\1us';
insert into dbo.tsql_singularize_pluralize select 'singular', '(alias|status)es$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '^(ox)en', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '(vert|ind)ices$', '\1ex';
insert into dbo.tsql_singularize_pluralize select 'singular', '(matr)ices$', '\1ix';
insert into dbo.tsql_singularize_pluralize select 'singular', '(quiz)zes$', '\1';
insert into dbo.tsql_singularize_pluralize select 'singular', '(database)s$', '\1';

insert into dbo.tsql_singularize_pluralize select 'irregular', 'person', 'people';
insert into dbo.tsql_singularize_pluralize select 'irregular', 'man', 'men';
insert into dbo.tsql_singularize_pluralize select 'irregular', 'child', 'children';
insert into dbo.tsql_singularize_pluralize select 'irregular', 'sex', 'sexes';
insert into dbo.tsql_singularize_pluralize select 'irregular', 'move', 'moves';
insert into dbo.tsql_singularize_pluralize select 'irregular', 'cow', 'kine';
insert into dbo.tsql_singularize_pluralize select 'irregular', 'zombie', 'zombies';

insert into dbo.tsql_singularize_pluralize select 'uncountable', 'equipment', null;
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'information', null;
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'rice money', null; 
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'species', null; 
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'series', null; 
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'fish', null; 
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'sheep', null; 
insert into dbo.tsql_singularize_pluralize select 'uncountable', 'jeans', null; 

go
use master
go
if object_id('Pluralize')>0
  drop function dbo.Pluralize
go
create function dbo.Pluralize
(
	@string varchar(1000)
)
returns varchar(1000)
as
begin
	--select find from dbo.tsql_singularize_pluralize where type='uncountable'
	--select replace from dbo.tsql_singularize_pluralize where type='irregular'

	declare @out varchar(1000), @find varchar(1000), @replace varchar(1000), @id int, @new varchar(1000)
	declare @rgs table ( id int, type varchar(15), find varchar(1000), replace varchar(1000) )

	insert into @rgs select * from dbo.tsql_singularize_pluralize where type='plural'

	while exists(select top 1 id from @rgs)
	begin
		select top 1 @find=find, @replace=replace, @id=id from @rgs order by id desc
		select @new = master.dbo.ufn_RegExReplace(@string, @find, @replace, 1)
		if @new<>@string
		begin
			select @out = @new
			delete from @rgs
		end
		delete from @rgs where id=@id
	end

	if @out is null
		select @out = @string

	return @out
end
go
if object_id('Singularize')>0
  drop function dbo.Singularize
go
create function dbo.Singularize
(
	@string varchar(1000)
)
returns varchar(1000)
as
begin
	--select find from dbo.tsql_singularize_pluralize where type='uncountable'
	--select replace from dbo.tsql_singularize_pluralize where type='irregular'

	declare @out varchar(1000), @find varchar(1000), @replace varchar(1000), @id int, @new varchar(1000)
	declare @rgs table ( id int, type varchar(15), find varchar(1000), replace varchar(1000) )

	insert into @rgs select * from dbo.tsql_singularize_pluralize where type='singular'

	while exists(select top 1 id from @rgs)
	begin
		select top 1 @find=find, @replace=replace, @id=id from @rgs order by id desc
		select @new = master.dbo.ufn_RegExReplace(@string, @find, @replace, 1)
		if @new<>@string
		begin
			select @out = @new
			delete from @rgs
		end
		delete from @rgs where id=@id
	end

	if @out is null
		select @out = @string

	return @out
end
go
if object_id('sp_Pluralize')>0
  drop procedure dbo.sp_Pluralize
go
create procedure dbo.sp_Pluralize
	@string varchar(1000)
as
begin
	--select find from dbo.tsql_singularize_pluralize where type='uncountable'
	--select replace from dbo.tsql_singularize_pluralize where type='irregular'

	declare @out varchar(1000), @find varchar(1000), @replace varchar(1000), @id int, @new varchar(1000)
	declare @rgs table ( id int, type varchar(15), find varchar(1000), replace varchar(1000) )

	insert into @rgs select * from dbo.tsql_singularize_pluralize where type='plural'

	while exists(select top 1 id from @rgs)
	begin
		select top 1 @find=find, @replace=replace, @id=id from @rgs order by id desc
		select @new = master.dbo.ufn_RegExReplace(@string, @find, @replace, 1)
		if @new<>@string
		begin
			select @find, @replace, @string, @new
			select @out = @new
			delete from @rgs
		end
		delete from @rgs where id=@id
	end

	if @out is null
		select @out = @string

	select @out
end

go

select convert(varchar(100),getdate(),109)
exec master.dbo.sp_Pluralize @string = 'goby'
select master.dbo.ufn_RegExReplace('goby', '([^aeiouy]|qu)y$', '\1', 0)
select convert(varchar(100),getdate(),109)

select convert(varchar(100),getdate(),109)
select master.dbo.Pluralize('goby')
select convert(varchar(100),getdate(),109)

select convert(varchar(100),getdate(),109)
select master.dbo.Singularize('gobies')
select convert(varchar(100),getdate(),109)

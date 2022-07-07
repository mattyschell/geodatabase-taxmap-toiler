begin
    execute immediate 'drop table habbak';
exception
    when others then
    if SQLCODE=-942 then 
        null;
    else 
        raise;
    end if;
end;
/
begin
    execute immediate 'drop table map_inset_librarybak';
exception
    when others then
    if SQLCODE=-942 then 
        null;
    else 
        raise;
    end if;
end;
/
begin
    execute immediate 'drop table map_librarybak';
exception
    when others then
    if SQLCODE=-942 then 
        null;
    else 
        raise;
    end if;
end;
/
create table 
    habbak 
as 
select * from 
    hab;
create table 
    map_inset_librarybak 
as 
select * from 
    map_inset_library;
create table 
    map_librarybak 
as 
select * from 
    map_library;
EXIT

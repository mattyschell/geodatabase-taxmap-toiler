begin
    execute immediate 'drop table DAB_ACTION_DEFINITION CASCADE CONSTRAINTS';
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
    execute immediate 'drop table DAB_AIR_RIGHTS';
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
    execute immediate 'drop table DAB_AIR_RIGHTS_DEFINITION';
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
    execute immediate 'drop table DAB_BOUNDARY_LINE';
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
    execute immediate 'drop table DAB_CONDO_CONVERSION';
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
    execute immediate 'drop table DAB_CONDO_UNITS';
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
    execute immediate 'drop table DAB_DOMAINS CASCADE CONSTRAINTS';
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
    execute immediate 'drop table DAB_REUC';
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
    execute immediate 'drop table DAB_SUBTERRANEAN_RIGHTS';
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
    execute immediate 'drop table DAB_TAX_LOTS';
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
    execute immediate 'drop table DAB_WIZARD_TRANSACTION';
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
    execute immediate 'drop table DTM_USER_MAINT';
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
    execute immediate 'drop table DTM_WORK_IN_PROGRESS';
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
    execute immediate 'drop table FINAL_ASMT';
exception
    when others then
    if SQLCODE=-942 then 
        null;
    else 
        raise;
    end if;
end;
/
--begin
--    execute immediate 'drop table HAB';
--exception
--    when others then
--    if SQLCODE=-942 then 
--        null;
--    else 
--        raise;
--    end if;
--end;
--/
--begin
--    execute immediate 'drop table MAP_INSET_LIBRARY';
--exception
--    when others then
--    if SQLCODE=-942 then 
--        null;
--    else 
--        raise;
--    end if;
--end;
--/
--begin
--    execute immediate 'drop table MAP_LIBRARY';
--exception
--    when others then
--    if SQLCODE=-942 then 
--        null;
--    else 
--        raise;
--    end if;
--end;
--/
EXIT
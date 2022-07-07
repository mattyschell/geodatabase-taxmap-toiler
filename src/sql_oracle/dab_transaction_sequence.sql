begin
    execute immediate 'create sequence ' 
                   || 'dab_transaction_sequence '
                   || 'start with 200000 '
                   || 'increment by 1 ';
exception
    when others then
    if SQLCODE=-955 then 
        null;
    else 
        raise;
    end if;
end;
/
EXIT
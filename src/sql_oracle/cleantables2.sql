rename habbak to hab;
rename map_inset_librarybak to map_inset_library;
rename map_librarybak to map_library;
alter table hab drop column objectid;
alter table map_inset_library drop column objectid;
alter table map_library drop column objectid;
EXIT

CREATE OR REPLACE FUNCTION get_guid_uuid_format
/**
    <b> Function RETURNs a SYS_GUID IN a UUID format </b> </br></br>  
    @return GUID VARCHAR2 - formated string
    
    @author Butcho
    @version 19.10.2017 
  */
 RETURN VARCHAR2 AS
  l_date VARCHAR2(100);
BEGIN
  SELECT SYS_GUID() into l_date FROM dual;

  RETURN SUBSTR(l_date, 1, 8)  || '-' ||
         SUBSTR(l_date, 9, 4)  || '-' ||
         SUBSTR(l_date, 13, 4) || '-' ||
         SUBSTR(l_date, 17, 4) || '-' ||
         SUBSTR(l_date, 21, 12);
END;
/

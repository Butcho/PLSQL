CREATE OR REPLACE FUNCTION check_sdo_elem_info_parity
/**
  <b> Function checks the correctness of the given sdo_elem_info </b><br>
      The errors in sdo_elem_info raise error ORA-13033 <br>
      The OFFSET atribute should always be odd (cause it indicates the first coordinate of a point (element of an SDO_ORDINATE_ARRAY)<br>
      Function returns TRUE where errors are not found <br>
      or position of element and value of OFFSET atribute, if it is even <br>
  <br>
      
      @param GEOM SDO_GEOMETRY - the geometry object to be tested
      
      @author Butcho
      @version 21.01.2016  
    */
(geom IN sdo_geometry) RETURN VARCHAR2 IS
  res VARCHAR2(100) := 'TRUE';

  CURSOR sdoInfo IS
    SELECT e.id + 1 id, e.etype, e.offset, e.interpretation
      FROM (SELECT TRUNC((ROWNUM - 1) / 3, 0) AS id,
                   SUM(CASE
                         WHEN MOD(ROWNUM, 3) = 1 THEN
                          sei.column_value
                         ELSE
                          NULL
                       END) AS offset,
                   SUM(CASE
                         WHEN MOD(ROWNUM, 3) = 2 THEN
                          sei.column_value
                         ELSE
                          NULL
                       END) AS etype,
                   SUM(CASE
                         WHEN MOD(ROWNUM, 3) = 0 THEN
                          sei.column_value
                         ELSE
                          NULL
                       END) AS interpretation
              FROM TABLE(geom.SDO_ELEM_INFO) sei
             GROUP BY TRUNC((ROWNUM - 1) / 3, 0)) e;

BEGIN
  IF (SUBSTR(geom.SDO_GTYPE, 1, 1) != 2) THEN
    RETURN NULL;
  END IF;

  FOR i IN sdoInfo LOOP
    IF (MOD(i.offset, 2) = 0) THEN
      IF (res = 'TRUE') THEN
        res := 'OFFSET has wrong parity in (element/value): ';
      END IF;
      res := res || i.id || '/' || i.offset || '; ';
    END IF;
  
  END LOOP;

  RETURN(res);
END;
/

CREATE OR REPLACE FUNCTION convert_float2date
/**
      <b> Function converts a number in float decimal to date</b></br>
      The float describes time elapsed from start point in time </br>
      The function was created for the datetime format used in GeoMap</br></br>
      
      @param floatVal FLOAT - input float number
      @param dateStart DATE - the start point in time, default '1899-12-31 00:00:00' 
      @return dateVal DATE - output date
  
      @author Butcho
      @version 01.08.2016  
  */
(floatVal  IN FLOAT,
 dateStart IN DATE DEFAULT TO_DATE('1899-12-31 00:00:00',
                                   'YYYY-MM-DD HH24:Mi:SS')) RETURN DATE IS
BEGIN
  RETURN dateStart + floatVal;
END;
/

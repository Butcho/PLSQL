CREATE OR REPLACE FUNCTION convert_hex2date
/**
      <b> Function converts a number in hexadecimal to date</b></br>
      The input HEX is: YYYYMMMMDDDDHHHHMiMiSSSS </br>
      The function was created for the datetime fromat used in BMT</br></br>
      
      @param hexVal CHAR - input HEX number
      @return dateVal DATE - output date
  
      @author Butcho
      @version 21.07.2016  
  */
(hexVal IN VARCHAR2) RETURN DATE IS
  YYYY VARCHAR2(4);
  MM   VARCHAR2(2);
  DD   VARCHAR2(2);
  HH   VARCHAR2(2);
  Mi   VARCHAR2(2);
  SS   VARCHAR2(2);

BEGIN
  YYYY := TRIM(TO_CHAR(convert_hex2dec(SUBSTR(hexVal, 1, 4)), '0000'));
  MM   := TRIM(TO_CHAR(convert_hex2dec(SUBSTR(hexVal, 5, 4)), '00'));
  DD   := TRIM(TO_CHAR(convert_hex2dec(SUBSTR(hexVal, 9, 4)), '00'));
  HH   := TRIM(TO_CHAR(convert_hex2dec(SUBSTR(hexVal, 13, 4)), '00'));
  Mi   := TRIM(TO_CHAR(convert_hex2dec(SUBSTR(hexVal, 17, 4)), '00'));
  SS   := TRIM(TO_CHAR(convert_hex2dec(SUBSTR(hexVal, 21, 4)), '00'));

  RETURN TO_DATE(YYYY || MM || DD || HH || Mi || SS, 'YYYYMMDDHH24MiSS');
END;
/

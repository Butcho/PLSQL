CREATE OR REPLACE FUNCTION convert_hex2bin
/**
    <b> Function converts a number in hexadecimal to binary</b></br></br>
    
    @param hexVal CHAR - input HEX number
    @return binVal NUMBER - output BIN number
      
    @author Butcho
    @version 01.03.2015  
  */
(hexVal IN VARCHAR2) RETURN VARCHAR2 IS
  result VARCHAR2(100);
  len    NUMBER(10);
BEGIN
  SELECT convert_dec2bin(convert_hex2dec(hexVal)) into result FROM dual;
  SELECT length(result) into len FROM dual;
  IF len < 32 and len != 64 THEN
    SELECT lpad(result, 32, '0') into result FROM dual;
  ELSIF len < 64 and len != 32 THEN
    SELECT lpad(result, 64, '0') into result FROM dual;
  END IF;
  RETURN result;
END;
/

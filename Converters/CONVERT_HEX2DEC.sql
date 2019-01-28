CREATE OR REPLACE FUNCTION convert_hex2dec
/**
    <b> Function converts a number in hexadecimal to decimal</b></br></br>
    
    @param hexVal CHAR - input HEX number
    @return numVal NUMBER - output DEC number
      
    @author Butcho
    @version 01.03.2015  
  */
(hexVal IN CHAR) RETURN NUMBER IS
  i                 NUMBER;
  digits            NUMBER;
  result            NUMBER := 0;
  current_digit     CHAR(1);
  current_digit_dec NUMBER;
BEGIN
  digits := LENGTH(hexVal);
  FOR i IN 1 .. digits LOOP
    current_digit := SUBSTR(hexVal, i, 1);
    IF UPPER(current_digit) IN ('A', 'B', 'C', 'D', 'E', 'F') THEN
      current_digit_dec := ASCII(current_digit) - ASCII('A') + 10;
    ELSE
      current_digit_dec := TO_NUMBER(current_digit);
    END IF;
    result := (result * 16) + current_digit_dec;
  END LOOP;
  IF result IS NULL THEN
    result := 0;
  END IF;
  RETURN result;
END;
/

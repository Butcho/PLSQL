CREATE OR REPLACE FUNCTION convert_bin2dec
/**
    <b> Function converts a number in binary to decimal</b></br></br>
    
    @param binVal CHAR - input BIN number
    @return decVal NUMBER - output DEC number
      
    @author Butcho
    @version 01.03.2015  
  */
(binVal IN CHAR) RETURN NUMBER IS
  i                 NUMBER;
  digits            NUMBER;
  result            NUMBER := 0;
  current_digit     CHAR(1);
  current_digit_dec NUMBER;
BEGIN
  digits := LENGTH(binVal);
  FOR i IN 1 .. digits LOOP
    current_digit     := SUBSTR(binVal, i, 1);
    current_digit_dec := TO_NUMBER(current_digit);
    result            := (result * 2) + current_digit_dec;
  END LOOP;
  RETURN result;
END;
/

CREATE OR REPLACE FUNCTION convert_dec2hex
/**
    <b> Function converts a number in decimal to hexadecimal</b></br></br>
    
    @param decVal VARCHAR2 - input DEC number
    @return hexVal NUMBER - output HEX number
      
    @author Butcho
    @version 01.03.2015  
  */
(decVal IN NUMBER) RETURN VARCHAR2 IS
  hexVal   VARCHAR2(64);
  N2       NUMBER := decVal;
  digit    NUMBER;
  hexDigit CHAR;
BEGIN
  WHILE (N2 > 0) LOOP
    digit := MOD(N2, 16);
    IF digit > 9 THEN
      hexDigit := CHR(ASCII('A') + digit - 10);
    ELSE
      hexDigit := TO_CHAR(digit);
    END IF;
    hexVal := hexDigit || hexVal;
    N2     := TRUNC(N2 / 16);
  END LOOP;
  IF hexVal IS NULL THEN
    hexVal := 0;
  END IF;
  RETURN hexVal;
END;
/

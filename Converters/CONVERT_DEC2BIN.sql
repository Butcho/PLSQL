CREATE OR REPLACE FUNCTION convert_dec2bin
/**
    <b> Function converts a number in decimal to binary</b></br></br>
    
    @param decVal VARCHAR2 - input DEC number
    @return binVal NUMBER - output BIN number
      
    @author Butcho
    @version 01.03.2015  
  */
(decVal IN NUMBER) RETURN VARCHAR2 IS
  binVal VARCHAR2(64);
  N2     NUMBER := decVal;
BEGIN
  IF N2 = 0 THEN
    binVal := 0;
  END IF;
  WHILE (N2 > 0) LOOP
    binVal := MOD(N2, 2) || binVal;
    N2     := TRUNC(N2 / 2);
  END LOOP;
  RETURN binVal;
END;
/

CREATE OR REPLACE FUNCTION convert_hex2float
/**
    <b> Function converts a number in hexadecimal to float decimal</b></br>
    The function works on the 8- and 16-character HEX numbers </br></br>
    The parameter endial allows to change between big endian (0) and little endian (1)</br></br>
    
    @param hexVal CHAR - input HEX number
    @param endian NUMBER - HEX type - big endian (0) and little endian (1), default 0
    @return floatVal NUMBER - output float DEC number
      
    @author Butcho
    @version 01.03.2015  
  */
(hexVal IN VARCHAR2, endian IN NUMBER DEFAULT 0) RETURN NUMBER IS
  floatVal NUMBER(38, 10);
  tmpHEX   VARCHAR2(50);
  bias     NUMBER(30);
  expon    NUMBER(30);
  signi    NUMBER(30);
  lenHEX   NUMBER(30);
  signHEX  NUMBER(30);
BEGIN
  IF MOD(LENGTH(hexVal), 2) = 1 THEN
    raise_application_error(-20001,
                            'Incorrect HEX number (odd number of characters)');
  END IF;
  tmpHEX := UPPER(hexVal);
  IF ENDian = 1 THEN
    NULL;
    SELECT REVERSE(regexp_REPLACE(hexVal, '(.)(.)', '\2\1'))
      INTO tmpHEX
      FROM dual;
  END IF;
  SELECT LENGTH(tmpHEX) INTO lenHEX FROM dual;

  IF lenHEX = 8 THEN
    SELECT DECODE(SUBSTR(convert_hex2bin(tmpHEX), 1, 1), 0, 1, 1, -1)
      INTO signHEX
      FROM dual;
    bias     := 127;
    expon    := convert_bin2dec(SUBSTR(convert_hex2bin(tmpHEX), 2, 8));
    signi    := convert_bin2dec(1 || SUBSTR(convert_hex2bin(tmpHEX), 10, 23));
    floatVal := signHEX * POWER(2, (expon - bias)) * signi * POWER(2, -23);
  
  ELSIF lenHEX = 16 THEN
    SELECT DECODE(SUBSTR(convert_hex2bin(tmpHEX), 1, 1), 0, 1, 1, -1)
      INTO signHEX
      FROM dual;
    bias     := 1023;
    expon    := convert_bin2dec(SUBSTR(convert_hex2bin(tmpHEX), 2, 11));
    signi    := convert_bin2dec(1 || SUBSTR(convert_hex2bin(tmpHEX), 13, 64));
    floatVal := signHEX * POWER(2, (expon - bias)) * signi * POWER(2, -52);
  
  END IF;
  RETURN floatVal;
END;
/

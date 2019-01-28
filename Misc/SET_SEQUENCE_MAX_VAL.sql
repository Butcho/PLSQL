CREATE OR REPLACE PROCEDURE set_sequence_max_val
/**
    <b> Procedure to change the current value of the given sequence</b> </br></br>  
    Procedure calls the sequene Seq, if the MaxVal is lower than the current value of this sequence. </br>
    Otherwise nothing happens, thus in any case the current value is bigger than MaxVal. </br>
    The query statement allows to use it in Oracle 10, as well as higher versions. </br>
    
    @param Seq VARCHAR2, sequence name
    @param MaxVal integer, desired max value of the sequence
    
    @author Butcho
    @version 31.03.2016 
  */
(Seq IN VARCHAR2, MaxVal IN INTEGER) IS
  dIFf  INTEGER;
  curr  NUMBER;
  query VARCHAR2(500);
BEGIN
  query := 'SELECT ' || Seq || '.NEXTVAL FROM DUAL';
  EXECUTE IMMEDIATE query
    INTO curr;
  IF MaxVal IS NOT NULL AND curr < MaxVal THEN
    dIFf := MaxVal - curr;
    FOR i IN 1 .. dIFf LOOP
      EXECUTE IMMEDIATE query
        INTO curr;
    END LOOP;
  END IF;
END;
/

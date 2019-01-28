CREATE OR REPLACE PROCEDURE set_sequence_max_val_column
/**
    <b> Procedure to change the current value of the given sequence to the max value FROM chosen table</b> </br></br>  
    Procedure calls the sequene Seq, if the MaxVal is lower than the current value of this sequence. </br>
    The max value is found as max value of field tabName.colName </br>
    
    @param Seq VARCHAR2, sequence name
    @param TabName VARCHAR2, table name
    @param colName VARCHAR2, column with the desired max value
    
    @author Butcho
    @version 15.09.2017 
  */
(Seq IN VARCHAR2, tabName IN VARCHAR2, colName IN VARCHAR2) IS
  maxVal NUMBER(10);
  query  VARCHAR2(200);
BEGIN
  query := 'SELECT max(' || colName || ') FROM ' || tabName;
  EXECUTE IMMEDIATE query
    INTO maxVal;
  SET_SEQUENCE_MAX_VAL(Seq, maxVal);
END;
/

CREATE OR REPLACE PROCEDURE change_column_data_type
/**
    <b> Procedure to change the datatype of the specific column </b> </br></br>  
    
    @usage <i> call CHANGE_COLUMN_DATA_TYPE('HANSLIK','V_SDESLUPY','OPIS','VARCHAR2(40)') </i><br>
    
    @param schema_name VARCHAR2, schema name
    @param table_name VARCHAR2, table name
    @param column_name VARCHAR2, changed column name
    @param new_data_type VARCHAR2, new data type (with precision)
    
    @author Butcho
    @version 10.10.2017 
*/
(schema_name   IN VARCHAR2,
 table_name    IN VARCHAR2,
 column_name   IN VARCHAR2,
 new_data_type IN VARCHAR2) IS
  tbl    VARCHAR2(5000);
  script VARCHAR2(1000);
BEGIN
  tbl := schema_name || '.' || table_name;

  script := 'alter table ' || tbl || ' rename column ' || column_name || ' to tmp_column_name';
  EXECUTE IMMEDIATE script;

  script := 'alter table ' || tbl || ' add ' || column_name || ' ' || new_data_type;
  EXECUTE IMMEDIATE script;

  script := 'update ' || tbl || ' set ' || column_name || ' = tmp_column_name';
  EXECUTE IMMEDIATE script;

  script := 'alter table ' || tbl || ' drop column tmp_column_name';
  EXECUTE IMMEDIATE script;

END;
/

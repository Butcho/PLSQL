CREATE OR REPLACE FUNCTION get_coordinate_from_sdo
/**
    <b> Function returns coordinate from the SDO_ORDINATE_ARRAY on the given position</b><br><br>
  
    @param geom mdsys.sdo_geometry - geometry object 
    @param pos NUMBER - position in the GEOM.SDO_ORDINATE_ARRAY
    @return coord NUMBER - found coordinate on the position
  
    @author Butcho
    @version 27.05.2016 
  */
(geom IN mdsys.sdo_geometry, pos IN NUMBER) RETURN NUMBER IS
  v_ordinates mdsys.sdo_ordinate_array;
  elem        NUMBER(20, 5);
BEGIN
  IF geom IS NULL THEN
    RETURN NULL;
  END IF;

  v_ordinates := geom.sdo_ordinates;
  IF v_ordinates.count() < pos OR pos < 1 THEN
    RETURN NULL;
  END IF;

  elem := v_ordinates(pos);
  RETURN elem;
END;
/

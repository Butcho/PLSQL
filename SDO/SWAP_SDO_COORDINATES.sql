CREATE OR REPLACE FUNCTION swap_sdo_coordinates
/**
    <b> Function swaps coordinates of the SDO_GEOMETRY </b><br>
  The coordinates order is changed YX->XY<br><br>
  
    @param geom mdsys.sdo_geometry - input geometry
    @return swapGeom mdsys.sdo_geometry - output geometry
  
    @author Butcho
    @version 16.10.2016 
  */
(geom IN mdsys.sdo_geometry) RETURN mdsys.sdo_geometry is
  tmp_array NUMBER_ARRAY;
  ords      SDO_ORDINATE_ARRAY;
BEGIN
  tmp_array := NUMBER_ARRAY();

  for i IN 1 .. SDO_UTIL.GETNUMVERTICES(geom) LOOP
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := get_coordinate_from_sdo(geom, i * 2);
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := get_coordinate_from_sdo(geom, i * 2 - 1);
  
  END LOOP;
  SELECT cast(tmp_array as SDO_ORDINATE_ARRAY) INTO ords FROM DUAL;
  RETURN MDSYS.SDO_GEOMETRY(geom.sdo_gtype,
                            geom.sdo_srid,
                            NULL,
                            geom.sdo_elem_info,
                            ords);
END;
/

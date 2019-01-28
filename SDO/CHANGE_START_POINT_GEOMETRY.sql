CREATE OR REPLACE FUNCTION change_start_point_geometry
/**
    <b> Function changes the first point of the SDO_GEOMETRY </b><br>
    The function works on the whole geometry - it CAN be applied ONLY for single ring geometries <br><br>
  
    @param geom mdsys.sdo_geometry - input geometry
    @param pos number - current position of the new first point
    @return newGeom mdsys.sdo_geometry - output geometry
  
    @author Butcho
    @version 20.07.2018 
  */
(geom IN mdsys.sdo_geometry, pos in number) RETURN mdsys.sdo_geometry is
  tmp_array NUMBER_ARRAY;
  ords      SDO_ORDINATE_ARRAY;
  verticesCnt number(10);
  posTmp number(4);
BEGIN
  verticesCnt := SDO_UTIL.GETNUMVERTICES(geom);
  
  if (pos not between 2 and verticesCnt) then 
    return geom;
  end if;
  
  tmp_array := NUMBER_ARRAY();
  posTmp := pos;
  
  for i IN 0 .. verticesCnt-1 LOOP
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := get_coordinate_from_sdo(geom, posTmp* 2 - 1);
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := get_coordinate_from_sdo(geom, posTmp * 2);
    
	posTmp:=posTmp + 1;
    if (posTmp > verticesCnt) then
      posTmp:=2;
    end if;  
  END LOOP;
  
  SELECT cast(tmp_array as SDO_ORDINATE_ARRAY) INTO ords FROM DUAL;
  RETURN MDSYS.SDO_GEOMETRY(geom.sdo_gtype,
                            geom.sdo_srid,
                            NULL,
                            geom.sdo_elem_info,
                            ords);
END;
/

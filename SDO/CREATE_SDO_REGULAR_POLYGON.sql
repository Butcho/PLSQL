CREATE OR REPLACE FUNCTION create_sdo_regular_polygon
/**
    <b> Function to compute a new regular polygon in SDO_GEOMETRY from a center point, side length, number of sides and azimuth</b><br>
    With high density it can be used to interpolate circles<br><br>
    
    @param X NUMBER - center point X coordinate
    @param Y NUMBER - center point Y coordinate
    @param dl NUMBER - length of the polygon's side
    @param seg NUMBER - number of sides
    @param Az NUMBER - azimuth of the polygon, in degrees, default 0
    @return geom SDO_GEOMETRY- computed polygon geometry
  
    @author Butcho
    @version 26.08.2015  
  */
(X   IN NUMBER,
 Y   IN NUMBER,
 dl  IN NUMBER,
 seg IN NUMBER,
 Az  IN NUMBER default 0) RETURN mdsys.sdo_geometry is
  geom      mdsys.sdo_geometry;
  PI CONSTANT NUMBER(10, 8) := 3.14159265359;
  R         NUMBER(10, 6);
  angle     NUMBER(10, 4);
  side_num   NUMBER(5);
  obl_x     NUMBER(15, 3);
  obl_y     NUMBER(15, 3);
  tmp_array NUMBER_ARRAY;
  ords      SDO_ORDINATE_ARRAY;
BEGIN

  tmp_array := NUMBER_ARRAY();

  side_num := seg;
  angle    := 2 * pi / side_num;
  R        := dl / (2 * SIN(angle));
  for i IN 0 .. side_num LOOP
    obl_x := COS(angle * (i)) * R;
    obl_y := SIN(angle * (i)) * R;
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := X + obl_x * COS(Az * pi / 180) -
                                 obl_y * SIN(Az * pi / 180);
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := Y + obl_x * SIN(Az * pi / 180) +
                                 obl_y * COS(Az * pi / 180);
  END LOOP;
  SELECT cast(tmp_array AS SDO_ORDINATE_ARRAY) INTO ords FROM DUAL;
  geom := SDO_GEOMETRY(2002,
                       ewid4.ewd.get_epsg,
                       NULL,
                       SDO_ELEM_INFO_ARRAY(1, 2, 1),
                       ords);

  RETURN(geom);
END;
/

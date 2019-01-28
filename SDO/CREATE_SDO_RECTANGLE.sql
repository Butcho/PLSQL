CREATE OR REPLACE FUNCTION create_sdo_rectangle
/**
    <b> Function to compute a new rectangle in SDO_GEOMETRY from a center point, segment lengths, and azimuth</b><br><br>
    
    @param X NUMBER - center point X coordinate
    @param Y NUMBER - center point Y coordinate
    @param a NUMBER - length of the 1st segment
    @param b NUMBER - length of the 2nd segment
    @param Az NUMBER - azimuth of the polygon, in degrees, default 0
    @return geom SDO_GEOMETRY- computed polygon geometry
  
    @author Butcho
    @version 12.08.2016  
  */
(X  IN NUMBER,
 Y  IN NUMBER,
 a  IN NUMBER,
 b  IN NUMBER,
 Az IN NUMBER default 0) RETURN mdsys.sdo_geometry IS
  geom mdsys.sdo_geometry;
  PI CONSTANT NUMBER(10, 8) := 3.14159265359;
  R         NUMBER(10, 6);
  angle     NUMBER(10, 6);
  angleSum  NUMBER(10, 6) := 0;
  obl_x     NUMBER(15, 3);
  obl_y     NUMBER(15, 3);
  tmp_array NUMBER_ARRAY;
  ords      SDO_ORDINATE_ARRAY;

  procedure addPoint(ang IN NUMBER) IS
  BEGIN
    obl_x := COS(ang) * R;
    obl_y := SIN(ang) * R;
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := X + obl_x * COS(Az * pi / 180) -
                                 obl_y * SIN(Az * pi / 180);
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := Y + obl_x * SIN(Az * pi / 180) +
                                 obl_y * COS(Az * pi / 180);
  END;

BEGIN
  tmp_array := NUMBER_ARRAY();

  angle := pi - 2 * ATAN(a / b);
  R     := SQRT(a * a / 4 + b * b / 4);

  angleSum := angle / 2 - pi;
  for i IN 0 .. 4 LOOP
    SELECT DECODE(MOD(i, 2), 0, pi - angle, 1, angle) + angleSum
      INTO angleSum
      FROM dual;
    addPoint(angleSum);
  END LOOP;

  SELECT cast(tmp_array AS SDO_ORDINATE_ARRAY) INTO ords FROM DUAL;
  geom := SDO_GEOMETRY(2002,
                       ewid4.ewd.get_epsg,
                       NULL,
                       SDO_ELEM_INFO_ARRAY(1, 2, 1),
                       ords);

  RETURN(geom);
END;


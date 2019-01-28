CREATE OR REPLACE FUNCTION create_sdo_elipse_1_pt_2_radii
/**
    <b> Function to compute a new eplise-shaped polygon in SDO_GEOMETRY from a center point, 2 radii and azimuth</b><br>
  The parameter 'seg' determines the number of segments of the polygon<br>
  The angles A1 and A2 allow to compute the part of the elipse shape<br>
  All angles have to be given in degrees<br><br>
    
    @param X NUMBER - center point X coordinate
    @param Y NUMBER - center point Y coordinate
    @param R1 NUMBER - 1st radius of the elipse
    @param R2 NUMBER - 2nd radius of the elipse
    @param Az NUMBER - azimuth of the elipse, in degrees, default 0
    @param seg NUMBER - number of segments of the new polygon, default 20
    @param A1 NUMBER - arc start point azimuth, in degrees, default 0
    @param A2 NUMBER - arc end point azimuth, in degrees, default 360
    @return geom SDO_GEOMETRY- computed polygon geometry
  
    @author Butcho
    @version 03.02.2018 
  */
(X   IN NUMBER,
 Y   IN NUMBER,
 R1  IN NUMBER,
 R2  IN NUMBER,
 Az  IN NUMBER default 0,
 seg IN NUMBER default 20,
 A1  IN NUMBER default 0,
 A2  IN NUMBER default 360) RETURN mdsys.sdo_geometry is
  geom mdsys.sdo_geometry;
  PI CONSTANT NUMBER(10, 8) := 3.14159265359;
  angle     NUMBER(10, 4);
  azDiff    NUMBER(15, 7);
  seg_num   NUMBER(5);
  obl_x     NUMBER(15, 3);
  obl_y     NUMBER(15, 3);
  tmp_array NUMBER_ARRAY;
  ords      SDO_ORDINATE_ARRAY;
BEGIN
  tmp_array := NUMBER_ARRAY();

  azDiff := A2;
  if (azDiff = 0) then 
	azDiff := 360;
  end if;
  
  seg_num := CEIL(abs(azDiff) / seg);
  angle   := azDiff / seg_num;

  -- the maximal tolerance (for the similar radii)
  IF (R1 + R2) * 0.5 * (1 - cos(pi / 180 * (angle / 2))) > 0.05 THEN
    angle   := 2 * 180 / pi * acos(1 - 0.05 / ((R1 + R2) * 0.5));
    seg_num := CEIL(abs(azDiff) / angle);
    angle   := azDiff / seg_num;
  END IF;

  for i IN 0 .. seg_num LOOP
    obl_x := cos(pi / 180 * (A1 + angle * (i))) * R1;
    obl_y := sin(pi / 180 * (A1 + angle * (i))) * R2;
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := X + obl_x * cos(Az * pi / 180) -
                                 obl_y * sin(Az * pi / 180);
    tmp_array.EXTEND;
    tmp_array(tmp_array.LAST) := Y + obl_x * sin(Az * pi / 180) +
                                 obl_y * cos(Az * pi / 180);
  END LOOP;
  SELECT cast(tmp_array as SDO_ORDINATE_ARRAY) INTO ords FROM DUAL;
  geom := SDO_GEOMETRY(2002,
                       ewid4.ewd.get_epsg,
                       NULL,
                       SDO_ELEM_INFO_ARRAY(1, 2, 1),
                       ords);

  RETURN(geom);
END;
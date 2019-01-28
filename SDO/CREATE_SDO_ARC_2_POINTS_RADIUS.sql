CREATE OR REPLACE FUNCTION create_sdo_arc_2_points_radius
/**
    <b> Function to compute a new arc in SDO_GEOMETRY from 2 points and a radius </b> </br>
    The arc direction depends on the angle direction (geodetic - clockwise, cartesian - counterclockwise)<br>
    If one wants to change the arc direction, the parameter 'direction' must be equal to 0<br><br>
    
    @param VXP NUMBER - arc start point X coordinate,
    @param VYP NUMBER - arc start point Y coordinate,
    @param VXK NUMBER - arc end point X coordinate,
    @param VYK NUMBER - arc end point Y coordinate,
    @param VR NUMBER - arc radius,
    @param DIRECTION NUMBER - arc direction - default is 1
    @return geom SDO_GEOMETRY- computed arc geometry
    
    @author Butcho
    @author Wojar
    @version 12.05.2014  
  */
(VXP       NUMBER,
 VYP       NUMBER,
 VXK       NUMBER,
 VYK       NUMBER,
 VR        NUMBER,
 DIRECTION NUMBER DEFAULT 1) RETURN SDO_GEOMETRY is
  PI CONSTANT NUMBER := 3.1415927;
  xp         NUMBER;
  yp         NUMBER;
  xk         NUMBER;
  yk         NUMBER;
  x3         NUMBER;
  y3         NUMBER;
  xs         NUMBER;
  ys         NUMBER;
  r          NUMBER;
  dist       NUMBER;
  alfa       NUMBER;
  azimuth_PS NUMBER;
  azimuth_SP NUMBER;
  azimuth_SK NUMBER;
  azimuth_S3 NUMBER;
BEGIN
  IF direction = 1 THEN
    xp := VXP;
    yp := VYP;
    xk := VXK;
    yk := VYK;
  ELSE
    xp := VXK;
    yp := VYK;
    xk := VXP;
    yk := VYP;
  END IF;

  dist := ROUND(SQRT(POWER((xk - xp), 2) + POWER((yk - yp), 2)), 2);
  r    := abs(VR);

  IF r < dist / 2 - 0.01 THEN
    RETURN NULL;
  END IF;

  IF r < dist / 2 THEN
    alfa := 0;
  ELSE
    alfa := acos((dist / 2) / r);
  END IF;

  azimuth_PS := get_segment_azimuth_grad(xp, yp, xk, yk) / 200 * PI + alfa;


  -- arc center point coordinates
  xs := xp + COS(azimuth_PS) * r;
  ys := yp + SIN(azimuth_PS) * r;

  -- arc 3rd point (in the middle)
  azimuth_SP := get_azimuth_difference_rad(azimuth_PS, PI);
  azimuth_SK := get_segment_azimuth_grad(xs, ys, xk, yk) / 200 * PI;
  azimuth_S3 := get_azimuth_sum_rad(azimuth_SP, get_azimuth_difference_rad(azimuth_SK,zimuth_SP) / 2);

  x3 := xs + COS(azimuth_S3) * VR;
  y3 := ys + SIN(azimuth_S3) * VR;

  RETURN SDO_GEOMETRY(2002,
                      ewid4.ewd.get_epsg,
                      NULL,
                      MDSYS.SDO_ELEM_INFO_ARRAY(1, 2, 2),
                      MDSYS.SDO_ORDINATE_ARRAY(xp, yp, x3, y3, xk, yk));
END;
/

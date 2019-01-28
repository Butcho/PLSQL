CREATE OR REPLACE function create_sdo_circle_2_points
/**
    <b>Function to compute a new circle in SDO_GEOMETRY from 2 points on a diameter </b> </br></br>,  
  
    @param VXK NUMBER - center point X coordinate,
    @param VYK NUMBER - center point Y coordinate,
    @param VR NUMBER - arc radius,
    @return geom SDO_GEOMETRY- computed circle geometry
  
    @author Butcho
    @author Wojar
    @version 12.05.2014  
  */
(X1 NUMBER, Y1 NUMBER, X2 NUMBER, Y2 NUMBER) RETURN SDO_GEOMETRY is
XC NUMBER;
YC NUMBER;
radius NUMBER;
BEGIN
  XC := (X1+X2)/2;
  YC := (Y1+Y2)/2;
  radius := get_segment_length(x1, y1, x2, y2)/2;
  
  RETURN get_sdo_circle_1_point_radius(XC, YC, radius);
END;
/

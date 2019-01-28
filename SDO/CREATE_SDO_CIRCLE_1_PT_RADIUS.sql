CREATE OR REPLACE function create_sdo_circle_1_pt_radius
/**
    <b>Function to compute a new circle in SDO_GEOMETRY from a center point and a radius </b> </br></br>,  
  
    @param VXK NUMBER - center point X coordinate,
    @param VYK NUMBER - center point Y coordinate,
    @param VR NUMBER - arc radius,
    @return geom SDO_GEOMETRY- computed circle geometry
  
    @author Butcho
    @author Wojar
    @version 12.05.2014  
  */
(X NUMBER, Y NUMBER, R NUMBER) RETURN SDO_GEOMETRY is
BEGIN
  RETURN SDO_GEOMETRY(2003,
                      ewid4.ewd.get_epsg,
                      NULL,
                      MDSYS.SDO_ELEM_INFO_ARRAY(1, 1003, 4),
                      MDSYS.SDO_ORDINATE_ARRAY(x - r, y, x, y + r, x + r, y));
END;
/

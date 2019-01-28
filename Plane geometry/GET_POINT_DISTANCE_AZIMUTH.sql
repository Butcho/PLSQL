CREATE OR REPLACE PROCEDURE get_point_distance_azimuth
/**
    <b> Procedure computes the new point as the end of a line of known azimuth and length</b></br>
    The line begins in the input point<br><br>
    
    @param inX NUMBER - input point X coordinate
    @param inY NUMBER - input point Y coordinate 
    @param az NUMBER - Azimuth of the line In-Out, in radians, clockwise
    @param dist NUMBER - Length of the line In-Out
    @RETURN outX NUMBER - output point X coordinate
    @RETURN outY NUMBER - output point Y coordinate
    
    @author Butcho
    @version 18.08.2017  
  */

(inX  IN NUMBER,
 inY  IN NUMBER,
 az   IN NUMBER,
 dist IN NUMBER,
 outX OUT NUMBER,
 outY OUT NUMBER) is
BEGIN
  outX := inX + dist * COS(az);
  outY := inY + dist * SIN(az);
END;
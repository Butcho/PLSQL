CREATE OR REPLACE PROCEDURE rotate_point_around_center
/**
    <b> Procedure rotates the point around the center point, clockwise</b><br><br>
    
    @param inX NUMBER, X coord of the point
    @param inY NUMBER, Y coord of the point
    @return outX NUMBER, X coord of the result
    @return outY NUMBER, Y coord of the result
    @param centerX NUMBER, X coord of the rotation center
    @param centerY NUMBER, Y coord of the rotation center
    @param angle NUMBER, angle of rotation, IN degrees, clockwise
    
    @author Butcho
    @version 10.08.2017  
  */
(inX     IN NUMBER,
 inY     IN NUMBER,
 outX    out NUMBER,
 outY    out NUMBER,
 centerX IN NUMBER,
 centerY IN NUMBER,
 angle   IN NUMBER) IS
  pi CONSTANT NUMBER := 3.14159265359;
  azimuth NUMBER(10, 6);
  dist    NUMBER(10, 3);

BEGIN
  azimuth := get_segment_azimuth_deg(centerX, centerY, inX, inY);
  dist    := get_segment_length(inX, inY, centerX, centerY);

  outX := centerX + dist * cos((azimuth - angle) * pi / 180);
  outY := centerY + dist * sin((azimuth - angle) * pi / 180);
END;
/

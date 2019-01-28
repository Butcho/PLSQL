CREATE OR REPLACE FUNCTION get_segment_length
/**
    <b> Function computes the length of the segment </b><br><br>
    
    @param xp NUMBER - X coordinate of the segment start point, 
    @param yp NUMBER - Y coordinate of the segment start point, 
    @param xk NUMBER - X coordinate of the segment END point, 
    @param yk NUMBER - Y coordinate of the segment END point 
    @return dist NUMBER - length of the given segment
    
    @author Butcho
    @author Wojar
    @version 18.07.2014 
  */
(xp FLOAT, yp FLOAT, xk FLOAT, yk FLOAT) RETURN FLOAT is
  dist FLOAT;
BEGIN
  BEGIN
    dist := SQRT(POWER((xk - xp), 2) + POWER((yk - yp), 2));
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;
  RETURN dist;
END;
/

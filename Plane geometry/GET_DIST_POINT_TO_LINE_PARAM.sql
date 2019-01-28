CREATE OR REPLACE FUNCTION get_dist_point_to_line_param(a IN NUMBER,
                                                        b IN NUMBER,
                                                        c IN NUMBER,
                                                        x IN NUMBER,
                                                        y IN NUMBER)
  RETURN NUMBER IS
  Result NUMBER;
  /**
    <b>Procedure computes the distance of a point to the line defined by linear equations </b></br></br>
    
    @param a NUMBER - line parameter A
    @param b NUMBER - line parameter B
    @param c NUMBER - line parameter C
    @param x NUMBER - point in distance X coordinate
    @param y NUMBER - point in distance Y coordinate
    
    @return dist NUMBER - distance between point and the line
    
    @version 11.07.2017
    @author Butcho 
  */
BEGIN
  IF a = 0 AND b = 0 THEN
    Result := -1;
  ELSE
    Result := ABS(a * x + b * y + c) / (SQRT(POWER(a, 2) + POWER(b, 2)));
  END IF;
  RETURN(Result);
END;
/

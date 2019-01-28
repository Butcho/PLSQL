CREATE OR REPLACE FUNCTION get_dist_point_to_line_coords(xB IN NUMBER,
                                                         yB IN NUMBER,
                                                         xE IN NUMBER,
                                                         yE IN NUMBER,
                                                         xP IN NUMBER,
                                                         yP IN NUMBER)
  RETURN NUMBER is
  Result NUMBER;
  /**
    <b>Procedure computes the distance of a point to the line defined by 2 points </b></br></br>
  
    @param xB NUMBER - 1st point X coordinate
    @param yB NUMBER - 1st point Y coordinate
    @param xE NUMBER - 2nd point X coordinate
    @param yE NUMBER - 2nd point Y coordinate
    @param xP NUMBER - point in distance X coordinate 
    @param yP NUMBER - point in distance Y coordinate 
  
    @return dist NUMBER - distance between point and the line
    
    @version 11.07.2017
    @author Butcho 
  */
  a NUMBER;
  b NUMBER;
  c NUMBER;
  function dist(x1 IN NUMBER, y1 IN NUMBER, x2 IN NUMBER, y2 IN NUMBER)
    RETURN NUMBER is
  BEGIN
    RETURN get_segment_length(x1, y1, x2, y2);
  END;
BEGIN
  IF xB = xE and yB = yE THEN
    Result := dist(xB, yB, xP, yP);
  ELSIF xP not between xB and xE OR yP not between yB and yE THEN
    Result := least(dist(xB, yB, xP, yP), dist(xE, yE, xP, yP));
  ELSE
    line_parameters(xB, yB, xE, yE, a, b, c);
    Result := get_dist_point_to_line_param(a, b, c, xP, yP);
  END IF;
  RETURN(Result);
END;
/

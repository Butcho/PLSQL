CREATE OR REPLACE PROCEDURE get_line_parameters_2_points(x1 IN NUMBER,
                                                         y1 IN NUMBER,
                                                         x2 IN NUMBER,
                                                         y2 IN NUMBER,
                                                         a  OUT NUMBER,
                                                         b  OUT NUMBER,
                                                         c  OUT NUMBER) IS
  /**
    <b> Procedure computes parameters of the line defined by 2 points </b></br></br>
     
    @param x1 NUMBER - 1st point X coordinate
    @param y1 NUMBER - 1st point Y coordinate
    @param x2 NUMBER - 2nd point X coordinate
    @param y2 NUMBER - 2nd point Y coordinate
    @return a NUMBER - line parameter A
    @return b NUMBER - line parameter B
    @return c NUMBER - line parameter C
    
    @version 11.07.2017
    @author Butcho 
  */
BEGIN
  IF x1 != x2 THEN
    a := ((y2 - y1) / (x2 - x1));
    b := -1;
  ELSE
    a := 1;
    b := 0;
  END IF;
  c := -x1 * a - b * y1;
END;
/

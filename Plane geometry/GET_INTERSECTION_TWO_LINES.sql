CREATE OR REPLACE PROCEDURE get_intersection_two_lines(a1 IN NUMBER,
                                                       b1 IN NUMBER,
                                                       c1 IN NUMBER,
                                                       a2 IN NUMBER,
                                                       b2 IN NUMBER,
                                                       c2 IN NUMBER,
                                                       x  OUT NUMBER,
                                                       y  OUT NUMBER) IS
  /**
    <b>Procedure computes the intersection point of two lines defined by linear equations</b></br></br>
     
    @param a1 NUMBER - 1st line parameter A
    @param b1 NUMBER - 1st line parameter B
    @param c1 NUMBER - 1st line parameter C
    @param a2 NUMBER - 2nd line parameter A
    @param b2 NUMBER - 2nd line parameter B
    @param c2 NUMBER - 2nd line parameter C
    @return x NUMBER - intersection point X coordinate
    @return y NUMBER - intersection point Y coordinate
    
    @version 11.07.2017
    @author Butcho 
  */
BEGIN
  IF a1 != a2 and a1 != 0 and a2 != 0 THEN
    y := ((a2 * c1 / a1) - c2) / (b2 - (a2 * b1 / a1));
    x := (-b1 * y - c1) / a1;
  ELSIF a1 = 0 THEN
    y := -c1 / b1;
    x := (-b2 * y - c2) / a2;
  ELSIF a2 = 0 THEN
    y := -c2 / b2;
    x := (-b1 * y - c1) / a1;
  END IF;
END;
/

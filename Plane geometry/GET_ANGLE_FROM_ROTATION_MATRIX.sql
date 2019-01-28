CREATE OR REPLACE FUNCTION get_angle_from_rotation_matrix
/**
    <b> Procedure computes an angle based on sinus and cosinus from a rotation matrix</b></br>
   <br><br>        
    
    @param cosAng NUMBER - cosinus value
    @param sinAng NUMBER - sinus value
    @RETURN angle NUMBER - result angle (radian)
    
    @author Butcho
    @version 13.11.2017  
  */
(cosAng   IN NUMBER,
 sinAng   IN NUMBER) RETURN NUMBER is Result NUMBER;
 PI CONSTANT NUMBER := 3.14159;
BEGIN
 
  IF (sinAng >= 0) THEN
    IF (cosAng >= 0) THEN
      Result := asin(sinAng); 
    ELSE
      Result := PI - asin(sinAng);
    END IF;
  ELSE
    IF (cosAng >= 0) THEN
      Result := 2*PI + asin(sinAng);
    ELSE
      Result := PI - asin(sinAng); 
    END IF;
  END IF;   
      
  RETURN(Result);
END;
/

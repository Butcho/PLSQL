CREATE OR REPLACE FUNCTION get_segment_azimuth_deg
/**
  <b> Function computes the azimuth (clockwise) of the segment in degrees </b><br><br>
  
  @param xp NUMBER - X coordinate of the segment start point, 
  @param yp NUMBER - Y coordinate of the segment start point, 
  @param xk NUMBER - X coordinate of the segment END point, 
  @param yk NUMBER - Y coordinate of the segment END point 
  @return az NUMBER - Azimuth in degrees
  
  @author Butcho
  @version 23.10.2017
*/   
(
	xp IN NUMBER,
	yp IN NUMBER,
	xk IN NUMBER,
	yk IN NUMBER
) RETURN NUMBER IS
	pi CONSTANT NUMBER := 3.1415927;
	wartosc NUMBER;
	az NUMBER;
BEGIN
	IF xp = xk THEN
	BEGIN
		IF yp = yk THEN RETURN 0; END IF;
		IF yp < yk THEN RETURN 90; END IF;
		IF yp > yk THEN RETURN 270; END IF;
	END;
	END IF;

	IF  yp = yk THEN
	BEGIN
		IF xp = xk THEN RETURN 0; END IF;
		IF xp < xk THEN RETURN 0; END IF;
		IF xp > xk THEN RETURN 180; END IF;
  	END;
	END IF;

	wartosc := (yk - yp)/(xk - xp);
	az := ATAN(wartosc) / pi * 180 ;

	IF xp < xk THEN
		az := 360 + az;
	ELSE
		az := 180 + az;
	END IF;

	RETURN MOD(az,360);
END;
/

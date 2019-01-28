CREATE OR REPLACE FUNCTION get_segment_azimuth_grad
/**
  <b> Function computes the azimuth (clockwise) of the segment in grads </b><br><br>
  
  @param xp NUMBER - X coordinate of the segment start point, 
  @param yp NUMBER - Y coordinate of the segment start point, 
  @param xk NUMBER - X coordinate of the segment END point, 
  @param yk NUMBER - Y coordinate of the segment END point 
  @return az NUMBER - Azimuth in grad
  
  @author Butcho
  @author Wojar
  @version 18.07.2014
*/   
(
	xp IN NUMBER,
	yp IN NUMBER,
	xk IN NUMBER,
	yk IN NUMBER
) RETURN NUMBER is
	pi CONSTANT NUMBER := 3.1415927;
	wartosc NUMBER;
	az NUMBER;
BEGIN
	IF xp = xk THEN
	BEGIN
		IF yp = yk THEN RETURN 0; END IF;
		IF yp < yk THEN RETURN 100; END IF;
		IF yp > yk THEN RETURN 300; END IF;
	END;
	END IF;

	IF  yp = yk THEN
	BEGIN
		IF xp = xk THEN RETURN 0; END IF;
		IF xp < xk THEN RETURN 0; END IF;
		IF xp > xk THEN RETURN 200; END IF;
  	END;
	END IF;

	wartosc := (yk - yp)/(xk - xp);
	az := ATAN(wartosc) / pi * 200 ;

	IF xp < xk THEN
		az := 400 + az;
	ELSE
		az := 200 + az;
	END IF;

	RETURN MOD(az,400);
END;
/

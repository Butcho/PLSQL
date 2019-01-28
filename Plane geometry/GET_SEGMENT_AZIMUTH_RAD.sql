CREATE OR REPLACE FUNCTION get_segment_azimuth_rad
/**
  <b> Function computes the azimuth (clockwise) of the segment in radian </b><br><br>
  
  @param xp NUMBER - X coordinate of the segment start point, 
  @param yp NUMBER - Y coordinate of the segment start point, 
  @param xk NUMBER - X coordinate of the segment END point, 
  @param yk NUMBER - Y coordinate of the segment END point 
  @return az NUMBER - Azimuth in radian
  
  @author Butcho
  @author Wojar
  @version 09.08.2016  
*/  
(
	xp IN NUMBER,
	yp IN NUMBER,
	xk IN NUMBER,
	yk IN NUMBER
) RETURN NUMBER IS
	pi CONSTANT NUMBER := 3.1415927;
	angleVal NUMBER;
	az NUMBER;
BEGIN
	IF xp = xk THEN
	BEGIN
		IF yp = yk THEN RETURN 0; END IF;
		IF yp < yk THEN RETURN pi/2; END IF;
		IF yp > yk THEN RETURN pi*1.5; END IF;
	END;
	END IF;

	IF  yp = yk THEN
	BEGIN
		IF xp = xk THEN RETURN 0; END IF;
		IF xp < xk THEN RETURN 0; END IF;
		IF xp > xk THEN RETURN pi; END IF;
  	END;
	END IF;

	angleVal := (yk - yp)/(xk - xp);
	az := ATAN(angleVal);

	IF xp < xk THEN
		az := 2*pi + az;
	ELSE
		az := pi + az;
	END IF;

	IF az >= 2*pi THEN
		az:=az - 2*pi;
	END IF;

	IF(az < 0) THEN
		az:= az + 2*pi;
	END IF;

	RETURN az;
END;
/

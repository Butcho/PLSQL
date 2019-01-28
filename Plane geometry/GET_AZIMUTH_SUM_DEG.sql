CREATE OR REPLACE FUNCTION get_azimuth_sum_deg 
/**
  <b> Function computes the difference between two azimuths in degrees </b><br><br>
  
  @param azimuth1 NUMBER - first azimuth in degrees, 
  @param azimuth2 NUMBER - second azimuth in degrees
  @return az NUMBER - Azimuth in degrees
  
  @author Butcho
  @version 23.10.2017
*/
(
	azimuth1 NUMBER,
	azimuth2 NUMBER
) RETURN NUMBER is
  fullAngle CONSTANT NUMBER := 360;
BEGIN
  RETURN mod(mod(azimuth1+azimuth2, fullAngle)+fullAngle,fullAngle);
END;
/

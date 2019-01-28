CREATE OR REPLACE FUNCTION get_azimuth_sum_rad 
/**
  <b> Function computes the difference between two azimuths in rad </b><br><br>
  
  @param azimuth1 NUMBER - first azimuth in rad, 
  @param azimuth2 NUMBER - second azimuth in rad
  @return az NUMBER - Azimuth in rad
  
  @author Butcho
  @version 23.10.2017
*/
(
	azimuth1 NUMBER,
	azimuth2 NUMBER
) RETURN NUMBER is
  PI CONSTANT NUMBER := 3.1415927;
BEGIN
  RETURN mod(mod(azimuth1+azimuth2, 2*pi)+2*pi,2*pi);
END;
/

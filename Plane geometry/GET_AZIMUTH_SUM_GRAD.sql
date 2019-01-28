CREATE OR REPLACE FUNCTION get_azimuth_sum_grad 
/**
  <b> Function computes the difference between two azimuths in grad </b><br><br>
  
  @param azimuth1 NUMBER - first azimuth in grad, 
  @param azimuth2 NUMBER - second azimuth in grad
  @return az NUMBER - Azimuth in grad
  
  @author Butcho
  @version 23.10.2017
*/
(
	azimuth1 NUMBER,
	azimuth2 NUMBER
) RETURN NUMBER is
  fullAngle CONSTANT NUMBER := 400;
BEGIN
  RETURN mod(mod(azimuth1+azimuth2, fullAngle)+fullAngle,fullAngle);
END;
/

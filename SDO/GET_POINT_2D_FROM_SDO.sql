CREATE OR REPLACE FUNCTION get_point_2d_from_sdo
/**
    <b> Function to find a SDO point 2D on the given position from SDO_ORDINATE_ARRAY</b></br>
    Created for KOL.<br><br>        
    
    @param geom SDO_GEOMETRY - input geometry
    @param ptNum INT - number of point in GEOM.SDO_ORDINATE_ARRAY
    @param roundVal INT - number of decimal places (default -1 -> original precision)
    @RETURN outGeom SDO_GEOMETRY - result SDO point
    
    @author Butcho
    @version 17.01.2017 
  */
(geom IN MDSYS.SDO_GEOMETRY, ptNum IN INT, roundVal IN INT default -1)
  RETURN MDSYS.SDO_GEOMETRY IS
  v_SdoPoint  MDSYS.SDO_Point_Type := MDSYS.SDO_Point_Type(0, 0, NULL);
  v_Ordinates MDSYS.SDO_Ordinate_Array;
BEGIN
  IF geom IS NULL THEN
    RETURN NULL;
  END IF;
  IF ptNum > SDO_UTIL.GETNUMVERTICES(geom) OR ptNum < 1 THEN
    RETURN NULL;
  END IF;
  IF geom.sdo_gtype in (2001) THEN
    RETURN geom;
  END IF;

  v_ordinates  := geom.sdo_ordinates;
  v_SdoPoint.X := v_ordinates(ptNum * 2 - 1);
  v_SdoPoint.Y := v_ordinates(ptNum * 2);

  IF (roundVal > -1) THEN
    v_SdoPoint.X := ROUND(v_SdoPoint.X, roundVal);
    v_SdoPoint.Y := ROUND(v_SdoPoint.Y, roundVal);
  END IF;
  RETURN mdsys.sdo_geometry(2001, geom.sdo_srid, v_SdoPoint, NULL, NULL);
END;
/

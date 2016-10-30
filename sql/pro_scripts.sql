CREATE OR REPLACE PROCEDURE GENERATE_LOW_ACTIVITY_ALERT(
    user_id_in IN VARCHAR
)

AS

countFreq NUMBER;
lastRecDays NUMBER;
countRec NUMBER;
activeAlertCount NUMBER;

BEGIN
  BEGIN   
     SELECT frequency INTO countFreq FROM RECOMMENDATION_WEIGHTS WHERE PATIENT_ID = user_id_in and IS_ACTIVE = 'Active';
  EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            countFreq := 0;
  END;
  
  IF countFreq > 0 THEN
     SELECT COUNT(OBSERVATION_TIME) INTO countRec FROM PATIENT_WEIGHTS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
     IF countRec > 0 THEN
              SELECT trunc(CURRENT_TIMESTAMP) - trunc(OBSERVATION_TIME) INTO lastRecDays FROM PATIENT_WEIGHTS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                       AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_WEIGHTS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;

     ELSE
              BEGIN
                  SELECT trunc(CURRENT_TIMESTAMP) - trunc(CREATED_TIME) INTO lastRecDays FROM APP_USERS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
              EXCEPTION 
                  WHEN NO_DATA_FOUND THEN 
                          lastRecDays := 0;
              END;
     END IF;
     IF lastRecDays > countFreq THEN   
      SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = 'Weight';
      IF activeAlertCount = 0 THEN
          INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,0,'Weight','Low Activity for Weights',CURRENT_TIMESTAMP,null,null,null,0,'Active');
          commit;
      END IF;
     END IF;

  END IF;
  

  BEGIN   
      SELECT frequency INTO countFreq FROM RECOMMENDATION_BPS WHERE PATIENT_ID = user_id_in and IS_ACTIVE = 'Active';
  EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
            countFreq := 0;
  END;
  
  IF countFreq > 0 THEN
        SELECT count(OBSERVATION_TIME) INTO countRec FROM PATIENT_BPS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
        IF countRec > 0 THEN
            SELECT trunc(CURRENT_TIMESTAMP) - trunc(OBSERVATION_TIME) INTO lastRecDays FROM PATIENT_BPS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
              AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_BPS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
        ELSE
              BEGIN
                  SELECT trunc(CURRENT_TIMESTAMP) - trunc(CREATED_TIME) INTO lastRecDays FROM APP_USERS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
              EXCEPTION 
                  WHEN NO_DATA_FOUND THEN 
                          lastRecDays := 0;
              END;        
        END IF;

        IF lastRecDays > countFreq THEN   
       SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = 'BP';
       IF activeAlertCount = 0 THEN
          INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,0,'BP','Low Activity for BP',CURRENT_TIMESTAMP,null,null,null,0,'Active');
          commit;
        END IF;
      END IF;
  END IF;



  BEGIN
    SELECT frequency INTO countFreq FROM RECOMMENDATION_MOODS WHERE PATIENT_ID = user_id_in and IS_ACTIVE = 'Active';
  EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
            countFreq := 0;
  END;
  
  IF countFreq > 0 THEN
        SELECT count(OBSERVATION_TIME) INTO countRec FROM PATIENT_MOODS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
        IF countRec > 0 THEN
            SELECT trunc(CURRENT_TIMESTAMP) - trunc(OBSERVATION_TIME) INTO lastRecDays FROM PATIENT_MOODS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
              AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_MOODS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
        ELSE
              BEGIN
                  SELECT trunc(CURRENT_TIMESTAMP) - trunc(CREATED_TIME) INTO lastRecDays FROM APP_USERS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
              EXCEPTION 
                  WHEN NO_DATA_FOUND THEN 
                          lastRecDays := 0;
              END;
        END IF;

    IF lastRecDays > countFreq THEN   
       SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = 'Mood';
       IF activeAlertCount = 0 THEN
          INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,0,'Mood','Low Activity for Mood',CURRENT_TIMESTAMP,null,null,null,0,'Active');
          commit;
       END IF;
    END IF;
  END IF;


  BEGIN
    SELECT frequency INTO countFreq FROM RECOMMENDATION_O2_SAT WHERE PATIENT_ID = user_id_in and IS_ACTIVE = 'Active';
  EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
            countFreq := 0;
  END; 

  IF countFreq > 0 THEN
        SELECT count(OBSERVATION_TIME) INTO countRec FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
        IF countRec > 0 THEN
            SELECT trunc(CURRENT_TIMESTAMP) - trunc(OBSERVATION_TIME) INTO lastRecDays FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
        ELSE
              BEGIN
                  SELECT trunc(CURRENT_TIMESTAMP) - trunc(CREATED_TIME) INTO lastRecDays FROM APP_USERS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
              EXCEPTION 
                  WHEN NO_DATA_FOUND THEN 
                          lastRecDays := 0;
              END;
        END IF;
      IF lastRecDays > countFreq THEN   
       SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = 'SPO2 Level';
       IF activeAlertCount = 0 THEN
          INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,0,'SPO2 Level','Low Activity for Oxygen Saturation',CURRENT_TIMESTAMP,null,null,null,0,'Active');
          commit;
       END IF;
     END IF;
  END IF;



  BEGIN
    SELECT frequency INTO countFreq FROM RECOMMENDATION_PAINS WHERE PATIENT_ID = user_id_in and IS_ACTIVE = 'Active';
  EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
            countFreq := 0;
  END; 

  IF countFreq > 0 THEN
        SELECT count(OBSERVATION_TIME) INTO countRec FROM PATIENT_PAINS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
        IF countRec > 0 THEN
            SELECT trunc(CURRENT_TIMESTAMP) - trunc(OBSERVATION_TIME) INTO lastRecDays FROM PATIENT_PAINS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
              AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_PAINS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
        ELSE
            BEGIN
                  SELECT trunc(CURRENT_TIMESTAMP) - trunc(CREATED_TIME) INTO lastRecDays FROM APP_USERS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
            EXCEPTION 
                  WHEN NO_DATA_FOUND THEN 
                          lastRecDays := 0;
            END;
        END IF;
          IF lastRecDays > countFreq THEN   
       SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = 'Pain';
       IF activeAlertCount = 0 THEN
          INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,0,'Pain','Low Activity for Pain',CURRENT_TIMESTAMP,null,null,null,0,'Active');
          commit;
       END IF;
  END IF;
  END IF;



  BEGIN
    SELECT frequency INTO countFreq FROM RECOMMENDATION_TEMPERATURES WHERE PATIENT_ID = user_id_in and IS_ACTIVE = 'Active';
  EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
            countFreq := 0;
  END;   

  IF countFreq > 0 THEN
        SELECT count(OBSERVATION_TIME) INTO countRec FROM PATIENT_TEMPERATURES WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
        IF countRec > 0 THEN
            SELECT trunc(CURRENT_TIMESTAMP) - trunc(OBSERVATION_TIME) INTO lastRecDays FROM PATIENT_TEMPERATURES WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
              AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_TEMPERATURES WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
        ELSE
            BEGIN
                  SELECT trunc(CURRENT_TIMESTAMP) - trunc(CREATED_TIME) INTO lastRecDays FROM APP_USERS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active';
            EXCEPTION 
                  WHEN NO_DATA_FOUND THEN 
                          lastRecDays := 0;
            END;
        END IF;

          IF lastRecDays > countFreq THEN   
       SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = 'Temperature';
       IF activeAlertCount = 0 THEN
          INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,0,'Temperature','Low Activity for Temperature',CURRENT_TIMESTAMP,null,null,null,0,'Active');
          commit;
       END IF;
  END IF;
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE GENERATE_OUT_OF_BOUNDS_ALERT(
    user_id_in IN VARCHAR,
    obs_type IN VARCHAR
)

AS

firstMinValue NUMBER;
firstMaxValue NUMBER;
firstValue NUMBER;

secondMinValue NUMBER;
secondMaxValue NUMBER;
secondValue NUMBER;

activeAlertCount NUMBER; 

BEGIN

CASE obs_type
    
    WHEN 'Weight' THEN   

        BEGIN
            SELECT MIN_VALUE,MAX_VALUE INTO firstMinValue,firstMaxValue FROM RECOMMENDATION_WEIGHTS WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        
        EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                      firstMinValue := 0;
                      firstMaxValue := 0;
        END;
        
        IF firstMinValue > 0 AND firstMaxValue > 0 THEN
            BEGIN
                SELECT value INTO firstValue FROM PATIENT_WEIGHTS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                    AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_WEIGHTS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                      firstValue := 0;
            END;
        	IF firstValue > 0 AND (firstValue < firstMinValue OR firstValue > firstMaxValue) THEN
            	SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = 'Weight';
        		IF activeAlertCount = 0 THEN
        	    		INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,1,'Weight','Out of bounds for Weights',CURRENT_TIMESTAMP,null,null,null,0,'Active');
        	    		commit;
        	    	END IF;
        	END IF;
        END IF;
    
    WHEN 'BP' THEN
        BEGIN
            SELECT SYSTOLIC_MIN_VALUE,SYSTOLIC_MAX_VALUE,DIASTOLIC_MIN_VALUE,DIASTOLIC_MAX_VALUE INTO firstMinValue,firstMaxValue,secondMinValue,secondMaxValue 
        			FROM RECOMMENDATION_BPS WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                      firstMinValue := 0;
                      firstMaxValue := 0;
                      secondMinValue := 0;
                      secondMaxValue := 0;
        END;

        IF firstMinValue > 0 AND firstMaxValue > 0  AND secondMinValue > 0  AND secondMaxValue > 0 THEN
                BEGIN
                    SELECT SYSTOLIC_VALUE,DIASTOLIC_VALUE INTO firstValue,secondValue FROM PATIENT_BPS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                        AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_BPS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
                EXCEPTION 
                    WHEN NO_DATA_FOUND THEN 
                        firstValue := 0;
                        secondValue := 0;
                END;
        	   IF firstValue > 0 AND secondValue > 0 AND (firstValue < firstMinValue OR firstValue > firstMaxValue OR secondValue < secondMinValue OR secondValue > secondMaxValue) THEN
            	SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = 'BP';
        		IF activeAlertCount = 0 THEN
        	    		INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,1,'BP','Out of bounds for BP',CURRENT_TIMESTAMP,null,null,null,0,'Active');
        	    		commit;
        	    	END IF;
        	   END IF;
        END IF;
        
    WHEN 'Mood' THEN
        BEGIN
            SELECT MOOD_VALUE INTO firstMaxValue FROM RECOMMENDATION_MOODS WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                      firstMaxValue := 0;
        END;
        
        IF firstMaxValue > 0 THEN
                BEGIN
                    SELECT MOOD_VALUE INTO firstValue FROM PATIENT_MOODS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                        AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_MOODS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
                EXCEPTION 
                    WHEN NO_DATA_FOUND THEN 
                        firstValue := 0;
                END;

        	   IF firstValue > 0 AND firstValue != firstMaxValue THEN
            	SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = 'Mood';
        		IF activeAlertCount = 0 THEN
        	    		INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,1,'Mood','Out of bounds for Moods',CURRENT_TIMESTAMP,null,null,null,0,'Active');
        	    		commit;
        	    	END IF;
        	   END IF;
        END IF;


    WHEN 'SPO2 Level' THEN
        BEGIN
            SELECT SPO2_MIN_VALUE,SPO2_MAX_VALUE INTO firstMinValue,firstMaxValue FROM RECOMMENDATION_O2_SAT WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                    firstMinValue := 0;
                    firstMaxValue := 0;
        END;
        
        IF firstMinValue > 0 AND firstMaxValue > 0 THEN
            BEGIN
                    SELECT SPO2_LEVEL_VALUE INTO firstValue FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                        AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
            EXCEPTION 
                    WHEN NO_DATA_FOUND THEN 
                        firstValue := 0;
            END;
        	IF firstValue > 0 AND (firstValue < firstMinValue OR firstValue > firstMaxValue) THEN
            	SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = 'SPO2';
        		IF activeAlertCount = 0 THEN
        	    		INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,1,'SPO2','Out of bounds for Oxygen Saturation',CURRENT_TIMESTAMP,null,null,null,0,'Active');
        	    		commit;
        	    	END IF;
        	END IF;
        END IF;


    WHEN 'Pain' THEN
        BEGIN
            SELECT PAIN_VALUE INTO firstMaxValue FROM RECOMMENDATION_PAINS WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                    firstMaxValue := 0;
        END;
        
        IF firstMaxValue > 0 THEN
                BEGIN
                    SELECT VALUE INTO firstValue FROM PATIENT_PAINS WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                        AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_PAINS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
                EXCEPTION 
                    WHEN NO_DATA_FOUND THEN 
                        firstValue := 0;
                END;
        	   IF firstValue > 0 AND firstValue != firstMaxValue THEN
            	SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = 'Pain';
        		IF activeAlertCount = 0 THEN
        	    		INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,1,'Pain','Out of bounds for Pains',CURRENT_TIMESTAMP,null,null,null,0,'Active');
        	    		commit;
        	    	END IF;
        	   END IF;
        END IF;

    WHEN 'Temperature' THEN
        BEGIN
            SELECT MIN_VALUE,MAX_VALUE INTO firstMinValue,firstMaxValue FROM RECOMMENDATION_TEMPERATURES WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                    firstMinValue := 0;
                    firstMaxValue := 0;
        END;
        
        IF firstMinValue > 0 AND firstMaxValue > 0 THEN
            BEGIN
                SELECT value INTO firstValue FROM PATIENT_TEMPERATURES WHERE USER_ID = user_id_in and IS_ACTIVE = 'Active'
                    AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_TEMPERATURES WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active') AND ROWNUM = 1;
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN 
                    firstValue := 0;
            END;
        	IF firstValue > 0 AND (firstValue < firstMinValue OR firstValue > firstMaxValue) THEN
            	SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = 'Temperature';
        		IF activeAlertCount = 0 THEN
        	    		INSERT INTO ALERTS VALUES(ALERTS_SEQ.NEXTVAL,user_id_in,1,'Temperature','Out of bounds for Temperatures',CURRENT_TIMESTAMP,null,null,null,0,'Active');
        	    		commit;
        	    	END IF;
        	END IF;
        END IF;
    END CASE;
END;
/

CREATE OR REPLACE PROCEDURE CLEAR_LOW_ACTIVITY_ALERTS(
    user_id_in IN VARCHAR,
    obs_type IN VARCHAR 
)

AS

activeAlertCount NUMBER;
result_val NUMBER;
result_val_1 NUMBER;

firstMinValue NUMBER;
firstMaxValue NUMBER;
secondMinValue NUMBER;
secondMaxValue NUMBER;

BEGIN

GENERATE_OUT_OF_BOUNDS_ALERT(user_id_in,obs_type);

SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 0 and OBSERVATION_TYPE = obs_type;
IF activeAlertCount > 0 THEN
    UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 0 and OBSERVATION_TYPE = obs_type;
    COMMIT;
END IF;

CASE obs_type
    
    WHEN 'Weight' THEN        
        BEGIN
            SELECT VALUE INTO result_val FROM (SELECT VALUE FROM PATIENT_WEIGHTS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active' ORDER BY OBSERVATION_TIME DESC) 
                WHERE ROWNUM=1;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  result_val := 0;
        END;

        BEGIN
            SELECT MIN_VALUE,MAX_VALUE INTO firstMinValue,firstMaxValue FROM RECOMMENDATION_WEIGHTS WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  firstMinValue := -1;
                  firstMaxValue := -1;
        END;
        
        IF firstMinValue IS NULL THEN
            firstMinValue := -1;
            firstMaxValue := -1;
        END IF;

        IF result_val > 0 AND (result_val >= firstMinValue AND result_val <= firstMaxValue) THEN
            SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
            IF activeAlertCount > 0 THEN
                UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
                commit;
            END IF;
        END IF;

    WHEN 'Temperature' THEN
        BEGIN
            SELECT VALUE INTO result_val FROM (SELECT VALUE FROM PATIENT_TEMPERATURES WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active' ORDER BY OBSERVATION_TIME DESC) 
                WHERE ROWNUM=1;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  result_val := 0;
        END;

        BEGIN
            SELECT MIN_VALUE,MAX_VALUE INTO firstMinValue,firstMaxValue FROM RECOMMENDATION_TEMPERATURES 
                WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  firstMinValue := -1;
                  firstMaxValue := -1;
        END;
        
        IF firstMinValue IS NULL THEN
            firstMinValue := -1;
            firstMaxValue := -1;
        END IF;

        IF result_val > 0 AND (result_val >= firstMinValue AND result_val <= firstMaxValue) THEN
            SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
            IF activeAlertCount > 0 THEN
                UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
                commit;
            END IF;
        END IF;      


    WHEN 'Pain' THEN
        BEGIN
            SELECT VALUE INTO result_val FROM (SELECT VALUE FROM PATIENT_PAINS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active' ORDER BY OBSERVATION_TIME DESC) 
                WHERE ROWNUM=1;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  result_val := 0;
        END;

        BEGIN
            SELECT PAIN_VALUE INTO firstMaxValue FROM RECOMMENDATION_PAINS
                WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  firstMaxValue := -1;
        END;
        
        IF firstMaxValue IS NULL THEN
            firstMaxValue := -1;
        END IF;

        IF result_val > 0 AND result_val != firstMaxValue THEN
            SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
            IF activeAlertCount > 0 THEN
                UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
                commit;
            END IF;
        END IF;         

    WHEN 'Mood' THEN
        BEGIN
            SELECT MOOD_VALUE INTO result_val FROM (SELECT MOOD_VALUE FROM PATIENT_MOODS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active' ORDER BY OBSERVATION_TIME DESC) 
                WHERE ROWNUM=1;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  result_val := 0;
        END;

        BEGIN
            SELECT MOOD_VALUE INTO firstMaxValue FROM RECOMMENDATION_MOODS
                WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  firstMaxValue := -1;
        END;
        
        IF firstMaxValue IS NULL THEN
            firstMaxValue := -1;
        END IF;

        IF result_val > 0 AND result_val != firstMaxValue THEN
            SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
            IF activeAlertCount > 0 THEN
                UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
                commit;
            END IF;
        END IF;           

    WHEN 'SPO2 Level' THEN
        BEGIN
            SELECT SPO2_LEVEL_VALUE INTO result_val FROM (SELECT SPO2_LEVEL_VALUE FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active' ORDER BY OBSERVATION_TIME DESC) 
                WHERE ROWNUM=1;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  result_val := 0;
        END;

        BEGIN
            SELECT SPO2_MIN_VALUE,SPO2_MAX_VALUE INTO firstMinValue,firstMaxValue FROM RECOMMENDATION_O2_SAT 
                WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  firstMinValue := -1;
                  firstMaxValue := -1;
        END;
        
        IF firstMinValue IS NULL THEN
            firstMinValue := -1;
            firstMaxValue := -1;
        END IF;

        IF result_val > 0 AND (result_val >= firstMinValue AND result_val <= firstMaxValue) THEN
            SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
            IF activeAlertCount > 0 THEN
                UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
                commit;
            END IF;
        END IF;        


    WHEN 'BP' THEN
        BEGIN
            SELECT SYSTOLIC_VALUE, DIASTOLIC_VALUE INTO result_val,result_val_1 FROM (SELECT SYSTOLIC_VALUE, DIASTOLIC_VALUE FROM PATIENT_BPS WHERE USER_ID = user_id_in AND IS_ACTIVE = 'Active' ORDER BY OBSERVATION_TIME DESC) 
                WHERE ROWNUM=1;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  result_val := 0;
                  result_val_1 := 0;
        END;

        BEGIN

            SELECT SYSTOLIC_MIN_VALUE, SYSTOLIC_MAX_VALUE, DIASTOLIC_MIN_VALUE, DIASTOLIC_MAX_VALUE
                 INTO firstMinValue,firstMaxValue,secondMinValue,secondMaxValue FROM RECOMMENDATION_BPS
                WHERE PATIENT_ID = user_id_in AND IS_ACTIVE = 'Active';
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
                  firstMinValue := -1;
                  firstMaxValue := -1;
                  secondMinValue := -1;
                  secondMaxValue := -1;
        END;
        
        IF firstMinValue IS NULL THEN
            firstMinValue := -1;
            firstMaxValue := -1;
            secondMinValue := -1;
            secondMaxValue := -1;
        END IF;

        IF result_val > 0 AND result_val_1 > 0 AND (result_val >= firstMinValue AND result_val <= firstMaxValue AND result_val_1 >= secondMinValue AND result_val_1 <= secondMaxValue) THEN
            SELECT count(1) INTO activeAlertCount FROM ALERTS WHERE PATIENT_ID = user_id_in and STATUS = 0 
                    and IS_ACTIVE = 'Active' and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
            IF activeAlertCount > 0 THEN
                UPDATE ALERTS SET STATUS = 1, CLEARED_REASON = 'Cleared by system', CLEARED_TIME = CURRENT_TIMESTAMP WHERE PATIENT_ID = user_id_in and ALERT_TYPE = 1 and OBSERVATION_TYPE = obs_type;
                commit;
            END IF;
        END IF;            

 END CASE;
END;
/

CREATE OR REPLACE PROCEDURE add_recommendation(
    patientId  IN APP_USERS.USER_ID%TYPE,
    supporterId IN APP_USERS.USER_ID%TYPE,
    otype IN DEFAULT_RECOMMENDATIONS.OBSERVATION_TYPE%TYPE,
    minval1 IN NUMBER,
    maxval1 IN NUMBER,
    minval2 IN NUMBER,
    maxval2 IN NUMBER,
    frequency IN NUMBER
)
IS
minval1_t NUMBER;
minval2_t NUMBER;
maxval1_t NUMBER;
maxval2_t NUMBER;
frequency_t NUMBER;

BEGIN

  IF minval1 = 0.0 THEN minval1_t := NULL; ELSE minval1_t := minval1; END IF;
  IF minval2 = 0.0 THEN minval2_t := NULL; ELSE minval2_t := minval2 ;END IF;
  IF maxval1 = 0.0 THEN maxval1_t := NULL; ELSE maxval1_t := maxval1; END IF;
  IF maxval2 = 0.0 THEN maxval2_t := NULL; ELSE maxval2_t := maxval2;  END IF;
  IF frequency = 0.0 THEN frequency_t := NULL; ELSE frequency_t := frequency; END IF;

  CASE otype
    WHEN 'Weight' THEN
	UPDATE RECOMMENDATION_WEIGHTS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_WEIGHTS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1_t, maxval1_t, frequency_t, CURRENT_TIMESTAMP, 'Active');
    WHEN 'Temperature' THEN
	UPDATE RECOMMENDATION_TEMPERATURES SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_TEMPERATURES VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1_t, maxval1_t, frequency_t, CURRENT_TIMESTAMP, 'Active');
    WHEN 'Pain' THEN
	UPDATE RECOMMENDATION_PAINS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_PAINS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, maxval1_t, frequency_t, CURRENT_TIMESTAMP, 'Active');
    WHEN 'Mood' THEN
	UPDATE RECOMMENDATION_MOODS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_MOODS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, maxval1_t, frequency_t, CURRENT_TIMESTAMP, 'Active');
    WHEN 'SPO2 Level' THEN
	UPDATE RECOMMENDATION_O2_SAT SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_O2_SAT VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1_t, maxval1_t, frequency_t, CURRENT_TIMESTAMP, 'Active');
    WHEN 'BP' THEN
	UPDATE RECOMMENDATION_BPS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_BPS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1_t, maxval1_t,minval2_t, maxval2_t, frequency_t,CURRENT_TIMESTAMP, 'Active');	
  END CASE;

COMMIT;

END;
/


CREATE OR REPLACE PROCEDURE get_default_recos(
	diseaseId IN NUMBER,
	records OUT SYS_REFCURSOR
)
AS
BEGIN
OPEN records FOR
SELECT * FROM DEFAULT_RECOMMENDATIONS WHERE
DISEASE_ID = diseaseId AND OBSERVATION_TYPE NOT IN ('Systolic BP','Diastolic BP'); 
END;
/
CREATE OR REPLACE PROCEDURE copy_default_bp_recos(
	patientId IN APP_USERS.USER_ID%TYPE,
        diseaseId IN NUMBER
)
IS
cnt number;
minval1 number;
maxval1 number;
minval2 number;
maxval2 number;
frequency number;
BEGIN

SELECT COUNT(*) INTO cnt FROM DEFAULT_RECOMMENDATIONS R1, DEFAULT_RECOMMENDATIONS R2 WHERE
R1.DISEASE_ID = diseaseId AND R2.DISEASE_ID = diseaseId AND R1.OBSERVATION_TYPE = 'Systolic BP'
AND R2.OBSERVATION_TYPE = 'Diastolic BP'; 

IF (cnt = 1) THEN
	SELECT R1.MIN_VALUE, R1.MAX_VALUE, R2.MIN_VALUE, R2.MAX_VALUE, R1.FREQUENCY 
	INTO minval1,maxval1,minval2,maxval2,frequency
	FROM DEFAULT_RECOMMENDATIONS R1, DEFAULT_RECOMMENDATIONS R2 WHERE
	R1.DISEASE_ID = diseaseId AND R2.DISEASE_ID = diseaseId
	AND R1.OBSERVATION_TYPE = 'Systolic BP' AND R2.OBSERVATION_TYPE = 'Diastolic BP';

	INSERT INTO RECOMMENDATION_BPS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, minval1, maxval1,minval2, maxval2, frequency,CURRENT_TIMESTAMP, 'Active');
END IF;
END;
/
CREATE OR REPLACE PROCEDURE copy_default_recommendation(
    patientId  IN APP_USERS.USER_ID%TYPE,
    diseaseId IN DISEASES.DISEASE_ID%TYPE
)
IS
records SYS_REFCURSOR;
record DEFAULT_RECOMMENDATIONS%rowtype;
BEGIN

copy_default_bp_recos(patientId, diseaseId);

get_default_recos(diseaseId, records);

LOOP
	FETCH records INTO record;
	EXIT WHEN records%notfound;
	CASE record.OBSERVATION_TYPE
	WHEN 'Weight' THEN
		INSERT INTO RECOMMENDATION_WEIGHTS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MIN_VALUE, record.MAX_VALUE, record.FREQUENCY, CURRENT_TIMESTAMP, 'Active');
	WHEN 'Temperature' THEN
                INSERT INTO RECOMMENDATION_TEMPERATURES VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MIN_VALUE, record.MAX_VALUE, record.FREQUENCY, CURRENT_TIMESTAMP, 'Active');
	WHEN 'Pain' THEN
                INSERT INTO RECOMMENDATION_PAINS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MAX_VALUE, record.FREQUENCY, CURRENT_TIMESTAMP, 'Active');
	WHEN 'Mood' THEN
                INSERT INTO RECOMMENDATION_MOODS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MAX_VALUE, record.FREQUENCY, CURRENT_TIMESTAMP, 'Active');
	WHEN 'SPO2 Level' THEN
                INSERT INTO RECOMMENDATION_O2_SAT VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MIN_VALUE, record.MAX_VALUE, record.FREQUENCY, CURRENT_TIMESTAMP, 'Active');
        END CASE;
END LOOP;
CLOSE records;
COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE get_user_data(
	userId IN APP_USERS.USER_ID%TYPE,
	userData OUT SYS_REFCURSOR
)
IS
BEGIN
OPEN userData FOR
	SELECT * FROM APP_USERS WHERE USER_ID = userId AND IS_ACTIVE <> 'Deleted';
END;
/

CREATE OR REPLACE PROCEDURE get_patient_diseases(
	userId IN APP_USERS.USER_ID%TYPE,
	diseases OUT SYS_REFCURSOR
)
IS
BEGIN
OPEN diseases FOR
	SELECT D.DISEASE_NAME, R.DIAGNOSED_ON FROM DISEASES D, PATIENT_DISEASES R 
	WHERE R.USER_ID = userId AND D.DISEASE_ID <> 1 AND D.DISEASE_ID = R.DISEASE_ID AND IS_ACTIVE = 'Active'; 
END;
/

CREATE OR REPLACE PROCEDURE get_primary_health_supporter(
	userId IN APP_USERS.USER_ID%TYPE,
	uid OUT APP_USERS.USER_ID%TYPE,
	fname OUT APP_USERS.USER_ID%TYPE,
	lname OUT APP_USERS.USER_ID%TYPE,
	auth_date OUT VARCHAR2
)
IS
BEGIN
	BEGIN
		SELECT U.USER_ID, U.FIRST_NAME, U.LAST_NAME, TO_CHAR(R.AUTHORIZATION_DATE,'DD-MM-YYYY') INTO
		uid, fname, lname, auth_date FROM PATIENT_SUPPORTERS R, APP_USERS U 
		WHERE U.USER_ID = R.USER_ID_SUPPORTER AND R.USER_ID_PATIENT = userId AND R.IS_ACTIVE = 'Active' and R.IS_PRIMARY=1;
		dbms_output.put_line(uid);
		dbms_output.put_line(fname);
		dbms_output.put_line(lname);
		dbms_output.put_line(auth_date);
		EXCEPTION
      	  WHEN NO_DATA_FOUND THEN
          uid := NULL;
          fname := NULL;
          lname := NULL;
          auth_date := NULL;
    END;
END;
/

CREATE OR REPLACE PROCEDURE get_secondary_health_supporter(
	userId IN APP_USERS.USER_ID%TYPE,
	uid OUT APP_USERS.USER_ID%TYPE,
	fname OUT APP_USERS.USER_ID%TYPE,
	lname OUT APP_USERS.USER_ID%TYPE,
	auth_date OUT VARCHAR2
)
IS
BEGIN
	BEGIN
		SELECT U.USER_ID, U.FIRST_NAME, U.LAST_NAME, TO_CHAR(R.AUTHORIZATION_DATE,'DD-MM-YYYY') INTO
		uid, fname, lname, auth_date FROM PATIENT_SUPPORTERS R, APP_USERS U 
		WHERE U.USER_ID = R.USER_ID_SUPPORTER AND R.USER_ID_PATIENT = userId AND R.IS_ACTIVE = 'Active' and R.IS_PRIMARY=0;
		dbms_output.put_line(uid);
		dbms_output.put_line(fname);
		dbms_output.put_line(lname);
		dbms_output.put_line(auth_date);
		EXCEPTION
      	  WHEN NO_DATA_FOUND THEN
          uid := NULL;
          fname := NULL;
          lname := NULL;
          auth_date := NULL;
    END;
END;
/
CREATE OR REPLACE PROCEDURE get_patient_active_alert(
	userId IN APP_USERS.USER_ID%TYPE,
	alerts OUT SYS_REFCURSOR
)
IS
BEGIN
	OPEN alerts FOR
		SELECT * FROM ALERTS WHERE PATIENT_ID = userId AND STATUS = 0 AND IS_ACTIVE = 'Active';
END;
/
CREATE OR REPLACE PROCEDURE get_supporter_active_alert(
	supporterId IN APP_USERS.USER_ID%TYPE,
	alerts OUT SYS_REFCURSOR
)
IS
BEGIN
	OPEN alerts FOR
		SELECT * FROM ALERTS WHERE 
		PATIENT_ID IN (SELECT USER_ID_PATIENT FROM PATIENT_SUPPORTERS WHERE USER_ID_SUPPORTER = supporterId and IS_ACTIVE = 'Active' 
			AND AUTHORIZATION_DATE <= SYSDATE)  
		 AND STATUS = 0 AND IS_ACTIVE = 'Active';
END;
/

CREATE OR REPLACE PROCEDURE read_user(
	userId IN APP_USERS.USER_ID%TYPE,
	userData OUT SYS_REFCURSOR,
	diseases OUT SYS_REFCURSOR,
	selfAlerts OUT SYS_REFCURSOR,
	patientAlerts OUT SYS_REFCURSOR,
	phs_uid OUT VARCHAR2,
	phs_fname OUT VARCHAR2,
	phs_lname OUT VARCHAR2,
	phs_authdate OUT VARCHAR2,
	shs_uid OUT VARCHAR2,
	shs_fname OUT VARCHAR2,
	shs_lname OUT VARCHAR2,
	shs_authdate OUT VARCHAR2
)
IS
BEGIN
	get_user_data(userId, userData);
	get_patient_diseases(userId, diseases);
	get_primary_health_supporter(userId, phs_uid, phs_fname, phs_lname, phs_authdate);
	get_secondary_health_supporter(userId, shs_uid, shs_fname, shs_lname, shs_authdate);
	generate_low_activity_alert(userId);
	get_patient_active_alert(userId, selfAlerts);
	get_supporter_active_alert(userId, patientAlerts);

END;
/

BEGIN
    copy_default_recommendation('P1',4);
    copy_default_recommendation('P2',2);
    copy_default_recommendation('P3',1);
    copy_default_recommendation('P4',1);
    add_recommendation('P2','P3','Weight',120,190,null,null,7);
    add_recommendation('P2','P3','BP',null,null,null,null,1);
    add_recommendation('P2','P3','Pain',null,5,null,null,1);
    GENERATE_LOW_ACTIVITY_ALERT('P1');
    GENERATE_LOW_ACTIVITY_ALERT('P1');
    GENERATE_LOW_ACTIVITY_ALERT('P1');
    GENERATE_LOW_ACTIVITY_ALERT('P1');
    GENERATE_OUT_OF_BOUNDS_ALERT('P2','Weight');
END;
/
commit;

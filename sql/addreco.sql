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
BEGIN

  CASE otype
    WHEN 'Weight' THEN
	UPDATE RECOMMENDATION_WEIGHTS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_WEIGHTS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1, maxval1, frequency, sysdate, 'Active');
    WHEN 'Temperature' THEN
	UPDATE RECOMMENDATION_TEMPERATURES SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_TEMPERATURES VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1, maxval1, frequency, sysdate, 'Active');
    WHEN 'Pain' THEN
	UPDATE RECOMMENDATION_PAINS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_PAINS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, maxval1, frequency, sysdate, 'Active');
    WHEN 'Mood' THEN
	UPDATE RECOMMENDATION_MOODS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_MOODS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, maxval1, frequency, sysdate, 'Active');
    WHEN 'SPO2 Level' THEN
	UPDATE RECOMMENDATION_O2_SAT SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_O2_SAT VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1, maxval1, frequency, sysdate, 'Active');
    WHEN 'BP' THEN
	UPDATE RECOMMENDATION_BPS SET IS_ACTIVE = 'Deleted' WHERE PATIENT_ID = patientId AND IS_ACTIVE = 'Active';
        INSERT INTO RECOMMENDATION_BPS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, supporterId, minval1, maxval1,minval2, maxval2, frequency,sysdate, 'Active');	
  END CASE;

COMMIT;

END;
/

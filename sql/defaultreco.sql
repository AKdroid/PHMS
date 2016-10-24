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

	INSERT INTO RECOMMENDATION_BPS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, minval1, maxval1,minval2, maxval2, frequency,sysdate, 'Active');
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
		INSERT INTO RECOMMENDATION_WEIGHTS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MIN_VALUE, record.MAX_VALUE, record.FREQUENCY, sysdate, 'Active');
	WHEN 'Temperature' THEN
                INSERT INTO RECOMMENDATION_TEMPERATURES VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MIN_VALUE, record.MAX_VALUE, record.FREQUENCY, sysdate, 'Active');
	WHEN 'Pain' THEN
                INSERT INTO RECOMMENDATION_PAINS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MAX_VALUE, record.FREQUENCY, sysdate, 'Active');
	WHEN 'Mood' THEN
                INSERT INTO RECOMMENDATION_MOODS VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MAX_VALUE, record.FREQUENCY, sysdate, 'Active');
	WHEN 'SPO2 Level' THEN
                INSERT INTO RECOMMENDATION_O2_SAT VALUES(RECOMMENDATION_SEQ.NEXTVAL, patientId, NULL, record.MIN_VALUE, record.MAX_VALUE, record.FREQUENCY, sysdate, 'Active');
        END CASE;
END LOOP;
CLOSE records;
COMMIT;
END;
/

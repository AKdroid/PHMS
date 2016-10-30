insert into app_users values('P1','password','Sheldon','Cooper',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Patient','26-APR-84','M','2500 Sacramento, Apt 903','Santa Cruz','CA','USA','90021','Active');

insert into app_users values('P2','password','Leonard','Hofstader',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Both','19-APR-89','M','2500 Sacramento, Apt 904','Santa Cruz','CA','USA','90021','Active');

insert into app_users values('P3','password','Penny','Hofstader',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Both','25-DEC-90','F','2500 Sacramento, Apt 904','Santa Cruz','CA','USA','90021','Active');

insert into app_users values('P4','password','Amy','Farrahfowler',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Both','15-JUN-92','F','2500 Sacramento, Apt 905','Santa Cruz','CA','USA','90021','Active');


insert into PATIENT_SUPPORTERS values('P1','P2','21-OCT-2016',1,'Active');

insert into PATIENT_SUPPORTERS values('P1','P4','21-OCT-2016',0,'Active');

insert into PATIENT_SUPPORTERS values('P2','P3','9-OCT-2016',1,'Active');

insert into PATIENT_SUPPORTERS values('P3','P4','21-OCT-2016',1,'Active');


insert into PATIENT_DISEASES values('P1',4,'22-OCT-2016',null,1,'Active');

insert into PATIENT_DISEASES values('P2',2,'10-OCT-2016',null,1,'Active');


insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Weight',4,120,200,7);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Systolic BP',4,140,159,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Diastolic BP',4,90,99,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Mood',4,0,1,7);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Weight',2,120,200,7);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Systolic BP',2,null,null,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Diastolic BP',2,null,null,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Pain',2,0,5,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'SPO2 Level',3,90,99,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Temperature',3,95,100,1);

insert into DEFAULT_RECOMMENDATIONS values(RECOMMENDATION_SEQ.NEXTVAL,'Weight',1,120,200,7);

insert into PATIENT_WEIGHTS VALUES ('P2',OBSERVATION_SEQ.NEXTVAL,180,'Active',TO_TIMESTAMP('10-10-2016 00:00:00', 'DD-MM-YYYY HH24:MI:SS'),TO_TIMESTAMP('10-11-2016 00:00:00', 'DD-MM-YYYY HH24:MI:SS'));

insert into PATIENT_WEIGHTS VALUES ('P2',OBSERVATION_SEQ.NEXTVAL,195,'Active',TO_TIMESTAMP('17-10-2016 00:00:00', 'DD-MM-YYYY HH24:MI:SS'),TO_TIMESTAMP('17-10-2016 00:00:00', 'DD-MM-YYYY HH24:MI:SS'));

commit;



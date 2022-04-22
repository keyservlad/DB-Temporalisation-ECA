SELECT CreateActivityWorkUnit('Unit1');
SELECT CreateActivityWorkUnit('Unit2');


SELECT CreateActivity(0,'Injections','Description');            /*Id:0*/
SELECT CreateActivity(0,'Blood tests','Description');           /*Id:1*/

SELECT CreateActivity(1,'Surgeries','Description');             /*Id:2*/
SELECT CreateActivity(1,'Diagnoses','Description');             /*Id:3*/
SELECT CreateActivity(1,'Consultations','Description');         /*Id:4*/

/*Establishment1 offers Consultations*/
INSERT INTO "UOActivity" VALUES (4,1,CURRENT_DATE);

/*Department1 offers Blood tests and Diagnoses*/
INSERT INTO "UOActivity" VALUES (1,3,CURRENT_DATE);
INSERT INTO "UOActivity" VALUES (3,3,CURRENT_DATE);

/*Department2 offers Surgeries*/
INSERT INTO "UOActivity" VALUES (2,4,CURRENT_DATE);

/*Department3 offers Injections,Surgeries, and Consultations*/
INSERT INTO "UOActivity" VALUES (0,5,CURRENT_DATE);
INSERT INTO "UOActivity" VALUES (2,5,CURRENT_DATE);
INSERT INTO "UOActivity" VALUES (4,5,CURRENT_DATE);
/*--------------------------------------------------------------------------------------------------------------------*/

-- ERROR : Prevision period can't be outside the Program period
SELECT CreatePrevision(0,1,4,10,daterange('2022-05-01','2024-08-01','[]'));

-- ERROR : We can't make a prevision to an UO that doesn't offer the activity
SELECT CreatePrevision(0,0,4,10,daterange('2022-05-01','2022-06-01','[]'));



-- ERROR : Assignment period can't be outside the Program period
SELECT CreateAssignment(0,0,3,1,10,daterange('2022-02-10','2022-06-01','[]'));

-- ERROR : The ECA 0 cannot perform Activity 2
SELECT CreateAssignment(0,0,3,2,10,daterange('2022-05-10','2022-06-01','[]'));

-- ERROR : The ECA 0 cannot perform Activity 1 during 2022-09-01 to 2022-10-01
SELECT CreateAssignment(0,0,3,1,10,daterange('2022-09-01','2022-10-01','[]'));

-- ERROR : UO 0 does not offer Activity 1
SELECT CreateAssignment(0,0,0,1,10,daterange('2022-05-01','2022-06-01','[]'));

-- SUCCESS : Everything is satisfied
SELECT CreateAssignment(0,0,3,1,10,daterange('2022-05-01','2022-06-01','[]'));

-- ERROR : ECA has an assignment during that period
SELECT CreateAssignment(0,0,3,1,10,daterange('2022-05-15','2022-05-20','[]'));


/*--------------------------------------------------------------------------------------------------------------------*/


/*Update an Assignment and see it reflected in since column (if done in a different day) and if it's added to _during table*/
SELECT * from "Assignment";
UPDATE "Assignment" SET "WorkQuantity"=25 where "IdECA"=0;
SELECT * from "Assignment_During";


/*Update a UO Name to see it reflected in the since column and if it's added to _during table*/
SELECT * FROM "UO";
UPDATE "UO" SET "Name"='New region name' where "Id"=0;
SELECT * FROM "UO";
SELECT * FROM "UO_Name_During";


/*Remove an UO to see UOActivities, Prevision, and assignment related to it move to their respective _during tables */
DELETE FROM "UO" WHERE "Id"=3;
SELECT * FROM "UO" WHERE "Id"=3;
SELECT * FROM "Prevision" WHERE "IdUO"=3;
SELECT * FROM "Prevision_During" WHERE "IdUO"=3;




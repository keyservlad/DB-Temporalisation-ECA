SELECT CreateHierarchy('Region');       /*Id:0*/
SELECT CreateHierarchy('Establishment');/*Id:1*/
SELECT CreateHierarchy('Department');   /*Id:2*/


SELECT CreateUO('Region1',NULL,0); /*Id:0*/

SELECT CreateUO('Establishment1',0,1); /*Id:1*/
SELECT CreateUO('Establishment2',0,1); /*Id:2*/

SELECT CreateUO('Department1',1,2); /*Id:3*/
SELECT CreateUO('Department2',1,2); /*Id:4*/
SELECT CreateUO('Department3',2,2); /*Id:5*/



SELECT createprogram('Program1',daterange('2022-05-01','2022-12-31','[]')) /*Id:0*/

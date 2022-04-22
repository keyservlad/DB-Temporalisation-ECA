SELECT CreatePrevision(0,1,4,10,daterange('2022-05-01','2022-08-01','[]'));

SELECT CreatePrevision(0,3,1,10,daterange('2022-05-01','2022-12-01','[]'));
SELECT CreatePrevision(0,3,3,15,daterange('2022-07-01','2022-11-01','[]'));
SELECT CreatePrevision(0,3,3,20,daterange('2022-06-01','2022-10-15','[]'));

SELECT CreatePrevision(0,4,2,12,daterange('2022-05-01','2022-08-30','[]'));

SELECT CreatePrevision(0,5,0,60,daterange('2022-05-01','2022-08-30','[]'));
SELECT CreatePrevision(0,5,0,20,daterange('2022-06-01','2022-10-01','[]'));
SELECT CreatePrevision(0,5,2,15,daterange('2022-05-01','2022-11-01','[]'));
SELECT CreatePrevision(0,5,4,30,daterange('2022-08-01','2022-12-01','[]'));

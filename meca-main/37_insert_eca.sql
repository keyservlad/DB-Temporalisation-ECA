/*Ford has 2 permit (0 and 1) and they allow him to practice activities 0,1 and 3 (Injection, Blood test, and Diagnoses) */
SELECT CreateECA('Ford', 'Megen');
    INSERT INTO "Permit" VALUES (0,'Permit1',daterange('2022-01-01','2022-08-30','[]'));
        INSERT INTO "PermitActivity" VALUES (0,0);
        INSERT INTO "PermitActivity" VALUES (0,1);
    INSERT INTO "Permit" VALUES (1,'Permit2',daterange('2022-09-01','2022-12-31','[]'));
        INSERT INTO "PermitActivity" VALUES (1,0);
        INSERT INTO "PermitActivity" VALUES (1,3);
    INSERT INTO "PermitECA" VALUES (0,0);
    INSERT INTO "PermitECA" VALUES (1,0);

SELECT CreateECA('Snowsill', 'Merrilee');
    INSERT INTO "Permit" VALUES (2,'Permit3',daterange('2021-01-01','2022-12-31','[]'));
        INSERT INTO "PermitActivity" VALUES (2,2);
    INSERT INTO "PermitECA" VALUES (2,1);

/*Megan has 2 permit (3 and 4) and they allow her to practice 4 (Consultations) but for different periods */

SELECT CreateECA('Meegan', 'Linn');
    INSERT INTO "Permit" VALUES (3,'Permit4',daterange('2022-01-01','2022-03-30','[]'));
        INSERT INTO "PermitActivity" VALUES (3,4);
    INSERT INTO "Permit" VALUES (4,'Permit5',daterange('2022-04-01','2023-08-30','[]'));
        INSERT INTO "PermitActivity" VALUES (4,4);
    INSERT INTO "PermitECA" VALUES (3,2);
    INSERT INTO "PermitECA" VALUES (4,2);

SELECT CreateECA('Woodsford', 'Meridel');
    INSERT INTO "Permit" VALUES (5,'Permit6',daterange('2022-02-01','2022-08-30','[]'));
        INSERT INTO "PermitActivity" VALUES (5,4);
    INSERT INTO "PermitECA" VALUES (5,3);

SELECT CreateECA('Ghent', 'Orville' );
    INSERT INTO "Permit" VALUES (6,'Permit7',daterange('2022-01-01','2022-11-30','[]'));
        INSERT INTO "PermitActivity" VALUES (6,0);
        INSERT INTO "PermitActivity" VALUES (6,1);
    INSERT INTO "PermitECA" VALUES (6,4);


SELECT CreateECA('Pelerin', 'Benoit');
    INSERT INTO "Permit" VALUES (7,'Permit8',daterange('2022-01-01','2025-08-30','[]'));
        INSERT INTO "PermitActivity" VALUES (7,1);
        INSERT INTO "PermitActivity" VALUES (7,2);
    INSERT INTO "PermitECA" VALUES (7,5);

SELECT CreateECA('Slides', 'Coletta');
    INSERT INTO "Permit" VALUES (8,'Permit9',daterange('2020-01-01','2022-08-30','[]'));
        INSERT INTO "PermitActivity" VALUES (8,1);
    INSERT INTO "PermitECA" VALUES (8,6);

SELECT CreateECA('Fish', 'Fancy');
    INSERT INTO "Permit" VALUES (9,'Permit10',daterange('2021-01-01','2024-08-30','[]'));
        INSERT INTO "PermitActivity" VALUES (9,2);
        INSERT INTO "PermitActivity" VALUES (9,3);
    INSERT INTO "PermitECA" VALUES (9,7);

SELECT CreateECA('Tower', 'Darcee');
    INSERT INTO "Permit" VALUES (10,'Permit11',daterange('2020-01-01','2022-12-31','[]'));
        INSERT INTO "PermitActivity" VALUES (10,3);
    INSERT INTO "PermitECA" VALUES (10,8);

SELECT CreateECA('Mosco', 'Gothart');
    INSERT INTO "Permit" VALUES (11,'Permit12',daterange('2022-01-01','2022-12-31','[]'));
        INSERT INTO "PermitActivity" VALUES (11,0);
    INSERT INTO "PermitECA" VALUES (11,9);


/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CheckIfECACanPerformActivity(IdECA INTEGER,IdActivity INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN (EXISTS(
            SELECT *
            FROM "PermitECA" PE
                     JOIN
                 "PermitActivity" PA on PA."IdPermit" = PE."IdPermit"
            WHERE PE."IdECA" = IdECA
              AND PA."IdActivity" = IdActivity
        ));
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CheckIfECACanPerformActivityForPeriod(IdECA INTEGER,IdActivity INTEGER,DateRange daterange)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN (EXISTS(
            SELECT *
            FROM "Permit" P
                    JOIN
                 "PermitECA" PE ON PE."IdPermit" = P."Id"
                     JOIN
                 "PermitActivity" PA on PA."IdPermit" = PE."IdPermit"
            WHERE PE."IdECA" = IdECA
                AND PA."IdActivity" = IdActivity
                AND P."ValidityDaterange"@>DateRange
        ));
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CheckIfECAIsAvailable(Id INTEGER,IdECA INTEGER,DateRange daterange)
RETURNS BOOLEAN AS $$
DECLARE
    OccupiedDateRanges daterange[] := (SELECT ARRAY(SELECT "DateRange" FROM "Assignment" WHERE "IdECA"=IdECA AND "Id"<>Id));
    OccupiedDateRange daterange;
BEGIN
    IF (OccupiedDateRanges IS NULL) THEN
        RETURN TRUE;
    END IF;
    FOREACH OccupiedDateRange IN ARRAY OccupiedDateRanges LOOP
        IF (OccupiedDateRange && DateRange) THEN
            RETURN FALSE;
        END IF;
    END LOOP;

    RETURN TRUE;
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CheckPeriodWithProgramPeriod(DateRange daterange,IdProgram INTEGER)
RETURNS BOOLEAN AS $$
DECLARE
    ProgramDateRange daterange := (SELECT "DateRange" FROM "Program" WHERE "Id"=IdProgram);
BEGIN
    RETURN (ProgramDateRange @> DateRange);
END;$$ LANGUAGE plpgsql;

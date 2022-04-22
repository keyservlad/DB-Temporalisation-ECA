
/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnAssignmentUpdateOrDelete()
RETURNS TRIGGER AS $$
DECLARE
    LatestUpdate date := (SELECT GREATEST(OLD."Since",OLD."IdECA_since",OLD."IdProgram_since",OLD."DateRange_since",
        OLD."IdProgram_since",OLD."IdUO_since",OLD."IdActivity_since",OLD."WorkQuantity_since"));
    During daterange := daterange(LatestUpdate,CURRENT_DATE,'[]');
BEGIN

    IF (TG_OP = 'UPDATE') THEN
        IF(OLD."IdECA" <> NEW."IdECA") then
            UPDATE "Assignment" SET "IdECA_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."IdUO" <> NEW."IdUO") then
            UPDATE "Assignment" SET "IdUO_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."IdActivity" <> NEW."IdActivity") then
            UPDATE "Assignment" SET "IdActivity_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."IdProgram" <> NEW."IdProgram") then
            UPDATE "Assignment" SET "IdProgram_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."DateRange" <> NEW."DateRange") then
            UPDATE "Assignment" SET "DateRange_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."WorkQuantity" <> NEW."WorkQuantity") then
            UPDATE "Assignment" SET "WorkQuantity_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSE
            /*Else is for when we update the since value, thus we RETURN OLD; so that when we call update automatically
              to update a "since" value, we won't re-insert the row into "Assignment_During" with the command bellow,
              but exit here instead. */
            RETURN OLD;
        END IF;
    END IF;

    INSERT INTO "Assignment_During" VALUES (OLD."Id",OLD."IdECA",OLD."IdUO",OLD."IdActivity",OLD."IdProgram",
                                            OLD."DateRange",OLD."WorkQuantity",During);
    RETURN OLD;
END;$$ LANGUAGE plpgsql ;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnPrevisionUpdateOrDelete()
RETURNS TRIGGER AS $$
DECLARE
    LatestUpdate date := (SELECT GREATEST(OLD."Since",OLD."IdProgram_since",OLD."DateRange_since",
        OLD."IdProgram_since",OLD."IdUO_since",OLD."IdActivity_since",OLD."WorkQuantity_since"));
    During daterange := daterange(LatestUpdate,CURRENT_DATE,'[]');
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF(OLD."IdUO" <> NEW."IdUO") then
            UPDATE "Prevision" SET "IdUO_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."IdActivity" <> NEW."IdActivity") then
            UPDATE "Prevision" SET "IdActivity_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."IdProgram" <> NEW."IdProgram") then
            UPDATE "Prevision" SET "IdProgram_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."DateRange" <> NEW."DateRange") then
            UPDATE "Prevision" SET "DateRange_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSIF(OLD."WorkQuantity" <> NEW."WorkQuantity") then
            UPDATE "Prevision" SET "WorkQuantity_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
        ELSE
            RETURN OLD;
        END IF;
    END IF;

    INSERT INTO "Prevision_During" VALUES (OLD."Id",OLD."IdProgram",OLD."IdUO",OLD."IdActivity",
                                           OLD."WorkQuantity",OLD."DateRange",During);
    RETURN OLD;
END;$$ LANGUAGE plpgsql ;


/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnUOActivityDelete()
RETURNS TRIGGER AS $$
DECLARE
    During daterange := daterange(OLD."Since",CURRENT_DATE,'[]');
BEGIN
    INSERT INTO "UOActivity_During" VALUES (OLD."IdActivity",OLD."IdUO",During);
    RETURN OLD;
END;$$ LANGUAGE plpgsql;


/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnUOUpdateOrDelete()
RETURNS TRIGGER AS $$
DECLARE
    LatestUpdate date := (SELECT GREATEST(OLD."Since",OLD."Name_since",OLD."IdParent_since", OLD."IdHierarchical_since"));
    During daterange := daterange(LatestUpdate,CURRENT_DATE,'[]');
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF(OLD."Name" <> NEW."Name") then
            UPDATE "UO" SET "Name_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
            INSERT INTO "UO_Name_During" VALUES (OLD."Id",OLD."Name",During);
        ELSIF(OLD."IdParent" <> NEW."IdParent") then
            UPDATE "UO" SET "IdParent_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
            INSERT INTO "UO_Parent_During" VALUES (OLD."Id",OLD."IdParent",During);
        ELSIF(OLD."IdHierarchical" <> NEW."IdHierarchical") then
            UPDATE "UO" SET "IdHierarchical_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
            INSERT INTO "UO_Hierarchy_During" VALUES (OLD."Id",OLD."IdHierarchical",During);
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        DELETE FROM "Prevision" WHERE "IdUO"=OLD."Id";
        DELETE FROM "Assignment" WHERE "IdUO"=OLD."Id";
        DELETE FROM "UOActivity" WHERE "IdUO"=OLD."Id";
        INSERT INTO "UO_During" VALUES (OLD."Id",During);
    END IF;

    RETURN OLD;
END;$$ LANGUAGE plpgsql;





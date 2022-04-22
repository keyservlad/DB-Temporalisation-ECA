
/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnHierarchyUpdate()
RETURNS TRIGGER AS $$
DECLARE
BEGIN
    IF(OLD."Name" <> NEW."Name") then
        UPDATE "Hierarchy" SET "Name_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    END IF;
    RETURN NEW;
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnActivityWorkUnitUpdate()
RETURNS TRIGGER AS $$
DECLARE
BEGIN
    IF(OLD."Name" <> NEW."Name") then
        UPDATE "ActivityWorkUnit" SET "Name_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    END IF;
    RETURN NEW;
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnActivityUpdate()
RETURNS TRIGGER AS $$
DECLARE
BEGIN
    IF(OLD."IdWorkUnit" <> NEW."IdWorkUnit") then
        UPDATE "Activity" SET "IdWorkUnit_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    ELSIF(OLD."Name" <> NEW."Name") then
        UPDATE "Activity" SET "Name_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    ELSIF(OLD."Description" <> NEW."Description") then
        UPDATE "Activity" SET "Description_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    END IF;
    RETURN NEW;
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnECAUpdate()
RETURNS TRIGGER AS $$
DECLARE
BEGIN
    IF(OLD."Lastname" <> NEW."Lastname") then
        UPDATE "ECA" SET "Lastname_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    ELSIF(OLD."Firstname" <> NEW."Firstname") then
        UPDATE "ECA" SET "Firstname_since" = CURRENT_DATE WHERE "Id"=NEW."Id";
    END IF;
    RETURN NEW;
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------------------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION OnProgramUpdate()
RETURNS TRIGGER AS $$
DECLARE
BEGIN
    IF(OLD."Name" <> NEW."Name") then
        UPDATE "Program" SET "Name" = CURRENT_DATE WHERE "Id"=NEW."Id";
    ELSIF(OLD."DateRange" <> NEW."DateRange") then
        UPDATE "Program" SET "DateRange" = CURRENT_DATE WHERE "Id"=NEW."Id";
    ELSIF(OLD."IsPublished" <> NEW."IsPublished") then
        UPDATE "Program" SET "IsPublished" = CURRENT_DATE WHERE "Id"=NEW."Id";
    END IF;
    RETURN NEW;
END;$$ LANGUAGE plpgsql;








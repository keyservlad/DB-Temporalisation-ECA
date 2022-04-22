CREATE SEQUENCE hierarchy_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;
CREATE SEQUENCE uo_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;

CREATE SEQUENCE activity_work_unit_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;
CREATE SEQUENCE activity_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;

CREATE SEQUENCE eca_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;

CREATE SEQUENCE program_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;
CREATE SEQUENCE prevision_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;
CREATE SEQUENCE assignment_id_seq START WITH 0 INCREMENT BY 1 MINVALUE 0 NO MAXVALUE CACHE 1;

/*------------------------------------------------------Hierarchy-----------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateHierarchy(Name varchar(50))
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "Hierarchy" VALUES (nextval('hierarchy_id_seq'), CURRENT_DATE,
                                Name,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;

/*---------------------------------------------------------UO---------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateUO(Name varchar(50),IdParent integer,IdHierarchical integer)
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "UO" VALUES (nextval('uo_id_seq'), CURRENT_DATE,
                                Name,CURRENT_DATE,
                                IdParent,CURRENT_DATE,
                                IdHierarchical,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;

/*--------------------------------------------------ActivityWorkUnit--------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateActivityWorkUnit(Name varchar(50))
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "ActivityWorkUnit" VALUES (nextval('activity_work_unit_id_seq'), CURRENT_DATE,
                                            Name,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;

/*------------------------------------------------------Activity------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateActivity(IdWorkUnit integer,Name varchar(50),Description varchar(50))
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "Activity" VALUES (nextval('activity_id_seq'), CURRENT_DATE,
                                IdWorkUnit,CURRENT_DATE,
                                Name,CURRENT_DATE,
                                Description,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;


/*---------------------------------------------------------ECA--------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateECA(FirstName varchar(50),LastName varchar(50))
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "ECA" VALUES (nextval('eca_id_seq'), CURRENT_DATE,
                                FirstName,CURRENT_DATE,
                                LastName,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;


/*------------------------------------------------------Program-------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateProgram(Name varchar(50),DateRange daterange)
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "Program" VALUES (nextval('program_id_seq'), CURRENT_DATE,
                                    Name,CURRENT_DATE,
                                    DateRange,CURRENT_DATE,
                                    FALSE,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;

/*-----------------------------------------------------Prevision------------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreatePrevision(IdProgram integer,IdUO integer,IdActivity integer,WorkQuantity integer,DateRange daterange)
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "Prevision" VALUES (nextval('prevision_id_seq'), CURRENT_DATE,
                                    IdProgram,CURRENT_DATE,
                                    IdUO,CURRENT_DATE,
                                    IdActivity,CURRENT_DATE,
                                    WorkQuantity,CURRENT_DATE,
                                    DateRange,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;

/*-----------------------------------------------------Assignment-----------------------------------------------------*/
CREATE OR REPLACE FUNCTION CreateAssignment(IdECA integer,IdProgram integer,IdUO integer,IdActivity integer,WorkQuantity integer,DateRange daterange)
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO "Assignment" VALUES (nextval('assignment_id_seq'), CURRENT_DATE,
                                    IdECA,CURRENT_DATE,
                                    IdUO,CURRENT_DATE,
                                    IdActivity,CURRENT_DATE,
                                    IdProgram,CURRENT_DATE,
                                    DateRange,CURRENT_DATE,
                                    WorkQuantity,CURRENT_DATE);
    RETURN TRUE;
END;$$ LANGUAGE plpgsql;
/*Get a list of all activities an ECA can partake in*/
CREATE OR REPLACE FUNCTION get_eca_activities(IdECA INTEGER)
RETURNS TABLE (ActivityName varchar,Description varchar,PermitName varchar,PermitValidity daterange)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
		SELECT A."Name",A."Description",P."Name",P."ValidityDaterange"
        FROM "ECA" AS ECA
                 JOIN
             "PermitECA" AS PE ON PE."IdECA" = ECA."Id"
                 JOIN
             "Permit" AS P ON P."Id" = PE."IdPermit"
                 JOIN
             "PermitActivity" AS PA ON PA."IdPermit" = PE."IdPermit"
                 JOIN
             "Activity" AS A ON A."Id" = PA."IdActivity"
        WHERE ECA."Id"=IdECA;
END;$$;



/*This is a generalized function from the previous example in queries on all hierarchical levels*/
CREATE OR REPLACE FUNCTION get_uo_previsions_by_hierarchy(IdHierarchical INTEGER)
RETURNS TABLE (Id integer,Name varchar,ActivityName varchar,WorkQuantity integer,DateRange daterange)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
		SELECT UO."Id" as Id,
               UO."Name" as Name,
               Activity."Name" as ActivityName,
               Prevision."WorkQuantity",
               Prevision."DateRange"
        FROM "Prevision" AS Prevision
                 JOIN
             "UO" AS UO ON UO."Id" = Prevision."IdUO"
                 JOIN
             "Activity" AS Activity ON Activity."Id" = Prevision."IdActivity"
        WHERE UO."IdHierarchical" = IdHierarchical
        ORDER BY UO."Id";
END;$$;




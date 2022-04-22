
/*Get all ECA with all the activities they can participate in*/
SELECT ECA."Id",
       ECA."Firstname",
       ECA."Lastname",
       array_agg(A."Name")  AS Activities
FROM "ECA" AS ECA
         JOIN
     "PermitECA" AS PE ON PE."IdECA" = ECA."Id"
         JOIN
     "PermitActivity" AS PA ON PA."IdPermit" = PE."IdPermit"
         JOIN
     "Activity" AS A ON A."Id" = PA."IdActivity"
GROUP BY ECA."Id"
ORDER BY ECA."Id";



/*Get all Departments by Establishments*/
SELECT Parent."Id",
       Parent."Name",
       array_agg(Child."Name")  AS Departments
FROM "UO" AS Child
    JOIN
    "UO" AS Parent on Parent."Id"=Child."IdParent"
WHERE Parent."IdHierarchical"=1
GROUP BY Parent."IdParent",Parent."Id"
ORDER BY Parent."IdParent";

/*Get all Departments by Regions*/
SELECT Region."Id",
       Region."Name",
       array_agg(Department."Name")  AS Departments
FROM "UO" AS Department
    JOIN
    "UO" AS Establishment on Establishment."Id"=Department."IdParent"
    JOIN
    "UO" AS Region on Region."Id"=Establishment."IdParent"
WHERE Region."IdHierarchical"=0
GROUP BY Region."IdParent", Region."Id"
ORDER BY Region."IdParent";



/*Get all activities by Departments*/
SELECT Department."Id",
       Department."Name",
       array_agg(Activity."Name")  AS Activities
FROM "UO" AS Department
         JOIN
     "UOActivity" AS UOActivity ON UOActivity."IdUO" = Department."Id"
         JOIN
     "Activity" AS Activity ON Activity."Id" = UOActivity."IdActivity"
WHERE Department."IdHierarchical"=2
GROUP BY Department."Id"
ORDER BY Department."Id";


/*Get prevision needs of all Establishments*/
/*The result of this query can be read as "The list of all establishments, in need of activity A, for a work quantity of N and on date range D" */
SELECT UO."Id" as EstablishmentId,
       UO."Name" as EstablishmentName,
       Activity."Name" as ActivityName,
       Prevision."WorkQuantity",
       Prevision."DateRange"
FROM "Prevision" AS Prevision
         JOIN
     "UO" AS UO ON UO."Id" = Prevision."IdUO"
         JOIN
     "Activity" AS Activity ON Activity."Id" = Prevision."IdActivity"
WHERE UO."IdHierarchical" = 1
ORDER BY UO."Id";

/*Get prevision needs of all Departments*/
/*The result of this query can be read as "The list of all departments, in need for an activity A, for a work quantity of N and on date range D" */
SELECT UO."Id" as EstablishmentId,
       UO."Name" as EstablishmentName,
       Activity."Name" as ActivityName,
       Prevision."WorkQuantity",
       Prevision."DateRange"
FROM "Prevision" AS Prevision
         JOIN
     "UO" AS UO ON UO."Id" = Prevision."IdUO"
         JOIN
     "Activity" AS Activity ON Activity."Id" = Prevision."IdActivity"
WHERE UO."IdHierarchical" = 2
ORDER BY UO."Id";
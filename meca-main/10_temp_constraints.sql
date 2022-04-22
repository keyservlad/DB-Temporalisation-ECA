CREATE EXTENSION IF NOT EXISTS btree_gist;


/*Since we are using daterange, there will be issues in relation to uniqueness if we update the same thing two time
  in the same day, we can solve this by having timerange but it's not offered by default in Postgres*/

/*--------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------UO---------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------UO_During-----------------------------------------------------*/
/* Redundancy */
ALTER TABLE "UO_During" ADD CONSTRAINT uo_during_redundancy
    EXCLUDE USING gist ("Id" with =, "During" with &&);

/* Circumlocution */
ALTER TABLE "UO_During" ADD CONSTRAINT uo_during_circumlocution
    EXCLUDE USING gist ("Id" with =, "During" with -|-);

/*----------------------------------------------------UO_Name_During--------------------------------------------------*/
/* Uniqueness */
ALTER TABLE "UO_Name_During" ADD CONSTRAINT uo_name_uniqueness
    EXCLUDE USING gist ("Id" with =, "During" with &&);
/* Circumlocution */
ALTER TABLE "UO_Name_During" ADD CONSTRAINT uo_name_circumlocution
    EXCLUDE USING gist ("Id" with =,"Name" with =, "During" with -|-);

/*---------------------------------------------------UO_Parent_During-------------------------------------------------*/
/* Uniqueness */
ALTER TABLE "UO_Parent_During" ADD CONSTRAINT uo_parent_uniqueness
    EXCLUDE USING gist ("Id" with =, "During" with &&);
/* Circumlocution */
ALTER TABLE "UO_Parent_During" ADD CONSTRAINT uo_parent_circumlocution
    EXCLUDE USING gist ("Id" with =,"IdParent" with =, "During" with -|-);

/*--------------------------------------------------UO_Hierarchy_During-----------------------------------------------*/
/* Uniqueness */
ALTER TABLE "UO_Hierarchy_During" ADD CONSTRAINT uo_hierarchy_uniqueness
    EXCLUDE USING gist ("Id" with =, "During" with &&);
/* Circumlocution */
ALTER TABLE "UO_Hierarchy_During" ADD CONSTRAINT uo_hierarchy_circumlocution
    EXCLUDE USING gist ("Id" with =,"IdHierarchical" with =, "During" with -|-);



/*--------------------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------UOActivity-----------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------------*/
/* Redundancy */
ALTER TABLE "UOActivity_During" ADD CONSTRAINT uo_activity_during_redundancy
    EXCLUDE USING gist ("IdUO" with =, "IdActivity" with =, "During" with &&);

/* Circumlocution */
ALTER TABLE "UOActivity_During" ADD CONSTRAINT uo_activity_during_circumlocution
    EXCLUDE USING gist ("IdUO" with =, "IdActivity" with =, "During" with -|-);


/*--------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------Prevision-----------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------------*/
/* Uniqueness */
ALTER TABLE "Prevision_During" ADD CONSTRAINT prevision_during_uniqueness
    EXCLUDE USING gist ("Id" with =, "During" with &&);
/* Circumlocution */
ALTER TABLE "Prevision_During" ADD CONSTRAINT prevision_during_circumlocution
    EXCLUDE USING gist ("Id" with =,"IdProgram" with =,"IdUO" with =,"IdActivity" with =,
                        "WorkQuantity" with =,"DateRange" with =, "During" with -|-);


/*--------------------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------Assignment-----------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------------*/
/* Uniqueness */
ALTER TABLE "Assignment_During" ADD CONSTRAINT assignment_during_uniqueness
    EXCLUDE USING gist ("Id" with =, "During" with &&);
/* Circumlocution */
ALTER TABLE "Assignment_During" ADD CONSTRAINT assignment_during_circumlocution
    EXCLUDE USING gist ("Id" with =,"IdECA" with =,"IdProgram" with =,"IdUO" with =,"IdActivity" with =,
                        "WorkQuantity" with =,"DateRange" with =, "During" with -|-);

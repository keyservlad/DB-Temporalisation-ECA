DROP TABLE IF EXISTS  "Assignment";
DROP TABLE IF EXISTS  "Assignment_During";
DROP TABLE IF EXISTS  "Prevision";
DROP TABLE IF EXISTS  "Prevision_During";

DROP TABLE IF EXISTS  "Program";

DROP TABLE IF EXISTS  "PermitActivity";
DROP TABLE IF EXISTS  "PermitECA";
DROP TABLE IF EXISTS  "Permit";

DROP TABLE IF EXISTS  "ECA";

DROP TABLE IF EXISTS  "UOActivity";
DROP TABLE IF EXISTS  "UOActivity_During";

DROP TABLE IF EXISTS  "Activity";
DROP TABLE IF EXISTS  "ActivityWorkUnit";

DROP TABLE IF EXISTS  "UO";
DROP TABLE IF EXISTS  "UO_During";
DROP TABLE IF EXISTS  "UO_Name_During";
DROP TABLE IF EXISTS  "UO_Parent_During";
DROP TABLE IF EXISTS  "UO_Hierarchy_During";
DROP TABLE IF EXISTS  "Hierarchy";

CREATE TABLE "Hierarchy" (
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"Name" varchar(50) NOT NULL,
	"Name_since" date NOT NULL
);

CREATE TABLE "UO"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"Name" varchar(50) NOT NULL,
	"Name_since" date NOT NULL,
	"IdParent" integer REFERENCES "UO"("Id"),
	"IdParent_since" date NOT NULL,
	"IdHierarchical" integer NOT NULL REFERENCES "Hierarchy"("Id"),
	"IdHierarchical_since" date NOT NULL
);

CREATE TABLE "UO_During"(
	"Id" integer NOT NULL,
	"During" daterange NOT NULL
);
CREATE TABLE "UO_Name_During"(
	"Id" integer NOT NULL,
	"Name" varchar(50) NOT NULL,
	"During" daterange NOT NULL
);
CREATE TABLE "UO_Parent_During"(
	"Id" integer NOT NULL,
	"IdParent" integer NOT NULL,
	"During" daterange NOT NULL
);
CREATE TABLE "UO_Hierarchy_During"(
	"Id" integer NOT NULL,
	"IdHierarchical" integer NOT NULL REFERENCES "Hierarchy"("Id"),
	"During" daterange NOT NULL
);


CREATE TABLE "ActivityWorkUnit"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"Name" varchar(50) NOT NULL,
	"Name_since" date NOT NULL
);

CREATE TABLE "Activity"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"IdWorkUnit" integer NOT NULL REFERENCES "ActivityWorkUnit"("Id"),
	"IdWorkUnit_since" date NOT NULL,
	"Name" varchar(50) NOT NULL,
	"Name_since" date NOT NULL,
	"Description" varchar(50) NOT NULL,
	"Description_since" date NOT NULL
);


CREATE TABLE "UOActivity"(
	"IdActivity" integer NOT NULL REFERENCES "Activity"("Id"),
	"IdUO" integer NOT NULL REFERENCES "UO"("Id"),
	"Since" date NOT NULL,
	PRIMARY KEY("IdActivity", "IdUO")
);
CREATE TABLE "UOActivity_During"(
	"IdActivity" integer NOT NULL REFERENCES "Activity"("Id"),
	"IdUO" integer NOT NULL,
	"During" daterange NOT NULL
);

CREATE TABLE "ECA"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"Lastname" varchar(50) NOT NULL,
	"Lastname_since" date NOT NULL,
	"Firstname" varchar(50) NOT NULL,
	"Firstname_since" date NOT NULL
);

CREATE TABLE "Permit"(
	"Id" integer NOT NULL PRIMARY KEY ,
	"Name"  varchar(50) NOT NULL,
	"ValidityDaterange" daterange NOT NULL
);

CREATE TABLE "PermitECA"(
	"IdPermit" integer NOT NULL REFERENCES "Permit"("Id"),
	"IdECA" integer NOT NULL REFERENCES "ECA"("Id")
);

CREATE TABLE "PermitActivity"(
	"IdPermit" integer NOT NULL REFERENCES "Permit"("Id"),
	"IdActivity" integer NOT NULL REFERENCES "Activity"("Id")
);

CREATE TABLE "Program"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"Name" varchar(50) NOT NULL,
	"Name_since" date NOT NULL,
	"DateRange" daterange NOT NULL,
	"DateRange_since" date NOT NULL,
	"IsPublished" boolean NOT NULL,
	"IsPublished_since" date NOT NULL
);

/*To specify the needs of each UO in relation to which Activity they need, for what work quantity, and the period*/
CREATE TABLE "Prevision"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"IdProgram" integer NOT NULL REFERENCES "Program"("Id"),
	"IdProgram_since" date NOT NULL,
	"IdUO" integer NOT NULL,
	"IdUO_since" date NOT NULL,
	"IdActivity" integer NOT NULL,
	"IdActivity_since" date NOT NULL,
	"WorkQuantity" integer NOT NULL,
	"WorkQuantity_since" date NOT NULL,
	"DateRange" daterange NOT NULL,
	"DateRange_since" date NOT NULL,
	FOREIGN KEY ("IdUO", "IdActivity") REFERENCES "UOActivity" ("IdUO", "IdActivity")
);
CREATE TABLE "Prevision_During"(
	"Id" integer NOT NULL,
	"IdProgram" integer NOT NULL REFERENCES "Program"("Id"),
	"IdUO" integer NOT NULL,
	"IdActivity" integer NOT NULL  REFERENCES "Activity"("Id"),
	"WorkQuantity" integer NOT NULL,
	"DateRange" daterange NOT NULL,
	"During" daterange NOT NULL
);


/*To assign ECAs to UOs*/
CREATE TABLE "Assignment"(
	"Id" integer NOT NULL PRIMARY KEY,
	"Since" date NOT NULL,
	"IdECA" integer NOT NULL REFERENCES "ECA"("Id"),
	"IdECA_since" date NOT NULL,
	"IdUO" integer NOT NULL,
	"IdUO_since" date NOT NULL,
	"IdActivity" integer NOT NULL,
	"IdActivity_since" date NOT NULL,
	"IdProgram" integer NOT NULL REFERENCES "Program"("Id"),
	"IdProgram_since" date NOT NULL,
	"DateRange" daterange NOT NULL,
	"DateRange_since" date NOT NULL,
	"WorkQuantity" integer NOT NULL,
	"WorkQuantity_since" date NOT NULL,
	FOREIGN KEY ("IdUO", "IdActivity") REFERENCES "UOActivity" ("IdUO", "IdActivity")
);

CREATE TABLE "Assignment_During"(
	"Id" integer NOT NULL,
	"IdECA" integer NOT NULL REFERENCES "ECA"("Id"),
	"IdUO" integer NOT NULL,
	"IdActivity" integer NOT NULL REFERENCES "Activity"("Id"),
	"IdProgram" integer NOT NULL REFERENCES "Program"("Id"),
	"DateRange" daterange NOT NULL,
	"WorkQuantity" integer NOT NULL,
	"During" daterange NOT NULL
);
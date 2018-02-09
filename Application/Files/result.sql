/* 
##################################################################################################
###########  INCLUDED ENTITIES:
###############  Currency
###############  Customer
##################################################################################################  

##################################################################################################  
###########  DATABASE PREPARATION
##################################################################################################
*/

IF NOT EXISTS (SELECT 1 FROM sys.schemas sc WHERE sc.name = 'dbo')
-- create the CURRENT schema
EXEC sp_executesql N'CREATE SCHEMA [dbo]';
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas sc WHERE sc.name = 'ver')
-- create the VERSION schema
EXEC sp_executesql N'CREATE SCHEMA [ver]';
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas sc WHERE sc.name = 'vex')
-- create the VERSION SETTLEMENT schema
EXEC sp_executesql N'CREATE SCHEMA [vex]';
GO

/*
##################################################################################################  
###########  ENTITY OBJECT DEFINITIONS FOR [Currency]
##################################################################################################
*/

IF OBJECT_ID(N'ver.[currency]', N'U') IS NOT NULL
  DROP TABLE ver.[currency]
;

CREATE TABLE ver.[currency] (

  -- VERSION IDENTITY KEY COLUMN
  currency_version_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, currency_uid VARCHAR(200)  NOT NULL

  -- FOREIGN REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, currency_code VARCHAR(20)  NULL
, currency_name VARCHAR(200)  NOT NULL
, currency_symbol NVARCHAR(10) NULL

  -- SOURCE COLUMNS
, source_uid VARCHAR(200) NOT NULL
, source_rev_dtm DATETIME NOT NULL
, source_rev_actor VARCHAR(200) NULL
, source_delete_ind BIT NOT NULL

  -- VERSION COLUMNS
, version_dtm DATETIME2
, version_batch_key INT

, CONSTRAINT ver_currency_pk
    PRIMARY KEY NONCLUSTERED (currency_version_key)
);
GO

CREATE CLUSTERED INDEX ver_currency_cx ON
  ver.[currency] (currency_uid);
GO

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */
IF OBJECT_ID(N'vex.[currency]', N'U') IS NOT NULL
DROP TABLE vex.[currency]
;

CREATE TABLE [vex].[currency] (
  
  -- GENERAL NOTES: Many columns are marked as nullable in order to improve load efficiency. 
  --   This is safe, assuming that loading is only handled through dedicated procs.

  -- KEY COLUMNS
  currency_version_key INT NOT NULL
, next_currency_version_key INT NULL
, currency_key INT NULL

  -- VERSION ATTRIBUTES
, version_index INT NULL
, version_current_ind BIT NULL
, version_latest_ind BIT NULL

  -- END OF RANGE COLUMNS
, end_version_dtmx DATETIME2 NULL
, end_version_batch_key INT NULL
, end_source_rev_dtmx DATETIME2 NULL

, CONSTRAINT vex_currency_pk
    PRIMARY KEY (currency_version_key)
)
;
GO

CREATE UNIQUE INDEX vex_currency_u1 ON
  vex.[currency] (currency_key)
  WHERE version_latest_ind = 1;
GO

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF OBJECT_ID(N'dbo.[currency]', N'V') IS NOT NULL
DROP VIEW dbo.[currency]
;
GO
/* ################################################################################

OBJECT: VIEW dbo.[currency]

DESCRIPTION: Exposes the current view of the version currency table,
  either latest or current version records.
  
RETURN DATASET:

  - Columns are identical to the corresponding version table.
  - The version key is retained for reference purposes.
  - Assumes that grain column in the version table is unique based on version latest/current
  - The filter "version_latest_ind = 1" is used for domain tables, whereas "version_current_ind = 1" is used for transaction tables.
  - Because this only contains latest records, the end dates have been supressed; they are always null.

NOTES:

  Content views are provided as a way of exposing the current state records
  of Version tables.  This makes it possible to query the dbo schema consistently
  without special logic being applied by the analyst.

HISTORY:

  Date        Name            Version  Description
  ---------------------------------------------------------------------------------
  2017-12-28  Jeff Kanel      1.0      Created by Centric Consulting, LLC

################################################################################
*/

CREATE VIEW dbo.[currency] AS
SELECT 

  -- KEY COLUMNS
  vx.currency_key

  -- FOREIGN REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, v.currency_code
, v.currency_name
, v.currency_symbol

  -- SOURCE COLUMNS
, v.source_uid
, v.source_rev_dtm
, v.source_rev_actor

  -- VERSION COLUMNS
, v.currency_version_key
, vx.version_index
, v.version_dtm
, vx.version_current_ind

  -- BATCH COLUMNS
, v.version_batch_key

FROM
ver.currency v
INNER JOIN vex.currency vx ON
  vx.currency_version_key = v.currency_version_key
WHERE
vx.version_latest_ind = 1
GO

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF OBJECT_ID(N'vex.[currency_settle]', N'P') IS NOT NULL
DROP PROCEDURE vex.[currency_settle]
;
GO
/* ################################################################################

OBJECT: vex.[currency_settle]

DESCRIPTION: Truncates corresponding VEX table and reloads it using settle logic.

PARAMETERS: None.

OUTPUT PARAMETERS: None.

RETURN VALUE: None.

RETURN DATASET: None.

HISTORY:

Date        Name            Version  Description
---------------------------------------------------------------------------------
2017-12-27  Jeff Kanel      1.0      Created by Centric Consulting, LLC

################################################################################ */

CREATE PROCEDURE vex.[currency_settle] AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE vex.[currency];

INSERT INTO vex.[currency] (
  currency_version_key
, next_currency_version_key
, currency_key
, version_index
, version_current_ind
, version_latest_ind
, end_version_dtmx
, end_version_batch_key
, end_source_rev_dtmx
)
SELECT

  v.currency_version_key

, LEAD(v.currency_version_key, 1) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC) AS next_currency_version_key

, MIN(v.currency_version_key) OVER (
    PARTITION BY v.currency_uid) AS currency_key

, ROW_NUMBER() OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC) AS version_index

  -- XOR "^" inverts the deleted indicator
, CASE
  WHEN LEAD(v.currency_version_key, 1) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC) IS NULL THEN 0
  ELSE LAST_VALUE(v.source_delete_ind) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) ^ 1 
  END AS version_current_ind

, CASE
  WHEN LAST_VALUE(v.currency_version_key) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) = v.currency_version_key THEN 1
  ELSE 0 END AS version_latest_ind

, LEAD(v.version_dtm, 1) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC) AS end_version_dtmx

  -- Back the LEAD batch key off by 1
, LEAD(v.version_batch_key, 1) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC) - 1 AS end_version_batch_key

, LEAD(v.source_rev_dtm, 1) OVER (
    PARTITION BY v.currency_uid
    ORDER BY v.currency_version_key ASC) AS end_source_rev_dtmx

FROM
ver.currency v

END;
GO


/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF OBJECT_ID(N'vex.[currency_settle_merge]', N'P') IS NOT NULL
DROP PROCEDURE vex.[currency_settle_merge]
;
GO
/* ################################################################################

OBJECT: vex.[currency_settle_merge]

DESCRIPTION: Performs a merge of all version records related to grain values that have been affected
  on or after the specified batch key.

PARAMETERS:

  @begin_version_batch_key INT = The minimum batch key used to determine with grain records should
    be considered in the settle.
  
OUTPUT PARAMETERS: None.
  
RETURN VALUE: None.

RETURN DATASET: None.
  
HISTORY:

  Date        Name            Version  Description
  ---------------------------------------------------------------------------------
  2017-12-27  Jeff Kanel      1.0      Created by Centric Consulting, LLC


################################################################################ */

CREATE PROCEDURE vex.[currency_settle_merge] 
  @begin_version_batch_key INT
AS
BEGIN

  SET NOCOUNT ON;

  MERGE vex.currency WITH (HOLDLOCK) AS vt

  USING (
  
    SELECT

      v.currency_version_key

    , LEAD(v.currency_version_key, 1) OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC) AS next_currency_version_key

    , MIN(v.currency_version_key) OVER (
        PARTITION BY v.currency_uid) AS currency_key

    , ROW_NUMBER() OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC) AS version_index

      -- XOR "^" inverts the deleted indicator
    , CASE
      WHEN LAST_VALUE(v.currency_version_key) OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC
        RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) = v.currency_version_key THEN v.source_delete_ind ^ 1
      ELSE 0 END AS version_current_indd

    , CASE
      WHEN LAST_VALUE(v.currency_version_key) OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC
        RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) = v.currency_version_key THEN 1
      ELSE 0 END AS version_latest_ind

    , LEAD(v.version_dtm, 1) OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC) AS end_version_dtmx

      -- Back the LEAD batch key off by 1
    , LEAD(v.version_batch_key, 1) OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC) - 1 AS end_version_batch_key

    , LEAD(v.source_rev_dtm, 1) OVER (
        PARTITION BY v.currency_uid
        ORDER BY v.currency_version_key ASC) AS end_source_rev_dtmx

    FROM
    ver.currency v
    WHERE
    EXISTS (

	    SELECT 1 FROM ver.currency vg
	    WHERE vg.version_batch_key >= @begin_version_batch_key AND
      vg.currency_uid = v.currency_uid

    )

  ) AS vs

  ON vs.currency_version_key = vt.currency_version_key 

  WHEN MATCHED
    AND COALESCE(vs.next_currency_version_key, -1) != 
      COALESCE(vt.next_currency_version_key, -1) THEN

    UPDATE SET
      next_currency_version_key = vs.next_currency_version_key
    , currency_key = vs.currency_key
    , version_index = vs.version_index
    , version_current_ind = vs.version_current_ind
    , version_latest_ind = vs.version_latest_ind
    , end_version_dtmx = vs.end_version_dtmx
    , end_version_batch_key = vs.end_version_batch_key
    , end_source_rev_dtmx = vs.end_source_rev_dtmx


  WHEN NOT MATCHED BY SOURCE
    AND EXISTS (

	    SELECT 1 FROM ver.currency vg
	    WHERE vg.version_batch_key >= @begin_version_batch_key AND
      vg.currency_uid = vt.currency_uid

    ) THEN
    
    DELETE

  WHEN NOT MATCHED BY TARGET THEN

    INSERT (
      currency_version_key
    , next_currency_version_key
    , currency_key
    , version_index
    , version_current_ind
    , version_latest_ind
    , end_version_dtmx
    , end_version_batch_key
    , end_source_rev_dtmx
    )  VALUES (
      vs.currency_version_key
    , vs.next_currency_version_key
    , vs.currency_key
    , vs.version_index
    , vs.version_current_ind
    , vs.version_latest_ind
    , vs.end_version_dtmx
    , vs.end_version_batch_key
    , vs.end_source_rev_dtmx
    )

  ;


END;
GO

  
/*
##################################################################################################  
###########  ENTITY OBJECT DEFINITIONS FOR [Customer]
##################################################################################################
*/

IF OBJECT_ID(N'ver.[customer]', N'U') IS NOT NULL
  DROP TABLE ver.[customer]
;

CREATE TABLE ver.[customer] (

  -- VERSION IDENTITY KEY COLUMN
  customer_version_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, customer_uid VARCHAR(200)  NOT NULL

  -- FOREIGN REFERENCE COLUMNS
, managing_legal_entity_uid VARCHAR(200)  NULL
, customer_type_uid VARCHAR(200)  NULL

  -- ATTRIBUTE COLUMNS
, customer_name VARCHAR(200)  NOT NULL
, customer_number VARCHAR(100)  NULL

  -- SOURCE COLUMNS
, source_uid VARCHAR(200) NOT NULL
, source_rev_dtm DATETIME NOT NULL
, source_rev_actor VARCHAR(200) NULL
, source_delete_ind BIT NOT NULL

  -- VERSION COLUMNS
, version_dtm DATETIME2
, version_batch_key INT

, CONSTRAINT ver_customer_pk
    PRIMARY KEY NONCLUSTERED (customer_version_key)
);
GO

CREATE CLUSTERED INDEX ver_customer_cx ON
  ver.[customer] (customer_uid);
GO

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */
IF OBJECT_ID(N'vex.[customer]', N'U') IS NOT NULL
DROP TABLE vex.[customer]
;

CREATE TABLE [vex].[customer] (
  
  -- GENERAL NOTES: Many columns are marked as nullable in order to improve load efficiency. 
  --   This is safe, assuming that loading is only handled through dedicated procs.

  -- KEY COLUMNS
  customer_version_key INT NOT NULL
, next_customer_version_key INT NULL
, customer_key INT NULL

  -- VERSION ATTRIBUTES
, version_index INT NULL
, version_current_ind BIT NULL
, version_latest_ind BIT NULL

  -- END OF RANGE COLUMNS
, end_version_dtmx DATETIME2 NULL
, end_version_batch_key INT NULL
, end_source_rev_dtmx DATETIME2 NULL

, CONSTRAINT vex_customer_pk
    PRIMARY KEY (customer_version_key)
)
;
GO

CREATE UNIQUE INDEX vex_customer_u1 ON
  vex.[customer] (customer_key)
  WHERE version_latest_ind = 1;
GO

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF OBJECT_ID(N'dbo.[customer]', N'V') IS NOT NULL
DROP VIEW dbo.[customer]
;
GO
/* ################################################################################

OBJECT: VIEW dbo.[customer]

DESCRIPTION: Exposes the current view of the version customer table,
  either latest or current version records.
  
RETURN DATASET:

  - Columns are identical to the corresponding version table.
  - The version key is retained for reference purposes.
  - Assumes that grain column in the version table is unique based on version latest/current
  - The filter "version_latest_ind = 1" is used for domain tables, whereas "version_current_ind = 1" is used for transaction tables.
  - Because this only contains latest records, the end dates have been supressed; they are always null.

NOTES:

  Content views are provided as a way of exposing the current state records
  of Version tables.  This makes it possible to query the dbo schema consistently
  without special logic being applied by the analyst.

HISTORY:

  Date        Name            Version  Description
  ---------------------------------------------------------------------------------
  2017-12-28  Jeff Kanel      1.0      Created by Centric Consulting, LLC

################################################################################
*/

CREATE VIEW dbo.[customer] AS
SELECT 

  -- KEY COLUMNS
  vx.customer_key

  -- FOREIGN REFERENCE COLUMNS
, v.managing_legal_entity_uid
, v.customer_type_uid

  -- ATTRIBUTE COLUMNS
, v.customer_name
, v.customer_number

  -- SOURCE COLUMNS
, v.source_uid
, v.source_rev_dtm
, v.source_rev_actor

  -- VERSION COLUMNS
, v.customer_version_key
, vx.version_index
, v.version_dtm
, vx.version_current_ind

  -- BATCH COLUMNS
, v.version_batch_key

FROM
ver.customer v
INNER JOIN vex.customer vx ON
  vx.customer_version_key = v.customer_version_key
WHERE
vx.version_latest_ind = 1
GO

/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF OBJECT_ID(N'vex.[customer_settle]', N'P') IS NOT NULL
DROP PROCEDURE vex.[customer_settle]
;
GO
/* ################################################################################

OBJECT: vex.[customer_settle]

DESCRIPTION: Truncates corresponding VEX table and reloads it using settle logic.

PARAMETERS: None.

OUTPUT PARAMETERS: None.

RETURN VALUE: None.

RETURN DATASET: None.

HISTORY:

Date        Name            Version  Description
---------------------------------------------------------------------------------
2017-12-27  Jeff Kanel      1.0      Created by Centric Consulting, LLC

################################################################################ */

CREATE PROCEDURE vex.[customer_settle] AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE vex.[customer];

INSERT INTO vex.[customer] (
  customer_version_key
, next_customer_version_key
, customer_key
, version_index
, version_current_ind
, version_latest_ind
, end_version_dtmx
, end_version_batch_key
, end_source_rev_dtmx
)
SELECT

  v.customer_version_key

, LEAD(v.customer_version_key, 1) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC) AS next_customer_version_key

, MIN(v.customer_version_key) OVER (
    PARTITION BY v.customer_uid) AS customer_key

, ROW_NUMBER() OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC) AS version_index

  -- XOR "^" inverts the deleted indicator
, CASE
  WHEN LEAD(v.customer_version_key, 1) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC) IS NULL THEN 0
  ELSE LAST_VALUE(v.source_delete_ind) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) ^ 1 
  END AS version_current_ind

, CASE
  WHEN LAST_VALUE(v.customer_version_key) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) = v.customer_version_key THEN 1
  ELSE 0 END AS version_latest_ind

, LEAD(v.version_dtm, 1) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC) AS end_version_dtmx

  -- Back the LEAD batch key off by 1
, LEAD(v.version_batch_key, 1) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC) - 1 AS end_version_batch_key

, LEAD(v.source_rev_dtm, 1) OVER (
    PARTITION BY v.customer_uid
    ORDER BY v.customer_version_key ASC) AS end_source_rev_dtmx

FROM
ver.customer v

END;
GO


/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF OBJECT_ID(N'vex.[customer_settle_merge]', N'P') IS NOT NULL
DROP PROCEDURE vex.[customer_settle_merge]
;
GO
/* ################################################################################

OBJECT: vex.[customer_settle_merge]

DESCRIPTION: Performs a merge of all version records related to grain values that have been affected
  on or after the specified batch key.

PARAMETERS:

  @begin_version_batch_key INT = The minimum batch key used to determine with grain records should
    be considered in the settle.
  
OUTPUT PARAMETERS: None.
  
RETURN VALUE: None.

RETURN DATASET: None.
  
HISTORY:

  Date        Name            Version  Description
  ---------------------------------------------------------------------------------
  2017-12-27  Jeff Kanel      1.0      Created by Centric Consulting, LLC


################################################################################ */

CREATE PROCEDURE vex.[customer_settle_merge] 
  @begin_version_batch_key INT
AS
BEGIN

  SET NOCOUNT ON;

  MERGE vex.customer WITH (HOLDLOCK) AS vt

  USING (
  
    SELECT

      v.customer_version_key

    , LEAD(v.customer_version_key, 1) OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC) AS next_customer_version_key

    , MIN(v.customer_version_key) OVER (
        PARTITION BY v.customer_uid) AS customer_key

    , ROW_NUMBER() OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC) AS version_index

      -- XOR "^" inverts the deleted indicator
    , CASE
      WHEN LAST_VALUE(v.customer_version_key) OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC
        RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) = v.customer_version_key THEN v.source_delete_ind ^ 1
      ELSE 0 END AS version_current_indd

    , CASE
      WHEN LAST_VALUE(v.customer_version_key) OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC
        RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) = v.customer_version_key THEN 1
      ELSE 0 END AS version_latest_ind

    , LEAD(v.version_dtm, 1) OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC) AS end_version_dtmx

      -- Back the LEAD batch key off by 1
    , LEAD(v.version_batch_key, 1) OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC) - 1 AS end_version_batch_key

    , LEAD(v.source_rev_dtm, 1) OVER (
        PARTITION BY v.customer_uid
        ORDER BY v.customer_version_key ASC) AS end_source_rev_dtmx

    FROM
    ver.customer v
    WHERE
    EXISTS (

	    SELECT 1 FROM ver.customer vg
	    WHERE vg.version_batch_key >= @begin_version_batch_key AND
      vg.customer_uid = v.customer_uid

    )

  ) AS vs

  ON vs.customer_version_key = vt.customer_version_key 

  WHEN MATCHED
    AND COALESCE(vs.next_customer_version_key, -1) != 
      COALESCE(vt.next_customer_version_key, -1) THEN

    UPDATE SET
      next_customer_version_key = vs.next_customer_version_key
    , customer_key = vs.customer_key
    , version_index = vs.version_index
    , version_current_ind = vs.version_current_ind
    , version_latest_ind = vs.version_latest_ind
    , end_version_dtmx = vs.end_version_dtmx
    , end_version_batch_key = vs.end_version_batch_key
    , end_source_rev_dtmx = vs.end_source_rev_dtmx


  WHEN NOT MATCHED BY SOURCE
    AND EXISTS (

	    SELECT 1 FROM ver.customer vg
	    WHERE vg.version_batch_key >= @begin_version_batch_key AND
      vg.customer_uid = vt.customer_uid

    ) THEN
    
    DELETE

  WHEN NOT MATCHED BY TARGET THEN

    INSERT (
      customer_version_key
    , next_customer_version_key
    , customer_key
    , version_index
    , version_current_ind
    , version_latest_ind
    , end_version_dtmx
    , end_version_batch_key
    , end_source_rev_dtmx
    )  VALUES (
      vs.customer_version_key
    , vs.next_customer_version_key
    , vs.customer_key
    , vs.version_index
    , vs.version_current_ind
    , vs.version_latest_ind
    , vs.end_version_dtmx
    , vs.end_version_batch_key
    , vs.end_source_rev_dtmx
    )

  ;


END;
GO

  
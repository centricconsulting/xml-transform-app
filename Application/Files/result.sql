
/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DOCUMENT INFORMATION  (123 Tables)

PROJECT: P&C Insurance Information Model
AUTHOR:  Kris Moniz & Jeff Kanel

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */


/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SUBJECT AREA: Claim (26 Tables)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */


/* ##################################################################################
TABLE: Adjuster
##################################################################################### */

CREATE TABLE dbo.[adjuster] (
  -- NAMED KEY COLUMN
  adjuster_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, adjuster_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, first_name VARCHAR(200)
, last_name VARCHAR(200)
, full_name VARCHAR(200)
, coll_full_name VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_adjuster_pk PRIMARY KEY CLUSTERED (adjuster_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.adjuster_version));

/* ##################################################################################
TABLE: Catastrophe
##################################################################################### */

CREATE TABLE dbo.[catastrophe] (
  -- NAMED KEY COLUMN
  catastrophe_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, catastrophe_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, catastrophe_code VARCHAR(20)
, catastrophe_desc VARCHAR(1000)
, legacy_catastophe_code VARCHAR(20)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_catastrophe_pk PRIMARY KEY CLUSTERED (catastrophe_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.catastrophe_version));

/* ##################################################################################
TABLE: Cause of Loss
##################################################################################### */

CREATE TABLE dbo.[cause_of_loss] (
  -- NAMED KEY COLUMN
  cause_of_loss_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, cause_of_loss_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, cause_of_loss_code VARCHAR(20)
, cause_of_loss_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_cause_of_loss_pk PRIMARY KEY CLUSTERED (cause_of_loss_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.cause_of_loss_version));

/* ##################################################################################
TABLE: Claim
##################################################################################### */

CREATE TABLE dbo.[claim] (
  -- NAMED KEY COLUMN
  claim_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, claim_number VARCHAR(200)
, report_date DATE
, loss_date DATE
, loss_desc VARCHAR(1000)
, policy_limit_amount DECIMAL(20,12)
, policy_deductible_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_pk PRIMARY KEY CLUSTERED (claim_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_version));

/* ##################################################################################
TABLE: Claim Incident
##################################################################################### */

CREATE TABLE dbo.[claim_incident] (
  -- NAMED KEY COLUMN
  claim_incident_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_incident_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, claim_status_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, claim_incident_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_incident_pk PRIMARY KEY CLUSTERED (claim_incident_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_incident_version));

/* ##################################################################################
TABLE: Claim Expense
##################################################################################### */

CREATE TABLE dbo.[claim_expense] (
  -- NAMED KEY COLUMN
  claim_expense_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_expense_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, expense_date DATE
, expense_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_expense_pk PRIMARY KEY CLUSTERED (claim_expense_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_expense_version));

/* ##################################################################################
TABLE: Claim Feature
##################################################################################### */

CREATE TABLE dbo.[claim_feature] (
  -- NAMED KEY COLUMN
  claim_feature_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_incident_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, coverage_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, subcoverage_desc VARCHAR(1000)
, claim_feature_desc VARCHAR(1000)
, limit_amount DECIMAL(20,12)
, deductible_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_feature_pk PRIMARY KEY CLUSTERED (claim_incident_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_feature_version));

/* ##################################################################################
TABLE: Claim Feature Status History
##################################################################################### */

CREATE TABLE dbo.[claim_feature_status_history] (
  -- NAMED KEY COLUMN
  claim_feature_status_history_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, status_date DATE

  -- ENTITY REFERENCE COLUMNS
, claim_feature_status_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_feature_status_history_pk PRIMARY KEY CLUSTERED (status_date)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_feature_status_history_version));

/* ##################################################################################
TABLE: Claim Payment
##################################################################################### */

CREATE TABLE dbo.[claim_payment] (
  -- NAMED KEY COLUMN
  claim_payment_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_payment_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, payment_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_payment_pk PRIMARY KEY CLUSTERED (claim_payment_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_payment_version));

/* ##################################################################################
TABLE: Claim Reserve
##################################################################################### */

CREATE TABLE dbo.[claim_reserve] (
  -- NAMED KEY COLUMN
  claim_reserve_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_reserve_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, claim_feature_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, reserve_date DATE
, reserve_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_reserve_pk PRIMARY KEY CLUSTERED (claim_reserve_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_reserve_version));

/* ##################################################################################
TABLE: Claim Reserve Type
##################################################################################### */

CREATE TABLE dbo.[claim_reserve_type] (
  -- NAMED KEY COLUMN
  claim_reserve_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_reserve_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, claim_reserve_code VARCHAR(20)
, claim_reserve_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_reserve_type_pk PRIMARY KEY CLUSTERED (claim_reserve_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_reserve_type_version));

/* ##################################################################################
TABLE: Claim Status
##################################################################################### */

CREATE TABLE dbo.[claim_status] (
  -- NAMED KEY COLUMN
  claim_status_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claim_status_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, claim_status_code VARCHAR(20)
, claim_status_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claim_status_pk PRIMARY KEY CLUSTERED (claim_status_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claim_status_version));

/* ##################################################################################
TABLE: Claimant
##################################################################################### */

CREATE TABLE dbo.[claimant] (
  -- NAMED KEY COLUMN
  claimant_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claimant_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, primary_address_uid VARCHAR(200)
, mail_address_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, first_name VARCHAR(200)
, last_name VARCHAR(200)
, full_name VARCHAR(200)
, coll_full_name VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claimant_pk PRIMARY KEY CLUSTERED (claimant_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claimant_version));

/* ##################################################################################
TABLE: Claimant Feature
##################################################################################### */

CREATE TABLE dbo.[claimant_feature] (
  -- NAMED KEY COLUMN
  claimant_feature_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claimant_feature_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, claimant_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claimant_feature_pk PRIMARY KEY CLUSTERED (claimant_feature_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claimant_feature_version));

/* ##################################################################################
TABLE: Claimant Type
##################################################################################### */

CREATE TABLE dbo.[claimant_type] (
  -- NAMED KEY COLUMN
  claimant_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, claimant_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, claimant_type_code VARCHAR(20)
, claimant_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_claimant_type_pk PRIMARY KEY CLUSTERED (claimant_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.claimant_type_version));

/* ##################################################################################
TABLE: Invoice
##################################################################################### */

CREATE TABLE dbo.[invoice] (
  -- NAMED KEY COLUMN
  invoice_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, invoice_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, invoice_number VARCHAR(200)
, provider_account_number VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_invoice_pk PRIMARY KEY CLUSTERED (invoice_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.invoice_version));

/* ##################################################################################
TABLE: Invoice Detail
##################################################################################### */

CREATE TABLE dbo.[invoice_detail] (
  -- NAMED KEY COLUMN
  invoice_detail_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, invoice_detail_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, icd10_diagnosis_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, line_desc VARCHAR(1000)
, line_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_invoice_detail_pk PRIMARY KEY CLUSTERED (invoice_detail_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.invoice_detail_version));

/* ##################################################################################
TABLE: Payee
##################################################################################### */

CREATE TABLE dbo.[payee] (
  -- NAMED KEY COLUMN
  payee_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, payee_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, first_name VARCHAR(200)
, last_name VARCHAR(200)
, full_name VARCHAR(200)
, coll_full_name VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_payee_pk PRIMARY KEY CLUSTERED (payee_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.payee_version));

/* ##################################################################################
TABLE: Payee Type
##################################################################################### */

CREATE TABLE dbo.[payee_type] (
  -- NAMED KEY COLUMN
  payee_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, payee_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, payee_type_code VARCHAR(20)
, payee_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_payee_type_pk PRIMARY KEY CLUSTERED (payee_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.payee_type_version));

/* ##################################################################################
TABLE: Invoice Claim Payment
##################################################################################### */

CREATE TABLE dbo.[invoice_claim_payment] (
  -- NAMED KEY COLUMN
  invoice_claim_payment_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, invoice_claim_payment_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, invoice_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_invoice_claim_payment_pk PRIMARY KEY CLUSTERED (invoice_claim_payment_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.invoice_claim_payment_version));

/* ##################################################################################
TABLE: Payment Type
##################################################################################### */

CREATE TABLE dbo.[payment_type] (
  -- NAMED KEY COLUMN
  payment_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, payment_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, payment_type_code VARCHAR(20)
, payment_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_payment_type_pk PRIMARY KEY CLUSTERED (payment_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.payment_type_version));

/* ##################################################################################
TABLE: Recovery
##################################################################################### */

CREATE TABLE dbo.[recovery] (
  -- NAMED KEY COLUMN
  recovery_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, recovery_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, claim_feature_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, financial_date DATE
, recovery_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_recovery_pk PRIMARY KEY CLUSTERED (recovery_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.recovery_version));

/* ##################################################################################
TABLE: Salvage
##################################################################################### */

CREATE TABLE dbo.[salvage] (
  -- NAMED KEY COLUMN
  salvage_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, salvage_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, property_desc VARCHAR(1000)
, salvage_date DATE
, salvage_amount DECIMAL(20,12)
, award_date DATE
, financial_date DATE

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_salvage_pk PRIMARY KEY CLUSTERED (salvage_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.salvage_version));

/* ##################################################################################
TABLE: Subrogation
##################################################################################### */

CREATE TABLE dbo.[subrogation] (
  -- NAMED KEY COLUMN
  subrogation_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, subrogation_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, subrogated_party_desc VARCHAR(1000)
, award_date DATE
, financial_date DATE
, subrogation_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_subrogation_pk PRIMARY KEY CLUSTERED (subrogation_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.subrogation_version));

/* ##################################################################################
TABLE: Vendor
##################################################################################### */

CREATE TABLE dbo.[vendor] (
  -- NAMED KEY COLUMN
  vendor_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, vendor_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, vendor_number VARCHAR(200)
, vendor_name VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_vendor_pk PRIMARY KEY CLUSTERED (vendor_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.vendor_version));

/* ##################################################################################
TABLE: Vendor Type
##################################################################################### */

CREATE TABLE dbo.[vendor_type] (
  -- NAMED KEY COLUMN
  vendor_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, vendor_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, vendor_type_code VARCHAR(20)
, vendor_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_vendor_type_pk PRIMARY KEY CLUSTERED (vendor_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.vendor_type_version));

/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SUBJECT AREA: Billing (27 Tables)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */


/* ##################################################################################
TABLE: Bill Policy
##################################################################################### */

CREATE TABLE dbo.[bill_policy] (
  -- NAMED KEY COLUMN
  bill_policy_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_policy_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_policy_pk PRIMARY KEY CLUSTERED (bill_policy_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_policy_version));

/* ##################################################################################
TABLE: Bill Party
##################################################################################### */

CREATE TABLE dbo.[bill_party] (
  -- NAMED KEY COLUMN
  bill_party_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_party_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_party_pk PRIMARY KEY CLUSTERED (bill_party_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_party_version));

/* ##################################################################################
TABLE: Bill Policy Party
##################################################################################### */

CREATE TABLE dbo.[bill_policy_party] (
  -- NAMED KEY COLUMN
  bill_policy_party_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_policy_party_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_policy_party_pk PRIMARY KEY CLUSTERED (bill_policy_party_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_policy_party_version));

/* ##################################################################################
TABLE: Party Role
##################################################################################### */

CREATE TABLE dbo.[party_role] (
  -- NAMED KEY COLUMN
  party_role_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, party_role_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_party_role_pk PRIMARY KEY CLUSTERED (party_role_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.party_role_version));

/* ##################################################################################
TABLE: Bill Account
##################################################################################### */

CREATE TABLE dbo.[bill_account] (
  -- NAMED KEY COLUMN
  bill_account_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_account_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_account_pk PRIMARY KEY CLUSTERED (bill_account_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_account_version));

/* ##################################################################################
TABLE: Bill Transaction
##################################################################################### */

CREATE TABLE dbo.[bill_tran] (
  -- NAMED KEY COLUMN
  bill_tran_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_tran_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_tran_pk PRIMARY KEY CLUSTERED (bill_tran_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_tran_version));

/* ##################################################################################
TABLE: Bill Policy Location
##################################################################################### */

CREATE TABLE dbo.[bill_policy_location] (
  -- NAMED KEY COLUMN
  bill_policy_location_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_policy_location_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_policy_location_pk PRIMARY KEY CLUSTERED (bill_policy_location_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_policy_location_version));

/* ##################################################################################
TABLE: Bill Broker
##################################################################################### */

CREATE TABLE dbo.[bill_broker] (
  -- NAMED KEY COLUMN
  bill_broker_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_broker_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_broker_pk PRIMARY KEY CLUSTERED (bill_broker_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_broker_version));

/* ##################################################################################
TABLE: Bill Policy Broker
##################################################################################### */

CREATE TABLE dbo.[bill_policy_broker] (
  -- NAMED KEY COLUMN
  bill_policy_broker_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_policy_broker_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_policy_broker_pk PRIMARY KEY CLUSTERED (bill_policy_broker_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_policy_broker_version));

/* ##################################################################################
TABLE: Bill Schedule Header
##################################################################################### */

CREATE TABLE dbo.[bill_schedule_header] (
  -- NAMED KEY COLUMN
  bill_schedule_header_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_schedule_header_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_schedule_header_pk PRIMARY KEY CLUSTERED (bill_schedule_header_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_schedule_header_version));

/* ##################################################################################
TABLE: Bill Schedule Detail
##################################################################################### */

CREATE TABLE dbo.[bill_schedule_detail] (
  -- NAMED KEY COLUMN
  bill_schedule_detail_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_schedule_detail_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_schedule_detail_pk PRIMARY KEY CLUSTERED (bill_schedule_detail_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_schedule_detail_version));

/* ##################################################################################
TABLE: Bill Payment Header
##################################################################################### */

CREATE TABLE dbo.[bill_payment_header] (
  -- NAMED KEY COLUMN
  bill_payment_header_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_payment_header_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_payment_header_pk PRIMARY KEY CLUSTERED (bill_payment_header_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_payment_header_version));

/* ##################################################################################
TABLE: Bill Payment Detail
##################################################################################### */

CREATE TABLE dbo.[bill_payment_detail] (
  -- NAMED KEY COLUMN
  bill_payment_detail_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_payment_detail_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_payment_detail_pk PRIMARY KEY CLUSTERED (bill_payment_detail_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_payment_detail_version));

/* ##################################################################################
TABLE: Bill Received Allocation
##################################################################################### */

CREATE TABLE dbo.[bill_received_allocation] (
  -- NAMED KEY COLUMN
  bill_received_allocation_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_received_allocation_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_received_allocation_pk PRIMARY KEY CLUSTERED (bill_received_allocation_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_received_allocation_version));

/* ##################################################################################
TABLE: Bill Invoice Header
##################################################################################### */

CREATE TABLE dbo.[bill_invoice_header] (
  -- NAMED KEY COLUMN
  bill_invoice_header_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_invoice_header_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_invoice_header_pk PRIMARY KEY CLUSTERED (bill_invoice_header_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_invoice_header_version));

/* ##################################################################################
TABLE: Bill Invoice Detail
##################################################################################### */

CREATE TABLE dbo.[bill_invoice_detail] (
  -- NAMED KEY COLUMN
  bill_invoice_detail_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_invoice_detail_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, bill_invoice_header_uid VARCHAR(200)
, bill_schedule_header_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_invoice_detail_pk PRIMARY KEY CLUSTERED (bill_invoice_detail_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_invoice_detail_version));

/* ##################################################################################
TABLE: Bill Promise to Pay
##################################################################################### */

CREATE TABLE dbo.[bill_promise_to_pay] (
  -- NAMED KEY COLUMN
  bill_promise_to_pay_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_promise_to_pay_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_promise_to_pay_pk PRIMARY KEY CLUSTERED (bill_promise_to_pay_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_promise_to_pay_version));

/* ##################################################################################
TABLE: Bill Promise to Pay Allocation
##################################################################################### */

CREATE TABLE dbo.[bill_promise_to_pay_allocation] (
  -- NAMED KEY COLUMN
  bill_promise_to_pay_allocation_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_promise_to_pay_allocation_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_promise_to_pay_allocation_pk PRIMARY KEY CLUSTERED (bill_promise_to_pay_allocation_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_promise_to_pay_allocation_version));

/* ##################################################################################
TABLE: Bill Schedule Discrepancy
##################################################################################### */

CREATE TABLE dbo.[bill_schedule_discrepancy] (
  -- NAMED KEY COLUMN
  bill_schedule_discrepancy_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_schedule_discrepancy_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_schedule_discrepancy_pk PRIMARY KEY CLUSTERED (bill_schedule_discrepancy_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_schedule_discrepancy_version));

/* ##################################################################################
TABLE: Bill Overpayment Discrepancy
##################################################################################### */

CREATE TABLE dbo.[bill_overpayment_discrepancy] (
  -- NAMED KEY COLUMN
  bill_overpayment_discrepancy_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_overpayment_discrepancy_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_overpayment_discrepancy_pk PRIMARY KEY CLUSTERED (bill_overpayment_discrepancy_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_overpayment_discrepancy_version));

/* ##################################################################################
TABLE: Bill Retained Commission
##################################################################################### */

CREATE TABLE dbo.[bill_retained_commission] (
  -- NAMED KEY COLUMN
  bill_retained_commission_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_retained_commission_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_retained_commission_pk PRIMARY KEY CLUSTERED (bill_retained_commission_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_retained_commission_version));

/* ##################################################################################
TABLE: Bill Commsion Earned
##################################################################################### */

CREATE TABLE dbo.[bill_commsion_earned] (
  -- NAMED KEY COLUMN
  bill_commsion_earned_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_commsion_earned_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_commsion_earned_pk PRIMARY KEY CLUSTERED (bill_commsion_earned_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_commsion_earned_version));

/* ##################################################################################
TABLE: Bill Commission Paid
##################################################################################### */

CREATE TABLE dbo.[bill_commission_paid] (
  -- NAMED KEY COLUMN
  bill_commission_paid_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_commission_paid_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_commission_paid_pk PRIMARY KEY CLUSTERED (bill_commission_paid_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_commission_paid_version));

/* ##################################################################################
TABLE: Bill Commission Statement
##################################################################################### */

CREATE TABLE dbo.[bill_commission_statement] (
  -- NAMED KEY COLUMN
  bill_commission_statement_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_commission_statement_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, bill_broker_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_commission_statement_pk PRIMARY KEY CLUSTERED (bill_commission_statement_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_commission_statement_version));

/* ##################################################################################
TABLE: Bill Broker Allocation Request
##################################################################################### */

CREATE TABLE dbo.[bill_broker_allocation_request] (
  -- NAMED KEY COLUMN
  bill_broker_allocation_request_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_broker_allocation_request_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_broker_allocation_request_pk PRIMARY KEY CLUSTERED (bill_broker_allocation_request_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_broker_allocation_request_version));

/* ##################################################################################
TABLE: Bill Broker Allocation Request Detail
##################################################################################### */

CREATE TABLE dbo.[bill_broker_allocation_request_detail] (
  -- NAMED KEY COLUMN
  bill_broker_allocation_request_detail_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_broker_allocation_request_detail_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_broker_allocation_request_detail_pk PRIMARY KEY CLUSTERED (bill_broker_allocation_request_detail_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_broker_allocation_request_detail_version));

/* ##################################################################################
TABLE: Bill Policy Transaction
##################################################################################### */

CREATE TABLE dbo.[bill_policy_tran] (
  -- NAMED KEY COLUMN
  bill_policy_tran_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, bill_policy_tran_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_bill_policy_tran_pk PRIMARY KEY CLUSTERED (bill_policy_tran_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.bill_policy_tran_version));

/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SUBJECT AREA: Policy (34 Tables)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */


/* ##################################################################################
TABLE: Auto Risk
##################################################################################### */

CREATE TABLE dbo.[auto_risk] (
  -- NAMED KEY COLUMN
  auto_risk_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, risk_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, vehicle_class_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, make_desc VARCHAR(1000)
, model_desc VARCHAR(1000)
, manufacture_year_value INT

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_auto_risk_pk PRIMARY KEY CLUSTERED (risk_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.auto_risk_version));

/* ##################################################################################
TABLE: Driver
##################################################################################### */

CREATE TABLE dbo.[driver] (
  -- NAMED KEY COLUMN
  driver_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, driver_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_tran_uid VARCHAR(200)
, license_state_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, first_name VARCHAR(200)
, middle_name VARCHAR(200)
, last_name VARCHAR(200)
, license_number VARCHAR(200)
, license_status_desc VARCHAR(1000)
, mvr_pull_ind BIT
, mvr_pull_date DATE
, full_name VARCHAR(200)
, coll_full_name VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_driver_pk PRIMARY KEY CLUSTERED (driver_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.driver_version));

/* ##################################################################################
TABLE: Coverage Location Risk
##################################################################################### */

CREATE TABLE dbo.[coverage_location_risk] (
  -- NAMED KEY COLUMN
  coverage_location_risk_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, coverage_uid VARCHAR(200)
, location_uid VARCHAR(200)
, risk_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, schedule_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_coverage_location_risk_pk PRIMARY KEY CLUSTERED (coverage_uid, location_uid, risk_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.coverage_location_risk_version));

/* ##################################################################################
TABLE: Location
##################################################################################### */

CREATE TABLE dbo.[location] (
  -- NAMED KEY COLUMN
  location_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, location_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_tran_uid VARCHAR(200)
, physical_address_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, location_identifier VARCHAR(200)
, location_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_location_pk PRIMARY KEY CLUSTERED (location_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.location_version));

/* ##################################################################################
TABLE: Named Insured
##################################################################################### */

CREATE TABLE dbo.[named_insured] (
  -- NAMED KEY COLUMN
  named_insured_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, named_insured_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_uid VARCHAR(200)
, policy_tran_uid VARCHAR(200)
, named_insured_type_uid VARCHAR(200)
, mail_address_uid VARCHAR(200)
, bill_address_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, first_name VARCHAR(200)
, middle_name VARCHAR(200)
, last_name VARCHAR(200)
, coll_full_name VARCHAR(200)
, bill_name VARCHAR(200)
, current_active_indicator_flag VARCHAR(20)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_named_insured_pk PRIMARY KEY CLUSTERED (named_insured_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.named_insured_version));

/* ##################################################################################
TABLE: Policy
##################################################################################### */

CREATE TABLE dbo.[policy] (
  -- NAMED KEY COLUMN
  policy_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, current_policy_status_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, policy_number VARCHAR(200)
, legacy_policy_number VARCHAR(200)
, policy_form_code VARCHAR(20)
, initial_quote_date DATE
, new_business_effect_date DATE
, current_in_force_ind BIT

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_pk PRIMARY KEY CLUSTERED (policy_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_version));

/* ##################################################################################
TABLE: Policy Term
##################################################################################### */

CREATE TABLE dbo.[policy_term] (
  -- NAMED KEY COLUMN
  policy_term_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_uid VARCHAR(200)
, policy_term_index INT

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, effect_date DATE
, expire_date DATE
, policy_end_date DATE
, in_force_ind BIT

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_term_pk PRIMARY KEY CLUSTERED (policy_uid, policy_term_index)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_term_version));

/* ##################################################################################
TABLE: Policy Transaction
##################################################################################### */

CREATE TABLE dbo.[policy_tran] (
  -- NAMED KEY COLUMN
  policy_tran_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_uid VARCHAR(200)
, agency_uid VARCHAR(200)
, producer_uid VARCHAR(200)
, tran_status_uid VARCHAR(200)
, policy_tran_type_uid VARCHAR(200)
, policy_tran_reason_uid VARCHAR(200)
, policy_tran_source_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, effect_date DATE
, expire_date DATE
, start_date DATE
, last_update_date DATE
, process_date DATE
, accounting_date DATE
, written_prem_amount DECIMAL(20,12)
, written_prem_tax_fee_amount DECIMAL(20,12)
, full_term_prem_amount DECIMAL(20,12)
, full_term_prem_tax_fee_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_pk PRIMARY KEY CLUSTERED (policy_tran_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_version));

/* ##################################################################################
TABLE: Property Risk
##################################################################################### */

CREATE TABLE dbo.[property_risk] (
  -- NAMED KEY COLUMN
  property_risk_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, risk_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, building_identifier VARCHAR(200)
, construction_type_desc VARCHAR(1000)
, square_footage_value FLOAT
, roof_type_desc VARCHAR(1000)
, construction_year_value FLOAT
, story_count INT
, actual_property_value_amount DECIMAL(20,12)
, replacement_cost_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_property_risk_pk PRIMARY KEY CLUSTERED (risk_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.property_risk_version));

/* ##################################################################################
TABLE: Risk
##################################################################################### */

CREATE TABLE dbo.[risk] (
  -- NAMED KEY COLUMN
  risk_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, risk_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_tran_uid VARCHAR(200)
, location_uid VARCHAR(200)
, risk_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, full_term_prem_amount DECIMAL(20,12)
, risk_identifier VARCHAR(200)
, displayed_risk_identifier VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_risk_pk PRIMARY KEY CLUSTERED (risk_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.risk_version));

/* ##################################################################################
TABLE: Schedule
##################################################################################### */

CREATE TABLE dbo.[schedule] (
  -- NAMED KEY COLUMN
  schedule_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, schedule_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, schedule_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_schedule_pk PRIMARY KEY CLUSTERED (schedule_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.schedule_version));

/* ##################################################################################
TABLE: Policy Transaction Detail
##################################################################################### */

CREATE TABLE dbo.[policy_tran_detail] (
  -- NAMED KEY COLUMN
  policy_tran_detail_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_detail_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_uid VARCHAR(200)
, policy_tran_uid VARCHAR(200)
, coverage_uid VARCHAR(200)
, limit_uid VARCHAR(200)
, deductible_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, manual_deductible_amount DECIMAL(20,12)
, manual_limit_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_detail_pk PRIMARY KEY CLUSTERED (policy_tran_detail_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_detail_version));

/* ##################################################################################
TABLE: Deductible
##################################################################################### */

CREATE TABLE dbo.[deductible] (
  -- NAMED KEY COLUMN
  deductible_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, deductible_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, deductible_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, deductible_desc VARCHAR(1000)
, deductible_amount DECIMAL(20,12)
, deductible_rate DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_deductible_pk PRIMARY KEY CLUSTERED (deductible_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.deductible_version));

/* ##################################################################################
TABLE: Limit
##################################################################################### */

CREATE TABLE dbo.[limit] (
  -- NAMED KEY COLUMN
  limit_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, limit_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, limit_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, limit_desc VARCHAR(1000)
, limit_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_limit_pk PRIMARY KEY CLUSTERED (limit_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.limit_version));

/* ##################################################################################
TABLE: Policy Transaction Detail Premium
##################################################################################### */

CREATE TABLE dbo.[policy_tran_detail_prem] (
  -- NAMED KEY COLUMN
  policy_tran_detail_prem_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_detail_prem_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, policy_uid VARCHAR(200)
, policy_tran_uid VARCHAR(200)
, tran_detail_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, written_prem_amount DECIMAL(20,12)
, full_term_prem_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_detail_prem_pk PRIMARY KEY CLUSTERED (policy_tran_detail_prem_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_detail_prem_version));

/* ##################################################################################
TABLE: Driver Risk
##################################################################################### */

CREATE TABLE dbo.[driver_risk] (
  -- NAMED KEY COLUMN
  driver_risk_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, driver_uid VARCHAR(200)
, risk_uid VARCHAR(200)
, driver_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_driver_risk_pk PRIMARY KEY CLUSTERED (driver_uid, risk_uid, driver_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.driver_risk_version));

/* ##################################################################################
TABLE: Workers Compensation Risk
##################################################################################### */

CREATE TABLE dbo.[wc_risk] (
  -- NAMED KEY COLUMN
  wc_risk_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, risk_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, ncci_class_uid VARCHAR(200)
, state_class_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, annual_payroll_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_wc_risk_pk PRIMARY KEY CLUSTERED (risk_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.wc_risk_version));

/* ##################################################################################
TABLE: Vehicle Classification
##################################################################################### */

CREATE TABLE dbo.[vehicle_class] (
  -- NAMED KEY COLUMN
  vehicle_class_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, vehicle_class_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, vehicle_class_code VARCHAR(20)
, vehicle_class_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_vehicle_class_pk PRIMARY KEY CLUSTERED (vehicle_class_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.vehicle_class_version));

/* ##################################################################################
TABLE: Driver Type
##################################################################################### */

CREATE TABLE dbo.[driver_type] (
  -- NAMED KEY COLUMN
  driver_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, driver_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, driver_type_code VARCHAR(20)
, driver_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_driver_type_pk PRIMARY KEY CLUSTERED (driver_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.driver_type_version));

/* ##################################################################################
TABLE: Policy Transaction Type
##################################################################################### */

CREATE TABLE dbo.[policy_tran_type] (
  -- NAMED KEY COLUMN
  policy_tran_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, policy_tran_type_code VARCHAR(20)
, policy_tran_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_type_pk PRIMARY KEY CLUSTERED (policy_tran_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_type_version));

/* ##################################################################################
TABLE: Policy Transaction Status
##################################################################################### */

CREATE TABLE dbo.[policy_tran_status] (
  -- NAMED KEY COLUMN
  policy_tran_status_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_status_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, policy_tran_status_code VARCHAR(20)
, policy_tran_status_desc VARCHAR(1000)
, complete_ind BIT

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_status_pk PRIMARY KEY CLUSTERED (policy_tran_status_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_status_version));

/* ##################################################################################
TABLE: Policy Transaction Reason
##################################################################################### */

CREATE TABLE dbo.[policy_tran_reason] (
  -- NAMED KEY COLUMN
  policy_tran_reason_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_reason_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, policy_tran_reason_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_reason_pk PRIMARY KEY CLUSTERED (policy_tran_reason_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_reason_version));

/* ##################################################################################
TABLE: Risk Type
##################################################################################### */

CREATE TABLE dbo.[risk_type] (
  -- NAMED KEY COLUMN
  risk_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, risk_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, risk_type_code VARCHAR(20)
, risk_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_risk_type_pk PRIMARY KEY CLUSTERED (risk_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.risk_type_version));

/* ##################################################################################
TABLE: Producer Assignment
##################################################################################### */

CREATE TABLE dbo.[producer_assignment] (
  -- NAMED KEY COLUMN
  producer_assignment_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, agency_uid VARCHAR(200)
, producer_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_producer_assignment_pk PRIMARY KEY CLUSTERED (agency_uid, producer_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.producer_assignment_version));

/* ##################################################################################
TABLE: Producer
##################################################################################### */

CREATE TABLE dbo.[producer] (
  -- NAMED KEY COLUMN
  producer_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, producer_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, primary_address_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, producer_code VARCHAR(20)
, producer_desc VARCHAR(1000)
, first_name VARCHAR(200)
, last_name VARCHAR(200)
, business_phone_number VARCHAR(200)
, spouse_phone_number VARCHAR(200)
, business_email_address VARCHAR(200)
, home_email_address VARCHAR(200)
, coll_full_name VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_producer_pk PRIMARY KEY CLUSTERED (producer_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.producer_version));

/* ##################################################################################
TABLE: Policy Status
##################################################################################### */

CREATE TABLE dbo.[policy_status] (
  -- NAMED KEY COLUMN
  policy_status_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_status_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, policy_status_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_status_pk PRIMARY KEY CLUSTERED (policy_status_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_status_version));

/* ##################################################################################
TABLE: Named Insured Type
##################################################################################### */

CREATE TABLE dbo.[named_insured_type] (
  -- NAMED KEY COLUMN
  named_insured_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, named_insured_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, named_insured_type_code VARCHAR(20)
, named_insured_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_named_insured_type_pk PRIMARY KEY CLUSTERED (named_insured_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.named_insured_type_version));

/* ##################################################################################
TABLE: Limit Type
##################################################################################### */

CREATE TABLE dbo.[limit_type] (
  -- NAMED KEY COLUMN
  limit_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, limit_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, limit_type_code VARCHAR(20)
, limit_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_limit_type_pk PRIMARY KEY CLUSTERED (limit_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.limit_type_version));

/* ##################################################################################
TABLE: License
##################################################################################### */

CREATE TABLE dbo.[license] (
  -- NAMED KEY COLUMN
  license_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, license_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, agency_uid VARCHAR(200)
, producer_uid VARCHAR(200)
, license_state_uid VARCHAR(200)
, lob_uid VARCHAR(200)
, license_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, effect_date DATE
, expire_date DATE
, license_number VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_license_pk PRIMARY KEY CLUSTERED (license_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.license_version));

/* ##################################################################################
TABLE: License Type
##################################################################################### */

CREATE TABLE dbo.[license_type] (
  -- NAMED KEY COLUMN
  license_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, license_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, license_type_code VARCHAR(20)
, license_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_license_type_pk PRIMARY KEY CLUSTERED (license_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.license_type_version));

/* ##################################################################################
TABLE: Company
##################################################################################### */

CREATE TABLE dbo.[company] (
  -- NAMED KEY COLUMN
  company_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, company_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, corp_hq_state_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, company_code VARCHAR(20)
, company_name VARCHAR(200)
, am_best_number VARCHAR(200)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_company_pk PRIMARY KEY CLUSTERED (company_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.company_version));

/* ##################################################################################
TABLE: Agency
##################################################################################### */

CREATE TABLE dbo.[agency] (
  -- NAMED KEY COLUMN
  agency_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, agency_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, primary_address_uid VARCHAR(200)
, mail_address_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, agency_code VARCHAR(20)
, agency_name VARCHAR(200)
, agency_group_name VARCHAR(200)
, phone_number VARCHAR(200)
, fax_number VARCHAR(200)
, primary_email_address VARCHAR(200)
, appointment_date DATE
, termination_date DATE

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_agency_pk PRIMARY KEY CLUSTERED (agency_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.agency_version));

/* ##################################################################################
TABLE: Deductible Type
##################################################################################### */

CREATE TABLE dbo.[deductible_type] (
  -- NAMED KEY COLUMN
  deductible_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, deductible_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, deductible_type_code VARCHAR(20)
, deductible_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_deductible_type_pk PRIMARY KEY CLUSTERED (deductible_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.deductible_type_version));

/* ##################################################################################
TABLE: Policy Transaction Source
##################################################################################### */

CREATE TABLE dbo.[policy_tran_source] (
  -- NAMED KEY COLUMN
  policy_tran_source_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, policy_tran_source_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, policty_tran_source_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_policy_tran_source_pk PRIMARY KEY CLUSTERED (policy_tran_source_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.policy_tran_source_version));

/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SUBJECT AREA: Quote (6 Tables)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */


/* ##################################################################################
TABLE: Quote Channel
##################################################################################### */

CREATE TABLE dbo.[quote_channel] (
  -- NAMED KEY COLUMN
  quote_channel_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, quote_channel_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, quote_channel_code VARCHAR(20)
, quote_channel_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_quote_channel_pk PRIMARY KEY CLUSTERED (quote_channel_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.quote_channel_version));

/* ##################################################################################
TABLE: Submission
##################################################################################### */

CREATE TABLE dbo.[submission] (
  -- NAMED KEY COLUMN
  submission_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, submission_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, submission_desc VARCHAR(1000)
, submission_date DATE
, response_due_date DATE
, effect_date DATE

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_submission_pk PRIMARY KEY CLUSTERED (submission_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.submission_version));

/* ##################################################################################
TABLE: Marketing Campaign
##################################################################################### */

CREATE TABLE dbo.[marketing_campaign] (
  -- NAMED KEY COLUMN
  marketing_campaign_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, marketing_campaign_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, marketing_campaign_desc VARCHAR(1000)
, market_desc VARCHAR(1000)
, begin_campaign_date DATE
, end_campaign_date DATE

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_marketing_campaign_pk PRIMARY KEY CLUSTERED (marketing_campaign_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.marketing_campaign_version));

/* ##################################################################################
TABLE: Marketing Channel
##################################################################################### */

CREATE TABLE dbo.[marketing_channel] (
  -- NAMED KEY COLUMN
  marketing_channel_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, marketing_channel_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, marketing_channel_desc_code VARCHAR(20)
, marketing_channel_code_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_marketing_channel_pk PRIMARY KEY CLUSTERED (marketing_channel_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.marketing_channel_version));

/* ##################################################################################
TABLE: Quote Status
##################################################################################### */

CREATE TABLE dbo.[quote_status] (
  -- NAMED KEY COLUMN
  quote_status_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, quote_status_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, quote_status_code VARCHAR(20)
, quote_status_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_quote_status_pk PRIMARY KEY CLUSTERED (quote_status_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.quote_status_version));

/* ##################################################################################
TABLE: Quote
##################################################################################### */

CREATE TABLE dbo.[quote] (
  -- NAMED KEY COLUMN
  quote_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, quote_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, quote_date DATE
, quote_prem_amount DECIMAL(20,12)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_quote_pk PRIMARY KEY CLUSTERED (quote_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.quote_version));

/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SUBJECT AREA: Reference Data (11 Tables)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */


/* ##################################################################################
TABLE: Address
##################################################################################### */

CREATE TABLE dbo.[address] (
  -- NAMED KEY COLUMN
  address_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, address_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, state_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, address_desc VARCHAR(1000)
, delivery_line_01_desc VARCHAR(1000)
, delivery_line_02_desc VARCHAR(1000)
, delivery_line_03_desc VARCHAR(1000)
, city_name VARCHAR(200)
, postal_code VARCHAR(20)
, plus4_postal_code VARCHAR(20)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_address_pk PRIMARY KEY CLUSTERED (address_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.address_version));

/* ##################################################################################
TABLE: Coverage
##################################################################################### */

CREATE TABLE dbo.[coverage] (
  -- NAMED KEY COLUMN
  coverage_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, coverage_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, lob_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, coverage_code VARCHAR(20)
, coverage_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_coverage_pk PRIMARY KEY CLUSTERED (coverage_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.coverage_version));

/* ##################################################################################
TABLE: ICD10 Diagnosis
##################################################################################### */

CREATE TABLE dbo.[icd10_diagnosis] (
  -- NAMED KEY COLUMN
  icd10_diagnosis_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, icd10_diagnosis_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, icd10_diagnosis_code VARCHAR(20)
, icd10_diagnosis_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_icd10_diagnosis_pk PRIMARY KEY CLUSTERED (icd10_diagnosis_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.icd10_diagnosis_version));

/* ##################################################################################
TABLE: LOB
##################################################################################### */

CREATE TABLE dbo.[lob] (
  -- NAMED KEY COLUMN
  lob_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, lob_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, lob_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, lob_code VARCHAR(20)
, lob_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_lob_pk PRIMARY KEY CLUSTERED (lob_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.lob_version));

/* ##################################################################################
TABLE: LOB Type
##################################################################################### */

CREATE TABLE dbo.[lob_type] (
  -- NAMED KEY COLUMN
  lob_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, lob_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, lob_type_code VARCHAR(20)
, lob_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_lob_type_pk PRIMARY KEY CLUSTERED (lob_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.lob_type_version));

/* ##################################################################################
TABLE: NCCI Classification
##################################################################################### */

CREATE TABLE dbo.[ncci_class] (
  -- NAMED KEY COLUMN
  ncci_class_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, ncci_class_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, ncci_class_code VARCHAR(20)
, ncci_class_desc VARCHAR(1000)
, ncci_class_category_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_ncci_class_pk PRIMARY KEY CLUSTERED (ncci_class_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.ncci_class_version));

/* ##################################################################################
TABLE: Product
##################################################################################### */

CREATE TABLE dbo.[product] (
  -- NAMED KEY COLUMN
  product_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, product_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, lob_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, product_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_product_pk PRIMARY KEY CLUSTERED (product_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.product_version));

/* ##################################################################################
TABLE: State
##################################################################################### */

CREATE TABLE dbo.[state] (
  -- NAMED KEY COLUMN
  state_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, state_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, state_code VARCHAR(20)
, state_name VARCHAR(200)
, iso_state_code VARCHAR(20)
, ncci_state_code VARCHAR(20)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_state_pk PRIMARY KEY CLUSTERED (state_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.state_version));

/* ##################################################################################
TABLE: State Classification
##################################################################################### */

CREATE TABLE dbo.[state_class] (
  -- NAMED KEY COLUMN
  state_class_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, state_class_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, state_class_code VARCHAR(20)
, state_class_desc VARCHAR(1000)
, state_class_category_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_state_class_pk PRIMARY KEY CLUSTERED (state_class_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.state_class_version));

/* ##################################################################################
TABLE: User
##################################################################################### */

CREATE TABLE dbo.[user] (
  -- NAMED KEY COLUMN
  user_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, user_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS
, user_type_uid VARCHAR(200)

  -- ATTRIBUTE COLUMNS
, login_name VARCHAR(200)
, user_desc VARCHAR(1000)
, email_address_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_user_pk PRIMARY KEY CLUSTERED (user_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.user_version));

/* ##################################################################################
TABLE: User Type
##################################################################################### */

CREATE TABLE dbo.[user_type] (
  -- NAMED KEY COLUMN
  user_type_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS
, user_type_uid VARCHAR(200)

  -- ENTITY REFERENCE COLUMNS

  -- ATTRIBUTE COLUMNS
, user_type_desc VARCHAR(1000)

/* ### BOILERPLATE BELOW THIS LINE ### */

  -- SOURCE COLUMNS
, source_uid VARCHAR(200)
, source_rev_timestamp DATETIME2
, source_rev_actor_desc VARCHAR(200)

  -- AUDIT BATCH KEY
, batch_key INT

  -- TEMPORAL COLUMNS
, version_begin_timestamp DATETIME2
    GENERATED ALWAYS AS ROW START
    CONSTRAINT dbo_policy_version_begin
    DEFAULT SYSUTCDATETIME() NOT NULL

, version_end_timestamp DATETIME2
    GENERATED ALWAYS AS ROW END
    CONSTRAINT dbo_policy_version_end
    DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59') NOT NULL

, PERIOD FOR SYSTEM_TIME(
    version_begin_timestamp, version_end_timestamp)

  -- PRIMARY KEY ON GRAIN COLUMNS
, CONSTRAINT dbo_user_type_pk PRIMARY KEY CLUSTERED (user_type_uid)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.user_type_version));

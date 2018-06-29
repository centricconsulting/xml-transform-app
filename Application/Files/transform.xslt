<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:user="urn:schemas-microsoft-com:user"
  xmlns:json="http://james.newtonking.com/projects/json"
  exclude-result-prefixes="#default msxsl user xsl json">

<xsl:output encoding="UTF-8" method="text" omit-xml-declaration="yes" indent="no" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
<xsl:call-template name="project" />
</xsl:template>

<!-- ##################################################################################### -->
<!-- SUBJECT AREAS -->
<!-- ##################################################################################### -->

<xsl:template name="project">
/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DOCUMENT INFORMATION  (<xsl:value-of select="count(//ownedElements[_type='UMLClass' and not(visibility)])" /> Tables)

PROJECT: <xsl:value-of select="document/name" />
AUTHOR:  <xsl:value-of select="document/author" />

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */

<xsl:for-each select="//ownedElements[_type='UMLSubsystem' and name !='Attribute Classes']">
  <xsl:call-template name="subject" />
</xsl:for-each>
</xsl:template>


  <!-- ##################################################################################### -->
  <!-- SUBJECT AREAS (UMLSubsystem) -->
  <!-- ##################################################################################### -->

<xsl:template name="subject" match="ownedElements">
/* ##################################################################################
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SUBJECT AREA: <xsl:value-of select="name" /> (<xsl:value-of select="count(.//ownedElements[_type='UMLClass' and not(visibility)])" /> Tables)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################################################################################### */

<xsl:for-each select="./ownedElements[_type='UMLClass' and not(visibility)]">
<xsl:call-template name="table" /></xsl:for-each>
</xsl:template>

<!-- ##################################################################################### -->
<!-- TABLES (UMLClass) -->
<!-- ##################################################################################### -->

<xsl:template name="table" match="ownedElements">
<xsl:variable name="class-name" select="name" />
/* ##################################################################################
TABLE: <xsl:value-of select="name" />
##################################################################################### */

CREATE TABLE dbo.[<xsl:value-of select="user:GetTableName($class-name)" />] (
  -- NAMED KEY COLUMN
  <xsl:value-of select="user:GetTableName($class-name)" />_key INT IDENTITY(1000,1)

  -- GRAIN COLUMNS<xsl:choose>
<xsl:when test="count(attributes[_type='UMLAttribute' and not(contains(multiplicity,'*')) and not(visibility) and isUnique='true'])=0">
, <xsl:value-of select="user:GetColumnPhrase($class-name, 'REFERENCE', true())" />
</xsl:when>
<xsl:otherwise>
  <xsl:for-each select="attributes[_type='UMLAttribute' and not(contains(multiplicity,'*')) and not(visibility) and isUnique='true']" >
    <xsl:call-template name="column-phrase" />
  </xsl:for-each>
</xsl:otherwise>
</xsl:choose>

  -- ENTITY REFERENCE COLUMNS<xsl:for-each
    select="attributes[_type='UMLAttribute' and not(contains(multiplicity,'*')) and not(visibility) and not(isUnique='true') and stereotype/_ref]" >
    <xsl:call-template name="column-phrase" />
  </xsl:for-each>

  -- ATTRIBUTE COLUMNS<xsl:for-each
    select="attributes[_type='UMLAttribute' and not(contains(multiplicity,'*')) and not(visibility) and not(isUnique='true') and not(stereotype/_ref)]" >
    <xsl:call-template name="column-phrase" />
  </xsl:for-each>

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
, CONSTRAINT dbo_<xsl:value-of select="user:GetTableName($class-name)" />_pk PRIMARY KEY CLUSTERED (<xsl:choose>
<xsl:when test="count(attributes[_type='UMLAttribute' and not(contains(multiplicity,'*')) and not(visibility) and isUnique='true'])=0">
  <xsl:value-of select="user:GetColumnName($class-name, 'REFERENCE', true())" />
</xsl:when>
<xsl:otherwise>
  <xsl:for-each select="attributes[_type='UMLAttribute' and not(contains(multiplicity,'*')) and not(visibility) and isUnique='true']" >
    <xsl:call-template name="column-name">
    <xsl:with-param name="position" select="position()" />
    </xsl:call-template>
  </xsl:for-each>
</xsl:otherwise>
</xsl:choose>)

) WITH (SYSTEM_VERSIONING = ON (
  HISTORY_TABLE = dbo.<xsl:value-of select="user:GetTableName($class-name)" />_version));
</xsl:template>

<!-- ##################################################################################### -->
<!-- COLUMNS (UMLAttribute)-->
<!-- ##################################################################################### -->

<xsl:template name="column-phrase" match="attributes">
<xsl:variable name="type-class-id" select="type/_ref" />
, <xsl:value-of select="user:GetColumnPhrase(name, //ownedElements[_type='UMLClass' and _id=$type-class-id]/name, stereotype/_ref)" />
</xsl:template>

<xsl:template name="column-name" match="attributes">
<xsl:param name="position" /><xsl:variable name="type-class-id" select="type/_ref" />
<xsl:if test="$position>1">, </xsl:if><xsl:value-of select="user:GetColumnName(name, //ownedElements[_type='UMLClass' and _id=$type-class-id]/name, stereotype/_ref)" />
</xsl:template>

<!-- ########################################### -->
<!-- ######## C# Code  ########################## -->  
<!-- ########################################### -->

<msxsl:script language="C#" implements-prefix="user">
  <msxsl:assembly name="System.Core" />
  <msxsl:using namespace="System.Linq" />
  <msxsl:using namespace="System.Collections.Generic"/>
  <msxsl:using namespace="System.Text.RegularExpressions"/>

<![CDATA[

public string GetTableName(String ClassName)
{
    String Result = FormatAsDatabaseObject(ClassName);
    return ApplyDatabaseAbbreviations(Result);
}

public string GetColumnName(String AttributeName, String AttributeClassName, bool IsReference)
{
  String ColumnName = FormatAsDatabaseObject(AttributeName);

  //override the Attribute Class for reference columns
  if(IsReference) AttributeClassName = "REFERENCE";

  // determine the AttributeClassInfo
  AttributeClassInfo aci = AttributeClassInfo.GetInfo(AttributeClassName);

  // assert the suffix
  if(aci != null) ColumnName = aci.AssertColumnSuffix(ColumnName);

  // apply abbreviations
  ColumnName = ApplyDatabaseAbbreviations(ColumnName);

  if(aci == null)
  {
    return ColumnName + " {Invalid Attribute Class: " + AttributeClassName + "}";
  }
  else
  {
    return ColumnName;
  }
}

public string GetColumnPhrase(String AttributeName, String AttributeClassName, bool IsReference)
{
  String ColumnName = GetColumnName(AttributeName, AttributeClassName, IsReference);

  //override the Attribute Class for reference columns
  if(IsReference) AttributeClassName = "REFERENCE";

  // determine the AttributeClassInfo
  AttributeClassInfo aci = AttributeClassInfo.GetInfo(AttributeClassName);

  if(aci == null)
  {
    return ColumnName;
  }
  else
  {
    return aci.BuildColumnPhrase(ColumnName);
  }
}

private string FormatAsDatabaseObject(String Name)
{
    // perform basic formatting: trim and replace spaces with underscore
    String Result = Name.Trim().Replace(" ","_").ToLower();
    
    // remove non-alphanumeric characters
    Regex rgx = new Regex("[^a-zA-Z0-9_]");
    Result = rgx.Replace(Result, "");

    // collapse any occurrances of multiple underscores
    rgx = new Regex("[_]{2,100}");
    return rgx.Replace(Result, "_");
    
}

private String ApplyDatabaseAbbreviations(String Name)
{
  Dictionary<string, string> dictionary = new Dictionary<string, string>();

  dictionary.Add("transaction", "tran");
  dictionary.Add("premium", "prem");
  dictionary.Add("effective", "effect");
  dictionary.Add("collated", "coll");
  dictionary.Add("collate", "coll");
  dictionary.Add("headquarter", "hq");
  dictionary.Add("corporate", "corp");
  dictionary.Add("expired", "expire");
  dictionary.Add("expiration", "expire");
  dictionary.Add("classification", "class");
  dictionary.Add("workers_compensation", "wc");
  dictionary.Add("workers_comp", "wc");
  
  String WorkingName = Name.ToLower().Trim();

  foreach(KeyValuePair<string, string> abbr in dictionary)
  {
    if(WorkingName.IndexOf(abbr.Key) >= 0)
    {
      WorkingName = WorkingName.Replace(abbr.Key, abbr.Value);
    }
  }

  return WorkingName;
}

public class AttributeClassInfo
{
  public string Suffix {get; set;}
  public string[] VariantSuffixes {get; set;}
  public string DataType {get; set;}

  public AttributeClassInfo(string Suffix, string DataType, string[] VariantSuffixes = null)
  {
    this.Suffix = Suffix;
    this.DataType = DataType;
    this.VariantSuffixes = VariantSuffixes;
  }

  public string AssertColumnSuffix(String ColumnName)
  {

    // clean the name
    String WorkingName = ColumnName.Trim();

    // test if the asserted suffix is already in place
    if(WorkingName.EndsWith(this.Suffix))
    {
      return WorkingName;
    }

    // test if variant suffixes are being used, and then replace
    if(this.VariantSuffixes != null)
    {
      foreach(String VariantSuffix in this.VariantSuffixes)
      {
        if(WorkingName.EndsWith(VariantSuffix))
        {
          return WorkingName.Substring(0, WorkingName.Length-VariantSuffix.Length) + this.Suffix;
        }
      }
    }

    // append the asserted suffix
    return WorkingName + this.Suffix;

  }

  public string BuildColumnPhrase(String ColumnName)
  {
    return ColumnName + " " + this.DataType;
  }

  public static AttributeClassInfo GetInfo(string AttributeClassName)
  {

    // prepare the Attribute Class
    if(String.IsNullOrEmpty(AttributeClassName)) return null;
  
    switch(AttributeClassName.Trim().ToUpper())
    {
      case "REFERENCE":
        return new AttributeClassInfo("_uid", "VARCHAR(200)");

      case "DATE":
        return new AttributeClassInfo("_date", "DATE");

      case "TIMESTAMP":
        return new AttributeClassInfo("_timestamp", "DATETIME2", new String[] {"_dtm", "_date", "_datetime"});

      case "NAME":
        return new AttributeClassInfo("_name", "VARCHAR(200)");

      case "DESCRIPTION":
        return new AttributeClassInfo("_desc", "VARCHAR(1000)", new String[] {"_description", "_name"});

      case "CODE":
        return new AttributeClassInfo("_code", "VARCHAR(20)");

      case "LOCATOR":
        return new AttributeClassInfo("_address", "VARCHAR(200)");

      case "CURRENCY": 
        return new AttributeClassInfo("_amount", "DECIMAL(20,12)", new String[] {"_amt", "_dollars"});

      case "QUANTITY":
        return new AttributeClassInfo("_quantity", "DECIMAL(20,12)", new String[] {"_qty", "_amount"});

      case "VALUE":
        return new AttributeClassInfo("_value", "FLOAT", new String[] {"_val", "_pct", "_percent","_percentage"});

      case "VALUE INTEGER":
        return new AttributeClassInfo("_value", "INT", new String[] {"_val", "_int", "_integer"});

      case "IDENTIFIER":
        return new AttributeClassInfo("_identifier", "VARCHAR(200)", new String[] {"_number", "_nbr", "_num", "_id"});

      case "NUMBER":
        return new AttributeClassInfo("_number", "VARCHAR(200)", new String[] {"_nbr", "_num", "_identifier", "_id"});

      case "INDICATOR":
        return new AttributeClassInfo("_ind", "BIT", new String[] {"_indicator", "_flag"});

      case "FLAG":
        return new AttributeClassInfo("_flag", "VARCHAR(20)", new String[] {"_code"});

      case "NOTE":
        return new AttributeClassInfo("_note", "VARCHAR(200)", new String[] {"_comment"});

      case "LIST":
        return new AttributeClassInfo("_list", "VARCHAR(2000)");

      case "COUNT":
        return new AttributeClassInfo("_count", "INT", new String[] {"_quantity", "_qty"});

      case "ORDINAL":
        return new AttributeClassInfo("_index", "INT", new String[] {"_count", "_quantity", "_qty", "_value", "_val"});

      case "RATE":
        return new AttributeClassInfo("_rate", "DECIMAL(20,12)", new String[] {"_ratio", "_value", "_val", "_percent", "_pct", "_percentage"});

      default:
        return null;
    }
  }
}


]]>

</msxsl:script>

</xsl:stylesheet>

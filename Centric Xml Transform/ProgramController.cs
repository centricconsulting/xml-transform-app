using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Json;
using Newtonsoft.Json;

namespace Centric.XmlTransform
{
  /// <summary>
  /// Handles all application functionality
  /// </summary>
  public class ProgramController
  {

    #region Command Line Properties

    public bool SupressTransform { get; set; } = false;

    #endregion

    #region Core Properties

    public string TransformFilePath { get; set; }
    private string _DefinitionFilePath;
    private bool _DefinitionFileIsJson = false;
    public string TargetFilePath { get; set; }
    public bool OverwriteTarget { get; set; } = false;

    public const string DEFAULT_ROOT_TAG_NAME = "document";
    private string _RootTagName = DEFAULT_ROOT_TAG_NAME;

    public bool GenerateXml { get; set; } = false;

    #endregion

    #region Interface Properties

    // default is to show the interface
    public bool UseInterface { get; set; } = true;

    public string PostTransformInstruction { get; set; }
    public bool TransformDragDrop { get; set; } = false;
    public string TargetApplicationFilePath { get; set; }
    public const string DATETIME_STRING_FORMAT = "yyyy-MM-dd h:mm:sstt";

    #endregion

    #region Special Properties

    public string DefinitionFilePath
    {
      get { return this._DefinitionFilePath; }
      set
      {
        this._DefinitionFilePath = value;
        this._DefinitionFileIsJson = JsonValidate(this._DefinitionFilePath, out string Message);
      }
    }
    public bool DefinitionFileIsJson
    {
      get {return _DefinitionFileIsJson; }
    }

    public string TargetXmlFilePath
    {
      get { 
        
        try{

          string FolderPath = GetPath(this.TargetFilePath);
          string FileNameNoFileType = GetFileNameWithoutFileType(this.TargetFilePath);

          if (FileNameNoFileType == null) return null;

          return FolderPath + "\\" + FileNameNoFileType + ".xml";

        }
        catch { return null; }
      }
    }

    public string RootTagName
    {
      get { return this._RootTagName; }
      set
      {

        if (!ProgramController.XmlTagIsValid(value, out string Message))
        {
          throw new ArgumentException(Message);
        }

        this._RootTagName = value;
      }
    }

    #endregion

    public bool ExecuteTransform(out string Message)
    {
 
      try
      {

        // excecute validation
        if (!this.ValidateFiles(out Message)) return false;
        
        // convert json file to Xml
        string WorkingDefinitionFilePath = this.DefinitionFilePath;
        XmlReader reader = null;

        if (this.DefinitionFileIsJson)
        {
          WorkingDefinitionFilePath = this.TargetXmlFilePath;
          
          XmlDocument doc = this.GetJsonXmlDocument(out Message);
          if (doc == null) return false;

          // save the resulting Xml file
          if (this.GenerateXml) doc.Save(WorkingDefinitionFilePath);

          // establish the XmlReader from the XmlDocument
          reader = new XmlNodeReader(doc);
       
        } else
        {

          // establish the XmlReader from the filepath
          reader = XmlReader.Create(WorkingDefinitionFilePath);
        }

        

        if(!this.SupressTransform)
        {
          XsltSettings settings = new XsltSettings()
          {
            EnableScript = true
          };
          
          XslCompiledTransform xslt = new XslCompiledTransform();
          xslt.Load(TransformFilePath, settings, null);

          using (FileStream fs = new FileStream(TargetFilePath, FileMode.Create))
          { 
            xslt.Transform(reader, null, fs);
          }
        }

        Message = null;
        return true;

      }
      catch(Exception ex)
      {
        if (ex.InnerException != null)
        {
          Message = ex.InnerException.Message + "\r\n\r\n" + ex.Message;
        }
        else
        {
          Message = ex.Message;
        }

        return false;
      }
    }

    private bool ValidateFiles(out string Message)
    {
      // validate file paths
      if (!this.SupressTransform)
      {
        if (!FileExists(this.TransformFilePath))
        {
          Message = "The Transform Xslt file is invalid or does not exist.";
          return false;
        }

        if (!XslValidate(this.TransformFilePath, out Message))
        {
          return false;
        }

        if (!FolderExists(this.TargetFilePath))
        {
          Message = "The Target File directory is invalid or does not exist.";
          return false;
        }

        if (!this.OverwriteTarget && FileExists(this.TargetFilePath))
        {
          Message = "The Target File already exists and will not be overwritten.";
          return false;
        }
      }

      if (this.DefinitionFileIsJson)
      {
        if (!JsonValidate(DefinitionFilePath, out Message))
        {
          Message = String.Format("The Definition Json file is not a valid Json format.\r\n\r\n{0}", Message);
          return false;
        }
      }
      else if (!XmlValidate(DefinitionFilePath, out Message))
      {
        Message = String.Format("The Definition Xml file is not a valid Xml format.\r\n\r\n{0}", Message);
        return false;
      }

      Message = null;
      return true;
    }

    private XmlDocument GetJsonXmlDocument(out string Message)
    {
      try{
        // searches for attributes names beginning with "$"
        string SearchPattern = @"[\""]([\$][\w\d]*)[\""]\s*[:]";
      
        // replace matches by replacing the "$" with "_"
        string JsonText = Regex.Replace(File.ReadAllText(this.DefinitionFilePath), SearchPattern, delegate (Match match)
        {
          return match.ToString().Replace("$", "_");
        });

        XmlDocument doc = JsonConvert.DeserializeXmlNode(JsonText, this.RootTagName);

        // add information to the root node      

        XmlAttribute SourceModifyTimeStampAttribute = doc.CreateAttribute("sourceModifiedTimestamp");
        SourceModifyTimeStampAttribute.Value = File.GetLastWriteTime(this.DefinitionFilePath).ToString(DATETIME_STRING_FORMAT);
        doc.FirstChild.Attributes.Append(SourceModifyTimeStampAttribute);

        XmlAttribute TransformTimeStampAttribute = doc.CreateAttribute("transformedTimestamp");
        TransformTimeStampAttribute.Value = DateTime.Now.ToString(DATETIME_STRING_FORMAT);
        doc.FirstChild.Attributes.Append(TransformTimeStampAttribute);

        XmlAttribute SoureFileAttribute = doc.CreateAttribute("sourceFile");
        SoureFileAttribute.Value = GetFileName(this.DefinitionFilePath);
        doc.FirstChild.Attributes.Append(SoureFileAttribute);

        Message = null;
        return doc;

      }
      catch(Exception ex)
      {
        if (ex.InnerException != null)
        {
          Message = ex.InnerException.Message + "\r\n\r\n" + ex.Message;
        }
        else
        {
          Message = ex.Message;
        }

        return null;
      }
    }

    #region Static File Methods

    public static string GetPath(string FilePath)
    {
      try
      {
        return Path.GetDirectoryName(FilePath);
      }
      catch
      {
        return null;
      }
    }

    public static string GetFileName(string FilePath)
    {
      try
      {
        return Path.GetFileName(FilePath);
      }
      catch
      {
        return null;
      }
    }

    public static string GetFileNameWithoutFileType(string FilePath)
    {
      try
      {
        string FileName = GetFileName(FilePath);
        string FileType = GetFileType(FilePath);
        return FileName.Substring(0, FileName.Length - FileType.Length);
      }
      catch
      {
        return null;
      }
    }

    public static string GetCleanFileType(string FilePath)
    {
      return CleanFileType(GetFileType(FilePath));
    }

    public static string GetFileType(string FilePath)
    {
      try
      {
        return Path.GetExtension(FilePath);
      }
      catch
      {
        return null;
      }
    }

    public static bool FileExists(string FilePath)
    {
      try
      {
        return File.Exists(FilePath);
      }
      catch
      {
        return false;
      }

    }

    public static bool FolderExists(string FilePath)
    {
      try
      {
        string path = GetPath(FilePath);
        return Directory.Exists(path);

      }
      catch
      {
        return false;
      }
    }

    public static string CleanFileType(string FileTypeText)
    {

      char[] arr = FileTypeText.Where(c => (
        char.IsLetterOrDigit(c) ||
        char.IsWhiteSpace(c))).ToArray();

      return new string(arr);
    }

    public static string GetProgramFilesPath()
    {
      if (8 == IntPtr.Size
          || (!String.IsNullOrEmpty(Environment.GetEnvironmentVariable("PROCESSOR_ARCHITEW6432"))))
      {
        return Environment.GetEnvironmentVariable("ProgramFiles(x86)");
      }

      return Environment.GetEnvironmentVariable("ProgramFiles");
    }

    public static string NormalizeFilePath(string FilePath)
    {

      if (String.IsNullOrEmpty(FilePath)) return null;

      // strop leading and trailing quotes
      if (FilePath.StartsWith("\"") && FilePath.EndsWith("\""))
      {
        FilePath = FilePath.Substring(1, FilePath.Length - 2);

      }
      else if (FilePath.StartsWith("'") && FilePath.EndsWith("'"))
      {
        FilePath = FilePath.Substring(1, FilePath.Length - 2);
      }

      // replace forward slash with back slash
      return FilePath.Replace("/", "\\");

    }

    #endregion

    #region Static Validation Methods

    public static bool XmlTagIsValid(string TagName, out string Message)
    {
      Regex rgx = new Regex("^[a-zA-Z_][a-zA-Z0-9_-.]*([:]{0,1}[a-zA-Z_][a-zA-Z0-9_-.]*)+$");

      if(rgx.IsMatch(TagName))
      {
        Message = null;
        return true;

      } else
      {
        Message = String.Format("The value, \"{0}\" is not a valid Xml tag name.",
          String.IsNullOrEmpty(TagName) ? "{null}" : TagName);

        return false;
      }
    }

    public static bool JsonValidate(string FilePath, out string Message)
    {
      try
      {
        String JsonText = File.ReadAllText(FilePath);
        JsonValue.Parse(JsonText);

        Message = null;
        return true;
      }
      catch (Exception ex)
      {
        if (ex.InnerException != null)
        {
          Message = ex.InnerException.Message + "\r\n\r\n" + ex.Message;
        }
        else
        {
          Message = ex.Message;
        }

        return false;
      }
    }

    public static bool XmlValidate(string FilePath, out string Message)
    {
      try
      {
        XmlDocument xd1 = new XmlDocument();
        xd1.Load(FilePath);
        xd1 = null;

        Message = null;
        return true;
      }
      catch (Exception ex)
      {
        if (ex.InnerException != null)
        {
          Message = ex.InnerException.Message + "\r\n\r\n" + ex.Message;
        }
        else
        {
          Message = ex.Message;
        }

        return false;
      }
    }

    public static bool XslValidate(string FilePath, out string Message)
    {
      try
      {
        XslCompiledTransform xd1 = new XslCompiledTransform();
        xd1.Load(FilePath);
        xd1 = null;

        Message = null;
        return true;
      }
      catch (Exception ex)
      {

        if (ex.InnerException != null)
        {
          Message = ex.InnerException.Message + "\r\n\r\n" + ex.Message;
        }
        else
        {
          Message = ex.Message;
        }

        return false;
      }
    }

    #endregion

  }
}

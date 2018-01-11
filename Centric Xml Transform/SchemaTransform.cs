using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Xsl;
using System.IO;

namespace Centric.XmlTransform
{
  public static class SchemaTransform
  {
     public static void Execute(string XmlFilePath, string XsltFilePath, string ResultFilePath)
     {
     
      XsltSettings settings = new XsltSettings();
      settings.EnableScript = true;
      
      XslCompiledTransform xslt = new XslCompiledTransform();
      xslt.Load(XsltFilePath, settings, null);

      xslt.Transform(XmlFilePath, ResultFilePath);
      
     }

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
      catch(Exception ex)
      {
        if(ex.InnerException != null)
        {
          Message = ex.InnerException.Message;
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
      catch(Exception ex)
      {

        if (ex.InnerException != null)
        {
          Message = ex.InnerException.Message;
        }
        else
        {
          Message = ex.Message;
        }

        return false;
      }
    }
  }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Centric.XmlTransform
{
  static class Program
  {
    /// <summary>
    /// The main entry point for the application.
    /// </summary>

    public static ProgramController Controller = new ProgramController();

    [STAThread]
    static void Main(string[] args)
    {

      if(Program.Controller.UseInterface = (args == null || args.Length == 0))
      {

        LoadConfigurations();

        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);
        Application.Run(new MainForm());

        SaveConfigurations();
      }
      else
      {
        ApplyCommandLindParameters(args);
        Program.Controller.ExecuteTransform(out string Message);

      }      
    }

    public static void LoadConfigurations()
    {

      try {

        Controller.TransformFilePath = Properties.Settings.Default.TransformFilePath;
        Controller.TargetFilePath = Properties.Settings.Default.TargetFilePath;
        Controller.OverwriteTarget = Properties.Settings.Default.OverwriteTarget;
        Controller.TargetApplicationFilePath = Properties.Settings.Default.TargetApplicationFilePath;
        Controller.DefinitionFilePath = Properties.Settings.Default.DefinitionFilePath;
        Controller.TransformDragDrop = Properties.Settings.Default.TransformDragDrop;
        Controller.PostTransformInstruction = Properties.Settings.Default.PostTransformInstruction;
        Controller.GenerateXml = Properties.Settings.Default.GenerateXml;
        Controller.RootTagName = Properties.Settings.Default.RootTagName;
      }
      catch { };

    }

    public static void SaveConfigurations()
    {

      try
      {

        Properties.Settings.Default.TransformFilePath = Controller.TransformFilePath;
        Properties.Settings.Default.TargetFilePath = Controller.TargetFilePath;
        Properties.Settings.Default.OverwriteTarget = Controller.OverwriteTarget;
        Properties.Settings.Default.TargetApplicationFilePath = Controller.TargetApplicationFilePath;
        Properties.Settings.Default.DefinitionFilePath = Controller.DefinitionFilePath;
        Properties.Settings.Default.TransformDragDrop = Controller.TransformDragDrop;
        Properties.Settings.Default.PostTransformInstruction = Controller.PostTransformInstruction;
        Properties.Settings.Default.GenerateXml = Controller.GenerateXml;
        Properties.Settings.Default.RootTagName = Controller.RootTagName;

        Properties.Settings.Default.Save();

      }
      catch { }

    }

    static void ApplyCommandLindParameters(string[] args)
    {

      /*
      * -source "{Xml of Json File Path}"
      * -xslt "{Xslt File Path}"
      * -target "{Target File Path}"
      * -root (Name of the root element created in Xml in case of Json conversion)
      * -overwrite (Instruction to overwite the {Target File Path} if the file already exists)
      * -xml (Instruction to generate Xml file path from Target file path)
      * -supress (Instruction to suppress the target file generation)
      */

      for (int n = 0; n < args.Length; n++)
      {

        if (args[n].Equals("-source") && n < args.Length - 1)
        {
          Program.Controller.DefinitionFilePath = ProgramController.NormalizeFilePath(args[n + 1]);
          n++;  // advance the arg counter

        }
        else if (args[n].Equals("-xslt") && n < args.Length - 1)
        {
          Program.Controller.TransformFilePath = ProgramController.NormalizeFilePath(args[n + 1]);
          n++;  // advance the arg counter

        }
        else if (args[n].Equals("-target") && n < args.Length - 1)
        {
          Program.Controller.TargetFilePath = ProgramController.NormalizeFilePath(args[n + 1]);
          n++;  // advance the arg counter    			

        }
        else if (args[n].Equals("-xml"))
        {
          Program.Controller.GenerateXml = true;
        }
        else if (args[n].Equals("-overwrite"))
        {
          Program.Controller.OverwriteTarget = true;
        }
        else if (args[n].Equals("-supress"))
        {
          Program.Controller.SupressTransform = true;
        }
      }
    }

    
  }
}


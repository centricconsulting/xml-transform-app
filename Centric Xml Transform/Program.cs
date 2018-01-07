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
    [STAThread]
    static void Main()
    {
      Application.EnableVisualStyles();
      Application.SetCompatibleTextRenderingDefault(false);
      Application.Run(new MainForm());

      //string XmlFilePath = @"C:\Development\Solutions\GitHub\schema-generator\Schema Generator\Schema Generator\Files\schema_definition.xml";
      //string XsltFilePath = @"C:\Development\Solutions\GitHub\schema-generator\Schema Generator\Schema Generator\Files\schema_transform.xslt";
      //string ResultFilePath = @"C:\Users\jeff.kanel\Downloads\result.sql";

      //
    }

    
  }

}


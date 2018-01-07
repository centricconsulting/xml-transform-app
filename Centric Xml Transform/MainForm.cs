using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Diagnostics;
using System.Globalization;

namespace Centric.XmlTransform
{
  public partial class MainForm : Form
  {
    public MainForm()
    {
      InitializeComponent();
    }


    private void MainForm_Load(object sender, EventArgs e)
    {
      ReadUserSettings();
    }

    private void TransformButton_Click(object sender, EventArgs e)
    {
      ExecuteTransform();
    }

    private void ExecuteTransform()
    {

      // validate file paths
      if(!SchemaTransform.FileExists(TransformFileText.Text))
      {
          MessageBox.Show(this, "The transform file is invalid or does not exist.", "Invalid Transform File",
            MessageBoxButtons.OK, MessageBoxIcon.Stop);
          return;
      }

      if (!SchemaTransform.XslValidate(TransformFileText.Text))
      {
        MessageBox.Show(this, "The transform file is not a valid XSL format.", "Invalid Transform File",
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      }

      if (!SchemaTransform.FolderExists(OutputFileText.Text))
      {
        MessageBox.Show(this, "The output folder is invalid or does not exist.", "Invalid Output Path", 
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      }

      if (!SchemaTransform.FileExists(DefinitionFileText.Text))
      {
        MessageBox.Show(this, "The definition file is invalid or does not exist.", "Invalid Definition File",
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      }

      if (!SchemaTransform.XmlValidate(DefinitionFileText.Text))
      {
        MessageBox.Show(this, "The definition file is not a valid XML format.", "Invalid Definition File",
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      }

      // force selection of new output path in overwrite condition
      if (!OverwriteCheckBox.Checked && SchemaTransform.FileExists(OutputFileText.Text))
      {
        string NewOutputFilePath = OutputFileText.Text;
        DialogResult result = DialogResult.Cancel;

        while (NewOutputFilePath.Equals(OutputFileText.Text, StringComparison.CurrentCultureIgnoreCase))
        {
          result = ShowOutputFileDialog(ref NewOutputFilePath);
          if (result == DialogResult.Cancel) break;
        }

        // set to the new output file path
        if (result == DialogResult.OK)
        {
          OutputFileText.Text = NewOutputFilePath;
        } else 
        {
          return;
        }
      }

      // execute transform
      try
      {

        SchemaTransform.Execute(DefinitionFileText.Text, TransformFileText.Text, OutputFileText.Text);

      } catch(Exception ex)
      {

        MessageBox.Show(this, "Transformation failed with the following message: " + ex.Message, "Transformation Failed",
          MessageBoxButtons.OK, MessageBoxIcon.Error);

        return;

      }

      TransformDateLabel.Text = string.Format("Last transformation completed: {0}", 
        DateTime.Now.ToString("hh:mm:ss tt, MMMM d, yyyy", CultureInfo.InvariantCulture));

      // open output file in application
      if(!OutputAppRadioNone.Checked)
      {
        OpenOutputFile();
      }
    }

    private void OpenOutputFileButton_Click(object sender, EventArgs e)
    {
      OpenOutputFile();
    }

    private void OpenOutputFile()
    {

      Process AppProcess = new Process();
      

      if (OutputAppRadioCustom.Checked)
      {

        // validate file paths
        if (!SchemaTransform.FileExists(AppFileText.Text))
        {
          MessageBox.Show(this, "The application path is invalid or does not exist.", "Invalid Application",
            MessageBoxButtons.OK, MessageBoxIcon.Stop);
          return;
        }

        AppProcess.StartInfo.FileName = AppFileText.Text; 
        AppProcess.StartInfo.Arguments = OutputFileText.Text;
        AppProcess.Start();

      } else 
      {

        AppProcess.StartInfo.FileName = OutputFileText.Text; 
        AppProcess.Start();
      }
      
    }
    
    private void TransformFileButton_Click(object sender, EventArgs e)
    {
      string FilePath = TransformFileText.Text;
      DialogResult result = ShowTransformFileDialog(ref FilePath);

      if (result == DialogResult.OK)
      {
        TransformFileText.Text = FilePath;
      }
    }

    private DialogResult ShowTransformFileDialog(ref string CurrentFilePath)
    {

      TransformFileDialog.Title = "Select Transformation File";
      TransformFileDialog.CheckPathExists = true;
      TransformFileDialog.CheckFileExists = true;
      TransformFileDialog.InitialDirectory = SchemaTransform.GetPath(CurrentFilePath);
      TransformFileDialog.Filter = "XSL Files (*.xsl; *.xslt) | *.xsl; *.xslt | All Files (*.*) | *.*";
      TransformFileDialog.FilterIndex = 2;
      TransformFileDialog.FileName = SchemaTransform.GetFileName(CurrentFilePath);

      DialogResult result = TransformFileDialog.ShowDialog(this);

      if (result == DialogResult.OK)
      {
        CurrentFilePath = TransformFileDialog.FileName;
      }

      return result;
    }

    private void OutputFileButton_Click(object sender, EventArgs e)
    {
      string FilePath = OutputFileText.Text;
      DialogResult result = ShowOutputFileDialog(ref FilePath);

      if (result == DialogResult.OK)
      {
        OutputFileText.Text = FilePath;
      }
    }

    private DialogResult ShowOutputFileDialog(ref string CurrentFilePath)
    {
      OutputFileDialog.Title = "Specify Output File";
      OutputFileDialog.CheckPathExists = true;
      OutputFileDialog.CheckFileExists = false;
      OutputFileDialog.OverwritePrompt = false;

      OutputFileDialog.InitialDirectory = SchemaTransform.GetPath(CurrentFilePath);
      string CleanFileType = null;

      if (CurrentFilePath == null)
      {
        OutputFileDialog.Filter = "All Files (*.*) | *.*";
        OutputFileDialog.FilterIndex = 1;
      }
      else
      {
        CleanFileType = SchemaTransform.GetCleanFileType(CurrentFilePath);
        OutputFileDialog.DefaultExt = CleanFileType;
        OutputFileDialog.Filter = "Output Files (*." + CleanFileType + ") | *." + CleanFileType + " | All Files (*.*) | *.*";
        OutputFileDialog.FilterIndex = 2;
      }

      OutputFileDialog.FileName = SchemaTransform.GetFileName(CurrentFilePath);

      DialogResult result = OutputFileDialog.ShowDialog(this);

      if (result == DialogResult.OK)
      {
        CurrentFilePath = OutputFileDialog.FileName;
      }

      return result;
    }

    private void AppFileButton_Click(object sender, EventArgs e)
    {
      string FilePath = AppFileText.Text;
      DialogResult result = ShowAppFileDialog(ref FilePath);

      if (result == DialogResult.OK)
      {
        AppFileText.Text = FilePath;
      }
    }

    private DialogResult ShowAppFileDialog(ref string CurrentFilePath)
    {

      AppFileDialog.Title = "Select Application File";
      AppFileDialog.CheckPathExists = true;
      AppFileDialog.CheckFileExists = true;
      if(CurrentFilePath == null || CurrentFilePath.Trim().Length == 0)
      {
        AppFileDialog.InitialDirectory = SchemaTransform.GetProgramFilesPath();
      } else
      {
        AppFileDialog.InitialDirectory = SchemaTransform.GetPath(CurrentFilePath);
      }
      
      AppFileDialog.Filter = "Executable Files (*.exe) | *.exe| All Files (*.*) | *.*";
      AppFileDialog.FilterIndex = 2;
      AppFileDialog.FileName = SchemaTransform.GetFileName(CurrentFilePath);

      DialogResult result = AppFileDialog.ShowDialog(this);

      if (result == DialogResult.OK)
      {
        CurrentFilePath = AppFileDialog.FileName;
      }

      return result;
    }

    private void DefinitionFileButton_Click(object sender, EventArgs e)
    {
      string FilePath = DefinitionFileText.Text;
      DialogResult result = ShowDefinitionFileDialog(ref FilePath);

      if (result == DialogResult.OK)
      {
        DefinitionFileText.Text = FilePath;
      }
    }
    
    private DialogResult ShowDefinitionFileDialog(ref string CurrentFilePath)
    {

      DefinitionFileDialog.Title = "Select Definition File";
      DefinitionFileDialog.CheckPathExists = true;
      DefinitionFileDialog.CheckFileExists = true;
      DefinitionFileDialog.InitialDirectory = SchemaTransform.GetPath(CurrentFilePath);
      DefinitionFileDialog.Filter = "XML Files (*.xml) | *.xml | All Files (*.*) | *.*";
      DefinitionFileDialog.FilterIndex = 2;
      DefinitionFileDialog.FileName = SchemaTransform.GetFileName(CurrentFilePath);

      DialogResult result = DefinitionFileDialog.ShowDialog(this);

      if (result == DialogResult.OK)
      {
        CurrentFilePath = DefinitionFileDialog.FileName;
      }

      return result;
    }


    private void CloseButton_Click(object sender, EventArgs e)
    {
      this.Close();
    }

    private void MainForm_DragEnter(object sender, DragEventArgs e)
    {
      if (e.Data.GetDataPresent(DataFormats.FileDrop)) e.Effect = DragDropEffects.Copy;
    }

    private void MainForm_DragDrop(object sender, DragEventArgs e)
    {

      string[] files = (string[])e.Data.GetData(DataFormats.FileDrop);
      if (files.Length > 1)
      {
        MessageBox.Show(this, "Multiple files were drag-dropped.  Limit to a single file.", "Invalid Definition File",
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      }

      string FilePath = files[0];
      if (SchemaTransform.FileExists(FilePath))
      {
        DefinitionFileText.Text = FilePath;

        if (DefinitionFileDropCheckBox.Checked)
        {
          ExecuteTransform();
        }

      }
      else
      {
        MessageBox.Show(this, "The definition file does not exist or is invalid.", "Invalid Definition File",
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      }
    }

    private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
    {
      SaveUserSettings();
    }

    private void SaveUserSettings()
    {

      Properties.Settings.Default.UpdateTimestamp = DateTime.Now;
      Properties.Settings.Default.TransformFile = TransformFileText.Text;
      Properties.Settings.Default.OutputFile = OutputFileText.Text;
      Properties.Settings.Default.Overwrite = OverwriteCheckBox.Checked;
      Properties.Settings.Default.AppFile = AppFileText.Text;
      Properties.Settings.Default.DefinitionFile = DefinitionFileText.Text;
      Properties.Settings.Default.TransformAuto = DefinitionFileDropCheckBox.Checked;

      if (OutputAppRadioNone.Checked)
      {
        Properties.Settings.Default.AppInstruction = "None";

      } else if (OutputAppRadioDefault.Checked)
      {
        Properties.Settings.Default.AppInstruction = "Default";

      } else if (OutputAppRadioCustom.Checked)
      {
        Properties.Settings.Default.AppInstruction = "Custom";
      }

      Properties.Settings.Default.Save();

    }

    private void ReadUserSettings()
    {
      // check if user settings exist before reading
      DateTime test = Properties.Settings.Default.UpdateTimestamp;

      if (test >= new DateTime(2000,1,1)) 
      {
        TransformFileText.Text = Properties.Settings.Default.TransformFile;
        OutputFileText.Text = Properties.Settings.Default.OutputFile;
        OverwriteCheckBox.Checked = Properties.Settings.Default.Overwrite;
        AppFileText.Text = Properties.Settings.Default.AppFile;
        DefinitionFileText.Text = Properties.Settings.Default.DefinitionFile;
        DefinitionFileDropCheckBox.Checked = Properties.Settings.Default.TransformAuto;

        switch (Properties.Settings.Default.AppInstruction)
        {
          case "None":
            OutputAppRadioNone.Checked = true;
            break;
          case "Default":
            OutputAppRadioDefault.Checked = true;
            break;
          case "Custom":
            OutputAppRadioCustom.Checked = true;
            break;
          default:
            break;
        }
      }
    }

  }
}

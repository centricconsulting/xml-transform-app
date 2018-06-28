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
      this.ReadUserSettings();
    }

    private void CloseButton_Click(object sender, EventArgs e)
    {
      this.Close();
    }

    private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
    {
      SaveUserSettings();
    }

    private void TransformButton_Click(object sender, EventArgs e)
    {
      this.ExecuteTransform();
    }

    private void ExecuteTransform()
    {

      // force selection of new output path in overwrite condition
      if (!OverwriteCheckBox.Checked && ProgramController.FileExists(Program.Controller.TargetFilePath))
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
      if (!Program.Controller.ExecuteTransform(out string Message))
      {
        MessageBox.Show(this, "Transformation failed with the following message:\r\n\r\n" + Message, "Transformation Failed",
          MessageBoxButtons.OK, MessageBoxIcon.Error);

        return;
      }

      // update the date label
      TransformDateLabel.Text = string.Format("Last transformation completed: {0}",
        DateTime.Now.ToString("hh:mm:ss tt, MMMM d, yyyy", CultureInfo.InvariantCulture));

      // open output file in application
      if(!OutputAppRadioNone.Checked) OpenOutputFile();
    }

    #region File Selection

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
        if (!ProgramController.FileExists(AppFileText.Text))
        {
          MessageBox.Show(this, "The application path is invalid or does not exist.", "Invalid Application",
            MessageBoxButtons.OK, MessageBoxIcon.Stop);
          return;
        }

        AppProcess.StartInfo.FileName = AppFileText.Text; 
        AppProcess.StartInfo.Arguments = "\"" + OutputFileText.Text + "\"";
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

    private void TransformFileText_TextChanged(object sender, EventArgs e)
    {
      Program.Controller.TransformFilePath = TransformFileText.Text.Trim();
    }

    private DialogResult ShowTransformFileDialog(ref string CurrentFilePath)
    {

      TransformFileDialog.Title = "Select Transformation File";
      TransformFileDialog.CheckPathExists = true;
      TransformFileDialog.CheckFileExists = true;
      TransformFileDialog.InitialDirectory = ProgramController.GetPath(CurrentFilePath);
      TransformFileDialog.Filter = "XSL Files (*.xsl; *.xslt) | *.xsl; *.xslt | All Files (*.*) | *.*";
      TransformFileDialog.FilterIndex = 2;
      TransformFileDialog.FileName = ProgramController.GetFileName(CurrentFilePath);

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

    private void OutputFileText_TextChanged(object sender, EventArgs e)
    {
      Program.Controller.TargetFilePath = OutputFileText.Text.Trim();
    }

    private DialogResult ShowOutputFileDialog(ref string CurrentFilePath)
    {
      OutputFileDialog.Title = "Specify Output File";
      OutputFileDialog.CheckPathExists = true;
      OutputFileDialog.CheckFileExists = false;
      OutputFileDialog.OverwritePrompt = false;

      OutputFileDialog.InitialDirectory = ProgramController.GetPath(CurrentFilePath);
      string CleanFileType = null;

      if (CurrentFilePath == null)
      {
        OutputFileDialog.Filter = "All Files (*.*) | *.*";
        OutputFileDialog.FilterIndex = 1;
      }
      else
      {
        CleanFileType = ProgramController.GetCleanFileType(CurrentFilePath);
        OutputFileDialog.DefaultExt = CleanFileType;
        OutputFileDialog.Filter = "Output Files (*." + CleanFileType + ") | *." + CleanFileType + " | All Files (*.*) | *.*";
        OutputFileDialog.FilterIndex = 2;
      }

      OutputFileDialog.FileName = ProgramController.GetFileName(CurrentFilePath);

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
        AppFileDialog.InitialDirectory = ProgramController.GetProgramFilesPath();
      } else
      {
        AppFileDialog.InitialDirectory = ProgramController.GetPath(CurrentFilePath);
      }
      
      AppFileDialog.Filter = "Executable Files (*.exe) | *.exe| All Files (*.*) | *.*";
      AppFileDialog.FilterIndex = 2;
      AppFileDialog.FileName = ProgramController.GetFileName(CurrentFilePath);

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

    private void DefinitionFileText_TextChanged(object sender, EventArgs e)
    {
      Program.Controller.DefinitionFilePath = DefinitionFileText.Text.Trim();
      GenerateXmlCheckbox.Enabled = Program.Controller.DefinitionFileIsJson;

    }

    private DialogResult ShowDefinitionFileDialog(ref string CurrentFilePath)
    {

      DefinitionFileDialog.Title = "Select Definition File";
      DefinitionFileDialog.CheckPathExists = true;
      DefinitionFileDialog.CheckFileExists = true;
      DefinitionFileDialog.InitialDirectory = ProgramController.GetPath(CurrentFilePath);
      DefinitionFileDialog.Filter = "XML Files (*.xml) | *.xml | Json Files (*.json) | *.json | StarUML Files | *.mdj | All Files (*.*) | *.*";
      DefinitionFileDialog.FilterIndex = 4;
      DefinitionFileDialog.FileName = ProgramController.GetFileName(CurrentFilePath);

      DialogResult result = DefinitionFileDialog.ShowDialog(this);

      if (result == DialogResult.OK)
      {
        CurrentFilePath = DefinitionFileDialog.FileName;
      }

      return result;
    }

    #endregion

    #region Drag Drop and Checkbox Logic


    private void DefinitionFileDropCheckBox_CheckedChanged(object sender, EventArgs e)
    {
      Program.Controller.TransformDragDrop = DefinitionFileDropCheckBox.Checked;
    }

    private void OverwriteCheckBox_CheckedChanged(object sender, EventArgs e)
    {
      Program.Controller.OverwriteTarget = OverwriteCheckBox.Checked;
    }

    private void GenerateXmlCheckbox_CheckedChanged(object sender, EventArgs e)
    {
      Program.Controller.GenerateXml = GenerateXmlCheckbox.Checked;
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
      if (ProgramController.FileExists(FilePath))
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

    #endregion

    #region Settings

    private void SaveUserSettings()
    {

      Program.Controller.TransformFilePath  = TransformFileText.Text;
      Program.Controller.TargetFilePath = OutputFileText.Text;
      Program.Controller.OverwriteTarget = OverwriteCheckBox.Checked;
      Program.Controller.TargetApplicationFilePath = AppFileText.Text;
      Program.Controller.DefinitionFilePath = DefinitionFileText.Text;
      Program.Controller.TransformDragDrop = DefinitionFileDropCheckBox.Checked;
      Program.Controller.GenerateXml = GenerateXmlCheckbox.Checked;

      if(OutputAppRadioNone.Checked)
      {
        Program.Controller.PostTransformInstruction = "None";
      }
      else if (OutputAppRadioDefault.Checked)
      {
        Program.Controller.PostTransformInstruction = "Default";

      } else if (OutputAppRadioCustom.Checked)
      {
        Program.Controller.PostTransformInstruction = "Custom";
      }
    }

    private void ReadUserSettings()
    {

      TransformFileText.Text = Program.Controller.TransformFilePath;
      OutputFileText.Text = Program.Controller.TargetFilePath;
      OverwriteCheckBox.Checked = Program.Controller.OverwriteTarget;
      AppFileText.Text = Program.Controller.TargetApplicationFilePath;
      DefinitionFileText.Text = Program.Controller.DefinitionFilePath;
      DefinitionFileDropCheckBox.Checked = Program.Controller.TransformDragDrop;
      GenerateXmlCheckbox.Checked = Program.Controller.GenerateXml;

      switch (Program.Controller.PostTransformInstruction)
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

    #endregion




  }
}

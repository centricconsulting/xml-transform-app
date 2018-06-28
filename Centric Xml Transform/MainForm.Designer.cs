namespace Centric.XmlTransform
{
  partial class MainForm
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
      this.TransformGroup = new System.Windows.Forms.GroupBox();
      this.TransformFileButton = new System.Windows.Forms.Button();
      this.TransformFileText = new System.Windows.Forms.TextBox();
      this.TransformFileLabel = new System.Windows.Forms.Label();
      this.DefinitionGroup = new System.Windows.Forms.GroupBox();
      this.DefinitionFileDropCheckBox = new System.Windows.Forms.CheckBox();
      this.DefinitionFileButton = new System.Windows.Forms.Button();
      this.DefinitionFileText = new System.Windows.Forms.TextBox();
      this.DefinitionFileLabel = new System.Windows.Forms.Label();
      this.OutputGroup = new System.Windows.Forms.GroupBox();
      this.OpenOutputFileButton = new System.Windows.Forms.Button();
      this.OutputAppButton = new System.Windows.Forms.Button();
      this.AppFileText = new System.Windows.Forms.TextBox();
      this.OutputAppRadioCustom = new System.Windows.Forms.RadioButton();
      this.OutputAppRadioDefault = new System.Windows.Forms.RadioButton();
      this.OutputAppRadioNone = new System.Windows.Forms.RadioButton();
      this.GenerateXmlCheckbox = new System.Windows.Forms.CheckBox();
      this.OverwriteCheckBox = new System.Windows.Forms.CheckBox();
      this.OutputFileButton = new System.Windows.Forms.Button();
      this.OutputFileText = new System.Windows.Forms.TextBox();
      this.OutputFileLabel = new System.Windows.Forms.Label();
      this.TransformButton = new System.Windows.Forms.Button();
      this.CloseButton = new System.Windows.Forms.Button();
      this.DefinitionFileDialog = new System.Windows.Forms.OpenFileDialog();
      this.TransformFileDialog = new System.Windows.Forms.OpenFileDialog();
      this.InstructionLabel = new System.Windows.Forms.Label();
      this.OutputFileDialog = new System.Windows.Forms.SaveFileDialog();
      this.AppFileDialog = new System.Windows.Forms.OpenFileDialog();
      this.TransformDateLabel = new System.Windows.Forms.Label();
      this.TransformGroup.SuspendLayout();
      this.DefinitionGroup.SuspendLayout();
      this.OutputGroup.SuspendLayout();
      this.SuspendLayout();
      // 
      // TransformGroup
      // 
      this.TransformGroup.Controls.Add(this.TransformFileButton);
      this.TransformGroup.Controls.Add(this.TransformFileText);
      this.TransformGroup.Controls.Add(this.TransformFileLabel);
      this.TransformGroup.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.TransformGroup.Location = new System.Drawing.Point(12, 58);
      this.TransformGroup.Name = "TransformGroup";
      this.TransformGroup.Size = new System.Drawing.Size(840, 65);
      this.TransformGroup.TabIndex = 10;
      this.TransformGroup.TabStop = false;
      this.TransformGroup.Text = "Transformation Xslt";
      // 
      // TransformFileButton
      // 
      this.TransformFileButton.AutoEllipsis = true;
      this.TransformFileButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.TransformFileButton.Location = new System.Drawing.Point(793, 24);
      this.TransformFileButton.Name = "TransformFileButton";
      this.TransformFileButton.Size = new System.Drawing.Size(31, 23);
      this.TransformFileButton.TabIndex = 2;
      this.TransformFileButton.Text = "...";
      this.TransformFileButton.UseVisualStyleBackColor = true;
      this.TransformFileButton.Click += new System.EventHandler(this.TransformFileButton_Click);
      // 
      // TransformFileText
      // 
      this.TransformFileText.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.TransformFileText.Location = new System.Drawing.Point(124, 26);
      this.TransformFileText.Name = "TransformFileText";
      this.TransformFileText.Size = new System.Drawing.Size(661, 21);
      this.TransformFileText.TabIndex = 1;
      this.TransformFileText.TextChanged += new System.EventHandler(this.TransformFileText_TextChanged);
      // 
      // TransformFileLabel
      // 
      this.TransformFileLabel.AutoSize = true;
      this.TransformFileLabel.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.TransformFileLabel.Location = new System.Drawing.Point(16, 29);
      this.TransformFileLabel.Name = "TransformFileLabel";
      this.TransformFileLabel.Size = new System.Drawing.Size(88, 13);
      this.TransformFileLabel.TabIndex = 6;
      this.TransformFileLabel.Text = "T&ransfor&m File";
      // 
      // DefinitionGroup
      // 
      this.DefinitionGroup.Controls.Add(this.DefinitionFileDropCheckBox);
      this.DefinitionGroup.Controls.Add(this.DefinitionFileButton);
      this.DefinitionGroup.Controls.Add(this.DefinitionFileText);
      this.DefinitionGroup.Controls.Add(this.DefinitionFileLabel);
      this.DefinitionGroup.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.DefinitionGroup.Location = new System.Drawing.Point(12, 153);
      this.DefinitionGroup.Name = "DefinitionGroup";
      this.DefinitionGroup.Size = new System.Drawing.Size(840, 96);
      this.DefinitionGroup.TabIndex = 11;
      this.DefinitionGroup.TabStop = false;
      this.DefinitionGroup.Text = "Definition Xml or Json";
      // 
      // DefinitionFileDropCheckBox
      // 
      this.DefinitionFileDropCheckBox.AutoSize = true;
      this.DefinitionFileDropCheckBox.Checked = true;
      this.DefinitionFileDropCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
      this.DefinitionFileDropCheckBox.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.DefinitionFileDropCheckBox.Location = new System.Drawing.Point(19, 61);
      this.DefinitionFileDropCheckBox.Name = "DefinitionFileDropCheckBox";
      this.DefinitionFileDropCheckBox.Size = new System.Drawing.Size(282, 17);
      this.DefinitionFileDropCheckBox.TabIndex = 14;
      this.DefinitionFileDropCheckBox.Text = "T&ransform automatically after drag-and-drop";
      this.DefinitionFileDropCheckBox.UseVisualStyleBackColor = true;
      this.DefinitionFileDropCheckBox.CheckedChanged += new System.EventHandler(this.DefinitionFileDropCheckBox_CheckedChanged);
      // 
      // DefinitionFileButton
      // 
      this.DefinitionFileButton.AutoEllipsis = true;
      this.DefinitionFileButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.DefinitionFileButton.Location = new System.Drawing.Point(796, 25);
      this.DefinitionFileButton.Name = "DefinitionFileButton";
      this.DefinitionFileButton.Size = new System.Drawing.Size(31, 23);
      this.DefinitionFileButton.TabIndex = 13;
      this.DefinitionFileButton.Text = "...";
      this.DefinitionFileButton.UseVisualStyleBackColor = true;
      this.DefinitionFileButton.Click += new System.EventHandler(this.DefinitionFileButton_Click);
      // 
      // DefinitionFileText
      // 
      this.DefinitionFileText.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.DefinitionFileText.Location = new System.Drawing.Point(121, 25);
      this.DefinitionFileText.Name = "DefinitionFileText";
      this.DefinitionFileText.Size = new System.Drawing.Size(664, 21);
      this.DefinitionFileText.TabIndex = 12;
      this.DefinitionFileText.TextChanged += new System.EventHandler(this.DefinitionFileText_TextChanged);
      // 
      // DefinitionFileLabel
      // 
      this.DefinitionFileLabel.AutoSize = true;
      this.DefinitionFileLabel.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.DefinitionFileLabel.Location = new System.Drawing.Point(16, 28);
      this.DefinitionFileLabel.Name = "DefinitionFileLabel";
      this.DefinitionFileLabel.Size = new System.Drawing.Size(84, 13);
      this.DefinitionFileLabel.TabIndex = 10;
      this.DefinitionFileLabel.Text = "&Definition File";
      // 
      // OutputGroup
      // 
      this.OutputGroup.Controls.Add(this.OpenOutputFileButton);
      this.OutputGroup.Controls.Add(this.OutputAppButton);
      this.OutputGroup.Controls.Add(this.AppFileText);
      this.OutputGroup.Controls.Add(this.OutputAppRadioCustom);
      this.OutputGroup.Controls.Add(this.OutputAppRadioDefault);
      this.OutputGroup.Controls.Add(this.OutputAppRadioNone);
      this.OutputGroup.Controls.Add(this.GenerateXmlCheckbox);
      this.OutputGroup.Controls.Add(this.OverwriteCheckBox);
      this.OutputGroup.Controls.Add(this.OutputFileButton);
      this.OutputGroup.Controls.Add(this.OutputFileText);
      this.OutputGroup.Controls.Add(this.OutputFileLabel);
      this.OutputGroup.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputGroup.Location = new System.Drawing.Point(15, 274);
      this.OutputGroup.Name = "OutputGroup";
      this.OutputGroup.Size = new System.Drawing.Size(840, 202);
      this.OutputGroup.TabIndex = 12;
      this.OutputGroup.TabStop = false;
      this.OutputGroup.Text = "Output Profile";
      // 
      // OpenOutputFileButton
      // 
      this.OpenOutputFileButton.AutoEllipsis = true;
      this.OpenOutputFileButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.OpenOutputFileButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OpenOutputFileButton.Location = new System.Drawing.Point(741, 112);
      this.OpenOutputFileButton.Name = "OpenOutputFileButton";
      this.OpenOutputFileButton.Size = new System.Drawing.Size(83, 31);
      this.OpenOutputFileButton.TabIndex = 11;
      this.OpenOutputFileButton.Text = "Op&en";
      this.OpenOutputFileButton.UseVisualStyleBackColor = true;
      this.OpenOutputFileButton.Click += new System.EventHandler(this.OpenOutputFileButton_Click);
      // 
      // OutputAppButton
      // 
      this.OutputAppButton.AutoEllipsis = true;
      this.OutputAppButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputAppButton.Location = new System.Drawing.Point(796, 158);
      this.OutputAppButton.Name = "OutputAppButton";
      this.OutputAppButton.Size = new System.Drawing.Size(31, 23);
      this.OutputAppButton.TabIndex = 10;
      this.OutputAppButton.Text = "...";
      this.OutputAppButton.UseVisualStyleBackColor = true;
      this.OutputAppButton.Click += new System.EventHandler(this.AppFileButton_Click);
      // 
      // AppFileText
      // 
      this.AppFileText.BackColor = System.Drawing.SystemColors.Control;
      this.AppFileText.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.AppFileText.Location = new System.Drawing.Point(43, 160);
      this.AppFileText.Name = "AppFileText";
      this.AppFileText.ReadOnly = true;
      this.AppFileText.Size = new System.Drawing.Size(745, 21);
      this.AppFileText.TabIndex = 9;
      // 
      // OutputAppRadioCustom
      // 
      this.OutputAppRadioCustom.AutoSize = true;
      this.OutputAppRadioCustom.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputAppRadioCustom.Location = new System.Drawing.Point(23, 135);
      this.OutputAppRadioCustom.Name = "OutputAppRadioCustom";
      this.OutputAppRadioCustom.Size = new System.Drawing.Size(307, 17);
      this.OutputAppRadioCustom.TabIndex = 8;
      this.OutputAppRadioCustom.Text = "Automatically open &with the following application:";
      this.OutputAppRadioCustom.UseVisualStyleBackColor = true;
      // 
      // OutputAppRadioDefault
      // 
      this.OutputAppRadioDefault.AutoSize = true;
      this.OutputAppRadioDefault.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputAppRadioDefault.Location = new System.Drawing.Point(23, 112);
      this.OutputAppRadioDefault.Name = "OutputAppRadioDefault";
      this.OutputAppRadioDefault.Size = new System.Drawing.Size(269, 17);
      this.OutputAppRadioDefault.TabIndex = 7;
      this.OutputAppRadioDefault.Text = "A&utomatically open with default application";
      this.OutputAppRadioDefault.UseVisualStyleBackColor = true;
      // 
      // OutputAppRadioNone
      // 
      this.OutputAppRadioNone.AutoSize = true;
      this.OutputAppRadioNone.Checked = true;
      this.OutputAppRadioNone.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputAppRadioNone.Location = new System.Drawing.Point(23, 89);
      this.OutputAppRadioNone.Name = "OutputAppRadioNone";
      this.OutputAppRadioNone.Size = new System.Drawing.Size(175, 17);
      this.OutputAppRadioNone.TabIndex = 6;
      this.OutputAppRadioNone.TabStop = true;
      this.OutputAppRadioNone.Text = "Do &not automatically open";
      this.OutputAppRadioNone.UseVisualStyleBackColor = true;
      // 
      // GenerateXmlCheckbox
      // 
      this.GenerateXmlCheckbox.AutoSize = true;
      this.GenerateXmlCheckbox.Checked = true;
      this.GenerateXmlCheckbox.CheckState = System.Windows.Forms.CheckState.Checked;
      this.GenerateXmlCheckbox.Enabled = false;
      this.GenerateXmlCheckbox.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.GenerateXmlCheckbox.Location = new System.Drawing.Point(296, 58);
      this.GenerateXmlCheckbox.Name = "GenerateXmlCheckbox";
      this.GenerateXmlCheckbox.Size = new System.Drawing.Size(134, 17);
      this.GenerateXmlCheckbox.TabIndex = 5;
      this.GenerateXmlCheckbox.Text = "Generate Json Xml";
      this.GenerateXmlCheckbox.UseVisualStyleBackColor = true;
      this.GenerateXmlCheckbox.CheckedChanged += new System.EventHandler(this.GenerateXmlCheckbox_CheckedChanged);
      // 
      // OverwriteCheckBox
      // 
      this.OverwriteCheckBox.AutoSize = true;
      this.OverwriteCheckBox.Checked = true;
      this.OverwriteCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
      this.OverwriteCheckBox.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OverwriteCheckBox.Location = new System.Drawing.Point(122, 58);
      this.OverwriteCheckBox.Name = "OverwriteCheckBox";
      this.OverwriteCheckBox.Size = new System.Drawing.Size(153, 17);
      this.OverwriteCheckBox.TabIndex = 5;
      this.OverwriteCheckBox.Text = "O&verwrite Existing File";
      this.OverwriteCheckBox.UseVisualStyleBackColor = true;
      this.OverwriteCheckBox.CheckedChanged += new System.EventHandler(this.OverwriteCheckBox_CheckedChanged);
      // 
      // OutputFileButton
      // 
      this.OutputFileButton.AutoEllipsis = true;
      this.OutputFileButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputFileButton.Location = new System.Drawing.Point(794, 29);
      this.OutputFileButton.Name = "OutputFileButton";
      this.OutputFileButton.Size = new System.Drawing.Size(31, 23);
      this.OutputFileButton.TabIndex = 4;
      this.OutputFileButton.Text = "...";
      this.OutputFileButton.UseVisualStyleBackColor = true;
      this.OutputFileButton.Click += new System.EventHandler(this.OutputFileButton_Click);
      // 
      // OutputFileText
      // 
      this.OutputFileText.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputFileText.Location = new System.Drawing.Point(122, 31);
      this.OutputFileText.Name = "OutputFileText";
      this.OutputFileText.Size = new System.Drawing.Size(664, 21);
      this.OutputFileText.TabIndex = 3;
      this.OutputFileText.TextChanged += new System.EventHandler(this.OutputFileText_TextChanged);
      // 
      // OutputFileLabel
      // 
      this.OutputFileLabel.AutoSize = true;
      this.OutputFileLabel.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.OutputFileLabel.Location = new System.Drawing.Point(17, 34);
      this.OutputFileLabel.Name = "OutputFileLabel";
      this.OutputFileLabel.Size = new System.Drawing.Size(68, 13);
      this.OutputFileLabel.TabIndex = 19;
      this.OutputFileLabel.Text = "&Output File";
      // 
      // TransformButton
      // 
      this.TransformButton.AutoEllipsis = true;
      this.TransformButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.TransformButton.Location = new System.Drawing.Point(642, 504);
      this.TransformButton.Name = "TransformButton";
      this.TransformButton.Size = new System.Drawing.Size(86, 31);
      this.TransformButton.TabIndex = 0;
      this.TransformButton.Text = "&Transform";
      this.TransformButton.UseVisualStyleBackColor = true;
      this.TransformButton.Click += new System.EventHandler(this.TransformButton_Click);
      // 
      // CloseButton
      // 
      this.CloseButton.AutoEllipsis = true;
      this.CloseButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.CloseButton.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.CloseButton.Location = new System.Drawing.Point(753, 504);
      this.CloseButton.Name = "CloseButton";
      this.CloseButton.Size = new System.Drawing.Size(86, 31);
      this.CloseButton.TabIndex = 15;
      this.CloseButton.Text = "&Close";
      this.CloseButton.UseVisualStyleBackColor = true;
      this.CloseButton.Click += new System.EventHandler(this.CloseButton_Click);
      // 
      // DefinitionFileDialog
      // 
      this.DefinitionFileDialog.FileName = "openFileDialog1";
      // 
      // TransformFileDialog
      // 
      this.TransformFileDialog.Filter = "XSL Files (*.xsl; *.xslt) | *;xsl; *;xslt | All Files (*.*) | *.*";
      // 
      // InstructionLabel
      // 
      this.InstructionLabel.AutoSize = true;
      this.InstructionLabel.Location = new System.Drawing.Point(12, 20);
      this.InstructionLabel.Name = "InstructionLabel";
      this.InstructionLabel.Size = new System.Drawing.Size(722, 13);
      this.InstructionLabel.TabIndex = 16;
      this.InstructionLabel.Text = "Transform an Xml or Json definition file with XSLT.   Drag-drop a definition file" +
    " on the form to set a new current definition file.";
      // 
      // AppFileDialog
      // 
      this.AppFileDialog.FileName = "openFileDialog1";
      // 
      // TransformDateLabel
      // 
      this.TransformDateLabel.AutoSize = true;
      this.TransformDateLabel.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.TransformDateLabel.Location = new System.Drawing.Point(12, 513);
      this.TransformDateLabel.Name = "TransformDateLabel";
      this.TransformDateLabel.Size = new System.Drawing.Size(0, 13);
      this.TransformDateLabel.TabIndex = 17;
      // 
      // MainForm
      // 
      this.AcceptButton = this.TransformButton;
      this.AllowDrop = true;
      this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.CancelButton = this.CloseButton;
      this.ClientSize = new System.Drawing.Size(871, 552);
      this.Controls.Add(this.TransformDateLabel);
      this.Controls.Add(this.InstructionLabel);
      this.Controls.Add(this.CloseButton);
      this.Controls.Add(this.TransformButton);
      this.Controls.Add(this.OutputGroup);
      this.Controls.Add(this.DefinitionGroup);
      this.Controls.Add(this.TransformGroup);
      this.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.Name = "MainForm";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Centric Xml Transform";
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainForm_FormClosing);
      this.Load += new System.EventHandler(this.MainForm_Load);
      this.DragDrop += new System.Windows.Forms.DragEventHandler(this.MainForm_DragDrop);
      this.DragEnter += new System.Windows.Forms.DragEventHandler(this.MainForm_DragEnter);
      this.TransformGroup.ResumeLayout(false);
      this.TransformGroup.PerformLayout();
      this.DefinitionGroup.ResumeLayout(false);
      this.DefinitionGroup.PerformLayout();
      this.OutputGroup.ResumeLayout(false);
      this.OutputGroup.PerformLayout();
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.GroupBox TransformGroup;
    private System.Windows.Forms.Button TransformFileButton;
    private System.Windows.Forms.TextBox TransformFileText;
    private System.Windows.Forms.Label TransformFileLabel;
    private System.Windows.Forms.GroupBox DefinitionGroup;
    private System.Windows.Forms.Button DefinitionFileButton;
    private System.Windows.Forms.TextBox DefinitionFileText;
    private System.Windows.Forms.Label DefinitionFileLabel;
    private System.Windows.Forms.GroupBox OutputGroup;
    private System.Windows.Forms.CheckBox OverwriteCheckBox;
    private System.Windows.Forms.Button OutputFileButton;
    private System.Windows.Forms.TextBox OutputFileText;
    private System.Windows.Forms.Label OutputFileLabel;
    private System.Windows.Forms.Button TransformButton;
    private System.Windows.Forms.Button CloseButton;
    private System.Windows.Forms.OpenFileDialog DefinitionFileDialog;
    private System.Windows.Forms.OpenFileDialog TransformFileDialog;
    private System.Windows.Forms.CheckBox DefinitionFileDropCheckBox;
    private System.Windows.Forms.Button OutputAppButton;
    private System.Windows.Forms.TextBox AppFileText;
    private System.Windows.Forms.RadioButton OutputAppRadioCustom;
    private System.Windows.Forms.RadioButton OutputAppRadioDefault;
    private System.Windows.Forms.RadioButton OutputAppRadioNone;
    private System.Windows.Forms.Label InstructionLabel;
    private System.Windows.Forms.SaveFileDialog OutputFileDialog;
    private System.Windows.Forms.Button OpenOutputFileButton;
    private System.Windows.Forms.OpenFileDialog AppFileDialog;
    private System.Windows.Forms.Label TransformDateLabel;
    private System.Windows.Forms.CheckBox GenerateXmlCheckbox;
  }
}


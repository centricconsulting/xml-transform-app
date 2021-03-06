# Centric Xml Transform Utility
## Overview
**Centric Xml Transform Utility** transforms an Xml or Json file using an Xslt transformation file. The application may be used either through an interface or silently with command line arguments.

Running this application requires installation of **.NET Framework 4.5** or higher.  Windows 10 users will already have this version of .NET installed.

### Application Interface
The interface provides an easy-to-use method for selecting transform, source and target files.

![alt text](https://github.com/centricconsulting/xml-transform-app/blob/master/Application/Files/screenshot.png "Centric Xml Transform Interface")

For a walkthrough of the application, [watch this video](https://youtu.be/qDaesrvaqrM).

### Command Line Execution
Silent execution may be achieved by running the application with command line arguments.  If any command line arguments are provided, the interface will not be shown. No messages will be displayed, even in the event of an exception.

Command line arguments may be provided in any order:

Argument                  |  Description
:-------------------------|:---------------
**`-transform "{path}"`** | Identifies the Xslt file used in the transformation.  The file path replaces **`{path}`**.
**`-source "{path}"`**    | Identifies the source Xml or Json file to be transformed.  The file path replaces **`{path}`**.
**`-target "{path}"`**    | Identifies the target file resulting from the transformation.  The file path replaces **`{path}`**.
**`-overwrite`**          | Presence of the argument instructs the application to overwrite an existing target file if necessary.
**`-xml`**                | Presence of the argument instructs the application to generate an intermediate Xml file.  This is only applicable when the source file has a Json format.
**`-supress`**            | Presence of the argument instructs the application to supress generation of the target file.

**Example 1** Transform a source Xml file to a target text file.

**```"CentricXmlTransform.exe" -target "C:\Temporary\target.txt" -xslt "C:\Temporary\transform.xslt" -source "C:\Temporary\source.xml" -overwrite```**

**Example 2**
Transform a source Json file to a target text file.

**```"CentricXmlTransform.exe" -target "C:\Temporary\target.txt" -xslt "C:\Temporary\transform.xslt" -source "C:\Temporary\source.json" -overwrite```**

**Example 3**
Generate an intermediate Xml from a Json file.

**```"CentricXmlTransform.exe" -target "C:\Temporary\target.xml" -source "C:\Temporary\source.json" -supress```**

### Notes On Using Json Source Files
Json source files are internally converted to an intermediate Xml file. The intermediate Xml file will have the same file name as the source Json file, but with a file type of **`.xml`**.  This file may be saved using the **`-xml`** command line argument or equivalent checkbox in the interface.

Xml convention requires a singular root node, however there is no corresponding convention for Json.  Therefore the system adds a **`<document>`** node as a root of the Xml document.  Within the **`<document>`** node, the system also adds the following attributes: 

* **`sourceFile`** containing the source Json file name
* **`sourceModifiedTimestamp`** containing the last modified timestamp of the source Json file
* **`transformedTimestamp`** containing the local timestamp of the transformation


These attributes may be referenced in the Xslt transform file.

## Repository Contents
### [Centric XML Transform Folder](https://github.com/centricconsulting/xml-transform-app/tree/master/Centric%20Xml%20Transform)
Contains the Visual Studio 2017 Solution for this Windows application.

### [Application Folder](https://github.com/centricconsulting/xml-transform-app/tree/master/Application)
This folder contains a compiled utility **`CentricXmlTransform.exe`** and supporting DDL files.  Sample Xml and Xslt files are provided in the [Files](https://github.com/centricconsulting/xml-transform-app/tree/master/Application/Files) folder.
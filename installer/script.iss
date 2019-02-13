; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Radius Configuration Tool"
#define MyAppVersion "1.0"
#define MyAppPublisher "Radiant Systems"
;#define MyAppURL "emmatics.in"
#define MyAppExeName "BPCL_c++.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)

PrivilegesRequired=admin
AppId={{CE8607D9-6679-45C2-8C8A-8F7087D6E4EB}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
;AppPublisherURL={#MyAppURL}
;AppSupportURL={#MyAppURL}
;AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=eula.rtf
InfoBeforeFile=info.rtf
OutputDir=.
OutputBaseFilename=setup
SetupIconFile=..\other_files\images\bpcl.ico
Compression=lzma/ultra64
SolidCompression=yes
ShowLanguageDialog=no
VersionInfoVersion=1.0
VersionInfoCompany=Radiant Systems
ArchitecturesInstallIn64BitMode=x64 ia64
ArchitecturesAllowed=x86 x64 ia64
UninstallDisplayName=Radius Configuration Tool
UninstallDisplaySize=1
UninstallDisplayIcon={app}\BPCL_c++.exe
VersionInfoCopyright=2017. All Rights Reserved.
VersionInfoProductName=Radius Configuration Tool
VersionInfoProductVersion=1.0
VersionInfoProductTextVersion=Radius Configuration Tool v1.0
InternalCompressLevel=ultra64
AppPublisherURL=radiantsystems.in
AppContact=info@radiantsystems.in
AppSupportPhone=+91 80264 20859

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 
;Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 

[Files]
Source: "..\BPCL_c++\x64\Release\BPCL_c++.exe"; DestDir: "{app}"; Flags: ignoreversion ;Check: Is64BitInstallMode;
Source: "..\BPCL_c++\Release\BPCL_c++.exe"; DestDir: "{app}"; Flags: ignoreversion  ;Check: "not IsWin64";

Source: "..\redist\vc_redist.x64.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall  ;Check: Is64BitInstallMode;
Source: "..\redist\vc_redist.x86.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall  ;Check: "not IsWin64";
Source: "..\redist\NDP461-KB3102436-x86-x64-AllOS-ENU.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall  ;


Source: "..\redist\drivers\*"; DestDir: "{app}\drivers"; Flags:  ignoreversion recursesubdirs ;
;Source: "..\redist\drivers\dpinst-amd64.exe"; DestDir: "{app}\drivers"; Flags: ignoreversion  ;Check: Is64BitInstallMode;
;Source: "..\redist\drivers\dpinst-x86.exe"; DestDir: "{app}\drivers"; Flags: ignoreversion  ;Check: "not IsWin64";
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
;Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]

Filename: "{tmp}\vc_redist.x64.exe"; Parameters: "/q /norestart"; Flags:runascurrentuser ; Check: Is64BitInstallMode ; StatusMsg: "Installing x64 VC++ redistributables...";
Filename: "{tmp}\vc_redist.x86.exe"; Parameters: "/q /norestart"; Flags:runascurrentuser ;Check: "not IsWin64" ; StatusMsg: "Installing x86 VC++ redistributables...";
Filename: "{tmp}\NDP461-KB3102436-x86-x64-AllOS-ENU.exe"; Parameters: "/q /norestart"; Flags:runascurrentuser ;  StatusMsg: "Installing .NET redistributables...";
Filename: "{app}\drivers\dpinst-amd64.exe"; Parameters: "/S"; Flags: runascurrentuser  ;Check: Is64BitInstallMode; StatusMsg: "Installing device drivers (x64)...";
Filename: "{app}\drivers\dpinst-x86.exe"; Parameters: "/S"; Flags: runascurrentuser  ;Check: "not IsWin64"; StatusMsg: "Installing device drivers (x86) ...";

Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent runascurrentuser
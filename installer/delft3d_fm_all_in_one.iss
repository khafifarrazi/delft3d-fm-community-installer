; ==============================================================================
; Inno Setup Script: Delft3D Flexible Mesh Suite (All-In-One Installer)
; Bundling: DeltaShell GUI + D-Flow FM Kernels + QuickPlot + Tutorials + License
; ==============================================================================

#define MyAppName "Delft3D Flexible Mesh Suite"
#define MyAppVersion "2026.02"
#define MyAppPublisher "Deltares & Community Open Source Build"
#define MyAppURL "https://oss.deltares.nl/web/delft3dfm"
#define MyAppExeName "DeltaShell.Gui.exe"

[Setup]
AppId={{5C16C978-B937-4AE4-8D92-FDF9484F26B8}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\Deltares\Delft3D FM Suite 2026.02 OpenHMWQ
DefaultGroupName=Deltares\Delft3D FM Suite 2026.02
DisableProgramGroupPage=no
OutputBaseFilename=Delft3D_FM_Suite_2026.02_AllInOne_Setup
OutputDir=D:\Delft3D_Flexible_Mesh\Installer_Output
SetupIconFile=assets\delft3d_app.ico
UninstallDisplayIcon={app}\bin\{#MyAppExeName}
Compression=lzma2/ultra64
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog
WizardStyle=modern
DisableWelcomePage=no
ShowLanguageDialog=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Types]
Name: "full"; Description: "Instalasi Lengkap (Direkomendasikan)"
Name: "compact"; Description: "Instalasi Minimum (Hanya GUI & Mesin Solver)"
Name: "custom"; Description: "Instalasi Kustom"; Flags: iscustom

[Components]
Name: "core"; Description: "Delft3D FM Core (DeltaShell GUI + Solver Hidrodinamika/Morfologi/Gelombang/Kualitas Air)"; Types: full compact custom; Flags: fixed
Name: "quickplot"; Description: "QUICKPLOT Tool (Visualisasi kurva, profil, dan peta grid NetCDF)"; Types: full custom
Name: "tutorials"; Description: "Contoh Model & Studi Kasus Resmi (D-Flow FM, RTC, Wave, Waq)"; Types: full custom

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quickplotdesktopicon"; Description: "Buat shortcut QUICKPLOT di Desktop"; GroupDescription: "{cm:AdditionalIcons}"; Components: quickplot

[Files]
; --- 1. Delft3D FM Suite Core (GUI + Kernels x64) ---
Source: "C:\Program Files\Deltares\Delft3D FM Suite 2026.02 OpenHMWQ\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: core

; --- 2. QUICKPLOT Tool ---
Source: "D:\Delft3D_Flexible_Mesh\QUICKPLOT\QUICKPLOT 2.72.c429e046e (Windows 64bit)\*"; DestDir: "{app}\tools\quickplot"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: quickplot

; --- 3. Tutorials & Case Studies ---
Source: "D:\Delft3D_Flexible_Mesh\Tutorials\*"; DestDir: "{app}\tutorials"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: tutorials

; --- 4. Manual Panduan PDF ---
Source: "D:\Delft3D_Flexible_Mesh\Delft3D FM Suite GUI Open Source\Installation Manual Delft3D FM Suite 2026.02.pdf"; DestDir: "{app}\docs"; Flags: ignoreversion

[Icons]
; Shortcut Aplikasi Utama
Name: "{group}\{#MyAppName} 2026.02"; Filename: "{app}\bin\{#MyAppExeName}"; IconFilename: "{app}\bin\{#MyAppExeName}"
Name: "{group}\Panduan Instalasi & Penggunaan"; Filename: "{app}\docs\Installation Manual Delft3D FM Suite 2026.02.pdf"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName} 2026.02"; Filename: "{app}\bin\{#MyAppExeName}"; IconFilename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon

; Shortcut QuickPlot
Name: "{group}\QUICKPLOT"; Filename: "{app}\tools\quickplot\win64\quickplot\bin\d3d_qp.exe"; Components: quickplot
Name: "{autodesktop}\QUICKPLOT"; Filename: "{app}\tools\quickplot\win64\quickplot\bin\d3d_qp.exe"; Components: quickplot; Tasks: quickplotdesktopicon

; Shortcut Folder Tutorial
Name: "{group}\Folder Contoh Model (Tutorials)"; Filename: "{app}\tutorials"; Components: tutorials

; Konfigurasi Registry FlexNet ditangani secara dinamis pada bagian [Code] sesuai lisensi yang dipilih

[Run]
Filename: "{app}\bin\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
var
  LicenseModePage: TInputOptionWizardPage;
  LicenseFilePage: TInputFileWizardPage;

procedure InitializeWizard;
begin
  // Halaman Opsi Lisensi (Privasi Terjamin: Tanpa lisensi pribadi)
  LicenseModePage := CreateInputOptionPage(
    wpSelectProgramGroup,
    'Konfigurasi Lisensi Delft3D Flexible Mesh',
    'Tentukan file lisensi resmi (.lic) Anda untuk mengaktifkan aplikasi.',
    'Aplikasi ini memerlukan file lisensi (.lic) resmi dari Deltares.' + #13#10 +
    'Untuk menjaga privasi dan keamanan data, paket ini tidak menyertakan data lisensi pribadi.' + #13#10#13#10 +
    'Anda dapat memperoleh lisensi resmi gratis atas nama Anda sendiri di: https://download.deltares.nl/' + #13#10#13#10 +
    'Silakan pilih opsi lisensi:',
    True, False);

  LicenseModePage.Add('Pilih file lisensi (.lic) resmi yang sudah saya peroleh dari Deltares (Direkomendasikan)');
  LicenseModePage.Add('Lewati (Saya akan mengunduh dan menyalin lisensi secara manual nanti)');

  // Default ke opsi 0
  LicenseModePage.SelectedValueIndex := 0;

  // Halaman File Picker (hanya aktif jika opsi 0 dipilih)
  LicenseFilePage := CreateInputFilePage(
    LicenseModePage.ID,
    'Pilih File Lisensi Resmi Anda',
    'Tentukan lokasi file lisensi (.lic) yang Anda peroleh dari Deltares.',
    'Klik tombol Browse untuk memilih file lisensi (.lic) Anda:');

  LicenseFilePage.Add(
    'File Lisensi (*.lic):',
    'License Files (*.lic)|*.lic|All files (*.*)|*.*',
    '.lic');
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;
  if PageID = LicenseFilePage.ID then
  begin
    // Lewati halaman file picker jika user memilih opsi 1 (Lewati)
    if LicenseModePage.SelectedValueIndex <> 0 then
      Result := True;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = LicenseFilePage.ID then
  begin
    if (LicenseFilePage.Values[0] = '') or (not FileExists(LicenseFilePage.Values[0])) then
    begin
      MsgBox('File lisensi yang Anda pilih tidak ditemukan atau belum dipilih.' + #13#10#13#10 +
             'Silakan pilih file lisensi (.lic) yang valid, atau klik tombol Back lalu pilih opsi "Lewati" jika belum memiliki file lisensi saat ini.', mbError, MB_OK);
      Result := False;
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  TargetLicDir: String;
  TargetLicFile: String;
  SourceLicFile: String;
begin
  if CurStep = ssPostInstall then
  begin
    TargetLicDir := ExpandConstant('{commonpf32}\DS_Flex');
    if not DirExists(TargetLicDir) then
      ForceDirectories(TargetLicDir);

    // Konfigurasi Registry FlexNet standar Deltares
    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\WOW6432Node\FLEXlm License Manager', 'DHSDELFT_LICENSE_FILE', ';' + TargetLicDir + ';');

    if LicenseModePage.SelectedValueIndex = 0 then
    begin
      SourceLicFile := LicenseFilePage.Values[0];
      if (SourceLicFile <> '') and FileExists(SourceLicFile) then
      begin
        TargetLicFile := TargetLicDir + '\' + ExtractFileName(SourceLicFile);
        FileCopy(SourceLicFile, TargetLicFile, False);
        RegWriteStringValue(HKEY_CURRENT_USER, 'Software\FLEXlm License Manager', 'DHSDELFT_LICENSE_FILE', TargetLicFile + ';' + TargetLicDir);
      end;
    end;
  end;
end;

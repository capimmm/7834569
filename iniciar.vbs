' iniciar.vbs - Roda o abrir.ps1 totalmente oculto
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh  = CreateObject("WScript.Shell")

pasta    = fso.GetParentFolderName(WScript.ScriptFullName)
scriptPs = pasta & "\abrir.ps1"

' 0 = janela oculta, False = não espera terminar
sh.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & scriptPs & """", 0, False

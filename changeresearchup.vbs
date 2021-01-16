' https://www.techrepublic.com/article/automate-tasks-with-windows-script-hosts-sendkeys-method/
Set WshShell = WScript.CreateObject("WScript.Shell")
T1 = "DOSBox 0.72"
Sub KeyIt(Keystroke, WinTitle)
  WshShell.AppActivate WinTitle
  WScript.Sleep 1000
  WshShell.SendKeys Keystroke
End Sub
Call KeyIt( "{F5}{UP}", T1)
Call KeyIt( "{Enter}", T1)
Call KeyIt( "^s", T1)
Wscript.Quit

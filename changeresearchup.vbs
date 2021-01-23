' https://www.techrepublic.com/article/automate-tasks-with-windows-script-hosts-sendkeys-method/
' Make sure the arrow num-lock keys are working, by pressing NumLock key either a total of one, two, three, or four times.
Set WshShell = WScript.CreateObject("WScript.Shell")
T1 = "DOSBox 0.72"
T2 = "DOSBoxC"
Sub KeyIt(Keystroke, WinTitle)
  WScript.Sleep 500
  WshShell.AppActivate WinTitle
  WScript.Sleep 500
  WshShell.SendKeys Keystroke
End Sub
Call KeyIt( "{DOWN}", T1)
Call KeyIt( "{UP}", T1)
Call KeyIt( "{F5}", T1)
Call KeyIt( "{UP}", T1)
Call KeyIt( "{Enter}", T1)
Call KeyIt( "^s", T1)
WScript.Sleep 1000
WshShell.AppActivate T2
Wscript.Quit

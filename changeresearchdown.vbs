' https://www.techrepublic.com/article/automate-tasks-with-windows-script-hosts-sendkeys-method/
' Make sure the arrow num-lock keys are working, by pressing NumLock key either a total of one, two, three, or four times.
Set WshShell = WScript.CreateObject("WScript.Shell")
T1 = "DOSBox 0.72"
Sub KeyIt(Keystroke, WinTitle)
  WshShell.AppActivate WinTitle
  WScript.Sleep 1000
  WshShell.SendKeys Keystroke
End Sub
Call KeyIt( "{F5}{DOWN}", T1)
Call KeyIt( "{Enter}", T1)
Call KeyIt( "^s", T1)
Wscript.Quit

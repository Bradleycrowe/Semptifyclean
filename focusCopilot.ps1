Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
}
"@

# Try to find the Copilot window by title
$windowTitle = "Copilot"  # Change this if you're using Edge (e.g., "Microsoft Edge")
$hWnd = [WinAPI]::FindWindow($null, $windowTitle)

if ($hWnd -ne [IntPtr]::Zero) {
    [WinAPI]::SetForegroundWindow($hWnd)
    Write-Host "✅ Copilot window brought to foreground."
} else {
    Write-Host "⚠️ Copilot window not found. Make sure it's open and titled correctly."
}

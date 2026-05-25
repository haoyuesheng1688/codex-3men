' Keywords: WINCC_CLASSIC_VBS_HMIRUNTIME
Option Explicit
On Error Resume Next

Dim tag, currentValue
Set tag = HMIRuntime.Tags("Motor_StartCmd")
currentValue = tag.Read

If Err.Number <> 0 Then
    HMIRuntime.Trace "Tag read failed: " & Err.Description
    Err.Clear
Else
    tag.Write CBool(Not currentValue)
    If Err.Number <> 0 Then
        HMIRuntime.Trace "Tag write failed: " & Err.Description
        Err.Clear
    Else
        HMIRuntime.Trace "Motor_StartCmd toggled safely."
    End If
End If

Set tag = Nothing

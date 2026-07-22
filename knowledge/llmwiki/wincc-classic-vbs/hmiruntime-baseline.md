# WinCC Classic VBS HMIRuntime Baseline

Updated: 2026-07-22 17:53:59 +00:00
Keyword: WINCC_CLASSIC_VBS_HMIRUNTIME

## Source

Siemens WinCC scripting manual: https://support.industry.siemens.com/cs/attachments/109990013/WinCC_Programming_en-US_en-US.pdf

## Digest

Classic WinCC VBS examples must start with explicit error handling, access tags through HMIRuntime.Tags, and release external COM/OLE resources before script exit. File, SQL, and OLE examples must include failure checks and runtime trace output.

# S7-200 SMART V3 versus V2 Deep-Diff Priority

Updated: 2026-06-22 18:46:54 +00:00
Keywords: S7200SMART_V3_V2_DIFF, S7200SMART_FB_USAGE

## Official Source Baseline

S7-200 SMART V3 System Manual:
https://support.industry.siemens.com/cs/attachments/109978364/S7-200_SMART_V3_system_manual_en-HS.pdf

## Current Learning Focus

Build a V3/V2 migration matrix. Prioritize FB block behavior, FB instance data, static local data, parameter passing, subroutine versus function block use, and syntax or instruction changes that can break migrated V2 projects.

The learning loop must extract:

- How V3 defines and calls FBs.
- How an FB instance stores block parameters and static local data.
- Whether V2 projects require structural edits before V3 import or compile.
- Which syntax differences affect reusable industrial blocks.
- Which behaviors must be verified in STEP 7-Micro/WIN SMART locally.

## Validation Boundary

Any V3/V2 compile, import, download, or online behavior must be marked `needs-local-validation` until checked on the local Windows workstation.

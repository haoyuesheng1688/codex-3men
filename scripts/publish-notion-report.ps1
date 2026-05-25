param(
  [Parameter(Mandatory = $true)]
  [string]$ReportPath,

  [Parameter(Mandatory = $true)]
  [string]$Title,

  [string]$ParentPageId = $env:NOTION_PARENT_PAGE_ID
)

$ErrorActionPreference = "Stop"

if (-not $env:NOTION_TOKEN) {
  throw "NOTION_TOKEN is not set."
}

$notionToken = ($env:NOTION_TOKEN -replace '[^\x20-\x7E]', '').Trim()
$ParentPageId = ($ParentPageId -replace '[^\x20-\x7E]', '').Trim()

if (-not $ParentPageId) {
  throw "NOTION_PARENT_PAGE_ID is not set."
}

if (-not (Test-Path -LiteralPath $ReportPath)) {
  throw "Report file not found: $ReportPath"
}

$content = Get-Content -LiteralPath $ReportPath -Raw

function New-RichText {
  param([string]$Text)
  return ,@(
    @{
      type = "text"
      text = @{ content = $Text }
    }
  )
}

function New-ParagraphBlock {
  param([string]$Text)
  return @{
    object = "block"
    type = "paragraph"
    paragraph = @{ rich_text = (New-RichText -Text $Text) }
  }
}

$blocks = New-Object System.Collections.Generic.List[object]
$current = New-Object System.Text.StringBuilder

foreach ($line in ($content -split "`r?`n")) {
  if ($line -match '^(#{1,3})\s+(.+)$') {
    if ($current.Length -gt 0) {
      $blocks.Add((New-ParagraphBlock -Text $current.ToString().Trim())) | Out-Null
      $current.Clear() | Out-Null
    }
    $level = $Matches[1].Length
    $text = $Matches[2]
    $type = if ($level -eq 1) { "heading_1" } elseif ($level -eq 2) { "heading_2" } else { "heading_3" }
    $blocks.Add(@{
      object = "block"
      type = $type
      $type = @{ rich_text = (New-RichText -Text $text) }
    }) | Out-Null
  } elseif ($line -match '^\s*-\s+(.+)$') {
    if ($current.Length -gt 0) {
      $blocks.Add((New-ParagraphBlock -Text $current.ToString().Trim())) | Out-Null
      $current.Clear() | Out-Null
    }
    $blocks.Add(@{
      object = "block"
      type = "bulleted_list_item"
      bulleted_list_item = @{ rich_text = (New-RichText -Text $Matches[1]) }
    }) | Out-Null
  } elseif ([string]::IsNullOrWhiteSpace($line)) {
    if ($current.Length -gt 0) {
      $blocks.Add((New-ParagraphBlock -Text $current.ToString().Trim())) | Out-Null
      $current.Clear() | Out-Null
    }
  } else {
    [void]$current.AppendLine($line)
  }
}

if ($current.Length -gt 0) {
  $blocks.Add((New-ParagraphBlock -Text $current.ToString().Trim())) | Out-Null
}

$body = @{
  parent = @{ page_id = $ParentPageId }
  properties = @{
    title = @(
      @{
        type = "text"
        text = @{ content = $Title }
      }
    )
  }
  children = $blocks.ToArray()
} | ConvertTo-Json -Depth 20

$headers = @{
  Authorization = "Bearer $notionToken"
  "Notion-Version" = "2022-06-28"
  "Content-Type" = "application/json"
}

$response = Invoke-RestMethod -Method Post -Uri "https://api.notion.com/v1/pages" -Headers $headers -Body $body
$response.url

import os
# TODO: Rename this module to ``utils``
type
  TStatusEnum* = enum
    sUnknown = -1, sBuildFailure, sBuildInProgress, sBuildSuccess, 
    sTestFailure, sTestInProgress, sTestSuccess, # ORDER MATTERS!
    sDocGenFailure, sDocGenInProgress, sDocGenSuccess

  TStatus* = object
    status*: TStatusEnum
    desc*: string
    hash*: string
    
proc initStatus*(): TStatus =
  result.status = sUnknown
  result.desc = ""
  result.hash = ""

proc isInProgress*(status: TStatusEnum): bool =
  return status == sBuildInProgress or status == sTestInProgress or
         status == sDocGenInProgress

proc `$`*(status: TStatusEnum): string =
  case status
  of sBuildFailure:
    return "build failure"
  of sBuildInProgress:
    return "build in progress"
  of sBuildSuccess:
    return "build finished"
  of sTestFailure:
    return "testing failure"
  of sTestInProgress:
    return "testing in progress"
  of sTestSuccess:
    return "testing finished"
  of sDocGenFailure:
    return "documentation generation failed"
  of sDocGenInProgress:
    return "generating documentation"
  of sDocGenSuccess:
    return "documentation generation succeeded"
  of sUnknown:
    return "unknown"
    
proc makeCommitPath*(platform, hash: string): string =
  return platform / "nimrod_" & hash.copy(0, 11) # 11 Chars.

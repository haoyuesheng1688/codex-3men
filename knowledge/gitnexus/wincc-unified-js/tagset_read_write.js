// Keywords: WINCC_UNIFIED_JS_TAGSET
export function ToggleMotorTags() {
  try {
    const tagSet = Tags.CreateTagSet(["Motor_StartCmd", "Motor_StopCmd"]);
    tagSet.Read();

    const startTag = tagSet("Motor_StartCmd");
    const stopTag = tagSet("Motor_StopCmd");

    startTag.Value = !startTag.Value;
    stopTag.Value = false;
    tagSet.Write();

    HMIRuntime.Trace("Motor tag set updated.");
  } catch (err) {
    HMIRuntime.Trace(`ToggleMotorTags failed: ${err.message}`);
  }
}

within Buildings.Templates.AHUs.Validation.UserProject.AHUs;
model BaseWithSensors
  extends VAVSingleDuct_old(
    final id="VAV_1",
    nZon=1,
    nGro=1,
    redeclare Buildings.Templates.BaseClasses.Sensors.Temperature TOut,
    redeclare Buildings.Templates.BaseClasses.Sensors.Temperature TMix,
    redeclare Buildings.Templates.BaseClasses.Sensors.HumidityRatio xSup,
    redeclare Buildings.Templates.BaseClasses.Sensors.DifferentialPressure
      pSup_rel,
    redeclare Buildings.Templates.BaseClasses.Sensors.VolumeFlowRate VRet_flow,
    redeclare Buildings.Templates.BaseClasses.Sensors.DifferentialPressure
      pRet_rel,
    redeclare Buildings.Templates.BaseClasses.Sensors.VolumeFlowRate VSup_flow,
    redeclare Buildings.Templates.BaseClasses.Sensors.VolumeFlowRate VOut_flow,
    redeclare Buildings.Templates.BaseClasses.Sensors.DifferentialPressure
      dpOutMin);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseWithSensors;

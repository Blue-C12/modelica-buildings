within Buildings.Templates.ChilledWaterPlant.Validation;
model RP1711_6_6
  "Parallel Chillers, Primary-Secondary CHW, Constant CW, Dedicated Primary CHW Pumps, Headered CW Pumps"
  extends Buildings.Templates.ChilledWaterPlant.Validation.BaseWaterCooled(redeclare
      Buildings.Templates.ChilledWaterPlant.Validation.UserProject.RP1711_6_6 chw);
  annotation (
  experiment(Tolerance=1e-6, StopTime=1));
end RP1711_6_6;

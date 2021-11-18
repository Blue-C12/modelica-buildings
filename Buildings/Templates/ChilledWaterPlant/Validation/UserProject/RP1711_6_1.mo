within Buildings.Templates.ChilledWaterPlant.Validation.UserProject;
model RP1711_6_1
  extends Buildings.Templates.ChilledWaterPlant.WaterCooledParallel(
    chiGro(final nChi=2),
    pumPri(final nPum=2, final has_floSen=true),
    pumCon(final nPum=2),
    cooTow(final nCooTow=2),
    final has_WSEByp=false,
    final has_byp=true,
    final id="CHW_1");

  annotation (
    defaultComponentName="ahu");
end RP1711_6_1;

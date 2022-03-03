within Buildings.Templates.AirHandlersFans.Validation.UserProject.AHUs;
model FanSupplyDrawArrayVariable
  extends Buildings.Templates.AirHandlersFans.VAVMultiZone(
    nZon=2,
    redeclare replaceable Buildings.Templates.Components.Fans.ArrayVariable
      fanSupDra);

  annotation (
    defaultComponentName="ahu");
end FanSupplyDrawArrayVariable;

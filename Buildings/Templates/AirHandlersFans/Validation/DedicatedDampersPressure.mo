within Buildings.Templates.AirHandlersFans.Validation;
model DedicatedDampersPressure
  extends BaseNoEconomizer(redeclare UserProject.AHUs.DedicatedDampersPressure
      VAV_1);
  annotation (
  experiment(Tolerance=1e-6, StopTime=1));
end DedicatedDampersPressure;

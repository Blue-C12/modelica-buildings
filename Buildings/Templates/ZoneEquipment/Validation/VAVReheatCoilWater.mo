within Buildings.Templates.ZoneEquipment.Validation;
model VAVReheatCoilWater
  extends BaseNoEquipment(
    redeclare UserProject.TerminalUnits.VAVReheatCoilWater ter);
  Fluid.Sources.Boundary_pT bou2(redeclare final package Medium = MediumHea,
      nPorts=1)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Fluid.Sources.Boundary_pT bou3(redeclare final package Medium = MediumHea,
      nPorts=1)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
equation
  connect(bou2.ports[1], ter.port_coiRehSup) annotation (Line(points={{-60,-40},
          {-2,-40},{-2,-19.8}}, color={0,127,255}));
  connect(ter.port_coiRehRet, bou3.ports[1]) annotation (Line(points={{2,-19.8},
          {2,-80},{-60,-80},{-60,-80}}, color={0,127,255}));
  annotation (
  experiment(Tolerance=1e-6, StopTime=1),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VAVReheatCoilWater;

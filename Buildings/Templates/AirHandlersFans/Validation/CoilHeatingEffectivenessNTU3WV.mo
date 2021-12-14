within Buildings.Templates.AirHandlersFans.Validation;
model CoilHeatingEffectivenessNTU3WV
  extends NoEconomizer(   redeclare
      UserProject.AHUs.CoilHeatingEffectivenessNTU3WV ahu);

  Fluid.Sources.Boundary_pT bou2(
    redeclare final package Medium = MediumHea, nPorts=1)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Fluid.Sources.Boundary_pT bou3(redeclare final package Medium = MediumHea,
      nPorts=1)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(bou3.ports[1], ahu.port_coiHeaRehSup) annotation (Line(points={{-40,
          -80},{16,-80},{16,-20},{15,-20}}, color={0,127,255}));
  connect(bou2.ports[1], ahu.port_coiHeaRehRet)
    annotation (Line(points={{-40,-50},{9,-50},{9,-20}}, color={0,127,255}));
  annotation (
  experiment(Tolerance=1e-6, StopTime=1));
end CoilHeatingEffectivenessNTU3WV;

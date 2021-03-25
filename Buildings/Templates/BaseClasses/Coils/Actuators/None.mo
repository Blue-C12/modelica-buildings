within Buildings.Templates.BaseClasses.Coils.Actuators;
model None "No actuator"
  extends Buildings.Templates.Interfaces.Actuator(
    final typ=Types.Actuator.None);

equation
  connect(port_bSup, port_aSup)
    annotation (Line(points={{-40,100},{-40,-100}}, color={0,127,255}));
  connect(port_bRet, port_aRet)
    annotation (Line(points={{40,-100},{40,100}}, color={0,127,255}));

end None;

within Buildings.Templates.AHUs.Sensors;
model Temperature
  extends Interfaces.Sensor(
    y(final unit="K", displayUnit="degC"),
    final typ=Types.Sensor.Temperature);
  extends Data.Temperature
    annotation (IconMap(primitivesVisible=false));
  Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare final package Medium=Medium,
    final m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(port_a, senTem.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(senTem.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(senTem.T, y)
    annotation (Line(points={{0,11},{0,120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end Temperature;

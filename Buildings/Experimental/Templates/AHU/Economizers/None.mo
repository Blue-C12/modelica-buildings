within Buildings.Experimental.Templates.AHU.Economizers;
model None
  extends Interfaces.Economizer(
    final typ=Types.Economizer.None);

  BaseClasses.PassThrough pas(redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));
  BaseClasses.PassThrough pas1(redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium =
        Medium) "Exhaust/relief air" annotation (Placement(transformation(
          extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,60},{-90,
            80}})));
equation
  connect(port_Exh, pas.port_b)
    annotation (Line(points={{-100,60},{-10,60}}, color={0,127,255}));
  connect(port_Ret, pas.port_a)
    annotation (Line(points={{100,60},{10,60}}, color={0,127,255}));
  connect(port_Out, pas1.port_a)
    annotation (Line(points={{-100,-60},{-10,-60}}, color={0,127,255}));
  connect(pas1.port_b, port_Sup)
    annotation (Line(points={{10,-60},{100,-60}}, color={0,127,255}));
  annotation (
  defaultComponentName="eco",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
          points={{-100,70},{100,70}},
          color={28,108,200},
          thickness=1),                                       Line(
          points={{-100,-70},{100,-70}},
          color={28,108,200},
          thickness=1)}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end None;

within Buildings.Templates.BaseClasses.Coils;
model WaterBased
  extends Buildings.Templates.Interfaces.Coil(
    final typ=Types.Coil.WaterBased,
    final have_sou=true,
    final have_weaBus=false);

  inner parameter Modelica.SIunits.MassFlowRate mWat_flow_nominal(min=0)=
    dat.getReal(varName=id + "." + funStr + " coil.Liquid mass flow rate")
    "Liquid mass flow rate"
    annotation(Dialog(group = "Nominal condition"), Evaluate=true);
//     Templates.BaseClasses.getReal(
//       id + "." + funStr + " coil.Liquid mass flow rate",
//       dat.fileName)
  inner parameter Modelica.SIunits.PressureDifference dpWat_nominal(
    displayUnit="Pa")=
    dat.getReal(varName=id + "." + funStr + " coil.Liquid pressure drop")
    "Liquid pressure drop"
    annotation(Dialog(group = "Nominal condition"), Evaluate=true);
    // Templates.BaseClasses.getReal(
    //   id + "." + funStr + " coil.Liquid pressure drop",
    //   dat.fileName)

  Actuators.Wrapper act(
    final typ=typAct,
    redeclare final package Medium = MediumSou)
    "Actuator"
    annotation (
      Placement(transformation(extent={{-10,-70},{10,-50}})));

  // TODO: conditional choices based on funStr to restrict HX models for cooling.
  HeatExchangers.WrapperWater hex(
    final typ=typHexWat,
    redeclare final package Medium1 = MediumSou,
    redeclare final package Medium2 = MediumAir,
    final m1_flow_nominal=mWat_flow_nominal,
    final m2_flow_nominal=mAir_flow_nominal,
    final dp1_nominal=if typAct==Types.Actuator.None then
      dpWat_nominal else 0,
    final dp2_nominal=dpAir_nominal)
    "Heat exchanger"
    annotation (
      Placement(transformation(extent={{10,4},{-10,-16}})));

  Modelica.Blocks.Routing.RealPassThrough yCoiCoo if funStr=="Cooling"
    "Pass through to connect with specific control signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,50})));
  Modelica.Blocks.Routing.RealPassThrough yCoiHea if funStr=="Heating"
    "Pass through to connect with specific control signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,50})));
  Modelica.Blocks.Routing.RealPassThrough yCoiReh if funStr=="Reheat"
    "Pass through to connect with specific control signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,50})));
equation
  connect(port_aSou, act.port_aSup) annotation (Line(points={{-40,-100},{-40,-80},
          {-4,-80},{-4,-70}}, color={0,127,255}));
  connect(act.port_bRet, port_bSou) annotation (Line(points={{4,-70},{4,-80},{40,
          -80},{40,-100}}, color={0,127,255}));
  connect(act.port_bSup,hex. port_a1) annotation (Line(points={{-4,-50},{-4,-22},
          {20,-22},{20,-12},{10,-12}}, color={0,127,255}));
  connect(hex.port_b1, act.port_aRet) annotation (Line(points={{-10,-12},{-20,-12},
          {-20,-24},{4,-24},{4,-50}}, color={0,127,255}));
  connect(port_a,hex. port_a2)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(hex.port_b2, port_b) annotation (Line(points={{10,0},{56,0},{56,0},{100,
          0}}, color={0,127,255}));

  connect(yCoiCoo.y, act.y)
    annotation (Line(points={{-40,39},{-40,-60},{-11,-60}}, color={0,0,127}));
  connect(yCoiHea.y, act.y) annotation (Line(points={{-1.9984e-15,39},{
          -1.9984e-15,30},{0,30},{0,20},{-40,20},{-40,-60},{-11,-60}},
                                                           color={0,0,127}));
  connect(busCon.out.yCoiHea, yCoiHea.u) annotation (Line(
      points={{0.1,100.1},{0.1,82},{0,82},{0,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(busCon.out.yCoiCoo, yCoiCoo.u) annotation (Line(
      points={{0.1,100.1},{-2,100.1},{-2,80},{-40,80},{-40,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(busCon.out.yCoiReh, yCoiReh.u) annotation (Line(
      points={{0.1,100.1},{0.1,100.1},{2,100.1},{2,80},{40,80},{40,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(yCoiReh.y, act.y) annotation (Line(points={{40,39},{40,20},{-40,20},{
          -40,-60},{-11,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<p>
Using modified getReal function with annotation(__Dymola_translate=true)
avoids warning for non literal nominal attributes.
Not supported by OCT though:
Compliance error at line 8, column 4, 
  Constructors for external objects is not supported in functions

</p>
</html>"));
end WaterBased;

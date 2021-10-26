within Buildings.Templates.Components.Coils;
model WaterBasedHeating "Water-based"
  extends Buildings.Templates.Components.Interfaces.Coil(
    final typ=Types.Coil.WaterBased,
    final typHex=hex.typ,
    final typAct=act.typ,
    final have_sou=true,
    final have_weaBus=false);

  inner parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal(min=0)=
    dat.getReal(varName=id + ".Mechanical." + funStr + " coil.Air mass flow rate.value")
    "Air mass flow rate"
    annotation (Dialog(
      group="Nominal condition"),
      Evaluate=true);

  inner parameter Modelica.SIunits.PressureDifference dpAir_nominal(
    displayUnit="Pa")=
    dat.getReal(varName=id + ".Mechanical." + funStr + " coil.Air pressure drop.value")
    "Air pressure drop"
    annotation (
      Dialog(group="Nominal condition"),
      Evaluate=true);

  inner parameter Modelica.SIunits.MassFlowRate mWat_flow_nominal(min=0)=
    dat.getReal(varName=id + ".Mechanical." + funStr + " coil.Liquid mass flow rate.value")
    "Liquid mass flow rate"
    annotation(Dialog(group = "Nominal condition"), Evaluate=true);

  inner parameter Modelica.SIunits.PressureDifference dpWat_nominal(
    displayUnit="Pa")=
    dat.getReal(varName=id + ".Mechanical." + funStr + " coil.Liquid pressure drop.value")
    "Liquid pressure drop"
    annotation(Dialog(group = "Nominal condition"), Evaluate=true);

  replaceable Buildings.Templates.Components.Actuators.None act constrainedby
    Interfaces.Actuator(redeclare final package Medium = MediumSou) "Actuator"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-10,
            -70},{10,-50}})));

  replaceable
    Buildings.Templates.Components.HeatExchangers.DryCoilEffectivenessNTU hex
    constrainedby Interfaces.HeatExchangerWater(
    redeclare final package Medium1 = MediumSou,
    redeclare final package Medium2 = MediumAir,
    final m1_flow_nominal=mWat_flow_nominal,
    final m2_flow_nominal=mAir_flow_nominal,
    final dp1_nominal=if typAct == Types.Actuator.None then dpWat_nominal else
        0,
    final dp2_nominal=dpAir_nominal) "Heat exchanger" annotation (choices(
        choice(redeclare
          Templates.BaseClasses.Coils.HeatExchangers.DryCoilEffectivenessNTU
          hex "Epsilon-NTU dry heat exchanger model")), Placement(
        transformation(extent={{10,4},{-10,-16}})));

equation
  /* Equipment signal connection - start */
  connect(bus.out.y, act.y);
  /* Equipment signal connection - end */
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

  connect(hex.port_b2, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  annotation (Icon(
    graphics={
      Bitmap(
        extent={{-80,-80},{80,80}},
        fileName="modelica://Buildings/Resources/Images/Templates/BaseClasses/Coils/WaterBasedHeating.svg")},
    coordinateSystem(preserveAspectRatio=false)), Diagram(
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
end WaterBasedHeating;

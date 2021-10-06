﻿within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Generic;
model PlantEnable
  "Sequence to enable/disable boiler plant based on heating hot-water requirements"

  parameter Integer nIgnReq(
    final min=0) = 0
    "Number of hot-water requests to be ignored before enablng boiler plant loop";

  parameter Integer nSchRow(
    final min=1) = 4
    "Number of rows to be created for plant schedule table";

  parameter Real schTab[nSchRow,2] = [0,1; 6,1; 18,1; 24,1]
    "Table defining schedule for enabling plant";

  parameter Real TOutLoc(
    final unit="K",
    final displayUnit="K") = 300
    "Boiler lock-out temperature for outdoor air";

  parameter Real locDt(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature") = 1
    "Temperature deadband for boiler lockout"
    annotation (Dialog(tab="Advanced"));

  parameter Real plaOffThrTim(
    final unit="s",
    final displayUnit="s") = 900
    "Minimum time for which the plant has to stay off once it has been disabled";

  parameter Real plaOnThrTim(
    final unit="s",
    final displayUnit="s") = plaOffThrTim
    "Minimum time for which the boiler plant has to stay on once it has been enabled";

  parameter Real staOnReqTim(
    final unit="s",
    final displayUnit="s") = 180
    "Time-limit for receiving hot-water requests to maintain enabled plant on";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput supResReq
    "Number of heating hot-water requests"
    annotation(Placement(transformation(extent={{-200,30},{-160,70}}),
      iconTransformation(extent={{-140,30},{-100,70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature")
    "Measured outdoor air temperature"
    annotation (Placement(transformation(extent={{-200,-70},{-160,-30}}),
      iconTransformation(extent={{-140,-70},{-100,-30}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPla
    "Plant enable signal"
    annotation (Placement(transformation(extent={{160,-20},{200,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable enaSch(
    final table=schTab,
    final smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    final timeScale=3600)
    "Table defining when plant can be enabled"
    annotation (Placement(transformation(extent={{-150,-120},{-130,-100}})));

protected
  Buildings.Controls.OBC.CDL.Logical.And and2
    "Logical And"
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));

  Buildings.Controls.OBC.CDL.Logical.Not not4
    "Logical not"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre1
    "Logical pre block"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    final delayTime=staOnReqTim)
    "Enable delay for minimum requests required to keep plant enabled"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(
    final delayTime=plaOnThrTim)
    "Enable delay to ensure plant stays enabled for required time period"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel2(
    final delayTime=plaOffThrTim,
    final delayOnInit=true)
    "Enable delay to ensure plant stays disabled for required time period"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThr(
    final threshold=0.5)
    "Check if schedule lets the controller enable the plant or not"
    annotation (Placement(transformation(extent={{-120,-120},{-100,-100}})));

  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr(
    final threshold=nIgnReq)
    "Check if number of requests is greater than number of requests to be ignored"
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat
    "Maintain plant status till the conditions to change it are met"
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(
    final nu=4)
    "Check if all the conditions for enabling plant have been met"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=3)
    "Check if any conditions except plant-on time have been satisfied to disable plant"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1
    "Logical Not"
    annotation (Placement(transformation(extent={{0,-120},{20,-100}})));

  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final p=TOutLoc,
    final k=-1)
    "Compare measured outdoor air temperature to boiler lockout temperature"
    annotation (Placement(transformation(extent={{-150,-60},{-130,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uLow=-locDt,
    final uHigh=0)
    "Hysteresis loop to prevent cycling caused by measured value"
    annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));

  Buildings.Controls.OBC.CDL.Logical.Not not3
    "Logical Not"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));

  Buildings.Controls.OBC.CDL.Logical.Not not2
    "Logical Not"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));

equation
  connect(yPla, yPla)
    annotation (Line(points={{180,0},{180,0}},
      color={255,0,255}));
  connect(greThr.y, not1.u)
    annotation (Line(points={{-98,-110},{-2,-110}},
      color={255,0,255}));
  connect(hys.u, addPar.y)
    annotation (Line(points={{-122,-50},{-128,-50}},
      color={0,0,127}));
  connect(not2.u, hys.y)
    annotation (Line(points={{-2,-70},{-86,-70},{-86,-50},{-98,-50}},
      color={255,0,255}));
  connect(intGreThr.y, not3.u)
    annotation (Line(points={{-98,50},{-80,50},{-80,-30},{-42,-30}},
      color={255,0,255}));
  connect(greThr.y, mulAnd.u[1])
    annotation (Line(points={{-98,-110},{-92,-110},{-92,95.25},{78,95.25}},
      color={255,0,255}));
  connect(hys.y, mulAnd.u[2])
    annotation (Line(points={{-98,-50},{-86,-50},{-86,91.75},{78,91.75}},
      color={255,0,255}));
  connect(intGreThr.y, mulAnd.u[3])
    annotation (Line(points={{-98,50},{-80,50},{-80,88.25},{78,88.25}},
      color={255,0,255}));
  connect(mulAnd.y, lat.u)
    annotation (Line(points={{102,90},{110,90},{110,0},{118,0}},
      color={255,0,255}));
  connect(intGreThr.u, supResReq)
    annotation (Line(points={{-122,50},{-180,50}},
      color={255,127,0}));
  connect(addPar.u, TOut)
    annotation (Line(points={{-152,-50},{-180,-50}},
      color={0,0,127}));
  connect(enaSch.y[1], greThr.u)
    annotation (Line(points={{-128,-110},{-122,-110}},
      color={0,0,127}));
  connect(lat.y, yPla)
    annotation (Line(points={{142,0},{180,0}},
      color={255,0,255}));
  connect(and2.y, lat.clr)
    annotation (Line(points={{102,-40},{110,-40},{110,-6},{118,-6}},
      color={255,0,255}));
  connect(mulOr.y, and2.u2)
    annotation (Line(points={{62,-70},{70,-70},{70,-48},{78,-48}},
      color={255,0,255}));
  connect(pre1.u, lat.y)
    annotation (Line(points={{-42,40},{-50,40},{-50,26},{150,26},{150,0},{142,0}},
      color={255,0,255}));
  connect(not3.y, truDel.u)
    annotation (Line(points={{-18,-30},{-2,-30}},
      color={255,0,255}));
  connect(truDel.y, mulOr.u[1])
    annotation (Line(points={{22,-30},{30,-30},{30,-65.3333},{38,-65.3333}},
      color={255,0,255}));
  connect(not2.y, mulOr.u[2])
    annotation (Line(points={{22,-70},{38,-70}},
      color={255,0,255}));
  connect(not1.y, mulOr.u[3])
    annotation (Line(points={{22,-110},{30,-110},{30,-74.6667},{38,-74.6667}},
      color={255,0,255}));
  connect(truDel1.y, and2.u1)
    annotation (Line(points={{62,-10},{70,-10},{70,-40},{78,-40}},
      color={255,0,255}));
  connect(truDel2.y, mulAnd.u[4])
    annotation (Line(points={{62,70},{70,70},{70,84.75},{78,84.75}},
      color={255,0,255}));
  connect(not4.y, truDel2.u)
    annotation (Line(points={{22,70},{38,70}},
      color={255,0,255}));
  connect(truDel1.u, pre1.y)
    annotation (Line(points={{38,-10},{-10,-10},{-10,40},{-18,40}},
      color={255,0,255}));
  connect(not4.u, pre1.y)
    annotation (Line(points={{-2,70},{-10,70},{-10,40},{-18,40}},
      color={255,0,255}));

  annotation (defaultComponentName = "plaEna",
    Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        lineThickness=0.1),
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={28,108,200},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        lineThickness=5,
        borderPattern=BorderPattern.Raised),
      Text(
        extent={{-120,146},{100,108}},
        lineColor={0,0,255},
        textString="%name"),
      Ellipse(
        extent={{-80,80},{80,-80}},
        lineColor={28,108,200},
        fillColor={170,255,213},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-90,90},{90,-90}},
        lineColor={28,108,200}),
      Rectangle(
        extent={{-75,2},{75,-2}},
        lineColor={28,108,200},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-66,46},{76,10}},
        lineColor={28,108,200},
        textString="START"),
      Text(
        extent={{-66,-8},{76,-44}},
        lineColor={28,108,200},
        textString="STOP")},
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})),
  Diagram(
    coordinateSystem(preserveAspectRatio=false,
    extent={{-160,-140},{160,140}})),
  Documentation(
    info="<html>
    <p>
    Block that generates boiler plant enable signal according to ASHRAE RP-1711
    Advanced Sequences of Operation for HVAC Systems Phase II – Central Plants
    and Hydronic Systems (March 23, 2020), section 5.3.2.1, 5.3.2.2, and 5.3.2.3.
    </p>
    <p>
    The boiler plant should be enabled and disabled according to the following
    conditions:
    </p>
    <ol>
    <li>
    An enabling schedule should be included to allow operators to lock out the 
    boiler plant during off-hour, e.g. to allow off-hour operation of HVAC systems
    except the boiler plant. The default schedule shall be 24/7 and be adjustable.
    </li>
    <li>
    The plant should be enabled when the plant has been continuously disabled
    for at least <code>plaOffThrTim</code> and: 
    <ul>
    <li>
    Number of boiler plant requests <code>supResReq</code> is greater than
    number of requests to be ignored <code>nIgnReq</code>, and,
    </li>
    <li>
    Outdoor air temperature <code>TOut</code> is lower than boiler
    lockout temperature <code>TOutLoc</code>, and,
    </li>
    <li>
    The operator defined enabling schedule <code>schTab</code> is active.
    </li>
    </ul>
    </li>
    <li>
    The plant should be disabled when it has been continuously enabled for at
    least <code>plaOnThrTim</code> and:
    <ul>
    <li>
    Number of boiler plant requests <code>supResReq</code> is less than number
    of requests to be ignored <code>nIgnReq</code> for a time
    <code>staOnReqTim</code>, or,
    </li>
    <li>
    Outdoor air temperature <code>TOut</code> is greater than boiler lockout
    temperature <code>TOutLoc</code> by <code>locDt</code> or more,ie,
    <code>TOut</code> &gt; <code>TOutLoc</code> + <code>locDt</code>, or,
    </li>
    <li>
    The operator defined enable schedule <code>schTab</code> is inactive.
    </li>
    </ul>
    </li>
    </ol>
    <p align=\"center\">
    <img alt=\"Validation plot for PlantEnable\"
    src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Generic/PlantEnable.png\"/>
    <br/>
    Validation plot generated from model <a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Generic.Validation.PlantEnable\">
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Generic.Validation.PlantEnable</a>.
    </p>
    </html>",
    revisions="<html>
    <ul>
    <li>
    May 18, 2020, by Karthik Devaprasad:<br/>
    First implementation.
    </li>
    </ul>
    </html>"));
end PlantEnable;

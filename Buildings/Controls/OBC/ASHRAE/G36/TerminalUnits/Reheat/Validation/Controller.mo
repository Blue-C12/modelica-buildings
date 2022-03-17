within Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.Reheat.Validation;
model Controller
  "Validation of model that controls terminal unit with reheat"

  Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.Reheat.Controller rehBoxCon(
    final AFlo=20,
    final desZonPop=2,
    final VZonMin_flow=0.5,
    final VCooZonMax_flow=1.5,
    final VHeaZonMin_flow=0.5,
    final VHeaZonMax_flow=1.2,
    final controllerTypeVal=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    final have_pressureIndependentDamper=false,
    final V_flow_nominal=1.5,
    final staPreMul=1,
    final hotWatRes=1,
    final floHys=0.01,
    final looHys=0.01,
    final damPosHys=0.01,
    final valPosHys=0.01) "Reheat unit controller"
    annotation (Placement(transformation(extent={{100,70},{120,110}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine TZon(
    final freqHz=1/86400,
    final amplitude=4,
    final offset=299.15)
    "Zone temperature"
    annotation (Placement(transformation(extent={{-120,220},{-100,240}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp disAirTem(
    final height=2,
    final duration=43200,
    final offset=273.15 + 15,
    final startTime=28800)
    "Discharge airflow temperture"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp damPos(
    final duration=43200,
    final height=0.7,
    final offset=0.3,
    final startTime=28800) "Damper position"
    annotation (Placement(transformation(extent={{-80,-170},{-60,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse winSta(
    final width=0.05,
    final period=43200,
    final shift=43200)
    "Window opening status"
    annotation (Placement(transformation(extent={{-80,160},{-60,180}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant cooSet(
    final k=273.15 + 24)
    "Zone cooling setpoint temperature"
    annotation (Placement(transformation(extent={{-80,200},{-60,220}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant heaSet(
    final k=273.15 + 20)
    "Zone heating setpoint temperature"
    annotation (Placement(transformation(extent={{-120,180},{-100,200}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse occ(
    final width=0.75,
    final period=43200,
    final shift=28800) "Occupancy status"
    annotation (Placement(transformation(extent={{-120,140},{-100,160}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp opeMod(
    final offset=1,
    final height=2,
    final duration=28800,
    final startTime=28800)
    "Operation mode"
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    "Convert real to integer"
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round2(
    final n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine CO2(
    final amplitude=400,
    final freqHz=1/28800,
    final offset=600) "CO2 concentration"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine parFanFlo(
    final offset=1.2,
    final amplitude=0.6,
    final freqHz=1/28800) "Parallel fan flow"
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp oveFlo(
    final height=2,
    final duration=10000,
    final startTime=35000)
    "Override flow setpoint"
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Convert real to integer"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round1(
    final n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp oveDam(
    final height=2,
    final duration=5000,
    startTime=60000) "Override damper position"
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt3
    "Convert real to integer"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round3(
    final n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp valPos(
    final duration=43200,
    final height=0.7,
    final offset=0.3,
    final startTime=28800) "Valve position"
    annotation (Placement(transformation(extent={{-120,-190},{-100,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine TSup(
    final offset=273.15 + 13,
    final amplitude=1,
    final freqHz=1/28800) "Supply air temperature from air handling unit"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse heaOff(
    final width=0.75,
    final period=3600)
    "Close heating valve"
    annotation (Placement(transformation(extent={{-120,-140},{-100,-120}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    "Logical not"
    annotation (Placement(transformation(extent={{-40,-140},{-20,-120}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse hotPla(
    final width=0.9,
    final period=7500)
    "Hot water plant status"
    annotation (Placement(transformation(extent={{-80,-250},{-60,-230}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse supFan(
    final width=0.75,
    final period=7500)
    "AHU supply fan status"
    annotation (Placement(transformation(extent={{-80,-210},{-60,-190}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TSupSet(
    final k=273.15 + 13)
    "AHU supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine disFlo(
    final offset=1.3,
    final amplitude=0.6,
    final freqHz=1/28800) "Discharge airflow rate"
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));

equation
  connect(TZon.y,rehBoxCon. TZon) annotation (Line(points={{-98,230},{52,230},{52,
          109},{98,109}}, color={0,0,127}));
  connect(cooSet.y,rehBoxCon. TZonCooSet) annotation (Line(points={{-58,210},{48,
          210},{48,107},{98,107}}, color={0,0,127}));
  connect(heaSet.y,rehBoxCon. TZonHeaSet) annotation (Line(points={{-98,190},{44,
          190},{44,105},{98,105}}, color={0,0,127}));
  connect(winSta.y,rehBoxCon. uWin) annotation (Line(points={{-58,170},{40,170},
          {40,102},{98,102}}, color={255,0,255}));
  connect(occ.y,rehBoxCon. uOcc) annotation (Line(points={{-98,150},{36,150},{36,
          100},{98,100}},  color={255,0,255}));
  connect(opeMod.y,round2. u)
    annotation (Line(points={{-98,120},{-82,120}}, color={0,0,127}));
  connect(round2.y,reaToInt2. u)
    annotation (Line(points={{-58,120},{-42,120}},
      color={0,0,127}));
  connect(reaToInt2.y,rehBoxCon. uOpeMod) annotation (Line(points={{-18,120},{32,
          120},{32,98},{98,98}},   color={255,127,0}));
  connect(CO2.y,rehBoxCon. ppmCO2) annotation (Line(points={{-58,90},{36,90},{36,
          96},{98,96}}, color={0,0,127}));
  connect(oveFlo.y,round1. u)
    annotation (Line(points={{-98,-40},{-82,-40}}, color={0,0,127}));
  connect(round1.y,reaToInt1. u)
    annotation (Line(points={{-58,-40},{-42,-40}}, color={0,0,127}));
  connect(oveDam.y, round3.u)
    annotation (Line(points={{-98,-80},{-82,-80}}, color={0,0,127}));
  connect(round3.y,reaToInt3. u)
    annotation (Line(points={{-58,-80},{-42,-80}},  color={0,0,127}));
  connect(reaToInt1.y,rehBoxCon. oveFloSet) annotation (Line(points={{-18,-40},{
          56,-40},{56,84},{98,84}},   color={255,127,0}));
  connect(disAirTem.y,rehBoxCon. TDis) annotation (Line(points={{-58,50},{40,50},
          {40,93},{98,93}}, color={0,0,127}));
  connect(reaToInt3.y,rehBoxCon. oveDamPos) annotation (Line(points={{-18,-80},{
          60,-80},{60,82},{98,82}}, color={255,127,0}));
  connect(damPos.y,rehBoxCon. uDam) annotation (Line(points={{-58,-160},{68,-160},
          {68,78},{98,78}}, color={0,0,127}));
  connect(valPos.y,rehBoxCon. uVal) annotation (Line(points={{-98,-180},{72,-180},
          {72,76},{98,76}}, color={0,0,127}));
  connect(heaOff.y, not1.u)
    annotation (Line(points={{-98,-130},{-42,-130}}, color={255,0,255}));
  connect(not1.y,rehBoxCon. uHeaOff) annotation (Line(points={{-18,-130},{64,-130},
          {64,80},{98,80}}, color={255,0,255}));
  connect(supFan.y,rehBoxCon. uFan) annotation (Line(points={{-58,-200},{76,-200},
          {76,73.2},{98,73.2}}, color={255,0,255}));
  connect(hotPla.y,rehBoxCon. uHotPla) annotation (Line(points={{-58,-240},{80,-240},
          {80,71.2},{98,71.2}}, color={255,0,255}));
  connect(TSupSet.y,rehBoxCon. TSupSet) annotation (Line(points={{-98,-10},{52,-10},
          {52,87},{98,87}}, color={0,0,127}));
  connect(TSup.y,rehBoxCon. TSup) annotation (Line(points={{-58,10},{48,10},{48,
          89},{98,89}}, color={0,0,127}));
  connect(disFlo.y,rehBoxCon. VDis_flow) annotation (Line(points={{-98,30},{44,30},
          {44,91},{98,91}}, color={0,0,127}));
annotation (
  experiment(StopTime=86400, Tolerance=1e-6),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/G36/TerminalUnits/Reheat/Validation/Controller.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.Reheat.Controller\">
Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.Reheat.Controller</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
February 10, 2022, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-260},{140,260}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}}),
                   Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}), Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,58},{64,-2},{-36,-62},{-36,58}})}));
end Controller;

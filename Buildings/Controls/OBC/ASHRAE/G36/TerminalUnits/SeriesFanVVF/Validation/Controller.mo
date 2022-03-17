within Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.SeriesFanVVF.Validation;
model Controller
  "Validation of model that controls series-fan powered unit with variable volume fan"

  Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.SeriesFanVVF.Controller serFanCon(
    final AFlo=20,
    final desZonPop=2,
    final VZonMin_flow=0.5,
    final VCooZonMax_flow=1.5,
    final maxRat=2,
    final controllerTypeVal=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    final have_pressureIndependentDamper=false,
    final V_flow_nominal=1.5,
    final staPreMul=1,
    final hotWatRes=1,
    final floHys=0.01,
    final looHys=0.01,
    final damPosHys=0.01,
    final valPosHys=0.01) "Series-fan powered unit controller"
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
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt3
    "Convert real to integer"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round3(
    final n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp oveTerFan(
    final height=2,
    final duration=5000,
    final startTime=60000) "Override terminal fan control"
    annotation (Placement(transformation(extent={{-120,-110},{-100,-90}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt4
    "Convert real to integer"
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round4(
    final n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
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
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant terFan(
    final k=true)
    "Terminal fan status"
    annotation (Placement(transformation(extent={{-120,-230},{-100,-210}})));
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
  connect(TZon.y,serFanCon. TZon) annotation (Line(points={{-98,230},{52,230},{52,
          109},{98,109}}, color={0,0,127}));
  connect(cooSet.y,serFanCon. TZonCooSet) annotation (Line(points={{-58,210},{48,
          210},{48,107},{98,107}}, color={0,0,127}));
  connect(heaSet.y,serFanCon. TZonHeaSet) annotation (Line(points={{-98,190},{44,
          190},{44,105},{98,105}}, color={0,0,127}));
  connect(winSta.y,serFanCon. uWin) annotation (Line(points={{-58,170},{40,170},
          {40,103},{98,103}}, color={255,0,255}));
  connect(occ.y,serFanCon. uOcc) annotation (Line(points={{-98,150},{36,150},{36,
          101},{98,101}},  color={255,0,255}));
  connect(opeMod.y,round2. u)
    annotation (Line(points={{-98,120},{-82,120}}, color={0,0,127}));
  connect(round2.y,reaToInt2. u)
    annotation (Line(points={{-58,120},{-42,120}},
      color={0,0,127}));
  connect(reaToInt2.y,serFanCon. uOpeMod) annotation (Line(points={{-18,120},{32,
          120},{32,99},{98,99}},   color={255,127,0}));
  connect(CO2.y,serFanCon. ppmCO2) annotation (Line(points={{-58,90},{32,90},{32,
          97},{98,97}},    color={0,0,127}));
  connect(oveFlo.y,round1. u)
    annotation (Line(points={{-98,-40},{-82,-40}},   color={0,0,127}));
  connect(round1.y,reaToInt1. u)
    annotation (Line(points={{-58,-40},{-42,-40}},   color={0,0,127}));
  connect(oveDam.y, round3.u)
    annotation (Line(points={{-98,-70},{-82,-70}}, color={0,0,127}));
  connect(round3.y,reaToInt3. u)
    annotation (Line(points={{-58,-70},{-42,-70}},   color={0,0,127}));
  connect(reaToInt1.y,serFanCon. oveFloSet) annotation (Line(points={{-18,-40},{
          56,-40},{56,87},{98,87}},   color={255,127,0}));
  connect(oveTerFan.y, round4.u)
    annotation (Line(points={{-98,-100},{-82,-100}}, color={0,0,127}));
  connect(round4.y,reaToInt4. u)
    annotation (Line(points={{-58,-100},{-42,-100}}, color={0,0,127}));
  connect(disAirTem.y,serFanCon. TDis) annotation (Line(points={{-58,50},{40,50},
          {40,95},{98,95}}, color={0,0,127}));
  connect(reaToInt3.y,serFanCon. oveDamPos) annotation (Line(points={{-18,-70},{
          60,-70},{60,85},{98,85}}, color={255,127,0}));
  connect(reaToInt4.y,serFanCon. oveFan) annotation (Line(points={{-18,-100},{64,
          -100},{64,83},{98,83}}, color={255,127,0}));
  connect(damPos.y,serFanCon. uDam) annotation (Line(points={{-58,-160},{72,-160},
          {72,79},{98,79}}, color={0,0,127}));
  connect(valPos.y,serFanCon. uVal) annotation (Line(points={{-98,-180},{76,-180},
          {76,77},{98,77}}, color={0,0,127}));
  connect(heaOff.y, not1.u)
    annotation (Line(points={{-98,-130},{-42,-130}}, color={255,0,255}));
  connect(not1.y,serFanCon. uHeaOff) annotation (Line(points={{-18,-130},{68,-130},
          {68,81},{98,81}}, color={255,0,255}));
  connect(supFan.y,serFanCon. uFan) annotation (Line(points={{-58,-200},{80,-200},
          {80,75},{98,75}}, color={255,0,255}));
  connect(terFan.y,serFanCon. uTerFan) annotation (Line(points={{-98,-220},{84,-220},
          {84,73},{98,73}}, color={255,0,255}));
  connect(hotPla.y,serFanCon. uHotPla) annotation (Line(points={{-58,-240},{88,-240},
          {88,71},{98,71}}, color={255,0,255}));
  connect(TSupSet.y,serFanCon. TSupSet) annotation (Line(points={{-98,-10},{52,-10},
          {52,89},{98,89}}, color={0,0,127}));
  connect(TSup.y,serFanCon. TSup) annotation (Line(points={{-58,10},{48,10},{48,
          91},{98,91}}, color={0,0,127}));
  connect(disFlo.y,serFanCon. VDis_flow) annotation (Line(points={{-98,30},{44,30},
          {44,93},{98,93}}, color={0,0,127}));
annotation (
  experiment(StopTime=86400, Tolerance=1e-6),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/G36/TerminalUnits/SeriesFanVVF/Validation/Controller.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.SeriesFanVVF.Controller\">
Buildings.Controls.OBC.ASHRAE.G36.TerminalUnits.SeriesFanVVF.Controller</a>.
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

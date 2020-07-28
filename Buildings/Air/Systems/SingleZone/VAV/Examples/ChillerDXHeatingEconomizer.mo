within Buildings.Air.Systems.SingleZone.VAV.Examples;
model ChillerDXHeatingEconomizer
  "Variable air volume flow system with single themal zone and conventional control"
  extends Modelica.Icons.Example;
  extends
    Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop;
  parameter Modelica.SIunits.Temperature TSupChi_nominal=279.15
    "Design value for chiller leaving water temperature";

  ChillerDXHeatingEconomizerController con(
    minAirFlo=0.1,
    minOAFra=0.4,
    kFan=4,
    kEco=4,
    kHea=4,
    TSupChi_nominal=TSupChi_nominal,
    TSetSupAir=286.15) "Controller for single zone VAV system"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Controls.OBC.CDL.Continuous.Sources.TimeTable
                                         TSetRooHea(
    table=[
      0,       15 + 273.15;
      8*3600,  20 + 273.15;
      18*3600, 15 + 273.15;
      24*3600, 15 + 273.15],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Heating setpoint for room temperature"
    annotation (Placement(transformation(extent={{-152,40},{-132,60}})));
  Controls.OBC.CDL.Continuous.Sources.TimeTable
                                         TSetRooCoo(
    table=[
      0,       30 + 273.15;
      8*3600,  25 + 273.15;
      18*3600, 30 + 273.15;
      24*3600, 30 + 273.15],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Cooling setpoint for room temperature"
    annotation (Placement(transformation(extent={{-152,10},{-132,30}})));

  Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{8,18})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-152,-44},{-132,-24}})));
equation
  connect(TSetRooHea.y[1], con.TSetRooHea)
    annotation (Line(points={{-130,50},{-110,50},{-110,8.6},{-101.4,8.6}},
                                                   color={0,0,127}));
  connect(TSetRooCoo.y[1], con.TSetRooCoo)
    annotation (Line(points={{-130,20},{-116,20},{-116,5.8},{-101.4,5.8}},
                                                                       color={0,0,127}));

  connect(hvac.uFan, con.yFan) annotation (Line(points={{-42,18},{-60,18},{-60,9},
          {-79,9}}, color={0,0,127}));
  connect(hvac.uHea, con.yHea) annotation (Line(points={{-42,12},{-58,12},{-58,
          5.4},{-79,5.4}},
                    color={0,0,127}));
  connect(con.yCooCoiVal, hvac.uCooVal) annotation (Line(points={{-79,-2},{-56,
          -2},{-56,5},{-42,5}},
                            color={0,0,127}));
  connect(hvac.uEco, con.yOutAirFra) annotation (Line(points={{-42,-2},{-52,-2},
          {-52,2},{-79,2}}, color={0,0,127}));
  connect(con.chiOn, hvac.chiOn) annotation (Line(points={{-79,-5.4},{-58,-5.4},
          {-58,-10},{-42,-10}},
                           color={255,0,255}));
  connect(hvac.TSetChi, con.TSetSupChi) annotation (Line(points={{-42,-18},{-60,
          -18},{-60,-9},{-79,-9}},                     color={0,0,127}));
  connect(hvac.TMix, con.TMix) annotation (Line(points={{1.2,-4},{8,-4},{8,-40},
          {-114,-40},{-114,3},{-101.4,3}},
                                        color={0,0,127}));
  connect(hvac.TSup, con.TSup) annotation (Line(points={{1.2,-8},{6,-8},{6,-36},
          {-110,-36},{-110,-8.6},{-101.4,-8.6}},
                                          color={0,0,127}));
  connect(zon.TRooAir, con.TRoo) annotation (Line(points={{81,0},{108,0},{108,
          -148},{-120,-148},{-120,-5.8},{-101.4,-5.8}},
                                                  color={0,0,127}));
  connect(occSch.occupied, con.uOcc) annotation (Line(points={{-131,-40},{-128,
          -40},{-128,3.60822e-16},{-102.8,3.60822e-16}},
                                           color={255,0,255}));
  connect(weaBus.TDryBul, con.TOut) annotation (Line(
      points={{-79,80},{-79,40},{-106,40},{-106,-3},{-101.4,-3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    experiment(
      StopTime=504800,
      Interval=3600,
      Tolerance=1e-06),
      __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Air/Systems/SingleZone/VAV/Examples/ChillerDXHeatingEconomizer.mos"
        "Simulate and plot"),
     Documentation(info="<html>
<p>
Implementation of <a href=\"modelica://Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop\">
Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop</a>
with conventional single-maximum control sequence.
</p>
</html>", revisions="<html>
<ul>
<li>
August 3, 2019, by David Blum:<br/>
Update to using <a href=\"modelica://Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop\">
Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.PartialOpenLoop</a>.
</li>
<li>
June 21, 2017, by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 1, 2017, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-160},{120,140}})));
end ChillerDXHeatingEconomizer;

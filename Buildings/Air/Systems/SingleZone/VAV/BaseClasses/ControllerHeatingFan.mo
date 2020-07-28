within Buildings.Air.Systems.SingleZone.VAV.BaseClasses;
model ControllerHeatingFan "Controller for heating coil and fan signal"
  extends Modelica.Blocks.Icons.Block;

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Heating coil signal"));
  parameter Real kHea(final unit="1/K")=0.1
    "Gain for heating coil control signal"
    annotation(Dialog(group="Heating coil signal"));
  parameter Real TiHea(
    final unit="s",
    final quantity="Time")=900
    "Time constant of integrator block for heating coil control signal"
    annotation(Dialog(group="Heating coil signal",
    enable=controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdHea(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for heating coil control signal"
    annotation (Dialog(group="Heating coil signal",
      enable=controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeFan=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Fan signal"));
  parameter Real kFan(final unit="1/K")=1
    "Gain for fan signal"
    annotation(Dialog(group="Fan signal"));
  parameter Real TiFan(
    final unit="s",
    final quantity="Time")=900
    "Time constant of integrator block for fan signal"
    annotation(Dialog(group="Fan signal",
    enable=controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdFan(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for fan signal"
    annotation (Dialog(group="Fan signal",
      enable=controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real minAirFlo(
    min=0,
    max=1,
    unit="1")
    "Minimum airflow rate of system";

  Modelica.Blocks.Interfaces.RealInput TSetRooCoo(
    final unit="K",
    displayUnit="degC") "Zone cooling setpoint"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput TRoo(
    final unit="K",
    displayUnit="degC")
    "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.RealInput TSetRooHea(
    final unit="K",
    displayUnit="degC") "Zone heating setpoint"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealOutput yFan(final unit="1") "Control signal for fan"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yHea(final unit="1")
    "Control signal for heating coil"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Controls.Continuous.LimPID conHeaCoi(
    final k=kHea,
    controllerType=Modelica.Blocks.Types.SimpleController.P)
    "Controller for heating coil"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Controls.Continuous.LimPID conFan(
    final k=kFan,
    final yMax=1,
    final yMin=minAirFlo,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    final reverseActing=false)
    "Controller for fan"
    annotation (Placement(transformation(extent={{20,30},{40,50}})));

equation
  connect(TSetRooHea, conHeaCoi.u_s)
    annotation (Line(points={{-110,60},{-60,60},{-60,-40},{-12,-40}},
                                                     color={0,0,127}));
  connect(TRoo, conHeaCoi.u_m) annotation (Line(points={{-110,-60},{-80,-60},{
          -80,-60},{0,-60},{0,-52}},   color={0,0,127}));
  connect(conHeaCoi.y, yHea)
    annotation (Line(points={{11,-40},{60,-40},{110,-40}},
                                                 color={0,0,127}));
  connect(conFan.u_s, TSetRooCoo) annotation (Line(points={{18,40},{18,40},{-48,
          40},{-48,40},{-80,40},{-80,0},{-110,0}},
                                                 color={0,0,127}));
  connect(TRoo, conFan.u_m) annotation (Line(points={{-110,-60},{-110,-60},{30,
          -60},{30,28}},                        color={0,0,127}));

  connect(conFan.y, yFan)
    annotation (Line(points={{41,40},{41,40},{110,40}},
                                                   color={0,0,127}));
  annotation (
  defaultComponentName="conHeaFan",
  Documentation(info="<html>
<p>
Controller for heating coil and fan speed.
</p>
</html>", revisions="<html>
<ul>
<li>
June 21, 2017, by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 1, 2017, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"));
end ControllerHeatingFan;

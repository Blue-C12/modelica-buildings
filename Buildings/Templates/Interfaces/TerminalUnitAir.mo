within Buildings.Templates.Interfaces;
partial model TerminalUnitAir
  "Interface class for terminal unit in air system"
  replaceable package MediumAir=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Air medium";

  parameter Types.TerminalUnit typ
    "Type of system"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  inner parameter String id
    annotation (
      Evaluate=true,
      Dialog(group="Configuration"));

  Modelica.Fluid.Interfaces.FluidPort_a port_Sup(
    redeclare final package Medium =MediumAir) if typ <> Types.TerminalUnit.DualDuct
    "Supply air"
    annotation (
      Placement(transformation(extent={{-310,-210},{-290,-190}}),
        iconTransformation(extent={{-210,-10},{-190,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_SupCol(
    redeclare final package Medium =MediumAir) if typ == Types.TerminalUnit.DualDuct
    "Dual duct cold deck air supply"
    annotation (Placement(transformation(
          extent={{-310,-250},{-290,-230}}), iconTransformation(extent={{-210,-110},
            {-190,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_SupHot(
    redeclare final package Medium =MediumAir) if typ == Types.TerminalUnit.DualDuct
    "Dual duct hot deck air supply"
    annotation (Placement(
        transformation(extent={{-310,-170},{-290,-150}}),
                                                        iconTransformation(
          extent={{-210,90},{-190,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Dis(
    redeclare final package Medium =MediumAir)
    "Discharge air"
    annotation (Placement(transformation(extent={{290,-210},{310,-190}}),
        iconTransformation(extent={{190,-10},{210,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Ret(
    redeclare final package Medium =MediumAir) if typ == Types.TerminalUnit.FanPowered
    or typ == Types.TerminalUnit.Induction
    "Return air"
    annotation (Placement(
        transformation(extent={{290,-90},{310,-70}}),     iconTransformation(
          extent={{190,90},{210,110}})));

  BaseClasses.Connectors.BusTerminalUnit busTer
    "Terminal unit control bus"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-300,0}), iconTransformation(
        extent={{-20,-19},{20,19}},
        rotation=90,
        origin={-199,160})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false,
    extent={{-200,-200},{200,200}}), graphics={
        Text(
          extent={{-155,-218},{145,-258}},
          lineColor={0,0,255},
          textString="%name"), Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                                       Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-300,-280},{300,
            280}}), graphics={
        Rectangle(
          extent={{-300,40},{300,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={245,239,184},
          pattern=LinePattern.None)}));
end TerminalUnitAir;

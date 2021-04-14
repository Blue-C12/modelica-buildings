within Buildings.Templates.Interfaces;
partial model AHU "Interface class for air handling unit"
  replaceable package MediumAir=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Air medium";

  parameter Boolean isModCtrSpe = true
    "Set to true to activate the control specification mode"
    annotation(Evaluate=true);

  parameter Types.AHU typ
    "Type of system"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Boolean have_porExh=typ == Types.AHU.ExhaustOnly
    "Set to true for exhaust/relief fluid port"
    annotation (
      Evaluate=true,
      Dialog(
        group="Configuration",
        enable=false));

  inner parameter String id
    annotation (
      Evaluate=true,
      Dialog(group="Configuration"));
  inner parameter Integer nZon
    "Number of served zones"
    annotation (
      Evaluate=true,
      Dialog(group="Configuration"));
  inner parameter Integer nGro
    "Number of zone groups"
    annotation (
      Evaluate=true,
      Dialog(group="Configuration"));

  Modelica.Fluid.Interfaces.FluidPort_a port_Out(
    redeclare final package Medium = MediumAir) if typ <> Types.AHU.ExhaustOnly
    "Outdoor air intake"
    annotation (Placement(transformation(
          extent={{-310,-210},{-290,-190}}), iconTransformation(extent={{-210,
            -110},{-190,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Sup(
    redeclare final package Medium =MediumAir) if typ == Types.AHU.SupplyOnly or
    typ == Types.AHU.SingleDuct
    "Supply air" annotation (
      Placement(transformation(extent={{290,-210},{310,-190}}),
        iconTransformation(extent={{190,-110},{210,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_SupCol(
    redeclare final package Medium =MediumAir) if typ == Types.AHU.DualDuct
    "Dual duct cold deck air supply"
    annotation (Placement(transformation(
          extent={{290,-250},{310,-230}}), iconTransformation(extent={{190,
            -180},{210,-160}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_SupHot(
    redeclare final package Medium =MediumAir) if typ == Types.AHU.DualDuct
    "Dual duct hot deck air supply"
    annotation (Placement(
        transformation(extent={{290,-170},{310,-150}}), iconTransformation(
          extent={{190,-40},{210,-20}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Ret(
    redeclare final package Medium =MediumAir) if typ <> Types.AHU.SupplyOnly
    "Return air"
    annotation (Placement(transformation(extent={{290,-90},{310,-70}}),
        iconTransformation(extent={{190,90},{210,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh(
    redeclare final package Medium = MediumAir) if typ <> Types.AHU.SupplyOnly and
    have_porExh
    "Exhaust/relief air"
    annotation (Placement(transformation(
          extent={{-310,-90},{-290,-70}}), iconTransformation(extent={{-210,90},
            {-190,110}})));

  BaseClasses.Connectors.BusAHU busAHU
    "AHU control bus"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-300,0}), iconTransformation(
        extent={{-20,-19},{20,19}},
        rotation=90,
        origin={-199,160})));

  BaseClasses.Connectors.BusTerminalUnit busTer[nZon]
    "Terminal unit control bus"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={300,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={198,160})));

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,
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
end AHU;

within Buildings.Templates.Interfaces;
partial model ReliefReturnSection "Exhaust/relief/return section"

  replaceable package MediumAir=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Air medium";

  parameter Types.ReliefReturn typ
    "Exhaust/relief/return section type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Templates.Types.Damper typDamRel
    "Relief damper type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Templates.Types.Fan typFan
    "Relief/return fan type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Boolean have_porPre
    "Set to true in case of fluid port for differential pressure sensor"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Boolean have_recHea
    "Set to true in case of heat recovery"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  outer parameter String id
    "System identifier";
  outer parameter ExternData.JSONFile dat
    "External parameter file";

  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,-10},{-190,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_aHeaRec(
    redeclare final package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default)) if have_recHea
    "Optional fluid connector for heat recovery"
    annotation (Placement(transformation(extent={{-130,-150},{-110,-130}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_bHeaRec(
    redeclare final package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default)) if have_recHea
    "Optional fluid connector for heat recovery"
    annotation (Placement(transformation(extent={{-70,-150},{-90,-130}})));
  BaseClasses.Connectors.BusInterface busCon
    "Control bus"
    annotation (
      Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,140}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,140})));

  BaseClasses.PassThroughFluid pas(
    redeclare final package Medium = MediumAir) if not have_recHea
     "Direct pass through (conditional)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_bRet(
    redeclare final package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default)) if
    typ<>Templates.Types.ReliefReturn.NoEconomizer
    "Optional fluid connector for return branch"
    annotation (Placement(transformation(extent={{10,-150},{-10,-130}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_bPre(
    redeclare final package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default)) if
    have_porPre
    "Optional fluid connector for differential pressure sensor"
    annotation (Placement(transformation(extent={{90,-150},{70,-130}})));
protected
  Modelica.Fluid.Interfaces.FluidPort_a port_aIns(
    redeclare final package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default))
    "Inside fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(port_aHeaRec, pas.port_a) annotation (Line(points={{-120,-140},{-120,0},
          {-110,0}}, color={0,127,255}));
  connect(port_aIns, pas.port_b)
    annotation (Line(points={{-80,0},{-90,0}}, color={0,127,255}));
  connect(port_aIns, port_bHeaRec) annotation (Line(points={{-80,0},{-80,-140},{
          -80,-140}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},
            {180,140}}), graphics={
        Text(
          extent={{-149,-150},{151,-190}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},{180,140}})));
end ReliefReturnSection;

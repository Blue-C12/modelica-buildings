within Buildings.Templates.Interfaces;
partial model OutdoorAirSection "Outdoor air section"

  replaceable package MediumAir=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Air medium";

  parameter Types.OutdoorAir typ
    "Outdoor air section type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Templates.Types.Damper typDamOut
    "Outdoor air damper type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Templates.Types.Damper typDamOutMin
    "Minimum outdoor air damper type"
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
    annotation (Placement(transformation(extent={{-190,-10},{-170,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{190,-10},{170,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_aHeaRec(
    redeclare final package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default)) if have_recHea
    "Optional fluid connector for heat recovery"
    annotation (Placement(transformation(extent={{-90,130},{-70,150}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_bHeaRec(
    redeclare final package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default)) if have_recHea
    "Optional fluid connector for heat recovery"
    annotation (Placement(transformation(extent={{-110,130},{-130,150}})));
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

protected
  Modelica.Fluid.Interfaces.FluidPort_a port_aIns(
    redeclare final package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default, nominal=MediumAir.h_default))
    "Inside fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(pas.port_b, port_aIns)
    annotation (Line(points={{-90,0},{-80,0}}, color={0,127,255}));
  connect(port_aHeaRec, port_aIns)
    annotation (Line(points={{-80,140},{-80,0},{-80,0}}, color={0,127,255}));
  connect(port_bHeaRec, pas.port_a) annotation (Line(points={{-120,140},{-120,0},
          {-110,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},
            {180,140}}), graphics={
        Text(
          extent={{-149,-150},{151,-190}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},{180,140}})));
end OutdoorAirSection;

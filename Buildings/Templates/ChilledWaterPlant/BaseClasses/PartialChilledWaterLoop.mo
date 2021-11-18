within Buildings.Templates.ChilledWaterPlant.BaseClasses;
model PartialChilledWaterLoop
  extends Buildings.Templates.ChilledWaterPlant.Interfaces.ChilledWaterPlant(
    redeclare final package Medium=MediumCHW,
    final nChi=chiGro.nChi);

  replaceable package MediumCHW=Buildings.Media.Water "Chilled water medium";

  parameter Boolean has_byp = false "Chilled water loop has bypass"
    annotation(Dialog(enable=not pumSec.is_none));
  parameter Boolean has_WSEByp = false "Waterside economizer has a bypass to supply chilled water"
    annotation(Dialog(enable=not WSE.is_none));

  final parameter Integer nPumPri = pumPri.nPum "Number of primary pumps";
  final parameter Integer nPumSec = if pumSec.is_none then 0 else pumSec.nPum "Number of secondary pumps";

  final parameter Modelica.SIunits.MassFlowRate mPri_flow_nominal=
    pumPri.mTot_flow_nominal
    "Primary mass flow rate";
  final parameter Modelica.SIunits.MassFlowRate mSec_flow_nominal=
    if pumSec.is_none then mPri_flow_nominal else pumSec.mTot_flow_nominal
    "Secondary mass flow rate";

  inner replaceable
    Buildings.Templates.ChilledWaterPlant.Components.ChillerGroup.ChillerParallel
    chiGro(final m2_flow_nominal=mPri_flow_nominal)
           constrainedby
    Buildings.Templates.ChilledWaterPlant.Components.ChillerGroup.Interfaces.ChillerGroup(
     redeclare final package MediumCHW = MediumCHW,
     final is_airCoo=is_airCoo)
    "Chiller group"
    annotation (Placement(transformation(
      extent={{10,-10},{-10,10}},rotation=90,origin={-40,10})));
  inner replaceable
    Buildings.Templates.ChilledWaterPlant.Components.ReturnSection.NoEconomizer
    WSE(final m2_flow_nominal=mPri_flow_nominal,
        final is_airCoo = is_airCoo) constrainedby
    Buildings.Templates.ChilledWaterPlant.Components.ReturnSection.Interfaces.ChilledWaterReturnSection(
      redeclare final package Medium2 = MediumCHW)
    "Chilled water return section"
    annotation (Placement(transformation(
      extent={{10,-10},{-10,10}},rotation=90,origin={-40,-72})));
  inner replaceable
    Buildings.Templates.ChilledWaterPlant.Components.PrimaryPumpGroup.Headered
    pumPri constrainedby
    Buildings.Templates.ChilledWaterPlant.Components.PrimaryPumpGroup.Interfaces.PrimaryPumpGroup(
      redeclare final package Medium = MediumCHW,
      final nChi=nChi,
      final has_ParChi=chiGro.typ == Buildings.Templates.ChilledWaterPlant.Components.Types.ChillerGroup.ChillerParallel,
      final has_byp=has_byp,
      final has_WSEByp=has_WSEByp,
      final has_comLeg=not pumSec.is_none)
    "Chilled water primary pump group"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  inner replaceable
    Buildings.Templates.ChilledWaterPlant.Components.SecondaryPumpGroup.None
    pumSec constrainedby
    Buildings.Templates.ChilledWaterPlant.Components.SecondaryPumpGroup.Interfaces.SecondaryPumpGroup(
      redeclare final package Medium = MediumCHW)
    "Chilled water secondary pump group"
    annotation (Placement(transformation(extent={{60,0},{80,20}})));

  Buildings.Templates.Components.Sensors.Temperature TCHWRet(
    redeclare final package Medium = MediumCHW,
    final have_sen=true,
    final typ=Buildings.Templates.Components.Types.SensorTemperature.InWell,
    m_flow_nominal=mSec_flow_nominal)
    "Chilled water return temperature"
    annotation (Placement(transformation(extent={{120,-80},{140,-60}})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dpCHW(
    redeclare final package Medium = MediumCHW,
    final have_sen=true,
    m_flow_nominal=0)
    "Chilled water demand side differential pressure"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={170,-30})));
  Buildings.Templates.Components.Sensors.Temperature TCHWSup(
    redeclare final package Medium = MediumCHW,
    final have_sen=true,
    final typ=Buildings.Templates.Components.Types.SensorTemperature.InWell,
    final m_flow_nominal=mSec_flow_nominal)
    "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{120,0},{140,20}})));
  Buildings.Templates.Components.Sensors.Temperature TCHWRetByp(
    redeclare final package Medium = MediumCHW,
    final have_sen = has_byp,
    final typ=Buildings.Templates.Components.Types.SensorTemperature.InWell)
    "Chilled water return temperature after bypass"
    annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},rotation=0,origin={30,-50})));
  Fluid.FixedResistances.Junction mixByp(
    redeclare package Medium = MediumCHW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Bypass mixer"
    annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},rotation=0,origin={-10,-50})));
  Fluid.FixedResistances.Junction splWSEByp(
    redeclare package Medium = MediumCHW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Splitter for waterside economizer bypass"
    annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},rotation=0,origin={-20,-20})));

  inner replaceable Components.Controls.OpenLoop con(
    final nChi=nChi,
    final nPumPri=nPumPri,
    final nPumSec=nPumSec,
    final is_airCoo=is_airCoo)
    constrainedby Components.Controls.OpenLoop
    annotation (Placement(
      transformation(
      extent={{10,10},{-10,-10}},
      rotation=180,
      origin={70,60})));
equation
  connect(TCHWRet.port_a,WSE. port_a2)
    annotation (Line(points={{120,-70},{-20,-70},{-20,-88},{-34,-88},{-34,-82}},
      color={0,127,255}));
  connect(WSE.port_b2,mixByp. port_2)
    annotation (Line(points={{-34,-62},{-34,-50},{-20,-50}},color={0,127,255}));
  connect(mixByp.port_1, TCHWRetByp.port_a)
    annotation (Line(points={{0,-50},{20,-50}}, color={0,127,255}));
  connect(chiGro.ports_b2, pumPri.ports_parallel)
    annotation (Line(points={{-30,16},{-20,16},{-20,10},{-8.88178e-16,10}},
      color={0,127,255}));
  connect(chiGro.port_b2, pumPri.port_series)
    annotation (Line(points={{-34,20},{-34,30},{-10,30},{-10,16},{0,16}},
      color={0,127,255}));
  connect(splWSEByp.port_2, chiGro.port_a2)
    annotation (Line(points={{-30,-20},{-34,-20},{-34,0}}, color={0,127,255}));
  connect(splWSEByp.port_3,pumPri. port_WSEByp)
    annotation (Line(points={{-20,-10},{-20,4},{0,4}}, color={0,127,255}));
  connect(pumPri.port_b, pumSec.port_a)
    annotation (Line(points={{20,10},{60,10}}, color={0,127,255}));
  connect(pumSec.port_b, TCHWSup.port_a)
    annotation (Line(points={{80,10},{120,10}}, color={0,127,255}));
  connect(TCHWRetByp.port_b, splWSEByp.port_1)
    annotation (Line(points={{40,-50},{60,-50},{60,-20},{-10,-20}},
    color={0,127,255}));
  connect(mixByp.port_3, pumPri.port_byp)
    annotation (Line(points={{-10,-40},{-10,-34},{10,-34},{10,0}},
    color={0,127,255}));
  connect(TCHWRet.port_b, port_b)
    annotation (Line(points={{140,-70},{200,-70}}, color={0,127,255}));

  connect(TCHWRetByp.y, chwCon.TRetByp);
  connect(TCHWSup.y, chwCon.TSup);
  connect(TCHWRet.y, chwCon.TRet);
  connect(dpCHW.y, chwCon.dp);
  connect(pumPri.busCon, chwCon.pumPri);
  connect(chiGro.busCon, chwCon.chiGro);
  connect(WSE.busCon, chwCon.wse);
  connect(pumSec.busCon, chwCon.pumSec);
  connect(con.busCW, cwCon) annotation (Line(
      points={{60,60},{-200,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.busCHW, chwCon) annotation (Line(
      points={{80,60},{200,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TCHWSup.port_b, port_a)
    annotation (Line(points={{140,10},{200,10}}, color={0,127,255}));
  connect(dpCHW.port_a, port_a)
    annotation (Line(points={{170,-20},{170,10},{200,10}}, color={0,127,255}));
  connect(dpCHW.port_b, port_b) annotation (Line(points={{170,-40},{170,-70},{
          200,-70}}, color={0,127,255}));
end PartialChilledWaterLoop;

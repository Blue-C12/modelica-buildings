within Buildings.Examples.Tutorial.ControlDescriptionLanguage;
model System4 "Open loop model with equipment on/off control"
  extends Buildings.Examples.Tutorial.ControlDescriptionLanguage.BaseClasses.PartialOpenLoop;

  Controls.BoilerReturn conBoiRet
    annotation (Placement(transformation(extent={{100,-290},{120,-270}})));
  Controls.OpenLoopSystemOnOff conSysSta
    annotation (Placement(transformation(extent={{-260,-60},{-240,-40}})));
  Controls.OpenLoopRadiatorSupply conRadSup
    annotation (Placement(transformation(extent={{-200,-160},{-180,-140}})));
  Controls.EquipmentOnOff conEquSta
    annotation (Placement(transformation(extent={{-200,-220},{-180,-200}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal radPumCon(
    realTrue=mRad_flow_nominal) "Type conversion for radiator pump signal"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal boiPumCon(
    realTrue=mBoi_flow_nominal) "Type conversion for boiler pump signal"
    annotation (Placement(transformation(extent={{-100,-290},{-80,-270}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal boiSigCon(
   realTrue=1)
    "Type conversion for boiler signal"
    annotation (Placement(transformation(extent={{-100,-260},{-80,-240}})));
equation
  connect(conSysSta.onSys, conEquSta.onSys) annotation (Line(points={{-238,-50},
          {-220,-50},{-220,-216},{-202,-216}}, color={255,0,255}));
  connect(conEquSta.onPum, boiPumCon.u) annotation (Line(points={{-178,-216},{-120,
          -216},{-120,-280},{-102,-280}}, color={255,0,255}));
  connect(radPumCon.u, conEquSta.onPum) annotation (Line(points={{-102,-70},{-120,
          -70},{-120,-216},{-178,-216}}, color={255,0,255}));
  connect(boiSigCon.u, conEquSta.onBoi) annotation (Line(points={{-102,-250},{-108,
          -250},{-108,-204},{-178,-204}}, color={255,0,255}));
  connect(radPumCon.y, pumRad.m_flow_in)
    annotation (Line(points={{-78,-70},{-62,-70}}, color={0,0,127}));
  connect(boiPumCon.y, pumBoi.m_flow_in)
    annotation (Line(points={{-78,-280},{-62,-280}}, color={0,0,127}));
  connect(boiSigCon.y, boi.y) annotation (Line(points={{-78,-250},{34,-250},{34,
          -302},{22,-302}}, color={0,0,127}));
  connect(conRadSup.yVal, valRad.y) annotation (Line(points={{-178,-150},{-62,
          -150}},      color={0,0,127}));
  connect(conEquSta.TBoi, boi.T) annotation (Line(points={{-202,-204},{-240,-204},
          {-240,-302},{-1,-302}}, color={0,0,127}));
  connect(conSysSta.TOut, senTOut.T) annotation (Line(points={{-262,-44},{-280,-44},
          {-280,30},{-298,30}}, color={0,0,127}));
  connect(conRadSup.TRoo, temRoo.T) annotation (Line(points={{-202,-144},{-268,
          -144},{-268,30},{-50,30}},
                               color={0,0,127}));
  connect(conSysSta.TRoo, temRoo.T) annotation (Line(points={{-262,-56},{-268,-56},
          {-268,30},{-50,30}}, color={0,0,127}));
  connect(temRet.T, conBoiRet.TRet)
    annotation (Line(points={{71,-280},{98,-280}}, color={0,0,127}));
  connect(conBoiRet.yVal, valBoi.y) annotation (Line(points={{122,-280},{140,-280},
          {140,-230},{72,-230}}, color={0,0,127}));

  connect(temSup.T, conRadSup.TSup) annotation (Line(points={{-61,-40},{-210,
          -40},{-210,-156},{-202,-156}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
In this step, we added the controller for the boiler on/off control.
</p>
<h4>Implementation</h4>
<p>
This model was built as follows:
</p>
<ol>
<li>
<p>
First, we copied the controller
<a href=\"modelica://Buildings.Examples.Tutorial.ControlDescriptionLanguage.Controls.OpenLoopEquipmentOnOff\">
Buildings.Examples.Tutorial.ControlDescriptionLanguage.Controls.OpenLoopEquipmentOnOff</a>
to create the block
<a href=\"modelica://Buildings.Examples.Tutorial.ControlDescriptionLanguage.Controls.EquipmentOnOff\">
Buildings.Examples.Tutorial.ControlDescriptionLanguage.Controls.EquipmentOnOff</a>.
</p>
</li>
<li>
<p>
In this new block, we used a hysteresis block
<a href=\"modelica://Buildings.Controls.OBC.CDL.Continuous.Hysteresis\">
Buildings.Controls.OBC.CDL.Continuous.Hysteresis</a> to switch the boiler,
and negated its output because the boiler needs to be off if the temperature exceeds the
value <code>uHigh</code> of this hysteresis.
We also used an instance of
<a href=\"modelica://Buildings.Controls.OBC.CDL.Logical.And\">
Buildings.Controls.OBC.CDL.Logical.And</a>
to switch the boiler only on if the system control signal is on.
Otherwise, the boiler would be heated up in summer.
</p>
</li>
</ol>
<p>
Simulating the system will show that the valve is controlled to maintain a return water temperature
of at least <i>60</i>&circ;C, and that the boiler is switched off when the temperature exceeds <i>90</i>&circ;C
and switched on again if it reaches <i>70</i>&circ;C as shown below.
</p>
<p align=\"center\">
<img alt=\"Temperatures and control signal.\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/ControlDescriptionLanguage/System4/TemperaturesControl.png\" border=\"1\"/>
</p>
</html>",
revisions="<html>
<ul>
<li>
February 18, 2020, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-400,-360},{240, 100}})),
    __Dymola_Commands(file=
     "modelica://Buildings/Resources/Scripts/Dymola/Examples/Tutorial/ControlDescriptionLanguage/System4.mos"
        "Simulate and plot"),
    experiment(
      StartTime=1296000,
      StopTime=1382400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end System4;

within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences;
block Status
  "Outputs current stage chiller index vector, current, next available lower and higher stage index and whether curent stage is the lowest and/or the highest available stage"

  parameter Integer nSta = 3
    "Number of stages";

  parameter Integer nChi = 2
    "Number of chillers";

  final parameter Integer staInd[nSta] = {i for i in 1:nSta}
    "Stage index vector";

  parameter Integer staMat[nSta, nChi] = {{1,0},{0,1},{1,1}}
    "Staging matrix with stages in rows and chillers in columns";

  final parameter Integer staIndMat[nSta, nChi] = {j for i in 1:nChi, j in 1:nSta}
    "Matrix of staging matrix dimensions with stage indices in each column";

  final parameter Integer lowDia[nSta, nSta] = {if i<=j then 1 else 0 for i in 1:nSta, j in 1:nSta}
    "Lower diagonal unit matrix";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uAva[nSta](
    final start = fill(true, nSta)) "Stage availability status"
    annotation (Placement(transformation(extent={{-460,-100},{-420,-60}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput u(
    final min=0,
    final max=nSta) "Current chiller stage index"
    annotation (Placement(transformation(extent={{-460,60},{-420,100}}),
        iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHig
    "If true current stage is the highest available stage"
    annotation (Placement(transformation(extent={{440,20},{480,60}}),
        iconTransformation(extent={{100,10},{140,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yLow
    "If true current stage is the lowest available stage"
    annotation (Placement(transformation(extent={{440,-100},{480,-60}}),
        iconTransformation(extent={{100,-80},{140,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[nChi]
    "Chillers index for the current stage"
    annotation (Placement(transformation(extent={{440,140},{480,180}}),
        iconTransformation(extent={{100,70},{140,110}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput y(
    final min=0,
    final max=nSta) "Current stage index"
    annotation (Placement(transformation(extent={{440,-180},{480,-140}}),
        iconTransformation(extent={{100,-110},{140,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yUp(
    final min=0,
    final max=nSta) "Next available stage up index"
    annotation (Placement(transformation(extent={{440,60},{480,100}}),
        iconTransformation(extent={{100,40},{140,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yDown(
    final min=0,
    final max=nSta) "Next available stage down index"
    annotation (Placement(transformation(extent={{440,-60},{480,-20}}),
        iconTransformation(extent={{100,-50},{140,-10}})));

protected
  Buildings.Controls.OBC.CDL.Logical.IntegerSwitch intSwi2 "Switch"
    annotation (Placement(transformation(extent={{100,-220},{120,-200}})));

  Buildings.Controls.OBC.CDL.Logical.IntegerSwitch intSwi3 "Switch"
    annotation (Placement(transformation(extent={{360,70},{380,90}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep(
    final nout=nSta) "Replicates signal to a length equal the stage count"
    annotation (Placement(transformation(extent={{-300,230},{-280,250}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep1[nSta](
    final nout=fill(nChi, nSta)) "Replicates signal to dimensions of the staging matrix"
    annotation (Placement(transformation(extent={{-180,230},{-160,250}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant staIndMatr[nSta,nChi](
    final k=staIndMat) "Matrix with stage index in each column"
    annotation (Placement(transformation(extent={{-180,180},{-160,200}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1[nSta,nChi]
    "Outputs a zero matrix populated with ones in the current stage index row"
    annotation (Placement(transformation(extent={{-120,230},{-100,250}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant chiStaMatr[nSta,nChi](
    final k=staMat) "Staging matrix"
    annotation (Placement(transformation(extent={{-100,180},{-80,200}})));

  Buildings.Controls.OBC.CDL.Continuous.MatrixMax matMax(
    final nRow=nSta,
    final nCol=nChi,
    final rowMax=false) "Column-wise matrix maximum"
    annotation (Placement(transformation(extent={{60,210},{80,230}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold chiInSta[nChi](threshold=fill(0.5, nChi))
    "Identifies chillers designated to operate in a given stage"
    annotation (Placement(transformation(extent={{100,210},{120,230}})));

  Buildings.Controls.OBC.CDL.Integers.Product proInt[nSta,nChi]
    "Outputs a zero matrix populated with ones for any available chiller in the current stage"
    annotation (Placement(transformation(extent={{-20,210},{0,230}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[nSta,nChi]
    "Type converter"
    annotation (Placement(transformation(extent={{-80,230},{-60,250}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[nSta,nChi]
    "Type converter"
    annotation (Placement(transformation(extent={{20,210},{40,230}})));

  Buildings.Controls.OBC.CDL.Integers.Product proInt1[nSta]
    "Outputs a vector of stage indices for any available stage above the current stage"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant staIndx[nSta](
    final k=staInd) "Stage index vector"
    annotation (Placement(transformation(extent={{-240,120},{-220,140}})));

  Buildings.Controls.OBC.CDL.Integers.Greater intGre[nSta]
    "Identifies stages that are above the current stage"
    annotation (Placement(transformation(extent={{-180,80},{-160,100}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1[nSta](
    final integerFalse=fill(nSta + 1, nSta))
    "Type converter that outputs a value larger than the stage count for any false input"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));

  Buildings.Controls.OBC.CDL.Logical.And and2[nSta]
    "Identifies any available stages above the current stage"
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));

  Buildings.Controls.OBC.CDL.Continuous.MultiMin multiMin(
    final nin=nSta)
    "Minimum of a vector input"
    annotation (Placement(transformation(extent={{20,100},{40,120}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1[nSta]
    "Type converter"
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Type converter"
    annotation (Placement(transformation(extent={{60,100},{80,120}})));

  Buildings.Controls.OBC.CDL.Integers.Less intLes[nSta]
    "Identifies stages that are below the current stage"
    annotation (Placement(transformation(extent={{-180,-80},{-160,-60}})));

  Buildings.Controls.OBC.CDL.Logical.And and1[nSta]
    "Identifies any available stage below the current stage"
    annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt2[nSta]
    "Type converter that outputs zero for any false input"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  Buildings.Controls.OBC.CDL.Integers.Product proInt2[nSta]
    "Outputs vector of stage indices for any available stage below the current stage"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea3[nSta]
    "Type converter"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

  Buildings.Controls.OBC.CDL.Continuous.MultiMax multiMax(
    final nin=nSta)
    "Maximum of a vector input"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Type converter"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));

  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr(
    final threshold=nSta)
    "If the current stage is the highest available the input value equals the number of stages + 1"
    annotation (Placement(transformation(extent={{100,100},{120,120}})));

  Buildings.Controls.OBC.CDL.Logical.IntegerSwitch intSwi "Logical switch"
    annotation (Placement(transformation(extent={{180,100},{200,120}})));

  Buildings.Controls.OBC.CDL.Integers.LessEqualThreshold intLesEquThr(
    final threshold=0)
    "If the current stage is the lowest available the input value equals 0"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));

  Buildings.Controls.OBC.CDL.Logical.IntegerSwitch intSwi1 "Logical switch"
    annotation (Placement(transformation(extent={{180,-80},{200,-60}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor extStaAva(
    final allowOutOfRange=false,
    final outOfRangeValue=nSta + 1,
    final nin=nSta) "Extracts stage availability for the current stage"
    annotation (Placement(transformation(extent={{-200,-160},{-180,-140}})));

  Buildings.Controls.OBC.CDL.Continuous.LessThreshold lesThr(
    final threshold=0.5)
    "Detects if the current stage becomes unavailable"
    annotation (Placement(transformation(extent={{-160,-160},{-140,-140}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[nSta]
    "Type converter"
    annotation (Placement(transformation(extent={{-240,-160},{-220,-140}})));

  Buildings.Controls.OBC.CDL.Utilities.Assert cheStaAva1(
    final message="There are no available chiller stages. The staging cannot be performed.")
    "Checks if any stage is available"
    annotation (Placement(transformation(extent={{-340,-140},{-320,-120}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nSta) "Logical or"
    annotation (Placement(transformation(extent={{-380,-140},{-360,-120}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    final k=0) "Zero"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));

  Buildings.Controls.OBC.CDL.Logical.And and4
    "Identifies any available stages above the current stage"
    annotation (Placement(transformation(extent={{220,70},{240,90}})));

equation
  connect(intRep.y, intRep1.u)
    annotation (Line(points={{-278,240},{-182,240}}, color={255,127,0}));
  connect(intRep1.y, intEqu1.u1)
    annotation (Line(points={{-158,240},{-122,240}},   color={255,127,0}));
  connect(matMax.y, chiInSta.u)
    annotation (Line(points={{82,220},{98,220}},  color={0,0,127}));
  connect(staIndMatr.y, intEqu1.u2) annotation (Line(points={{-158,190},{-140,190},
          {-140,232},{-122,232}},      color={255,127,0}));
  connect(chiInSta.y, yChi)
    annotation (Line(points={{122,220},{200,220},{200,160},{460,160}},
          color={255,0,255}));
  connect(proInt.y, intToRea.u)
    annotation (Line(points={{2,220},{18,220}}, color={255,127,0}));
  connect(intToRea.y, matMax.u)
    annotation (Line(points={{42,220},{58,220}}, color={0,0,127}));
  connect(booToInt.y, proInt.u1) annotation (Line(points={{-58,240},{-40,240},{-40,
          226},{-22,226}},    color={255,127,0}));
  connect(intEqu1.y, booToInt.u)
    annotation (Line(points={{-98,240},{-82,240}}, color={255,0,255}));
  connect(chiStaMatr.y, proInt.u2) annotation (Line(points={{-78,190},{-40,190},
          {-40,214},{-22,214}}, color={255,127,0}));
  connect(staIndx.y, intGre.u1) annotation (Line(points={{-218,130},{-200,130},{
          -200,90},{-182,90}},  color={255,127,0}));
  connect(intRep.y, intGre.u2) annotation (Line(points={{-278,240},{-260,240},{-260,
          82},{-182,82}},
                 color={255,127,0}));
  connect(intGre.y, and2.u1) annotation (Line(points={{-158,90},{-150,90},{-150,
          80},{-142,80}},color={255,0,255}));
  connect(uAva, and2.u2) annotation (Line(points={{-440,-80},{-280,-80},{-280,
          72},{-142,72}}, color={255,0,255}));
  connect(staIndx.y, proInt1.u1) annotation (Line(points={{-218,130},{-70,130},{
          -70,116},{-62,116}},  color={255,127,0}));
  connect(booToInt1.y, proInt1.u2) annotation (Line(points={{-78,80},{-70,80},{-70,
          104},{-62,104}},     color={255,127,0}));
  connect(proInt1.y, intToRea1.u)
    annotation (Line(points={{-38,110},{-22,110}}, color={255,127,0}));
  connect(intToRea1.y, multiMin.u) annotation (Line(points={{2,110},{18,110}},
          color={0,0,127}));
  connect(intRep.y, intLes.u2) annotation (Line(points={{-278,240},{-260,240},{-260,
          -78},{-182,-78}},      color={255,127,0}));
  connect(staIndx.y, intLes.u1) annotation (Line(points={{-218,130},{-200,130},{
          -200,-70},{-182,-70}},  color={255,127,0}));
  connect(uAva, and1.u2) annotation (Line(points={{-440,-80},{-280,-80},{-280,
          -98},{-142,-98}}, color={255,0,255}));
  connect(intLes.y, and1.u1) annotation (Line(points={{-158,-70},{-150,-70},{-150,
          -90},{-142,-90}},      color={255,0,255}));
  connect(proInt2.y, intToRea3.u)
    annotation (Line(points={{-38,-70},{-22,-70}}, color={255,127,0}));
  connect(intToRea3.y, multiMax.u) annotation (Line(points={{2,-70},{18,-70}},
    color={0,0,127}));
  connect(staIndx.y, proInt2.u1) annotation (Line(points={{-218,130},{-200,130},
          {-200,-40},{-70,-40},{-70,-64},{-62,-64}}, color={255,127,0}));
  connect(booToInt2.y, proInt2.u2) annotation (Line(points={{-78,-90},{-70,-90},
          {-70,-76},{-62,-76}}, color={255,127,0}));
  connect(multiMax.y, reaToInt1.u)
    annotation (Line(points={{42,-70},{58,-70}}, color={0,0,127}));
  connect(multiMin.y, reaToInt.u)
    annotation (Line(points={{42,110},{58,110}}, color={0,0,127}));
  connect(reaToInt.y, intGreThr.u)
    annotation (Line(points={{82,110},{98,110}}, color={255,127,0}));
  connect(intGreThr.y, intSwi.u2)
    annotation (Line(points={{122,110},{178,110}}, color={255,0,255}));
  connect(intGreThr.y, yHig) annotation (Line(points={{122,110},{140,110},{140,40},
          {460,40}},     color={255,0,255}));
  connect(reaToInt1.y, intLesEquThr.u)
    annotation (Line(points={{82,-70},{98,-70}}, color={255,127,0}));
  connect(intLesEquThr.y, intSwi1.u2)
    annotation (Line(points={{122,-70},{178,-70}}, color={255,0,255}));
  connect(intLesEquThr.y, yLow) annotation (Line(points={{122,-70},{140,-70},{140,
          -90},{340,-90},{340,-80},{460,-80}},     color={255,0,255}));
  connect(uAva, booToRea.u) annotation (Line(points={{-440,-80},{-280,-80},{
          -280,-150},{-242,-150}}, color={255,0,255}));
  connect(and2.y, booToInt1.u)
    annotation (Line(points={{-118,80},{-102,80}}, color={255,0,255}));
  connect(lesThr.y, intSwi2.u2) annotation (Line(points={{-138,-150},{0,-150},{0,
          -210},{98,-210}},   color={255,0,255}));
  connect(intGreThr.y, and4.u1)
    annotation (Line(points={{122,110},{140,110},{140,80},{218,80}},
                                  color={255,0,255}));
  connect(lesThr.y, and4.u2)
    annotation (Line(points={{-138,-150},{210,-150},{210,72},{218,72}},
                                                               color={255,0,255}));
  connect(and4.y, intSwi3.u2)
    annotation (Line(points={{242,80},{358,80}}, color={255,0,255}));
  connect(yUp, yUp)
    annotation (Line(points={{460,80},{460,80}}, color={255,127,0}));
  connect(uAva, mulOr.u) annotation (Line(points={{-440,-80},{-400,-80},{-400,-130},
          {-392,-130},{-392,-130},{-382,-130}}, color={255,0,255}));
  connect(mulOr.y, cheStaAva1.u)
    annotation (Line(points={{-358,-130},{-342,-130}},   color={255,0,255}));
  connect(booToRea.y, extStaAva.u)
    annotation (Line(points={{-218,-150},{-202,-150}}, color={0,0,127}));
  connect(extStaAva.y, lesThr.u)
    annotation (Line(points={{-178,-150},{-162,-150}}, color={0,0,127}));
  connect(and1.y, booToInt2.u)
    annotation (Line(points={{-118,-90},{-102,-90}}, color={255,0,255}));
  connect(u, intRep.u) annotation (Line(points={{-440,80},{-320,80},{-320,240},
          {-302,240}}, color={255,127,0}));
  connect(u, extStaAva.index) annotation (Line(points={{-440,80},{-300,80},{
          -300,-180},{-190,-180},{-190,-162}}, color={255,127,0}));
  connect(conInt.y, intSwi1.u1) annotation (Line(points={{122,-30},{160,-30},{160,
          -62},{178,-62}},     color={255,127,0}));
  connect(intSwi1.y, yDown) annotation (Line(points={{202,-70},{320,-70},{320,-40},
          {460,-40}},      color={255,127,0}));
  connect(intSwi1.y, intSwi2.u1) annotation (Line(points={{202,-70},{220,-70},{220,
          -160},{80,-160},{80,-202},{98,-202}},     color={255,127,0}));
  connect(intSwi2.y, y) annotation (Line(points={{122,-210},{380,-210},{380,-160},
          {460,-160}},       color={255,127,0}));
  connect(intSwi2.y, intSwi3.u1) annotation (Line(points={{122,-210},{350,-210},
          {350,88},{358,88}}, color={255,127,0}));
  connect(u, intSwi2.u3) annotation (Line(points={{-440,80},{-300,80},{-300,
          -218},{98,-218}}, color={255,127,0}));
  connect(intSwi.y, intSwi3.u3) annotation (Line(points={{202,110},{340,110},{340,
          72},{358,72}},     color={255,127,0}));
  connect(u, intSwi.u1) annotation (Line(points={{-440,80},{-300,80},{-300,160},
          {160,160},{160,118},{178,118}}, color={255,127,0}));
  connect(reaToInt.y, intSwi.u3) annotation (Line(points={{82,110},{90,110},{90,
          90},{160,90},{160,102},{178,102}}, color={255,127,0}));
  connect(reaToInt1.y, intSwi1.u3) annotation (Line(points={{82,-70},{90,-70},{90,
          -100},{170,-100},{170,-78},{178,-78}},    color={255,127,0}));
  connect(intSwi3.y, yUp)
    annotation (Line(points={{382,80},{460,80}}, color={255,127,0}));
  annotation (defaultComponentName = "sta",
        Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-420,-280},{440,280}})),
Documentation(info="<html>
<p>
Based on the current stage <code>u</code> and stage availability vector <code>uAva</code> the sequence outputs:
</p>
<ul>
<li>
Vector of chillers operating in the current stage <code>yChi</code>.
</li>
<li>
Index of the current stage <code>y</code>, first available higher stage <code>yUp</code> and the first available lower stage <code>yDown</code>.
</li>
<li>
Boolean indicators whether current operating stage <code>u</code> is the highest <code>yHig</code> 
and/or the lowest <code>yLow</code> available stage.
</li>
</ul>
<p>
The purpose of this sequence is to:
</p>
<ul>
<li>
Provide inputs for the stage up and down conditionals such that staging into 
unavailable stages is avoided.
</li>
<li>
Change the stage to the first available lower stage in an event that the current stage 
becomes unavailable.
</li>
</ul>
<p>
The sequences are implemented according to RP-1711 Draft 4 5.2.4.11. 3.
</p>
</html>",
revisions="<html>
<ul>
<li>
June 10, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Status;

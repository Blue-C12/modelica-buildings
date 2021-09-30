within Buildings.Controls.OBC.RadiantSystems.CoolingAndHeating.SlabTemperatureSignal.Validation.BaseClasses;
block ForecastHighChicago
  "Outputs next-day forecast high temperature for Chicago"
  Buildings.Utilities.Time.ModelTime modTim1 "Model timer for forecast high"
    annotation (Placement(transformation(extent={{32,26},{52,46}})));
  Controls.SetPoints.Table forHi(table=[0,272.05; 86400,275.35; 172800,273.75;
        259200,272.55; 345600,269.85; 432000,262.05; 518400,260.35; 604800,
        264.85; 691200,274.85; 777600,275.35; 864000,277.55; 950400,277.05;
        1036800,268.15; 1123200,270.35; 1209600,275.95; 1296000,283.15; 1382400,
        284.85; 1468800,280.35; 1555200,275.35; 1641600,274.85; 1728000,285.35;
        1814400,276.45; 1900800,277.05; 1987200,275.95; 2073600,275.95; 2160000,
        266.45; 2246400,258.15; 2332800,265.35; 2419200,266.45; 2505600,267.55;
        2592000,272.05; 2678400,268.15; 2764800,272.55; 2851200,272.55; 2937600,
        272.55; 3024000,261.45; 3110400,263.75; 3196800,264.25; 3283200,269.25;
        3369600,278.15; 3456000,281.45; 3542400,287.05; 3628800,279.85; 3715200,
        275.35; 3801600,272.05; 3888000,268.75; 3974400,269.85; 4060800,276.45;
        4147200,279.85; 4233600,273.15; 4320000,272.55; 4406400,275.35; 4492800,
        284.85; 4579200,287.55; 4665600,283.75; 4752000,277.55; 4838400,274.85;
        4924800,273.15; 5011200,275.95; 5097600,279.25; 5184000,278.15; 5270400,
        274.85; 5356800,283.15; 5443200,270.95; 5529600,274.85; 5616000,279.85;
        5702400,284.25; 5788800,284.85; 5875200,289.85; 5961600,283.75; 6048000,
        282.55; 6134400,276.45; 6220800,282.05; 6307200,282.05; 6393600,283.15;
        6480000,275.35; 6566400,280.35; 6652800,290.35; 6739200,278.75; 6825600,
        281.45; 6912000,280.95; 6998400,279.85; 7084800,278.15; 7171200,279.85;
        7257600,290.95; 7344000,294.25; 7430400,288.15; 7516800,286.45; 7603200,
        276.45; 7689600,280.95; 7776000,277.55; 7862400,279.85; 7948800,277.55;
        8035200,275.35; 8121600,278.15; 8208000,279.25; 8294400,282.55; 8380800,
        284.25; 8467200,283.15; 8553600,290.95; 8640000,297.05; 8726400,292.05;
        8812800,289.85; 8899200,297.55; 8985600,304.25; 9072000,303.75; 9158400,
        302.05; 9244800,304.25; 9331200,292.55; 9417600,281.45; 9504000,278.75;
        9590400,279.25; 9676800,288.75; 9763200,295.95; 9849600,285.35; 9936000,
        283.75; 10022400,284.85; 10108800,288.15; 10195200,289.25; 10281600,
        288.15; 10368000,289.85; 10454400,297.05; 10540800,297.55; 10627200,
        303.15; 10713600,303.75; 10800000,295.95; 10886400,286.45; 10972800,
        285.35; 11059200,290.95; 11145600,295.35; 11232000,291.45; 11318400,
        290.35; 11404800,293.15; 11491200,288.15; 11577600,289.25; 11664000,
        289.85; 11750400,286.45; 11836800,289.25; 11923200,292.05; 12009600,
        296.45; 12096000,300.35; 12182400,300.95; 12268800,297.05; 12355200,
        298.15; 12441600,300.35; 12528000,295.95; 12614400,302.55; 12700800,
        302.55; 12787200,300.35; 12873600,302.55; 12960000,298.15; 13046400,
        298.15; 13132800,298.15; 13219200,302.05; 13305600,303.75; 13392000,
        294.25; 13478400,305.35; 13564800,299.85; 13651200,306.45; 13737600,
        299.85; 13824000,296.45; 13910400,298.75; 13996800,295.35; 14083200,
        295.95; 14169600,303.15; 14256000,304.85; 14342400,304.25; 14428800,
        298.15; 14515200,292.05; 14601600,302.05; 14688000,305.35; 14774400,
        303.75; 14860800,297.55; 14947200,288.15; 15033600,293.75; 15120000,
        299.85; 15206400,303.75; 15292800,303.75; 15379200,303.15; 15465600,
        299.85; 15552000,300.35; 15638400,292.05; 15724800,297.05; 15811200,
        297.55; 15897600,303.75; 15984000,305.95; 16070400,305.95; 16156800,
        302.05; 16243200,301.45; 16329600,296.45; 16416000,297.55; 16502400,
        298.75; 16588800,300.95; 16675200,302.05; 16761600,298.15; 16848000,
        305.35; 16934400,306.45; 17020800,307.05; 17107200,307.05; 17193600,
        308.15; 17280000,302.55; 17366400,300.95; 17452800,302.55; 17539200,
        304.25; 17625600,305.35; 17712000,303.15; 17798400,300.95; 17884800,
        304.85; 17971200,303.15; 18057600,300.95; 18144000,302.55; 18230400,
        304.85; 18316800,300.95; 18403200,302.55; 18489600,304.85; 18576000,
        304.25; 18662400,303.15; 18748800,294.85; 18835200,294.85; 18921600,
        298.15; 19008000,300.35; 19094400,301.45; 19180800,299.85; 19267200,
        301.45; 19353600,301.45; 19440000,298.75; 19526400,297.55; 19612800,
        296.45; 19699200,298.75; 19785600,298.15; 19872000,299.25; 19958400,
        302.05; 20044800,303.75; 20131200,302.05; 20217600,295.95; 20304000,
        295.95; 20390400,298.15; 20476800,299.85; 20563200,301.45; 20649600,
        301.45; 20736000,302.55; 20822400,300.95; 20908800,301.45; 20995200,
        298.75; 21081600,293.75; 21168000,295.35; 21254400,302.05; 21340800,
        304.25; 21427200,303.15; 21513600,297.05; 21600000,299.85; 21686400,
        299.25; 21772800,299.85; 21859200,300.35; 21945600,299.25; 22032000,
        293.75; 22118400,297.05; 22204800,299.25; 22291200,295.35; 22377600,
        294.85; 22464000,293.15; 22550400,294.85; 22636800,289.85; 22723200,
        289.25; 22809600,294.25; 22896000,297.55; 22982400,293.75; 23068800,
        293.75; 23155200,302.05; 23241600,304.85; 23328000,300.35; 23414400,
        292.05; 23500800,292.05; 23587200,292.55; 23673600,295.95; 23760000,
        292.55; 23846400,289.85; 23932800,288.75; 24019200,286.45; 24105600,
        285.35; 24192000,287.55; 24278400,295.95; 24364800,289.85; 24451200,
        289.85; 24537600,289.85; 24624000,289.85; 24710400,283.15; 24796800,
        283.75; 24883200,285.35; 24969600,287.05; 25056000,288.15; 25142400,
        288.75; 25228800,295.95; 25315200,299.25; 25401600,295.95; 25488000,
        284.25; 25574400,286.45; 25660800,289.25; 25747200,285.35; 25833600,
        290.35; 25920000,286.45; 26006400,287.55; 26092800,293.75; 26179200,
        286.45; 26265600,288.75; 26352000,294.85; 26438400,294.25; 26524800,
        288.15; 26611200,286.45; 26697600,288.15; 26784000,287.55; 26870400,
        290.35; 26956800,291.45; 27043200,276.45; 27129600,277.05; 27216000,
        275.95; 27302400,277.55; 27388800,284.85; 27475200,288.75; 27561600,
        284.85; 27648000,280.35; 27734400,279.25; 27820800,280.95; 27907200,
        288.15; 27993600,275.35; 28080000,277.05; 28166400,276.45; 28252800,
        277.05; 28339200,273.15; 28425600,265.95; 28512000,270.95; 28598400,
        268.15; 28684800,273.75; 28771200,276.25; 28857600,281.45; 28944000,
        274.85; 29030400,277.55; 29116800,277.05; 29203200,276.45; 29289600,
        280.35; 29376000,284.25; 29462400,276.45; 29548800,271.45; 29635200,
        272.55; 29721600,273.15; 29808000,275.35; 29894400,275.35; 29980800,
        273.75; 30067200,267.55; 30153600,267.55; 30240000,268.15; 30326400,
        267.55; 30412800,265.35; 30499200,267.55; 30585600,273.75; 30672000,
        273.75; 30758400,272.55; 30844800,271.45; 30931200,274.25; 31017600,
        274.25; 31104000,272.55; 31190400,270.95; 31276800,265.35; 31363200,
        271.45; 31449600,275.95])
    "Forecast high lookup table: x axis time in seconds, y axis forecast high temperature"
    annotation (Placement(transformation(extent={{-6,-30},{-48,12}})));
  Controls.OBC.CDL.Interfaces.RealOutput TForHigChi
    "Forecasted high temperature"
    annotation (Placement(transformation(extent={{100,-18},{140,22}})));
  Controls.OBC.CDL.Discrete.Sampler sam(samplePeriod=86400)
    "Samples forecast temperature each day"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
equation
  connect(modTim1.y, forHi.u) annotation (Line(points={{53,36},{70,36},{70,-9},
          {-1.8,-9}}, color={0,0,127}));
  connect(sam.y, TForHigChi) annotation (Line(points={{42,-70},{80,-70},{80,2},{
          120,2}}, color={0,0,127}));
  connect(forHi.y, sam.u) annotation (Line(points={{-50.1,-9},{-60,-9},{-60,-70},
          {18,-70}}, color={0,0,127}));
  annotation (defaultComponentName = "forHiChi",Documentation(info="<html>
<p>
This outputs the next-day high temperature for Chicago, so that an appropriate radiant slab setpoint can be chosen from the lookup table. 
</p>
</html>", revisions="<html>
<ul>
<li>
October 6, 2020, by Fiona Woods:<br/>
First implementation.  
</li>
</ul>
</html>"),Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name"),  Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
       Text(
          extent={{-72,78},{102,6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
        fillPattern=FillPattern.Solid,
        textString="F"),
        Text(
          extent={{226,60},{106,10}},
          lineColor={0,0,0},
          textString=DynamicSelect("", String(y, leftjustified=false, significantDigits=3)))}), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-94,110},{24,66}},
          lineColor={0,0,0},
          lineThickness=1,
          horizontalAlignment=TextAlignment.Left,
          fontName="Arial Narrow",
          textStyle={TextStyle.Bold},
          textString="Chicago Forecast High Outdoor Temperature")}));
end ForecastHighChicago;

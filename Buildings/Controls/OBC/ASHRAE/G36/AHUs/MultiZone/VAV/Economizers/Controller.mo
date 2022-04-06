within Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers;
block Controller
  "Multi zone VAV AHU economizer control sequence"

  parameter Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection minOADes
    "Design of minimum outdoor air and economizer function";
  parameter Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes buiPreCon
    "Type of building pressure control system";
  parameter Buildings.Controls.OBC.ASHRAE.G36.Types.EnergyStandard eneSta=Buildings.Controls.OBC.ASHRAE.G36.Types.EnergyStandard.Not_Specified
    "Energy standard, ASHRAE 90.1 or Title 24";
  parameter Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer ecoHigLimCon
    "Economizer high limit control device";
  parameter Buildings.Controls.OBC.ASHRAE.G36.Types.ASHRAEClimateZone ashCliZon=
    Buildings.Controls.OBC.ASHRAE.G36.Types.ASHRAEClimateZone.Not_Specified
    "ASHRAE climate zone"
    annotation (Dialog(enable=eneSta==Buildings.Controls.OBC.ASHRAE.G36.Types.EnergyStandard.ASHRAE90_1_2016));
  parameter Buildings.Controls.OBC.ASHRAE.G36.Types.Title24ClimateZone tit24CliZon=
    Buildings.Controls.OBC.ASHRAE.G36.Types.Title24ClimateZone.Not_Specified
    "California Title 24 climate zone"
    annotation (Dialog(enable=eneSta==Buildings.Controls.OBC.ASHRAE.G36.Types.EnergyStandard.California_Title_24_2016));
  parameter Real aveTimRan(unit="s")=5
    "Time horizon over which the outdoor air flow measurment is averaged";

  // Limits
  parameter Real minSpe(unit="1")=0.1
    "Minimum supply fan speed"
    annotation (Dialog(tab="Limits",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
           or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController minOAConTyp=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PID
    "Type of minimum outdoor air controller"
    annotation (Dialog(tab="Limits", group="With AFMS",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
           or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper));
  parameter Real kMinOA(unit="1")=1
    "Gain of controller"
    annotation (Dialog(tab="Limits", group="With AFMS",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
           or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper));
  parameter Real TiMinOA(unit="s")=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Limits", group="With AFMS",
      enable=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
           or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper)
           and (minOAConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
           or minOAConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));
  parameter Real TdMinOA(unit="s")=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Limits", group="With AFMS",
      enable=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
           or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper)
           and (minOAConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
           or minOAConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));
  parameter Types.VentilationStandard venSta=Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.Not_Specified
    "Ventilation standard, ASHRAE 62.1 or Title 24"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure));
  parameter Boolean have_CO2Sen=false
    "True: there are zones have CO2 sensor"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
          and venSta==Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016)));
  parameter Real dpAbsOutDam_min=0
    "Absolute pressure difference across the minimum outdoor air damper"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=(venSta==Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016
          and minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)));
  parameter Real dpDesOutDam_min(unit="Pa")=300
    "Design pressure difference across the minimum outdoor air damper"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController dpConTyp=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PID
    "Type of differential pressure setpoint controller"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure));
  parameter Real kDp(unit="1")=1
    "Gain of controller"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure));
  parameter Real TiDp(unit="s")=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)
           and (dpConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
           or dpConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));
  parameter Real TdDp(unit="s")=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Limits", group="With DP",
      enable=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)
           and (dpConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
           or dpConTyp == Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));
  parameter Real uMinRetDam(unit="1")=0.5
    "Loop signal value to start decreasing the maximum return air damper position"
    annotation (Dialog(tab="Limits", group="Common",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper));

  // Enable
  parameter Real delTOutHis(
    unit="K",
    displayUnit="K")=1
    "Delta between the temperature hysteresis high and low limit"
    annotation (Dialog(tab="Enable", group="Hysteresis"));
  parameter Real delEntHis(unit="J/kg")=1000
    "Delta between the enthalpy hysteresis high and low limits"
    annotation (Dialog(tab="Enable", group="Hysteresis",
                       enable=ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb
                           or ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.FixedEnthalpyWithFixedDryBulb));
  parameter Real retDamFulOpeTim(unit="s")=180
    "Time period to keep RA damper fully open before releasing it for minimum outdoor airflow control at disable to avoid pressure fluctuations"
    annotation (Dialog(tab="Enable", group="Delays"));
  parameter Real disDel(unit="s")=15
    "Short time delay before closing the OA damper at disable to avoid pressure fluctuations"
    annotation (Dialog(tab="Enable", group="Delays"));

  // Commissioning
  parameter Real retDamPhyPosMax(unit="1")=1
    "Physically fixed maximum position of the return air damper"
    annotation (Dialog(tab="Commissioning", group="Limits"));
  parameter Real retDamPhyPosMin(unit="1")=0
    "Physically fixed minimum position of the return air damper"
    annotation (Dialog(tab="Commissioning", group="Limits"));
  parameter Real outDamPhyPosMax(unit="1")=1
    "Physically fixed maximum position of the outdoor air damper"
    annotation (Dialog(tab="Commissioning", group="Limits"));
  parameter Real outDamPhyPosMin(unit="1")=0
    "Physically fixed minimum position of the outdoor air damper"
    annotation (Dialog(tab="Commissioning", group="Limits"));
  parameter Real minOutDamPhyPosMax(unit="1")=1
    "Physically fixed maximum position of the minimum outdoor air damper"
    annotation (Dialog(tab="Commissioning", group="Limits",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow));
  parameter Real minOutDamPhyPosMin(unit="1")=0
    "Physically fixed minimum position of the minimum outdoor air damper"
    annotation (Dialog(tab="Commissioning", group="Limits",
      enable=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow));
  parameter Real uHeaMax(unit="1")=-0.25
    "Lower limit of controller input when outdoor damper opens (see diagram)"
    annotation (Dialog(tab="Commissioning", group="Modulation"));
  parameter Real uCooMin(unit="1")=+0.25
    "Upper limit of controller input when return damper is closed (see diagram)"
    annotation (Dialog(tab="Commissioning", group="Modulation"));
  parameter Real uOutDamMax(unit="1")=(uHeaMax + uCooMin)/2
    "Maximum loop signal for the OA damper to be fully open"
    annotation (Dialog(tab="Commissioning", group="Modulation",
      enable=buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefDamper
             or buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefFan));
  parameter Real uRetDamMin(unit="1")=(uHeaMax + uCooMin)/2
    "Minimum loop signal for the RA damper to be fully open"
    annotation (Dialog(tab="Commissioning", group="Modulation",
      enable=buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefDamper
             or buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefFan));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VOutMinSet_flow_normalized(
    final unit="1")
    "Effective minimum outdoor airflow setpoint, normalized by design minimum outdoor airflow rate"
    annotation (Placement(transformation(extent={{-280,210},{-240,250}}),
        iconTransformation(extent={{-140,170},{-100,210}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VOut_flow_normalized(
    final unit="1")
    if (minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
     or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper)
    "Measured outdoor volumetric airflow rate, normalized by design minimum outdoor airflow rate"
    annotation (Placement(transformation(extent={{-280,170},{-240,210}}),
        iconTransformation(extent={{-140,150},{-100,190}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uOutDamPos(
    final unit="1")
    if (minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
     or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)
    "Economizer outdoor air damper position"
    annotation (Placement(transformation(extent={{-280,140},{-240,180}}),
        iconTransformation(extent={{-140,120},{-100,160}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uSupFanSpe(
    final unit="1")
    if (minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
     or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)
    "Supply fan speed"
    annotation (Placement(transformation(extent={{-280,110},{-240,150}}),
        iconTransformation(extent={{-140,100},{-100,140}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput effAbsOutAir_normalized(
    final unit="1")
    if (minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
     and venSta == Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016)
    "Effective minimum outdoor airflow setpoint, normalized by the absolute outdoor air rate "
    annotation (Placement(transformation(extent={{-280,80},{-240,120}}),
        iconTransformation(extent={{-140,70},{-100,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMaxCO2(
    final unit="1")
    if (have_CO2Sen and venSta == Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016)
        and minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
    "Maximum Zone CO2 control loop"
    annotation (Placement(transformation(extent={{-280,50},{-240,90}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput effDesOutAir_normalized(
    final unit="1")
    if minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
     and venSta == Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016
    "Effective minimum outdoor airflow setpoint, normalized by the design outdoor air rate "
    annotation (Placement(transformation(extent={{-280,20},{-240,60}}),
        iconTransformation(extent={{-140,50},{-100,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpMinOutDam(
    final unit="Pa",
    final quantity="PressureDifference")
    if minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
    "Measured pressure difference across the minimum outdoor air damper"
    annotation (Placement(transformation(extent={{-280,-10},{-240,30}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTSup(
    final unit="1")
    "Signal for supply air temperature control (T Sup Control Loop Signal in diagram)"
    annotation (Placement(transformation(extent={{-280,-50},{-240,-10}}),
        iconTransformation(extent={{-140,-30},{-100,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Outdoor air (OA) temperature"
    annotation (Placement(transformation(extent={{-280,-90},{-240,-50}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    if ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialDryBulb
    "Used only for fixed plus differential dry bulb temperature high limit cutoff"
    annotation (Placement(transformation(extent={{-280,-120},{-240,-80}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput hOut(
    final unit="J/kg",
    final quantity="SpecificEnergy")
    if (ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb
     or ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.FixedEnthalpyWithFixedDryBulb)
    "Outdoor air enthalpy"
    annotation (Placement(transformation(extent={{-280,-150},{-240,-110}}),
        iconTransformation(extent={{-140,-110},{-100,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput hRet(
    final unit="J/kg",
    final quantity="SpecificEnergy")
    if (eneSta == Buildings.Controls.OBC.ASHRAE.G36.Types.EnergyStandard.ASHRAE90_1_2016
    and ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb)
    "Return air enthalpy"
    annotation (Placement(transformation(extent={{-280,-180},
            {-240,-140}}), iconTransformation(extent={{-140,-130},{-100,-90}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uSupFan
    "Supply fan status"
    annotation (Placement(transformation(extent={{-280,-210},{-240,-170}}),
        iconTransformation(extent={{-140,-160},{-100,-120}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod
    "AHU operation mode status signal"
    annotation (Placement(transformation(extent={{-280,-240},{-240,-200}}),
        iconTransformation(extent={{-140,-190},{-100,-150}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uFreProSta
    "Freeze protection status"
    annotation (Placement(transformation(extent={{-280,-270},{-240,-230}}),
        iconTransformation(extent={{-140,-210},{-100,-170}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yOutDamPosMin(
    final min=0,
    final max=1,
    final unit="1")
    "Minimum outdoor air damper position limit"
    annotation (Placement(transformation(extent={{260,220},{300,260}}),
        iconTransformation(extent={{100,160},{140,200}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yMinOutDamPos(
    final min=0,
    final max=1,
    final unit="1")
    if not minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper
    "Outdoor air damper position to ensure minimum outdoor air flow"
    annotation (Placement(transformation(extent={{260,160},{300,200}}),
        iconTransformation(extent={{100,110},{140,150}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRetDamPos(
    final min=0,
    final max=1,
    final unit="1") "Return air damper position"
    annotation (Placement(transformation(extent={{260,80},{300,120}}),
        iconTransformation(extent={{100,40},{140,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelDamPos(
    final min=0,
    final max=1,
    final unit="1")
    if ((buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanAir
        or buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanDp)
      and (not buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanDp))
    "Relief air damper position"
    annotation (Placement(transformation(extent={{260,0},{300,40}}),
        iconTransformation(extent={{100,-80},{140,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yOutDamPos(
    final min=0,
    final max=1,
    final unit="1") "Outdoor air damper position"
    annotation (Placement(transformation(extent={{260,-90},{300,-50}}),
        iconTransformation(extent={{100,-140},{140,-100}})));

  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.SeparateWithAFMS
    sepAFMS(
    final minSpe=minSpe,
    final minOAConTyp=minOAConTyp,
    final kMinOA=kMinOA,
    final TiMinOA=TiMinOA,
    final TdMinOA=TdMinOA,
    final retDamPhyPosMax=retDamPhyPosMax,
    final retDamPhyPosMin=retDamPhyPosMin,
    final outDamPhyPosMax=outDamPhyPosMax,
    final outDamPhyPosMin=outDamPhyPosMin,
    final minOutDamPhyPosMax=minOutDamPhyPosMax,
    final minOutDamPhyPosMin=minOutDamPhyPosMin)
    if minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
    "Damper position limits for units with separated minimum outdoor air damper and airflow measurement"
    annotation (Placement(transformation(extent={{-140,130},{-120,150}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.SeparateWithDP
    sepDp(
    final venSta=venSta,
    final have_CO2Sen=have_CO2Sen,
    final dpAbsOutDam_min=dpAbsOutDam_min,
    final dpDesOutDam_min=dpDesOutDam_min,
    final minSpe=minSpe,
    final dpCon=dpConTyp,
    final kDp=kDp,
    final TiDp=TiDp,
    final TdDp=TdDp,
    final retDamPhyPosMax=retDamPhyPosMax,
    final retDamPhyPosMin=retDamPhyPosMin,
    final outDamPhyPosMax=outDamPhyPosMax,
    final outDamPhyPosMin=outDamPhyPosMin)
    if minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
    "Damper position limits for units with separated minimum outdoor air damper and differential pressure measurement"
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.Common
    damLim(
    final uRetDamMin=uMinRetDam,
    final controllerType=minOAConTyp,
    final k=kMinOA,
    final Ti=TiMinOA,
    final Td=TdMinOA,
    final retDamPhyPosMax=retDamPhyPosMax,
    final retDamPhyPosMin=retDamPhyPosMin,
    final outDamPhyPosMax=outDamPhyPosMax,
    final outDamPhyPosMin=outDamPhyPosMin)
    if minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper
    "Damper position limits for units with common damper"
    annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Enable enaDis(
    final use_enthalpy=ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb
                       or ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.FixedEnthalpyWithFixedDryBulb,
    final use_differential_enthalpy_with_fixed_drybulb=ecoHigLimCon ==
                       Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb,
    final delTOutHis=delTOutHis,
    final delEntHis=delEntHis,
    final retDamFulOpeTim=retDamFulOpeTim,
    final disDel=disDel)
    "Enable or disable economizer"
    annotation (Placement(transformation(extent={{20,-94},{40,-66}})));

  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Modulations.ReturnFan modRet(
    final have_directControl=buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanDp,
    final uMin=uHeaMax,
    final uMax=uCooMin)
    if (buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanAir
        or buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanDp)
    "Modulate economizer dampers position for buildings with return fan controlling pressure"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Modulations.Reliefs modRel(
    final uMin=uHeaMax,
    final uMax=uCooMin,
    final uOutDamMax=uOutDamMax,
    final uRetDamMin=uRetDamMin)
    if (buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefDamper
        or buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefFan)
    "Modulate economizer dampers position for buildings with relief damper or fan controlling pressure"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Buildings.Controls.OBC.ASHRAE.G36.Generic.AirEconomizerHighLimits ecoHigLim(
    final eneSta=eneSta,
    final ecoHigLimCon=ecoHigLimCon,
    final ashCliZon=ashCliZon,
    final tit24CliZon=tit24CliZon) "High limits"
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.MovingAverage movAve(
    final delta=aveTimRan) if (minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
     or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper)
    "Moving average of outdoor air flow measurement, normalized by design minimum outdoor airflow rate"
    annotation (Placement(transformation(extent={{-220,180},{-200,200}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea if minOADes ==
    Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
    "Convert boolean to real"
    annotation (Placement(transformation(extent={{20,90},{40,110}})));

equation
  connect(sepAFMS.VOutMinSet_flow_normalized, VOutMinSet_flow_normalized)
    annotation (Line(points={{-142,149},{-160,149},{-160,230},{-260,230}},
        color={0,0,127}));
  connect(sepAFMS.uOutDamPos, uOutDamPos) annotation (Line(points={{-142,134},{-172,
          134},{-172,160},{-260,160}},      color={0,0,127}));
  connect(sepAFMS.uSupFanSpe, uSupFanSpe) annotation (Line(points={{-142,131},{-178,
          131},{-178,130},{-260,130}},      color={0,0,127}));
  connect(sepDp.dpMinOutDam, dpMinOutDam) annotation (Line(points={{-142,83},{-184,
          83},{-184,10},{-260,10}},         color={0,0,127}));
  connect(VOutMinSet_flow_normalized, sepDp.VOutMinSet_flow_normalized)
    annotation (Line(points={{-260,230},{-160,230},{-160,81},{-142,81}},
        color={0,0,127}));
  connect(uOutDamPos, sepDp.uOutDamPos) annotation (Line(points={{-260,160},{-172,
          160},{-172,73},{-142,73}},        color={0,0,127}));
  connect(uSupFanSpe, sepDp.uSupFanSpe) annotation (Line(points={{-260,130},{-178,
          130},{-178,71},{-142,71}},        color={0,0,127}));
  connect(uSupFan, sepAFMS.uSupFan) annotation (Line(points={{-260,-190},{-196,-190},
          {-196,143},{-142,143}},      color={255,0,255}));
  connect(uSupFan, sepDp.uSupFan) annotation (Line(points={{-260,-190},{-196,-190},
          {-196,78},{-142,78}},   color={255,0,255}));
  connect(uSupFan, damLim.uSupFan) annotation (Line(points={{-260,-190},{-196,-190},
          {-196,30},{-142,30}},      color={255,0,255}));
  connect(uOpeMod, sepAFMS.uOpeMod) annotation (Line(points={{-260,-220},{-190,-220},
          {-190,137},{-142,137}},       color={255,127,0}));
  connect(uOpeMod, sepDp.uOpeMod) annotation (Line(points={{-260,-220},{-190,-220},
          {-190,76},{-142,76}},         color={255,127,0}));
  connect(uOpeMod, damLim.uOpeMod) annotation (Line(points={{-260,-220},{-190,-220},
          {-190,22},{-142,22}},       color={255,127,0}));
  connect(VOutMinSet_flow_normalized, damLim.VOutMinSet_flow_normalized)
    annotation (Line(points={{-260,230},{-160,230},{-160,38},{-142,38}}, color=
          {0,0,127}));
  connect(uSupFan, enaDis.uSupFan) annotation (Line(points={{-260,-190},{-196,-190},
          {-196,-77},{18,-77}},       color={255,0,255}));
  connect(uFreProSta, enaDis.uFreProSta) annotation (Line(points={{-260,-250},{-184,
          -250},{-184,-79},{18,-79}},       color={255,127,0}));
  connect(damLim.yOutDamPosMin, enaDis.uOutDamPosMin) annotation (Line(points={{-118,38},
          {-80,38},{-80,-84},{18,-84}}, color={0,0,127}));
  connect(damLim.yOutDamPosMax, enaDis.uOutDamPosMax) annotation (Line(points={{-118,34},
          {-86,34},{-86,-82},{18,-82}}, color={0,0,127}));
  connect(damLim.yRetDamPosMin, enaDis.uRetDamPosMin) annotation (Line(points={{-118,30},
          {-92,30},{-92,-93},{18,-93}}, color={0,0,127}));
  connect(damLim.yRetDamPosMax, enaDis.uRetDamPosMax) annotation (Line(points={{-118,26},
          {-98,26},{-98,-91},{18,-91}}, color={0,0,127}));
  connect(damLim.yRetDamPhyPosMax, enaDis.uRetDamPhyPosMax) annotation (Line(
        points={{-118,22},{-104,22},{-104,-89},{18,-89}},  color={0,0,127}));
  connect(sepDp.yOutDamPosMin, enaDis.uOutDamPosMin) annotation (Line(points={{-118,85},
          {-40,85},{-40,-84},{18,-84}}, color={0,0,127}));
  connect(sepDp.yOutDamPosMax, enaDis.uOutDamPosMax) annotation (Line(points={{-118,83},
          {-46,83},{-46,-82},{18,-82}}, color={0,0,127}));
  connect(sepDp.yRetDamPosMin, enaDis.uRetDamPosMin) annotation (Line(points={{-118,77},
          {-52,77},{-52,-93},{18,-93}}, color={0,0,127}));
  connect(sepDp.yRetDamPosMax, enaDis.uRetDamPosMax) annotation (Line(points={{-118,75},
          {-58,75},{-58,-91},{18,-91}}, color={0,0,127}));
  connect(sepDp.yRetDamPhyPosMax, enaDis.uRetDamPhyPosMax) annotation (Line(
        points={{-118,71},{-64,71},{-64,-89},{18,-89}}, color={0,0,127}));
  connect(sepAFMS.yOutDamPosMin, enaDis.uOutDamPosMin) annotation (Line(points={{-118,
          145},{0,145},{0,-84},{18,-84}}, color={0,0,127}));
  connect(sepAFMS.yOutDamPosMax, enaDis.uOutDamPosMax) annotation (Line(points={{-118,
          143},{-6,143},{-6,-82},{18,-82}}, color={0,0,127}));
  connect(sepAFMS.yRetDamPosMin, enaDis.uRetDamPosMin) annotation (Line(points={{-118,
          137},{-12,137},{-12,-93},{18,-93}}, color={0,0,127}));
  connect(sepAFMS.yRetDamPosMax, enaDis.uRetDamPosMax) annotation (Line(points={{-118,
          135},{-18,135},{-18,-91},{18,-91}}, color={0,0,127}));
  connect(sepAFMS.yRetDamPhyPosMax, enaDis.uRetDamPhyPosMax) annotation (Line(
        points={{-118,131},{-24,131},{-24,-89},{18,-89}},  color={0,0,127}));
  connect(uTSup, modRet.uTSup) annotation (Line(points={{-260,-30},{60,-30},{60,
          36},{98,36}}, color={0,0,127}));
  connect(uTSup, modRel.uTSup) annotation (Line(points={{-260,-30},{98,-30}},
                     color={0,0,127}));
  connect(damLim.yOutDamPosMin, modRel.uOutDamPosMin) annotation (Line(points={{-118,38},
          {-80,38},{-80,-39},{98,-39}}, color={0,0,127}));
  connect(sepDp.yOutDamPosMin, modRel.uOutDamPosMin) annotation (Line(points={{-118,85},
          {-40,85},{-40,-39},{98,-39}}, color={0,0,127}));
  connect(sepAFMS.yOutDamPosMin, modRel.uOutDamPosMin) annotation (Line(points={{-118,
          145},{0,145},{0,-39},{98,-39}},          color={0,0,127}));
  connect(enaDis.yOutDamPosMax, modRel.uOutDamPosMax) annotation (Line(points={{42,-70},
          {60,-70},{60,-35},{98,-35}}, color={0,0,127}));
  connect(enaDis.yRetDamPosMax, modRel.uRetDamPosMax) annotation (Line(points={{42,-80},
          {66,-80},{66,-21},{98,-21}}, color={0,0,127}));
  connect(enaDis.yRetDamPosMin, modRel.uRetDamPosMin) annotation (Line(points={{42,-90},
          {72,-90},{72,-25},{98,-25}}, color={0,0,127}));
  connect(enaDis.yRetDamPosMax, modRet.uRetDamPosMax) annotation (Line(points={{42,-80},
          {66,-80},{66,30},{98,30}}, color={0,0,127}));
  connect(enaDis.yRetDamPosMin, modRet.uRetDamPosMin) annotation (Line(points={{42,-90},
          {72,-90},{72,24},{98,24}},  color={0,0,127}));
  connect(VOut_flow_normalized, movAve.u)
    annotation (Line(points={{-260,190},{-222,190}}, color={0,0,127}));
  connect(movAve.y, sepAFMS.VOut_flow_normalized) annotation (Line(points={{-198,
          190},{-166,190},{-166,146},{-142,146}},      color={0,0,127}));
  connect(movAve.y, damLim.VOut_flow_normalized) annotation (Line(points={{-198,
          190},{-166,190},{-166,34},{-142,34}}, color={0,0,127}));
  connect(modRet.yRetDamPos, yRetDamPos) annotation (Line(points={{122,36},{140,
          36},{140,100},{280,100}}, color={0,0,127}));
  connect(modRel.yRetDamPos, yRetDamPos) annotation (Line(points={{122,-24},{140,
          -24},{140,100},{280,100}}, color={0,0,127}));
  connect(modRet.yOutDamPos, yOutDamPos) annotation (Line(points={{122,24},{160,
          24},{160,-70},{280,-70}}, color={0,0,127}));
  connect(modRel.yOutDamPos, yOutDamPos) annotation (Line(points={{122,-36},{160,
          -36},{160,-70},{280,-70}}, color={0,0,127}));
  connect(modRet.yRelDamPos, yRelDamPos) annotation (Line(points={{122,30},{180,
          30},{180,20},{280,20}}, color={0,0,127}));
  connect(sepDp.yMinOutDam, booToRea.u) annotation (Line(points={{-118,88},{-40,
          88},{-40,100},{18,100}}, color={255,0,255}));
  connect(sepAFMS.yMinOutDamPos, yMinOutDamPos) annotation (Line(points={{-118,148},
          {80,148},{80,180},{280,180}}, color={0,0,127}));
  connect(booToRea.y, yMinOutDamPos) annotation (Line(points={{42,100},{80,100},
          {80,180},{280,180}}, color={0,0,127}));
  connect(damLim.yOutDamPosMin, yOutDamPosMin) annotation (Line(points={{-118,38},
          {-80,38},{-80,240},{280,240}}, color={0,0,127}));
  connect(sepDp.yOutDamPosMin, yOutDamPosMin) annotation (Line(points={{-118,85},
          {-80,85},{-80,240},{280,240}}, color={0,0,127}));
  connect(sepAFMS.yOutDamPosMin, yOutDamPosMin) annotation (Line(points={{-118,145},
          {-80,145},{-80,240},{280,240}}, color={0,0,127}));
  connect(ecoHigLim.TCut, enaDis.TOutCut) annotation (Line(points={{-118,-44},{-30,
          -44},{-30,-69},{18,-69}}, color={0,0,127}));
  connect(ecoHigLim.hCut, enaDis.hOutCut) annotation (Line(points={{-118,-56},{-70,
          -56},{-70,-74},{18,-74}}, color={0,0,127}));
  connect(hRet, ecoHigLim.hRet) annotation (Line(points={{-260,-160},{-160,-160},
          {-160,-56},{-142,-56}}, color={0,0,127}));
  connect(TRet, ecoHigLim.TRet) annotation (Line(points={{-260,-100},{-202,-100},
          {-202,-44},{-142,-44}},color={0,0,127}));
  connect(TOut, enaDis.TOut) annotation (Line(points={{-260,-70},{-110,-70},{-110,
          -67},{18,-67}}, color={0,0,127}));
  connect(hOut, enaDis.hOut) annotation (Line(points={{-260,-130},{6,-130},{6,-72},
          {18,-72}}, color={0,0,127}));
  connect(effAbsOutAir_normalized, sepDp.effAbsOutAir_normalized) annotation (
      Line(points={{-260,100},{-208,100},{-208,89},{-142,89}}, color={0,0,127}));
  connect(uMaxCO2, sepDp.uMaxCO2) annotation (Line(points={{-260,70},{-208,70},{
          -208,87},{-142,87}}, color={0,0,127}));
  connect(effDesOutAir_normalized, sepDp.effDesOutAir_normalized) annotation (
      Line(points={{-260,40},{-202,40},{-202,85},{-142,85}}, color={0,0,127}));
annotation (defaultComponentName="ecoCon",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-200},{100,200}}),
    graphics={
        Text(
          extent={{-100,240},{100,200}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,-200},{100,200}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,200},{6,180}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VOutMinSet_flow_normalized"),
        Text(
          extent={{-96,178},{-12,164}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VOut_flow_normalized",
          visible=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
               or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper)),
        Text(
          extent={{-96,150},{-44,134}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uOutDamPos",
          visible=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
               or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)),
        Text(
          extent={{-96,128},{-46,114}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uSupFanSpe",
          visible=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersAirflow
               or minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure)),
        Text(
          extent={{-96,30},{-30,12}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="dpMinOutDam",
          visible=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure),
        Text(
          extent={{-98,-2},{-66,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uTSup"),
        Text(
          extent={{-100,-34},{-72,-48}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TOut"),
        Text(
          extent={{-100,-52},{-70,-66}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TRet",
          visible=ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialDryBulb),
        Text(
          extent={{-100,-84},{-70,-98}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="hOut",
          visible=(ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb
               or ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.FixedEnthalpyWithFixedDryBulb)),
        Text(
          extent={{-98,-104},{-70,-118}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible=(eneSta == Buildings.Controls.OBC.ASHRAE.G36.Types.EnergyStandard.ASHRAE90_1_2016
               and ecoHigLimCon == Buildings.Controls.OBC.ASHRAE.G36.Types.ControlEconomizer.DifferentialEnthalpyWithFixedDryBulb),
          textString="hRet"),
        Text(
          extent={{-98,-132},{-56,-146}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uSupFan"),
        Text(
          extent={{-98,-184},{-42,-198}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uFreProSta"),
        Text(
          extent={{-100,-162},{-50,-176}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="uOpeMod"),
        Text(
          extent={{34,142},{98,124}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible=not minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.SingleDamper,
          textString="yMinOutDamPos"),
        Text(
          extent={{40,70},{96,54}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yRetDamPos"),
        Text(
          extent={{42,-50},{98,-66}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible=((buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanAir
               or buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanDp)
               and (not buiPreCon == Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanDp)),
          textString="yRelDamPos"),
        Text(
          extent={{42,-110},{98,-126}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yOutDamPos"),
        Text(
          extent={{34,190},{96,174}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible=not minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.MultizoneAHUMinOADesigns.CommonDamper,
          textString="yOutDamPosMin"),
        Text(
          extent={{-96,100},{6,80}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="effAbsOutAir_normalized",
          visible=(minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
               and venSta == Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016)),
        Text(
          extent={{-96,80},{6,60}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="effDesOutAir_normalized",
          visible=minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure
               and venSta == Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016),
        Text(
          extent={{-96,58},{-54,42}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uMaxCO2",
          visible=((have_CO2Sen and venSta == Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24_2016)
                   and minOADes == Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorSection.DedicatedDampersPressure))}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,-260},{260,260}}),
    graphics={
        Line(points={{156,122}}, color={28,108,200})}),
  Documentation(info="<html>
<p>
Multi zone VAV AHU economizer control sequence that calculates
outdoor and return air damper positions based on ASHRAE
Guidline 36, May 2020, Sections: 5.16.2.3,5.16.4, 5.16.5, 5.16.6, 5.16.7.
</p>
<p>
The sequence consists of three sets of subsequences.
</p>
<ul>
<li>
First set of sequences compute the damper position limits to satisfy
outdoor air requirements. Different sequence will be enabled depending on the
designes minimum outdoor air and economizer function, which include
<ol type=\"i\">
<li>
separate minimum outdoor air damper, with airflow measurement. 
See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.SeparateWithAFMS\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.SeparateWithAFMS</a>
for a description.
</li>
<li>
separate minimum outdoor air damper, with differential pressure measurement. 
See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.SeparateWithDP\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.SeparateWithDP</a>
for a description.
</li>
<li>
single common minimum outdoor air and economizer damper. 
See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.Common\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Limits.Common</a>
for a description.
</li>
</ol>
</li>

<li>
The second set of sequences which have one sequence enable or disable the economizer based on
outdoor temperature and optionally enthalpy, and based on the supply fan status,
freeze protection stage and zone state.
See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Enable\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Enable</a>
for a description.
</li>

<li>
Third set of sequences modulate the outdoor and return damper position
to track the supply air temperature setpoint, subject to the limits of the damper positions
that were computed in the above blocks. Different sequence will be enabled depending
on the types of building pressure control system, which include
<ol type=\"i\">
<li>
relief damper or relief fan control. 
See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Modulations.Reliefs\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Modulations.Reliefs</a>
for a description.
</li>
<li>
return fan control with airflow tracking, or with direct building pressure control. 
See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Modulations.ReturnFan\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Subsequences.Modulations.ReturnFan</a>
for a description.
</li>
</ol>
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
August 1, 2020, by Jianjun Hu:<br/>
Updated implementation according to ASHRAE G36 official release.
</li>
<li>
October 11, 2017, by Michael Wetter:<br/>
Corrected implementation to use control loop signal as input.
</li>
<li>
June 28, 2017, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;

within Buildings.Templates.AHUs;
package Types "AHU types"
  extends Modelica.Icons.TypesPackage;
  type Configuration = enumeration(
      SupplyOnly
      "Supply only system",
      ExhaustOnly
      "Exhaust only system",
      DualDuct
      "Dual duct system with supply and return",
      SingleDuct
      "Single duct system with supply and return")
    "Enumeration to configure the AHU";
  type Controller = enumeration(
      Guideline36
      "Guideline 36 control sequence",
      OpenLoop
      "Open loop")
    "Enumeration to configure the AHU controller";
  type HeatRecovery = enumeration(
      None
      "No heat recovery",
      FlatPlate
      "Flat plate heat exchanger",
      EnthalpyWheel
      "Enthalpy wheel",
      RunAroundCoil
      "Run-around coil")
    "Enumeration to configure the heat recovery";
  type Location = enumeration(
      OutdoorAir,
      MinimumOutdoorAir,
      Relief,
      Return,
      Supply,
      Terminal)
  "Enumeration to specify the equipment location";
  type OutdoorSection = enumeration(
      NoEconomizer
      "No economizer",
      SingleCommon
      "Single common OA damper (modulated) with AFMS",
      DedicatedPressure
      "Dedicated minimum OA damper (two-position) with differential pressure sensor",
      DedicatedAirflow
      "Dedicated minimum OA damper (modulated) with AFMS")
    "Enumeration to configure the outdoor air section";
  type OutdoorReliefReturnSection = enumeration(
      Economizer
      "Air economizer",
      HeatRecovery
      "Heat recovery",
      NoRelief
      "No relief branch")
    "Enumeration to configure the outdoor/relief/return air section";
  type ReliefReturnSection = enumeration(
      NoEconomizer
      "No economizer",
      NoRelief
      "No relief branch",
      Barometric
      "No relief fan - Barometric relief damper",
      ReliefDamper
      "No relief fan - Modulated relief damper",
      ReliefFan
      "Relief fan - Two-position relief damper",
      ReturnFan
      "Return fan - Modulated relief damper")
    "Enumeration to configure the relief/return air section";
  type ReturnFanControlSensor = enumeration(
      None
      "Not applicable",
      Airflow
      "Airflow tracking",
      Pressure
      "Direct building pressure (via discharge static pressure)")
    "Enumeration to configure the sensor used for return fan control";
end Types;

within Buildings.Templates.BaseClasses.Connectors;
expandable connector BusChillerGroup
  "Generic control bus for chiller group classes"
  extends Modelica.Icons.SignalBus;

  Buildings.Templates.BaseClasses.Connectors.BusChiller chi[:]
    annotation (HideResult=false);

  annotation (
  defaultComponentName="busCon",
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}), Documentation(info="<html>

</html>"));
end BusChillerGroup;

within Buildings.Templates.AHUs.BaseClasses;
package HeatRecovery
  extends Modelica.Icons.Package;

  model None "No heat recovery"
    extends Interfaces.HeatRecovery(
      final typ=Types.HeatRecovery.None);

  end None;
end HeatRecovery;

within Buildings.Templates.TerminalUnits.Validation.UserProject.TerminalUnits;
model BaseNoEquipment
  extends Buildings.Templates.TerminalUnits.VAVBox(
    id="Box_1");
  annotation (
    defaultComponentName="ter",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseNoEquipment;

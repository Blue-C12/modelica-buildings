within Buildings.Templates.AHUs.Validation;
model EconomizerDedicatedDamperTandem
  extends BaseNoEquipment(redeclare
      UserProject.AHUs.EconomizerDedicatedDamperTandem ahu(redeclare record
        RecordEco =
          Buildings.Templates.AHUs.BaseClasses.Economizers.Data.DedicatedDamperTandem
          (mExh_flow_nominal=1)));
  annotation (
  experiment(Tolerance=1e-6, StopTime=1));
end EconomizerDedicatedDamperTandem;

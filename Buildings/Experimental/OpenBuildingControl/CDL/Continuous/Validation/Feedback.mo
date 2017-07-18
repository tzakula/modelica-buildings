within Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Validation;
model Feedback "Validation model for the Feedback block"
extends Modelica.Icons.Example;

  Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Feedback feedback1
    "Block that outputs difference between commanded and feedback input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Sources.Ramp ramp1(
    duration=1,
    offset=-1,
    height=4)  "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Sources.Ramp ramp2(
    height=2,
    duration=1,
    offset=-1) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
equation
  connect(ramp1.y, feedback1.u1) annotation (Line(points={{-39,20},{-26,20},{-26,
          0},{-12,0}},
                   color={0,0,127}));
  connect(ramp2.y, feedback1.u2) annotation (Line(points={{-39,-20},{-26,-20},{-26,
          -12},{0,-12}},
                     color={0,0,127}));
  annotation (
experiment(StopTime=1.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/CDL/Continuous/Validation/Feedback.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Feedback\">
Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Feedback</a>.
</p>
<p>
The input <code>u1</code> varies from <i>-2</i> to <i>+2</i>, input <code>u2</code> varies from <i>-1</i> to <i>+1</i>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 20, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end Feedback;

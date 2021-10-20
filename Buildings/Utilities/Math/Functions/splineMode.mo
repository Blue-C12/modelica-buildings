within Buildings.Utilities.Math.Functions;
function splineMode
  "Find the mode of a unimodal cubic Hermite spline"
  extends Modelica.Icons.Function;
  input Real x[:] "Support point, strict monotone increasing";
  input Real y[size(x, 1)] "Function values at x";
  output Real m[2] "The mode as (x,y)";

protected
  Integer cnt "Count of extrema";
  Integer n = size(x, 1) "Number of data points";
  Real d[size(x, 1)] "Derivative at the support points";
  Real Delta "Search accuracy";
  Real r[2,2] "Roots of the derivative equation";
  Real rIn "The root within the target interval";

  // Within the target interval
  Real x1 "Lower abscissa value";
  Real x2 "Higher abscissa value";
  Real y1 "Lower ordinate value";
  Real y2 "Higher ordinate value";
  Real y1d "Lower gradient";
  Real y2d "Higher gradient";

algorithm

  assert(n>=3,"There must be at least three points");
  d := Buildings.Utilities.Math.Functions.splineDerivatives(
    x=x,y=y,ensureMonotonicity=false);
  cnt := 0;
  //flag:=false;
  for i in 1:n-1 loop
    if d[i]*d[i + 1] <= 0 then
      //Identify the target interval at sign change
      //flag:=true;
      cnt := cnt+1;
      x1 :=x[i];
      x2 :=x[i + 1];
      y1 :=y[i];
      y2 :=y[i + 1];
      y1d :=d[i]*(x2-x1);
      y2d :=d[i + 1]*(x2-x1);
    end if;
  end for;
  //  assert(flag,"Mode not found");
  assert(cnt==1,"The curve provided is not unimodal.");

  //Root of the derivative mapped to [0,1]
  r :=Modelica.Math.Vectors.Utilities.roots(
    {6*y1 + 3*y1d - 6*y2 + 3*y2d,-6*y1 - 4*y1d + 6*y2 - 2*y2d,y1d});
  //With unimodality, exactly one of the two roots will be in (0,1)
  if (r[1,1]>0) and (r[1,1]<1) then
    rIn :=r[1,1];
  else
    rIn :=r[2,1];
  end if;
  rIn := rIn * (x2-x1)+x1; //Mapping the root back to [x1,x2]
  m[1]:=rIn;
  m[2]:=Buildings.Utilities.Math.Functions.smoothInterpolation(
    x=rIn,xSup=x,ySup=y,ensureMonotonicity=false);

  annotation(smoothOrder=1,
              Documentation(info="<html>
<p>
This function finds the mode of a unimodal interval within two adjacent knots
of a cubic Hermite spline.
The spline provided must be unimodal.
The function solves for the roots of the derivative on the interval 
between the two knots where the mode occurs.
Although by definition it is meant to find the maximum of a convex curve,
it also works for finding the minimum of a concave curve.
</p>
</html>",
revisions="<html>
<ul>
<li>
October 20, 2021, by Hongxiang Fu:<br/>
First implementation.
</li>
</ul>
</html>"));
end splineMode;

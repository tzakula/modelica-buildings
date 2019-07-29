within Buildings.Fluid.CHPs.BaseClasses;
model EnergyConversion "Energy conversion control volume"
   extends Modelica.Blocks.Icons.Block;
   replaceable parameter Buildings.Fluid.CHPs.Data.Generic per
    "Performance data"
    annotation (Placement(transformation(extent={{-98,-98},{-78,-78}})));

  replaceable package Medium = Buildings.Media.Water "Medium model";

  CHPs.BaseClasses.Interfaces.ModeTypeInput opeMod "Operation mode" annotation (
     Placement(transformation(extent={{-140,100},{-100,140}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput PEle(unit="W") "Electric power demand"
    annotation (Placement(transformation(extent={{-140,68},{-100,108}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput TWatIn(unit="K")
    "Water inlet temperature" annotation (Placement(transformation(extent={{-140,
            12},{-100,52}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput mWat_flow(unit="kg/s") "Water flow rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput TEng(unit="K") "Engine temperature"
    annotation (Placement(transformation(extent={{-138,-80},{-98,-40}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput PEleNet(unit="W")
    "Electric power generation" annotation (Placement(transformation(extent={{280,
            110},{300,130}}), iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput mFue_flow(unit="kg/s") "Fuel flow rate"
    annotation (Placement(transformation(extent={{280,50},{300,70}}),
        iconTransformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput mAir_flow(unit="kg/s") "Air flow rate"
    annotation (Placement(transformation(extent={{280,-10},{300,10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput QGen(unit="W") "Heat generation"
    annotation (Placement(transformation(extent={{280,-70},{300,-50}}),
        iconTransformation(extent={{100,-70},{120,-50}})));

protected
  CHPs.BaseClasses.AssertFuel assFue(per=per)
    "Assert if fuel flow rate is outside boundaries"
    annotation (Placement(transformation(extent={{260,76},{280,96}})));
  CHPs.BaseClasses.OperModeBasic opeModBas(per=per)
    "Typical energy conversion mode"
    annotation (Placement(transformation(extent={{22,26},{50,54}})));
  CHPs.BaseClasses.OperModeWarmUpEngTem opeModWarUpEngTem(per=per)
    "Warm-up by engine temperature"
    annotation (Placement(transformation(extent={{24,-44},{52,-16}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Modelica.Blocks.Sources.BooleanExpression booExp(y=opeMod ==CHPs.BaseClasses.Types.Mode.WarmUp
         or opeMod ==CHPs.BaseClasses.Types.Mode.Normal)
    "Check if warm up mode or normal operation mode"
    annotation (Placement(transformation(extent={{-92,64},{-72,84}})));
  Modelica.Blocks.Sources.BooleanExpression booExp1(y=opeMod ==CHPs.BaseClasses.Types.Mode.WarmUp
         and per.warmUpByTimeDelay) "Check if warm up mode by time delay"
    annotation (Placement(transformation(extent={{20,78},{40,98}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{20,104},{40,124}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{60,78},{80,98}})));

  Modelica.Blocks.Sources.BooleanExpression booExp3(y=opeMod ==CHPs.BaseClasses.Types.Mode.WarmUp
         and not per.warmUpByTimeDelay)
    "Check if typical operation or warm-up by engine temperature"
    annotation (Placement(transformation(extent={{170,10},{190,30}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{220,130},{240,110}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{220,70},{240,50}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{220,10},{240,-10}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{220,-50},{240,-70}})));
  Modelica.Blocks.Sources.Constant Troo(k=273.15 + 15)
    "Temperature used to calculate warm-up by engine temperature mode"
    annotation (Placement(transformation(extent={{-92,-42},{-72,-22}})));
equation
  connect(opeModBas.mWat_flow, mWat_flow) annotation (Line(points={{20.6,40},{
          -50,40},{-50,0},{-120,0}}, color={0,0,127}));
  connect(opeModBas.TWatIn, TWatIn) annotation (Line(points={{20.6,31.6},{-40,
          31.6},{-40,32},{-120,32}}, color={0,0,127}));
  connect(opeModWarUpEngTem.TEng, TEng) annotation (Line(points={{22.6,-38.4},{-60,
          -38.4},{-60,-60},{-118,-60}},
                                      color={0,0,127}));
  connect(opeModWarUpEngTem.TWatIn, TWatIn) annotation (Line(points={{22.6,-27.2},
          {-60,-27.2},{-60,32},{-120,32}},
                                         color={0,0,127}));
  connect(const.y, switch.u3) annotation (Line(points={{-71,50},{-32,50},{-32,72},
          {-22,72}}, color={0,0,127}));
  connect(PEle, switch.u1) annotation (Line(points={{-120,88},{-22,88}},
                     color={0,0,127}));
  connect(booExp.y, switch.u2) annotation (Line(points={{-71,74},{-46,74},{-46,80},
          {-22,80}}, color={255,0,255}));
  connect(booExp1.y, switch1.u2)
    annotation (Line(points={{41,88},{58,88}}, color={255,0,255}));
  connect(switch.y, switch1.u3)
    annotation (Line(points={{1,80},{58,80}},  color={0,0,127}));
  connect(switch.y, opeModBas.PEle) annotation (Line(points={{1,80},{10,80},{10,
          48.4},{20.6,48.4}},
                           color={0,0,127}));
  connect(opeModWarUpEngTem.mWat_flow, mWat_flow) annotation (Line(points={{22.6,
          -21.88},{-14,-21.88},{-14,-22},{-50,-22},{-50,0},{-120,0}},
                                                                    color={0,0,127}));
  connect(switch1.u1, const1.y) annotation (Line(points={{58,96},{52,96},{
          52,114},{41,114}}, color={0,0,127}));
  connect(booExp3.y, switch2.u2) annotation (Line(points={{191,20},{200,20},{200,
          120},{218,120}}, color={255,0,255}));
  connect(opeModWarUpEngTem.PEleNet, switch2.u1) annotation (Line(points={{53.4,
          -21.6},{148,-21.6},{148,112},{218,112}},
                                               color={0,0,127}));
  connect(switch2.y, PEleNet)
    annotation (Line(points={{241,120},{290,120}}, color={0,0,127}));
  connect(switch1.y, switch2.u3) annotation (Line(points={{81,88},{100,88},{100,128},
          {218,128}},           color={0,0,127}));
  connect(booExp3.y, switch3.u2) annotation (Line(points={{191,20},{200,20},{200,
          60},{218,60}}, color={255,0,255}));
  connect(switch4.u2, booExp3.y) annotation (Line(points={{218,0},{212,0},{212,20},
          {191,20}}, color={255,0,255}));
  connect(switch5.u2, booExp3.y) annotation (Line(points={{218,-60},{200,-60},{200,
          20},{191,20}}, color={255,0,255}));
  connect(switch3.y, mFue_flow)
    annotation (Line(points={{241,60},{290,60}}, color={0,0,127}));
  connect(switch4.y, mAir_flow)
    annotation (Line(points={{241,0},{290,0}}, color={0,0,127}));
  connect(switch5.y, QGen)
    annotation (Line(points={{241,-60},{290,-60}}, color={0,0,127}));
  connect(opeModBas.mFue_flow, switch3.u3) annotation (Line(points={{51.4,48.4},
          {106,48.4},{106,68},{218,68}},color={0,0,127}));
  connect(opeModWarUpEngTem.mFue_flow, switch3.u1) annotation (Line(points={{53.4,
          -27.2},{154,-27.2},{154,52},{218,52}},
                                             color={0,0,127}));
  connect(opeModBas.mAir_flow, switch4.u3) annotation (Line(points={{51.4,40},{
          106,40},{106,8},{218,8}},
                                color={0,0,127}));
  connect(opeModWarUpEngTem.mAir_flow, switch4.u1) annotation (Line(points={{53.4,
          -32.8},{160,-32.8},{160,-8},{218,-8}},
                                             color={0,0,127}));
  connect(opeModWarUpEngTem.QGen, switch5.u1) annotation (Line(points={{53.4,-38.4},
          {160,-38.4},{160,-68},{218,-68}},
                                          color={0,0,127}));
  connect(opeModBas.QGen, switch5.u3) annotation (Line(points={{51.4,31.6},{76,
          31.6},{76,32},{100,32},{100,-52},{218,-52}},
                                                 color={0,0,127}));
  connect(Troo.y, opeModWarUpEngTem.TRoo)
    annotation (Line(points={{-71,-32},{-26,-32},{-26,-32.8},{22.6,-32.8}},
                                                       color={0,0,127}));
  connect(assFue.mFue_flow, switch3.y) annotation (Line(points={{258,86},{250,86},
          {250,60},{241,60}}, color={0,0,127}));
  annotation (
    defaultComponentName="eneCon",
    Diagram(coordinateSystem(extent={{-100,-100},{280,160}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
The model defines energy conversion that occurs during the normal mode and warm-up mode. The model <a href=\"modelica://Buildings.Fluid.CHPs.BaseClasses.OperModeWarmUpEngTem\">
Buildings.Fluid.CHPs.BaseClasses.OperModeWarmUpEngTem</a> is used only for the warm-up mode dependent on the engine temperature. 
The model <a href=\"modelica://Buildings.Fluid.CHPs.BaseClasses.OperModeBasic\">
Buildings.Fluid.CHPs.BaseClasses.OperModeBasic</a> is used for all other cases (the normal mode and warm-up mode based on a time delay).
</p>
</html>", revisions="<html>
<ul>
<li>
June 01, 2019 by Tea Zakula:<br/>
First implementation.
</li>
</ul>
</html>"));
end EnergyConversion;
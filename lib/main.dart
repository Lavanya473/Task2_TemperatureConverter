import 'package:flutter/material.dart';
import 'package:flutter_application_temp_conv/colors.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Temperature Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedValue = "Degree Celcius (°C)";
  String selectedValue1 = "Degree Fahrenheit (°F)";
  List<String> dropDownItems = ["Degree Celcius (°C)","Degree Fahrenheit (°F)","Kelvin (K)"];
  var input="0";
  var output="";
  var hinput=false;
  var houtput=false;
  onButtonClick(value)
  {
    if (value == "C"){
      input="0";
      output="";
    }
    else if (value == "<"){
      if (input.isNotEmpty){
      input = input.substring(0,input.length-1);}
      houtput=false;
      output="";

    }
    else if (value == "="){
      houtput=true;
      if(selectedValue!=selectedValue1)
      {
        Parser p1 = Parser();
        var inputnew="";
      if(selectedValue == "Degree Celcius (°C)" )
        {//output=input*1.8;
        if(selectedValue1 == "Degree Fahrenheit (°F)")
        {
          
          inputnew=input+"*1.8+32";
          
        }else if (selectedValue1 == "Kelvin (K)")
        {
          inputnew=input+"+273.15";
        }
        }else if(selectedValue == "Degree Fahrenheit (°F)")
        {
          if (selectedValue1 == "Degree Celcius (°C)"){
          inputnew="("+input+"-32)*5/9";
          }else if (selectedValue1 == "Kelvin (K)")
          {
          inputnew="("+input+"-32)*5/9+273.15";
          }
        }else{
          if (selectedValue1 == "Degree Celcius (°C)"){
          inputnew=input+"-273.15";
          }else if (selectedValue1 == "Degree Fahrenheit (°F)")
          {
          inputnew="("+input+"-273.15)*9/5+32";
          }
        }
          Expression expression = p1.parse(inputnew);
          ContextModel cm =ContextModel();
          var fValue = expression.evaluate(EvaluationType.REAL,cm);
          output = fValue.toString();
        }
        else{
            output=input;
        }   }
    else if(value == "+/-"){
      if (input.isNotEmpty)
      {
        if(input.startsWith("-"))
          input=input.substring(1,input.length);
        else
          input="-"+input;
      }
    }
    else{
        hinput=true;
        input=input+value;
    }
    if (input.startsWith("0"))
      input=input.substring(1,input.length);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[ Card(
              color: Color2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    value:selectedValue,
                    onChanged: (newValue){setState((){selectedValue=newValue!;});},
                    items: dropDownItems.map((String item){
                      return DropdownMenuItem<String>(
                        child: Text(item),
                        value:item);}).toList()),
                  Text(input, style: TextStyle(color:hinput? Colors.orange:Colors.grey, fontSize: 25))
                  ])
            ),
            Card(
              color: Color2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    value:selectedValue1,
                    onChanged: (newValue){setState((){selectedValue1=newValue!;});},
                    items: dropDownItems.map((String item){
                      return DropdownMenuItem<String>(
                        child: Text(item),
                        value:item);}).toList()),
                  Text(output  , style: TextStyle(color:houtput? Colors.orange: Colors.grey, fontSize: 25))
                  ])
            )]),
        )),
      Row(children: [
        button(text:"7"),
        button(text:"8"),
        button(text:"9"),
        button(text:"C",tbground: opColor)],),
        Row(children: [
        button(text:"4"),
        button(text:"5"),
        button(text:"6"),
        button(text:"<",tbground: opColor)],),
        Row(children: [
        button(text:"1"),
        button(text:"2"),
        button(text:"3"),
        button(text:"+/-",tbground: opColor)],),
        Row(children: [
        button(text:"00"),
        button(text:"0"),
        button(text:"."),
        button(text:"=", tbground: opColor )],)
      ],)
    );
  }
  Widget button({text ,tcolor=Colors.white,tbground=Color2 })
  {
    return Expanded(child: Container(
    margin: EdgeInsets.all(8),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(40),
        primary: tbground),
    onPressed: ()=>onButtonClick(text),
    child: Text(text, style: TextStyle(
      fontSize: 22,
      color: tcolor,
      fontWeight: FontWeight.bold,
    ))
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:tiptap/widgets/bill_amount_field.dart';
import 'package:tiptap/widgets/person_counter.dart';
import 'package:tiptap/widgets/tip_row.dart';
import 'package:tiptap/widgets/tip_slider.dart';
import 'package:tiptap/widgets/total_per_person.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TipTap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const TipTap(),
    );
  }
}

  class TipTap extends StatefulWidget {
  const TipTap({super.key});

  @override
  State<TipTap> createState() => _TipTapState();
}

class _TipTapState extends State<TipTap> {
  int _personCount = 1;
  double _tipPecentage = 0.0;
  double _billTotal = 0.0;

  double totalPerPerson(){
    return ((_billTotal * _tipPecentage) + (_billTotal)) / _personCount;
  }

  double totalTip(){
    return (_billTotal * _tipPecentage);
  }

  //increment and decrement methods
  void increment(){
    setState(() {
      _personCount = _personCount + 1;
    });
  }

  void decrement(){
    setState(() {
      if (_personCount > 1){
      _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double total = totalPerPerson();
    double totalT = totalTip();
    //Add style
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,

    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('TipTap'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(theme: theme, style: style, total: total),

          //Form
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  BillAmountField(
                    billAmount: _billTotal.toString(),
                    onChanged: (value){
                      setState(() {
                        _billTotal = double.parse(value);
                      });
                      //print("Amount: $value");
                    }

                  ),
                  //Split bill section
                  PersonCounter(
                    theme: theme, 
                    personCount: _personCount, 
                    onDecrement: decrement, 
                    onIncrement: increment
                    ),

                  // == Tip Section ==
                  TipRow(theme: theme, totalT: totalT),

                  // == Slider text ==
                  Text('${(_tipPecentage*100).round()}%'),

                  // == Tip Slider ==
                  TipSlider(tipPecentage: _tipPecentage, onChanged: (double value) { 
                    setState(() {
                       _tipPecentage = value;
                    });
                   },)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
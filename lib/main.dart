import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptap/providers/ThemeProvider.dart';
import 'package:tiptap/providers/TipCalculatorModel.dart';
import 'package:tiptap/widgets/bill_amount_field.dart';
import 'package:tiptap/widgets/person_counter.dart';
import 'package:tiptap/widgets/tip_row.dart';
import 'package:tiptap/widgets/tip_slider.dart';
import 'package:tiptap/widgets/toggle_theme_button.dart';
import 'package:tiptap/widgets/total_per_person.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TipCalculatorModel()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
    child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'TipTap',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      // ),
      theme: themeProvider.currentTheme,
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final model = Provider.of<TipCalculatorModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    //Add style
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,

    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('TipTap'),
        actions: [
          ToggleThemeButton(themeProvider: themeProvider),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(theme: theme, style: style, total: model.totalPerPerson),

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
                    billAmount: model.billTotal.toString(),
                    onChanged: (billTotal){
                      model.updateBillTotal(double.parse(billTotal));
                      //print("Amount: $billTotal");
                    }

                  ),
                  //Split bill section
                  PersonCounter(
                    theme: theme, 
                    personCount: model.personCount, 
                    onDecrement: () {
                      if (model.personCount > 1) {
                        model.updatePersonCount(model.personCount - 1);
                      }
                    },
                    onIncrement: () {
                      model.updatePersonCount(model.personCount + 1);
                    }
                    ),

                  // == Tip Section ==
                  TipRow(theme: theme, 
                  totalT: model.billTotal, 
                  percentage: model.tipPercentage),

                  // == Slider text ==
                  Text('${(model.tipPercentage*100).round()}%'),

                  // == Tip Slider ==
                  TipSlider(tipPecentage: model.tipPercentage, 
                  onChanged: (double value) { 
                    model.updateTipPercentage(value);
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


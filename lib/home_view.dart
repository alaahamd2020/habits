import 'package:flutter/material.dart';
import 'package:habits/extension/on_num.dart';
import 'package:habits/widgets/custom_text.dart';
import 'package:habits/widgets/my_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom('Habits', fontSize: 25, color: Theme.of(context).primaryColor.opacity>0.5?Colors.white:Colors.black,),backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: ,
      ),
      floatingActionButton: FloatingActionButton(onPressed: addHabit, child: Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 1)),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height*0.75,
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                  TextCustom("Counter", fontSize: 30, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onPrimary, ),
                  TextCustom("10", fontSize: 25, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onPrimary,),
                ],),
              ), /// First box
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextCustom('The last', fontSize: 25,color: Theme.of(context).colorScheme.onPrimaryContainer,alignment: TextAlign.center, bold: true,),
                    Container(
                      padding: EdgeInsets.all( 8),
                      decoration: BoxDecoration(border: Border.all(width: 1), color: Theme.of(context).colorScheme.secondaryFixed),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                            TextCustom("Day", fontSize: 20, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                            TextCustom("Saturday", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                          ],),
                          Column(
                            children: [
                            TextCustom("Date", fontSize: 20, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                            TextCustom("2025/7/7", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                          ],),
                        ],
                      ),
                    ),
                  ],
                ),
              ), /// The last
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextCustom('Total days in this period', fontSize: 25,color: Theme.of(context).colorScheme.onPrimaryContainer,alignment: TextAlign.center, bold: true,),
                    Container(
                      padding: EdgeInsets.all( 8),
                      decoration: BoxDecoration(border: Border.all(width: 1), color: Theme.of(context).colorScheme.secondaryContainer),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                            TextCustom("This Week", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                            TextCustom("3 Days", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                          ],),
                          Column(
                            children: [
                            TextCustom("This Day", fontSize: 20, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer, bold: true,),
                            TextCustom("5 Days", fontSize: 20, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer, bold: true,),
                          ],),
                          Column(
                            children: [
                            TextCustom("This Month", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                            TextCustom("2 Days", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                          ],),
                        ],
                      ),
                    ),
                  ],
                ),
              ), /// Total days in this period
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextCustom('Longest Streak', fontSize: 25,color: Theme.of(context).colorScheme.onPrimaryContainer,alignment: TextAlign.center, bold: true,),
                    Container(
                      padding: EdgeInsets.all( 8),
                      decoration: BoxDecoration(border: Border.all(width: 1), color: Theme.of(context).colorScheme.secondaryContainer),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                            TextCustom("Second", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                            TextCustom("3 Days", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                          ],),
                          Column(
                            children: [
                            TextCustom("Firstly", fontSize: 20, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer, bold: true,),
                            TextCustom("5 Days", fontSize: 20, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer, bold: true,),
                          ],),
                          Column(
                            children: [
                            TextCustom("Third", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                            TextCustom("2 Days", fontSize: 18, alignment: TextAlign.center, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                          ],),
                        ],
                      ),
                    ),
                  ],
                ),
              ), /// Longest streak
              10.space,
              TextButton(
                onPressed: (){},
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.resolveWith((states) => Theme.of(context).primaryColor,) ,
                  minimumSize: WidgetStatePropertyAll(Size(MediaQuery.sizeOf(context).width *0.9, 50)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))) ,
                ),
                child: TextCustom('Habit history', fontSize: 20,bold: true, color: Theme.of(context).colorScheme.onPrimary,),)
            ],
          ),
        ),
      ),
    );
  }

  void addHabit() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: TextCustom('Add Habit', fontSize: 20, bold: true,alignment: TextAlign.center,),
        content: FormField(
          key: _key,
          builder: (field) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hint: 'Enter your name',
                  init: DateTime.now().toString(),
                  typeInput: TextInputType.datetime,
                ),
              ],
            );
          },
        ),
      );
    },);
  }
}

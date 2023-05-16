import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/button.dart';

class ReserveSpotStep2 extends StatefulWidget {
  const ReserveSpotStep2({super.key});

  @override
  State<ReserveSpotStep2> createState() => _ReserveSpotStep2State();
}

class _ReserveSpotStep2State extends State<ReserveSpotStep2> {
  
  //!!!De init waarde van _dropdownValue moet aanwezig zijn in de lijst met keuzes van de dropdownbutton
  String _dropdownValue = "Ford";
  final _cars = ["Ford","BMW","Audi","Toyota"];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        Column(
          children:  [
            Text(
              "Reserve this spot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),

            Text(
              "Select the car you want to park",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),

            
            DropdownButton(
              items: _cars
                .map((String item) =>
                  DropdownMenuItem(child: Text(item), value: item,))
                  .toList(),
              onChanged: dropdownCallBack,
              value: _dropdownValue,
            )
          ],
        ),
        // SizedBox(
        //       child: MyButton(
        //       onTap: () => print("test"),
        //       //code van chatGPT lmao
        //       // onTap: () {
        //       //   final slideUpMenuState = context.findAncestorStateOfType<_slide_up_menuState>();
        //       //   slideUpMenuState?.changeContent();
        //       //     },

        //       button_text: "Confirm",),
        //       width: 300,
        //     )
      ]),
    );
  }

  void dropdownCallBack(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }
}
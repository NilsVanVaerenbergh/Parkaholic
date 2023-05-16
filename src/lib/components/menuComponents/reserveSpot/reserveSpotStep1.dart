import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/button.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2.dart';

class ReserveSpotStep1 extends StatefulWidget {
  const ReserveSpotStep1({super.key, required this.availableIn, required this.carSize});

  final int availableIn;
  final int carSize;
  //final contentCallback nextContent;
  //TODO: address toevoegen aan parkingSpot
  //final String address 

  @override
  State<ReserveSpotStep1> createState() => _ReserveSpotStep1State();
}
typedef contentCallback = void Function();
class _ReserveSpotStep1State extends State<ReserveSpotStep1> {

  String determineCarSize(){
    if(widget.carSize == 0){
      return "small";
    }   
    else if(widget.carSize == 1){
      return "medium";
    }
    else if(widget.carSize == 2){
      return "large";
    }
    else{
      return "unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text(
              "Information",
              style: TextStyle(fontSize: 30),
              ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                text: "Available in: ",
                 style: TextStyle(fontSize: 20),
                 children: <TextSpan>[
                    TextSpan(
                      text: widget.availableIn.toString() + " minutes",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                    )
                 ]
                )           
              ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                text: "Parking spot size: ",
                 style: TextStyle(fontSize: 20),
                 children: <TextSpan>[
                    TextSpan(
                      text: determineCarSize(),
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                    )
                 ]
                )           
              ),
            const SizedBox(
              height: 20,
            ),
            const Text.rich(
              TextSpan(
                text: "address: ",
                 style: TextStyle(fontSize: 20),
                 children: <TextSpan>[
                    TextSpan(
                      text: "Teststraat 123 Anterwerpen 2000",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                    )
                 ]
                )           
              ),
              const SizedBox(
              height: 20,
              ),
              ],
            ),
            
            // SizedBox(
            //   child: MyButton(
            //   onTap: () {
            //     // widget.nextContent();
            //   },
            //   button_text: "Reserve",),
            //   width: 300,
            // )
          
        ],
      ),
    );
  }
}
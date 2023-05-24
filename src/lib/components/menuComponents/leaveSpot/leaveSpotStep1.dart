import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/textField.dart';

class LeaveSpotStep1 extends StatefulWidget {
  LeaveSpotStep1(
      {super.key, required this.leavingDate, required this.onTimeSelected});

  DateTime leavingDate;
  final Function(DateTime) onTimeSelected;

  @override
  State<LeaveSpotStep1> createState() => _LeaveSpotStep1State();
}

class _LeaveSpotStep1State extends State<LeaveSpotStep1> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String hours = dateTime.hour.toString().padLeft(2, '0');
    String minutes = dateTime.minute.toString().padLeft(2, '0');
    return Column(
      children: [
        const Text(
          "Leave this spot",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Select when you will leave",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        // MyTextField(controller: widget.timeInputController, hintText: "Time", obscureText: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 255, 255)),
              ),
              child:
                  Text('${dateTime.year}/${dateTime.month}/${dateTime.day}/'),
              onPressed: () async {
                final date = await pickDate();
                if (date == null) return; //when cancel is pressed

                setState(() => dateTime = date);
              },
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: Text('$hours:$minutes'),
              onPressed: () async {
                final time = await pickTime();
                // setState(() {
                //   hours = time!.hour.toString().padLeft(2,'0');
                //   minutes = time.minute.toString().padLeft(2,'0');
                //
                // });
                if (time == null) return; //cencel pressed
                final newTime = DateTime(dateTime.year, dateTime.month,
                    dateTime.day, time.hour, time.minute);
                setState(() => dateTime = newTime);
                widget.onTimeSelected(newTime);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:
                  Color.fromARGB(255, 255, 255, 255), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Color.fromARGB(255, 255, 255, 255), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: DateTime.now().add(const Duration(days: 7)));

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue, // header background color
                onPrimary: Color.fromARGB(255, 0, 0, 0), // header text color
                onSurface:
                    Color.fromARGB(255, 255, 255, 255), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
}

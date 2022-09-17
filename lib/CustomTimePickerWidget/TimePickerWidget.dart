import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final hourSelected = TextEditingController();
  final minSelected = TextEditingController();

  var title;

  TimePickerWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _TimePickerWidgetState(hourSelected, minSelected);
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  final TimeOfDay _time = TimeOfDay.now();

  TextEditingController hourSelected;
  TextEditingController minSelected;
  var isAM = false;
  var isPM = false;

  _TimePickerWidgetState(this.hourSelected, this.minSelected);

  @override
  Widget build(context) {
    return Scaffold(

      body: Container(
        color:  Colors.transparent,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.blue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// HR
                Flexible(
                  child: TextField(
                    maxLength: 2,
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)),
                        hintText: "${TimeOfDay.hoursPerDay}",
                        labelText: "hr"),
                    controller: hourSelected,
                    keyboardType: TextInputType.number,
                  ),
                ),

                /// MIN
                Flexible(
                  child: TextField(
                    maxLength: 2,
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)),
                        hintText: "${TimeOfDay.minutesPerHour}",
                        labelText: "min"),
                    controller: minSelected,
                    keyboardType: TextInputType.number,
                  ),
                ),

                /// AM / PM
                Flexible(
                    child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (isPM) {
                            isPM = false;
                            isAM = true;
                          } else {
                            isAM = false;
                            isPM = true;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: isAM ? Colors.grey.shade400 : Colors.grey,
                      ),
                      child: const Text("AM",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (isPM) {
                              isPM = false;
                              isAM = true;
                            } else {
                              isAM = false;
                              isPM = true;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isPM ? Colors.grey.shade400 : Colors.grey,
                        ),
                        child: const Text("PM",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final hourSelected = TextEditingController();
  final minSelected = TextEditingController();

  var title;

  TimePickerWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _TimePickerWidgetState(hourSelected, minSelected);

  late TimeOfDay _selectedTime;

  //
  // TimeOfDay getSelectedTime() {
  //   _selectedTime = TimeOfDay(
  //       hour: int.parse(hourSelected.text),
  //       minute: int.parse(minSelected.text));
  //
  //   return _selectedTime;
  // }
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  final TimeOfDay _time = TimeOfDay.now();

  TextEditingController hourSelected;
  TextEditingController minSelected;

  _TimePickerWidgetState(this.hourSelected, this.minSelected);

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        // color: Colors.blue.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.blue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
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
                const Text(" : "),
                Flexible(
                  child: TextField(

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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimePickerWidgetState();
}

// class TimePickerWidget2 extends StatelessWidget{
//   TimeOfDay _time = TimeOfDay.now();
//   var hourSelected = TextEditingController();
//   var minSelected = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//      return  Scaffold(
//       body:
//       Container(
//         color: Colors.blue,
//         child: Row(
//
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     borderSide: BorderSide(width: 2)),
//                 hintText: "${TimeOfDay.hoursPerDay}",
//               ),
//               controller: hourSelected,
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     borderSide: BorderSide(width: 2)),
//                 hintText: "${TimeOfDay.minutesPerHour}",
//               ),
//               controller: minSelected,
//               keyboardType: TextInputType.number,
//               maxLength: 60,
//             ),
//
//           ],
//
//
//         ),
//       ),
//
//     );
//
//   }
//
// }

class _TimePickerWidgetState extends State<TimePickerWidget> {
  final TimeOfDay _time = TimeOfDay.now();
  final _hourSelected = TextEditingController();
  final _minSelected = TextEditingController();
  late  TimeOfDay _selectedTime;


  TimeOfDay  getSelectedTime() {
     _selectedTime.replacing(
       hour:  int.parse(_hourSelected.text),
       minute:  int.parse(_minSelected.text),
       
     ) ;



     return _selectedTime;
  }
  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        child: Column(

          children: [
            const Text("Pick Time"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)),
                        hintText: "${TimeOfDay.hoursPerDay}",
                        labelText: "hr"),
                    controller: _hourSelected,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)),
                        hintText: "${TimeOfDay.minutesPerHour}",
                        labelText: "min"),

                    controller: _minSelected,
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

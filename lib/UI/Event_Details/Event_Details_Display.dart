import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:intl/intl.dart';

class Event_Details_Display extends StatefulWidget {
  final CleanCalendarEvent event;

  const Event_Details_Display({Key? key, required this.event})
      : super(key: key);

  @override
  State<Event_Details_Display> createState() => _Event_Details_DisplayState();
}

class _Event_Details_DisplayState extends State<Event_Details_Display> {
  final formatter = DateFormat("YYYY-MM-DD");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Events"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.blue.withOpacity(0.1),
                  Colors.blueGrey.shade400,
                ],
                stops: const [
                  0.0,
                  1.0
                ])),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: // Text("${widget.event.startTime } - ${widget.event.startTime.month} - ${widget.event.startTime.year}"),
                Text(DateFormat.yMMMMd().format(widget.event.startTime),
                  style: const TextStyle(fontSize: 40,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),),
              ),

              const SizedBox(
                height: 10,
              )
              ,
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                width: double.infinity,
                // height: 60,
                decoration: BoxDecoration(
                  color: widget.event.description.isEmpty
                      ? Colors.transparent
                      : Colors.blue.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.event.description.isNotEmpty ? [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                               Text(
                                  'Description ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color:Colors.black54)),
                            ],
                          ),


                          Text('\n ${widget.event.description}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color:Colors.black54),
                          ),

                  ] : [],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.event.summary.isEmpty
                      ? Colors.transparent
                      : Colors.blue.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:const [
                         Text(
                            'Summary ',
                        textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color:Colors.black54),),
                      ],
                    ),

                    Text('\n ${widget.event.summary}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color:Colors.black54),
                    ),

                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                             Text(
                                'Start Time \t ${widget.event.startTime
                                    .hour} : ${widget.event.startTime.minute} ',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color:Colors.black54),
                              ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                              children: [
                                const Text(
                                  'End Time  \t' , textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color:Colors.black54)),
                                Text('${widget.event.endTime
                                    .hour} : ${widget.event.endTime.minute}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color:Colors.black54),
                                ),

                              ],


                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin:  widget.event.location.isNotEmpty ? EdgeInsets.fromLTRB(30, 10, 30, 10) : null ,
                decoration: BoxDecoration(
                  color: widget.event.location.isEmpty
                      ? Colors.transparent
                      : Colors.blue.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: widget.event.location.isNotEmpty ?  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                         Text(
                              widget.event.location,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color:Colors.black54),
                            ),
                        ],
                      ),
                    )
                  ],
                ) : null ,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Is Done : '  , textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color:Colors.black54)),

                      Text('${widget.event.isDone
                                  ? " YES"
                                  : " NO"} ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: widget.event.isDone ? Colors.green : Colors.red),
                              ),
                    ],
                  ),
                ),
              )
              ,
            ],
          ),
        ),
      ),
    );
  }
}

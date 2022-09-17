import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';

class Event_Details_Display extends StatefulWidget {
  final CleanCalendarEvent event;

  const Event_Details_Display({Key? key, required this.event})
      : super(key: key);

  @override
  State<Event_Details_Display> createState() => _Event_Details_DisplayState();
}

class _Event_Details_DisplayState extends State<Event_Details_Display> {
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
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30 , 10),
                // height: 60,
                decoration: BoxDecoration(
                  color: widget.event.description.isEmpty?  Colors.transparent : Colors.blue.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Description:  \n ${widget.event.description}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const  EdgeInsets.fromLTRB(30, 10, 30 , 10),
                decoration: BoxDecoration(
                  color:     widget.event.summary.isEmpty?  Colors.transparent : Colors.blue.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(

                        'Summary: \n ${widget.event.summary}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30 , 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Start Time :  ${widget.event.startTime.hour} : ${widget.event.startTime.minute} ',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'End Time :  ${widget.event.endTime.hour} : ${widget.event.endTime.minute}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30 , 10),
                decoration: BoxDecoration(
                  color:  widget.event.location.isEmpty?  Colors.transparent : Colors.blue.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.event.location,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30 , 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Is Done :${widget.event.isDone ? " YES" : " NO"} ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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

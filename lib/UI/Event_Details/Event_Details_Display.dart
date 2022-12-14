import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Services/Provider/MyProvider.dart';

import '../Edit_Event/Edit_Events.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class Event_Details_Display extends StatefulWidget {
  final CleanCalendarEvent event;

  const Event_Details_Display({Key? key, required this.event})
      : super(key: key);

  @override
  State<Event_Details_Display> createState() => _Event_Details_DisplayState();
}

class _Event_Details_DisplayState extends State<Event_Details_Display> {
  final formatter = DateFormat("YYYY-MM-DD");
  late Uri _url;

  //todo change to 5:00 pm format
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  //todo open the url link
  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  //todo handling textwidget lenght for big url

  // late final Size? txtSize;
  // final TextStyle textStyle = const TextStyle(
  //     fontSize: 20,
  //     fontWeight: FontWeight.bold,
  //     color:Colors.blueAccent);
  //
  // Size _textSize(String text, TextStyle style) {
  //   final TextPainter textPainter = TextPainter(
  //
  //     textDirection:  ui.TextDirection.ltr,
  //       text: TextSpan(text: text, style: style), maxLines: 1 ,  )
  //     ..layout(minWidth: 0, maxWidth: double.infinity);
  //   return textPainter.size;
  // }

  initState() {
    setState(() {
      _url = Uri.parse(widget.event.Url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            " ${widget.event.description}",
            style: TextStyle(fontSize: 30),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<MyProvider>(context, listen: false)
                    .deleteEvent(widget.event);

                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Edit_Event(
                              selectedDay: DateTime(
                                widget.event.startTime.year,
                                widget.event.startTime.month,
                                widget.event.startTime.day,
                              ),
                              event: widget.event,
                            )));
              },
            )
          ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
              Colors.blue.withOpacity(0.1),
              Colors.white70,
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
                padding: const EdgeInsets.all(8),
                child: // Text("${widget.event.startTime } - ${widget.event.startTime.month} - ${widget.event.startTime.year}"),
                    Text(
                  DateFormat.yMMMMd().format(widget.event.startTime),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //todo desc
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                width: double.infinity,
                // height: 60,
                decoration: BoxDecoration(
                  color: widget.event.description.isEmpty
                      ? Colors.transparent
                      : Colors.white30,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.event.description.isNotEmpty
                      ? [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Description ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ],
                          ),
                          Text(
                            '\n ${widget.event.description}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ]
                      : [],
                ),
              ),

              //todo summary
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.event.summary.isEmpty
                      ? Colors.transparent
                      : Colors.white30,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Summary ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    Text(
                      '\n ${widget.event.summary}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),

              //todo start time
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Start Time  \t',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      Text(
                        formatTimeOfDay(TimeOfDay(
                            hour: widget.event.startTime.hour,
                            minute: widget.event.startTime.minute)),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              // todo end time
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Text('End Time  \t',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                              Text(
                                formatTimeOfDay(TimeOfDay(
                                    hour: widget.event.endTime.hour,
                                    minute: widget.event.endTime.minute)),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              //todo url
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: widget.event.isOnline
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Event Is Online ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (_url.toString().isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                          content: Text("No link available"),
                                        ));
                                      }
                                      else {
                                        _launchUrl(_url);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.web,
                                      color: Colors.blueAccent,
                                      size: 30,
                                    ))
                              ],
                            ),
                          )
                        ],
                      )
                    : null,
              ),
              // Container(
              //   // width: txtSize?.width,
              //   // height: txtSize?.height,
              //   // padding: const EdgeInsets.all(8.0),
              //   // margin:  widget.event.Url.isNotEmpty ? EdgeInsets.fromLTRB(30, 10, 30, 10) : null ,
              //   decoration: BoxDecoration(
              //     color: widget.event.location.isEmpty
              //         ? Colors.transparent
              //         : Colors.white30,
              //     borderRadius: const BorderRadius.all(Radius.circular(10)),
              //   ),
              //   child: widget.event.Url.isNotEmpty ?
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //
              //             const Text(
              //               "Url  ",
              //               textAlign: TextAlign.start,
              //               style: TextStyle( fontSize:  20 , fontWeight:  FontWeight.bold),
              //
              //             ),
              //
              //             GestureDetector(
              //                     onTap: () {
              //
              //                       final Uri _url = Uri.parse(widget.event.Url);
              //
              //                       _launchUrl(_url);
              //                     },
              //
              //                     child:  const Text("Link " , style: TextStyle(color:  Colors.blueAccent , fontSize:  20 , fontWeight:  FontWeight.bold),)
              //             )
              //
              //
              //                     //
              //                     // AutoSizeText.rich(
              //                     //   TextSpan(
              //                     //     text:  widget.event.Url,
              //                     //     style: TextStyle(fontSize: 15),
              //                     //   ),
              //                     //   minFontSize: 0,
              //                     //   stepGranularity: 0.1,
              //                     // )
              //                     //
              //                     // AutoSizeText(
              //                     //   widget.event.Url,
              //                     //   style: TextStyle(fontSize: 10),
              //                     //   minFontSize: 10,
              //                     //   stepGranularity: 10,
              //                     //   maxLines: 4,
              //                     //   overflow: TextOverflow.ellipsis,
              //                     // )
              //
              //
              //
              //                       // child:  FittedBox(
              //                       //     fit: BoxFit.scaleDown,
              //                       //     // clipBehavior: Clip.antiAlias,
              //                       //     child: Text(widget.event.Url ,
              //                       //     style: textStyle,
              //                       //     softWrap: false,
              //                       //     overflow: TextOverflow.clip,
              //                       //     maxLines: 1,
              //                       //   )
              //                       // ),
              //
              //
              //                       // child:
              //                       //
              //                       // Text(
              //                       //   widget.event.Url,
              //                       //   // textAlign: TextAlign.center,
              //                       //
              //                       //     style: textStyle,
              //                       //     softWrap: false,
              //                       //     overflow: TextOverflow.clip,
              //                       //     maxLines: 1,
              //                       // ),
              //
              //
              //
              //     ],
              //   ) : null ,
              // ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin:  widget.event.location.isEmpty
                    ? EdgeInsets.fromLTRB(30, 10, 30, 10)
                    : null,
                decoration: BoxDecoration(
                  color: widget.event.location.isEmpty
                      ? Colors.transparent
                      : Colors.white30,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: widget.event.location.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Location  ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                Text(
                                  widget.event.location,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : null,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Is completed: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      Text(
                        '${widget.event.isDone ? " YES" : " NO"} ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.event.isDone
                                ? Colors.green
                                : Colors.red),
                      ),
                      widget.event.isDone
                          ? Container()
                          : Checkbox(
                              checkColor: Colors.blue,
                              activeColor: Colors.white,
                              value: widget.event.isDone,
                              onChanged: (value) {
                                setState(() {
                                  widget.event.isDone
                                      ? widget.event.isDone = false
                                      : widget.event.isDone = true;
                                });

                                Provider.of<MyProvider>(context, listen: false)
                                    .eventIsCompleted(widget.event);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

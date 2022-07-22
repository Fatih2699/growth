// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event_editing_screen.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Padding(
        padding: const EdgeInsets.only(top:30.0, left: 10, right: 10),
        child: Scaffold(
          body: SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            cellBorderColor: Colors.transparent,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.grey,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EventEditingPage())) ;
            },
          ),
        ),
        
      ),
    );
  }
}
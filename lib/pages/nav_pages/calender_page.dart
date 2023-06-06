// ignore_for_file: prefer_const_constructors

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class Calender_page extends StatefulWidget {
  const Calender_page({super.key});

  @override
  State<Calender_page> createState() => _Calender_pageState();
}

class _Calender_pageState extends State<Calender_page> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
  }
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.black,
          appBar: AppBar( 
              toolbarHeight: 80,
               backgroundColor:Colors.black,
            automaticallyImplyLeading: false,
            title: Text('Calender'),
            actions: [
              IconButton(onPressed: (){}, 
              icon: Icon(Icons.notifications)
              ),
              IconButton(onPressed: (){
              }, 
              icon:Icon(Icons.message) )
            ],
        ),
        body: SafeArea(
          
          child: Column(
            children: [
              TableCalendar(
                
                firstDay: DateTime(2023),
                lastDay: DateTime(2024),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
                        },
                        selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
                        },
                         onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
                        },
                         onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
                        },    
                      
                        calendarStyle: CalendarStyle(
                          disabledTextStyle: TextStyle(
                             color: Colors.white,
                          ),
                          selectedDecoration: BoxDecoration(
                              color: Color(0xff45B39D),
                              shape: BoxShape.circle,
                              
                          ),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                             color: Color.fromARGB(255, 48, 50, 51),
                          ),
                          outsideTextStyle: TextStyle(
                            color: Color.fromARGB(255, 48, 50, 51),
                          ),
                          defaultTextStyle: TextStyle(
                           color: Color.fromARGB(255, 48, 50, 51),
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                              color: Colors.white,
                          ),
                          weekendStyle: TextStyle(
                            color: Colors.white,
                          )
                        ),
                       
            headerStyle:
            
    
             HeaderStyle(
                leftChevronIcon: Icon(
                   Icons.chevron_left,
                  color: Color(0xff45B39D), // Change the color of the arrow here
                   ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Color(0xff45B39D), // Change the color of the arrow here
                   ),
              formatButtonVisible: false,
               titleCentered: true,
               titleTextStyle: TextStyle(
                color: Color(0xff45B39D),
                fontSize: 17,
               ),
               
            ),
                          
                      
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color:Color.fromARGB(255, 48, 50, 51),
           ),
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pushNamed(context, '/Camera');
                    }
                    , icon: Icon(Icons.add_a_photo_outlined,color: Colors.white,size: 30,)),
                     IconButton(onPressed: (){
                      Navigator.pushNamed(context, '/enter_weight');
                     }
                    , icon: Icon(Icons.monitor_weight_outlined,color: Colors.white,size: 30,)),
                     IconButton(onPressed: (){
                       Navigator.pushNamed(context, '/enter_nutrition');
                     }
                    , icon: Icon(Icons.restaurant_menu_outlined,color: Colors.white,size: 30,))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color:Color.fromARGB(255, 48, 50, 51),
           ),
                padding: EdgeInsets.all(5),
                child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, '/excrsise');
                },
                 style: ButtonStyle (
                   minimumSize: MaterialStateProperty.all(Size(380, 40)),
                   backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                   padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                 ),
                 child:Text("Add Exercise", style: TextStyle(fontSize: 18),),
               ),
              ),
        ],
        )
        ),
    );
  }
}
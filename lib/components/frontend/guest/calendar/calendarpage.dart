import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tdvp/utility/style.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  Map<DateTime, List>? _events;
  List? _selectedEvents;
  AnimationController? _animationController;
  CalendarController? _calendarController;

  @override
  void initState() {
    super.initState();
    final selectedDay = DateTime.now();

    _events = {
      DateTime.parse("2020-02-10"): ['วันสถาปนากองอาสารักษาดินแดน'],
      DateTime.parse("2020-04-01"): ['วันสถาปนากระทรวงมหาดไทย'],
      DateTime.parse("2020-04-13"): ['วันสงกรานต์'],
      DateTime.parse("2020-02-10"): ['วันสถาปนากองอาสารักษาดินแดน'],
      DateTime.parse("2020-06-03"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
      ],
      DateTime.parse("2020-07-28"): [
        'วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'
      ],
      DateTime.parse("2020-08-12"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
      ],
      DateTime.parse("2020-09-28"): [
        'วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย'
      ],
      DateTime.parse("2020-10-13"): [
        'วันคล้ายวันสวรรคตพระบาทสมเด็จพระปรมินทรมหาภูมิพลอดุลยเดช'
      ],
      DateTime.parse("2020-10-23"): ['วันปิยมหาราช'],
      DateTime.parse("2020-12-05"): [
        'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2020-12-10"): ['วันรัฐธรรมนูญ'],
      DateTime.parse("2020-12-31"): ['วันสิ้นปี'],

      //2564-2021
      DateTime.parse("2021-01-01"): ['วันขึ้นปีใหม่'],
      DateTime.parse("2021-02-10"): ['วันสถาปนากองอาสารักษาดินแดน'],
      DateTime.parse("2021-02-26"): ['วันมาฆบูชา'],
      DateTime.parse("2021-04-01"): ['วันสถาปนากระทรวงมหาดไทย'],
      DateTime.parse("2021-04-06"): [
        'วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราชและวันที่ระลึกมหาจักรีบรมราชวงศ์'
      ],
      DateTime.parse("2021-04-12"): ['วันสงกรานต์'],
      DateTime.parse("2021-04-13"): ['วันสงกรานต์'],
      DateTime.parse("2021-04-14"): ['วันสงกรานต์'],
      DateTime.parse("2021-04-15"): ['วันสงกรานต์'],
      DateTime.parse("2021-05-01"): ['วันแรงงานแห่งชาติ'],
      DateTime.parse("2021-05-04"): ['วันฉัตรมงคล'],
      DateTime.parse("2021-05-26"): ['วันวิสาขบูชา'],
      DateTime.parse("2021-06-03"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
      ],
      DateTime.parse("2021-07-24"): ['วันอาสาฬหบูชา'],
      DateTime.parse("2021-07-28"): [
        'วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'
      ],
      DateTime.parse("2021-08-12"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
      ],
      DateTime.parse("2021-09-28"): [
        'วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย'
      ],
      DateTime.parse("2021-10-13"): [
        'วันคล้ายวันสวรรคตพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2021-10-23"): ['วันปิยมหาราช'],
      DateTime.parse("2021-12-05"): [
        'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2021-12-10"): ['วันรัฐธรรมนูญ'],
      DateTime.parse("2021-12-31"): ['วันสิ้นปี'],

      //2565-2022
      DateTime.parse("2022-01-01"): ['วันขึ้นปีใหม่'],
      DateTime.parse("2022-01-03"): ['วันหยุดชดเชยวันขึ้นปีใหม่'],
      DateTime.parse("2022-02-10"): ['วันสถาปนากองอาสารักษาดินแดน'],
      DateTime.parse("2022-02-16"): ['วันมาฆบูชา'],
      DateTime.parse("2022-04-01"): ['วันสถาปนากระทรวงมหาดไทย'],
      DateTime.parse("2022-04-06"): [
        'วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราชและวันที่ระลึกมหาจักรีบรมราชวงศ์'
      ],
      DateTime.parse("2022-04-12"): ['วันสงกรานต์'],
      DateTime.parse("2022-04-13"): ['วันสงกรานต์'],
      DateTime.parse("2022-04-14"): ['วันสงกรานต์'],
      DateTime.parse("2022-04-15"): ['วันสงกรานต์'],
      DateTime.parse("2022-05-01"): ['วันแรงงานแห่งชาติ'],
      DateTime.parse("2022-05-04"): ['วันฉัตรมงคล'],
      DateTime.parse("2022-05-15"): ['วันวิสาขบูชา'],
      DateTime.parse("2022-05-16"): ['วันหยุดชดเชยวันวิสาขบูชา'],
      DateTime.parse("2022-06-03"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
      ],
      DateTime.parse("2022-07-13"): ['วันอาสาฬหบูชา'],
      DateTime.parse("2022-07-14"): ['วันเข้าพรรษา'],
      DateTime.parse("2022-07-15"): ['วันหยุดราชการกรณีพิเศษประจำปี 2565'],
      DateTime.parse("2022-07-28"): [
        'วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'
      ],

      DateTime.parse("2022-07-29"): ['วันหยุดราชการ กรณีพิเศษประจำปี 2565'],

      DateTime.parse("2022-08-12"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
      ],
      DateTime.parse("2022-09-28"): [
        'วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย'
      ],
      DateTime.parse("2022-10-13"): [
        'วันคล้ายวันสวรรคตพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2022-10-14"): ['วันหยุดราชการ กรณีพิเศษประจำปี 2565'],
      DateTime.parse("2022-10-23"): ['วันปิยมหาราช'],
      DateTime.parse("2022-10-23"): ['วันหยุดชดเชยวันปิยมหาราช'],
      DateTime.parse("2022-12-05"): [
        'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2022-12-10"): ['วันรัฐธรรมนูญ'],
      DateTime.parse("2022-12-12"): ['วันหยุดชดเชยวันรัฐธรรมนูญ'],

      DateTime.parse("2022-12-30"): ['วันหยุดราชการ กรณีพิเศษประจำปี 2565'],
      DateTime.parse("2022-12-31"): ['วันสิ้นปี'],

      //2566-2023
      DateTime.parse("2023-01-01"): ['วันขึ้นปีใหม่'],
      DateTime.parse("2023-01-02"): ['วันหยุดชดเชยวันขึ้นปีใหม่'],

      DateTime.parse("2023-02-10"): ['วันสถาปนากองอาสารักษาดินแดน'],

      DateTime.parse("2023-03-06"): ['วันมาฆบูชา'],

      DateTime.parse("2023-04-01"): ['วันสถาปนากระทรวงมหาดไทย'],
      DateTime.parse("2023-04-06"): [
        'วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราชและวันที่ระลึกมหาจักรีบรมราชวงศ์'
      ],
      DateTime.parse("2023-04-12"): ['วันสงกรานต์'],
      DateTime.parse("2023-04-13"): ['วันสงกรานต์'],
      DateTime.parse("2023-04-14"): ['วันสงกรานต์'],
      DateTime.parse("2023-04-15"): ['วันสงกรานต์'],
      DateTime.parse("2023-05-01"): ['วันแรงงานแห่งชาติ'],

      DateTime.parse("2023-05-04"): ['วันฉัตรมงคล'],
      DateTime.parse("2023-06-03"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
      ],
      DateTime.parse("2023-06-05"): ['วันวิสาขบูชา'],

      DateTime.parse("2023-07-28"): [
        'วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'
      ],

      DateTime.parse("2023-08-01"): ['วันอาสาฬหบูชา'],
      DateTime.parse("2023-08-02"): ['วันเข้าพรรษา'],
      DateTime.parse("2023-08-12"): [
        'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
      ],
      DateTime.parse("2023-08-14"): [
        'วันหยุดชดเชยวันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
      ],

      DateTime.parse("2023-09-28"): [
        'วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย'
      ],

      DateTime.parse("2023-10-13"): [
        'วันคล้ายวันสวรรคตพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2023-10-23"): ['วันปิยมหาราช'],

      DateTime.parse("2023-12-05"): [
        'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
      ],
      DateTime.parse("2023-12-10"): ['วันรัฐธรรมนูญ'],
      DateTime.parse("2023-12-11"): ['วันหยุดชดเชยวันรัฐธรรมนูญ'],
      DateTime.parse("2023-12-31"): ['วันสิ้นปี'],
    };

    _selectedEvents = _events![selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _calendarController?.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg652.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            StyleProjects().boxTop1,
            _backButton(),
            StyleProjects().boxheight1,
            Card(
              margin: const EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              color: const Color(0xfff8fcff),
              child: Container(
                child: Column(
                  children: <Widget>[
                    StyleProjects().boxTop2,
                    StyleProjects().header2(),
                    StyleProjects().boxheight1,
                    Container(
                      //padding: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          StyleProjects().boxwidth1,
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                thickness: 2,
                                //color: const Color(0xff070ab5),
                                color: Color(0xff04066b),
                              ),
                            ),
                          ),
                          Text(
                            "ปฏิทิน",
                            style: TextStyle(
                              fontFamily: 'THSarabunNew',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              //color: const Color(0xff070ab5),
                              color: const Color(0xff04066b),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                thickness: 2,
                                //color: const Color(0xff070ab5),
                                color: const Color(0xff04066b),
                              ),
                            ),
                          ),
                          StyleProjects().boxwidth1,
                        ],
                      ),
                    ),
                    _buildTableCalendar(),
                    //StyleProjects().boxheight1,
                    StyleProjects().boxTop2,
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildEventList(),
            ),
          ],
        ),
      ),
    );
  }

  //configuration Styles
  Widget _buildTableCalendar() {
    return TableCalendar(
      //locale: 'th_TH',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.green,
        todayColor: Colors.lightGreen,
        markersColor: Colors.red,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(
          color: Colors.white,
          fontSize: 14,
        ),
        formatButtonDecoration: BoxDecoration(
          color: const Color(0xffffcc5c),
          //color: const Color(0xffffe09d),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents!
          .map((event) => Container(
                decoration: BoxDecoration(
                  // ignore: prefer_const_constructors
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: <Color>[
                      const Color(0xfffad961),
                      const Color(0xfff7681c),
                    ],
                  ),

                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: <BoxShadow>[
                    const BoxShadow(
                      color: Color(0xfff8fcff),
                      offset: Offset(1.0, 5.0),
                      blurRadius: 2,
                    ),
                  ],
                  //color: const Color(0xff81c2eb),
                  color: const Color(0xfff8fcff),
                ),
                //margin: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListTile(
                  title: Text(
                    'วันหยุดราชการและวันหยุดพิเศษ',
                    textAlign: TextAlign.center,
                    style: StyleProjects().topicstyle6,
                  ),
                  subtitle: Text(
                    event.toString(),
                    textAlign: TextAlign.center,
                    style: StyleProjects().contentstyle4,
                  ),
                  onTap: () => print('$event'),
                ),
              ))
          .toList(),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: const Color(0xff04066b),
              ),
            ),
            Text(
              'Back',
              style: StyleProjects().topicstyle4,
            )
          ],
        ),
      ),
    );
  }
}

// holidays ทำสีแดงตัวเลขในวันหยุดพิเศษต่างๆ
final Map<DateTime, List> _holidays = {
  //2563-2020
  DateTime(2020, 06, 03): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
  ],
  DateTime(2020, 07, 28): ['วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'],
  DateTime(2020, 08, 12): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง และวันแม่แห่งชาติ'
  ],
  DateTime(2020, 09, 28): ['วันสถาปนาโรงพิมพ์อาสารักษาดินแดน'],
  DateTime(2020, 10, 13): [
    'วันคล้ายวันสวรรคตพระบาทสมเด็จพระปรมินทรมหาภูมิพลอดุลยเดช'
  ],
  DateTime(2020, 10, 23): ['วันปิยมหาราช'],
  DateTime(2020, 12, 05): [
    'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
  ],
  DateTime(2020, 12, 10): ['วันรัฐธรรมนูญ'],
  DateTime(2020, 12, 11): ['วันหยุดชดเชย'],
  DateTime(2020, 12, 31): ['วันสิ้นปี'],

  //2564-2021
  DateTime(2021, 01, 01): ['วันขึ้นปีใหม่'],
  DateTime(2021, 02, 26): ['วันมาฆบูชา'],
  DateTime(2021, 04, 06): [
    'วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราชและวันที่ระลึกมหาจักรีบรมราชวงศ์'
  ],
  DateTime(2021, 04, 12): ['วันสงกรานต์'],
  DateTime(2021, 04, 13): ['วันสงกรานต์'],
  DateTime(2021, 04, 14): ['วันสงกรานต์'],
  DateTime(2021, 04, 15): ['วันสงกรานต์'],
  DateTime(2021, 05, 01): ['วันแรงงานแห่งชาติ'],
  DateTime(2021, 05, 03): ['ชดเชยวันแรงงานแห่งชาติ'],
  DateTime(2021, 05, 04): ['วันฉัตรมงคล'],
  DateTime(2021, 05, 26): ['วันวิสาขบูชา'],
  DateTime(2021, 06, 03): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
  ],
  DateTime(2021, 07, 26): ['ชดเชย วันอาสาฬหบูชา'],
  DateTime(2021, 07, 28): ['วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'],
  DateTime(2021, 08, 12): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง และวันแม่แห่งชาติ'
  ],
  DateTime(2021, 09, 28): ['วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง'],
  DateTime(2021, 10, 13): [
    'วันคล้ายวันสวรรคตพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
  ],
  DateTime(2021, 10, 23): ['วันปิยมหาราช'],
  DateTime(2021, 12, 05): [
    'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร',
    'วันชาติ และ วันพ่อแห่งชาติ'
  ],
  DateTime(2021, 12, 10): ['วันรัฐธรรมนูญ'],
  DateTime(2021, 12, 31): ['วันสิ้นปี'],

  //2565-2022
  DateTime(2022, 01, 01): ['วันขึ้นปีใหม่'],
  DateTime(2022, 01, 03): ['วันหยุดชดเชยวันขึ้นปีใหม่'],

  DateTime(2022, 02, 10): ['วันสถาปนากองอาสารักษาดินแดน'],
  DateTime(2022, 02, 16): ['วันมาฆบูชา'],

  DateTime(2022, 04, 01): ['วันสถาปนากระทรวงมหาดไทย'],
  DateTime(2022, 04, 06): [
    'วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราชและวันที่ระลึกมหาจักรีบรมราชวงศ์'
  ],

  DateTime(2022, 04, 12): ['วันสงกรานต์'],
  DateTime(2022, 04, 13): ['วันสงกรานต์'],
  DateTime(2022, 04, 14): ['วันสงกรานต์'],
  DateTime(2022, 04, 15): ['วันสงกรานต์'],
  DateTime(2022, 05, 01): ['วันแรงงานแห่งชาติ'],

  DateTime(2022, 05, 04): ['วันฉัตรมงคล'],
  DateTime(2022, 05, 15): ['วันวิสาขบูชา'],
  DateTime(2022, 05, 16): ['วันหยุดชดเชยวันวิสาขบูชา'],
  DateTime(2022, 06, 03): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
  ],
  DateTime(2022, 07, 13): ['วันอาสาฬหบูชา'],

  DateTime(2022, 07, 14): ['วันเข้าพรรษา'],
  DateTime(2022, 07, 15): ['วันหยุดราชการกรณีพิเศษประจำปี 2565'],
  DateTime(2022, 07, 28): ['วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'],

  DateTime(2022, 07, 29): ['วันหยุดราชการ กรณีพิเศษประจำปี 2565'],

  DateTime(2022, 08, 12): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
  ],

  DateTime(2022, 09, 28): [
    'วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย'
  ],
  DateTime(2022, 10, 13): [
    'วันคล้ายวันสวรรคตพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
  ],
  DateTime(2022, 10, 14): ['วันหยุดราชการ กรณีพิเศษประจำปี 2565'],
  DateTime(2022, 10, 23): ['วันปิยมหาราช'],
  DateTime(2022, 10, 24): ['วันหยุดชดเชยวันปิยมหาราช'],
  DateTime(2022, 12, 05): [
    'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
  ],

  DateTime(2022, 12, 10): ['วันรัฐธรรมนูญ'],
  DateTime(2022, 12, 12): ['วันหยุดชดเชยวันรัฐธรรมนูญ'],
  DateTime(2022, 12, 30): ['วันหยุดราชการ กรณีพิเศษประจำปี 2565'],
  DateTime(2022, 12, 31): ['วันสิ้นปี'],

  //2566 - 2023
  DateTime(2023, 01, 01): ['วันขึ้นปีใหม่'],
  DateTime(2023, 01, 02): ['วันหยุดชดเชยวันขึ้นปีใหม่'],

  DateTime(2023, 02, 10): ['วันสถาปนากองอาสารักษาดินแดน'],

  DateTime(2023, 03, 06): ['วันมาฆบูชา'],

  DateTime(2023, 04, 01): ['วันสถาปนากระทรวงมหาดไทย'],
  DateTime(2023, 04, 06): [
    'วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราชและวันที่ระลึกมหาจักรีบรมราชวงศ์'
  ],

  DateTime(2023, 04, 12): ['วันสงกรานต์'],
  DateTime(2023, 04, 13): ['วันสงกรานต์'],
  DateTime(2023, 04, 14): ['วันสงกรานต์'],
  DateTime(2023, 04, 15): ['วันสงกรานต์'],

  DateTime(2023, 05, 01): ['วันแรงงานแห่งชาติ'],
  DateTime(2023, 05, 04): ['วันฉัตรมงคล'],

  DateTime(2023, 06, 05): ['วันวิสาขบูชา'],
  DateTime(2023, 06, 03): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดาพัชรสุธาพิมลลักษณ พระบรมราชินี'
  ],

  DateTime(2023, 07, 28): ['วันเฉลิมพระชนมพรรษาพระบาทสมเด็จพระเจ้าอยู่หัว'],

  DateTime(2023, 08, 01): ['วันอาสาฬหบูชา'],
  DateTime(2023, 08, 02): ['วันเข้าพรรษา'],
  DateTime(2023, 08, 12): [
    'วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
  ],
  DateTime(2023, 08, 14): [
    'วันหยุดชดเชยวันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถพระบรมราชชนนีพันปีหลวง'
  ],

  DateTime(2023, 09, 28): [
    'วันสถาปนาโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย'
  ],

  DateTime(2023, 10, 13): [
    'วันคล้ายวันสวรรคตพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
  ],
  DateTime(2023, 10, 23): ['วันปิยมหาราช'],

  DateTime(2023, 12, 05): [
    'วันคล้ายวันพระบรมราชสมภพของพระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร'
  ],
  DateTime(2023, 12, 10): ['วันรัฐธรรมนูญ'],
  DateTime(2023, 12, 11): ['วันหยุดชดเชยวันรัฐธรรมนูญ'],
  DateTime(2023, 12, 31): ['วันสิ้นปี'],
};

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendereventpageController extends GetxController {
  var calendarFormat = CalendarFormat.month.obs;
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  // Store events as a map containing name & description
  var events = <DateTime, List<Map<String, String>>>{}.obs;

  void selectDay(DateTime day, DateTime focusDay) {
    selectedDay.value = day;
    focusedDay.value = focusDay;
  }

  void addEvent(
    String eventName,
    String description,
    String userName,
    String phone,
  ) {
    final event = {
      "name": userName,
      "phone": phone,
      "eventName": eventName,
      "description": description,
    };

    // Store this event in your events map or database
    final dateKey = selectedDay.value;
    if (events[dateKey] == null) {
      events[dateKey] = [];
    }
    events[dateKey]!.add(event);

    events.refresh(); // Refresh UI
  }

  void deleteEvent(String existingEventName) {}
}

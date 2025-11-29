import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/Calendereventpage/controllers/calendereventpage_controller.dart';
import 'package:foodapp/widgets/AddEventPopup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendereventpageView extends GetView<CalendereventpageController> {
  final CalendereventpageController controller =
      Get.put(CalendereventpageController());

  CalendereventpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔙 Back button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: isDark
                        ? const Color.fromARGB(255, 245, 206, 87)
                        : Colors.pink,
                    size: width * 0.06,
                  ),
                ),
              ),

              /// 📅 Calendar
              Container(
                margin: EdgeInsets.all(width * 0.02),
                padding: EdgeInsets.all(width * 0.025),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(width * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black45 : Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Obx(
                  () => TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controller.focusedDay.value,
                    calendarFormat: controller.calendarFormat.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay.value, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.selectDay(selectedDay, focusedDay);
                    },
                    eventLoader: (day) => controller.events[day] ?? [],

                    /// 📌 Calendar Styling
                    calendarStyle: CalendarStyle(
                      defaultDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        color: isDark
                            ? Colors.grey.shade800
                            : const Color.fromARGB(255, 238, 237, 237),
                      ),
                      selectedDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        color: isDark
                            ? const Color.fromARGB(255, 247, 208, 91)
                            : Colors.pink,
                      ),
                      todayDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        color: Colors.deepOrange,
                      ),
                      markersAlignment: Alignment.bottomCenter,
                      markerDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.015),
                        color: Colors.redAccent,
                      ),
                      defaultTextStyle: TextStyle(
                        fontSize: width * 0.032 * textScale,
                        fontWeight: FontWeight.w500,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      weekendTextStyle: TextStyle(
                        fontSize: width * 0.032 * textScale,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.red[200] : Colors.red[700],
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: width * 0.045 * textScale,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.01),

              /// 📝 Event list container
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(width * 0.04),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[50],
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  child: Obx(() {
                    var selectedEvents =
                        controller.events[controller.selectedDay.value] ?? [];

                    if (selectedEvents.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_busy_rounded,
                                size: width * 0.14,
                                color:
                                    isDark ? Colors.grey[500] : Colors.grey[400]),
                            SizedBox(height: width * 0.03),
                            Text(
                              'No Events Scheduled',
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.035 * textScale,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDark ? Colors.grey[400] : Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: width * 0.015),
                            Text(
                              'Tap the + button to add a new event',
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.032 * textScale,
                                color: Colors.grey[500],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: selectedEvents.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: width * 0.03),
                      itemBuilder: (context, index) {
                        var event = selectedEvents[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            side: BorderSide(
                              color: isDark
                                  ? const Color.fromARGB(255, 247, 210, 97)
                                  : Colors.pink,
                              width: 1.2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// 🔹 Header Row (Icon + Title + Delete)
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: isDark
                                          ? const Color.fromARGB(
                                              255, 248, 208, 89)
                                          : Colors.pink,
                                      radius: width * 0.05,
                                      child: Icon(Icons.event,
                                          color: Colors.white,
                                          size: width * 0.05),
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Expanded(
                                      child: Text(
                                        event["eventName"] ?? "No Title",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: width * 0.038 * textScale,
                                          color:
                                              theme.textTheme.bodyLarge?.color,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever_rounded,
                                          color: Colors.redAccent,
                                          size: width * 0.07),
                                      onPressed: () {
                                        _showDeleteDialog(
                                            context, index, isDark, width);
                                      },
                                    ),
                                  ],
                                ),

                                SizedBox(height: width * 0.02),

                                /// 🔹 User Info
                                Row(
                                  children: [
                                    Icon(Icons.person,
                                        size: width * 0.05,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.blueGrey),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        event["name"] ?? "Unknown",
                                        style: GoogleFonts.poppins(
                                          fontSize: width * 0.033 * textScale,
                                          color: isDark
                                              ? Colors.grey[400]
                                              : Colors.blueGrey[700],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 6),

                                /// 🔹 Phone (click to call)
                                GestureDetector(
                                  onTap: () async {
                                    if (event["phone"] != null &&
                                        event["phone"].toString().isNotEmpty) {
                                      final Uri phoneUri =
                                          Uri(scheme: "tel", path: event["phone"]);
                                      if (await canLaunchUrl(phoneUri)) {
                                        await launchUrl(phoneUri);
                                      } else {
                                        Get.snackbar("Error", "Cannot launch dialer");
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone,
                                          size: width * 0.05,
                                          color: isDark
                                              ? Colors.lightGreen
                                              : Colors.green),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          event["phone"] ?? "N/A",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * 0.033 * textScale,
                                            color: isDark
                                                ? Colors.grey[400]
                                                : Colors.blueGrey[700],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (event["phone"] != null &&
                                          event["phone"].toString().isNotEmpty)
                                        Icon(Icons.call,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.pink,
                                            size: width * 0.06),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 6),

                                /// 🔹 Description
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.description,
                                        size: width * 0.05,
                                        color:
                                            isDark ? Colors.pink : Colors.orange),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        event["description"] ??
                                            "No Description",
                                        style: GoogleFonts.poppins(
                                          fontSize: width * 0.033 * textScale,
                                          color: isDark
                                              ? Colors.grey[400]
                                              : Colors.blueGrey[700],
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),

      /// ➕ Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddEventPopup.show(controller),
        backgroundColor:
            isDark ? const Color.fromARGB(255, 247, 207, 87) : Colors.pink,
        child: Icon(Icons.add, color: Colors.white, size: width * 0.07),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, int index, bool isDark, double width) {
    final controller = Get.find<CalendereventpageController>();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
            side: BorderSide(color: Colors.redAccent, width: 2),
          ),
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          child: Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Delete Event",
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black)),
                SizedBox(height: 12),
                Text("Are you sure you want to delete\nthis event?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.032,
                        height: 1.4,
                        color: isDark ? Colors.white70 : Colors.black87)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              isDark ? Colors.pink : Colors.amber),
                      onPressed: () => Get.back(),
                      child: Text("Cancel",
                          style: GoogleFonts.poppins(
                              fontSize: width * 0.031,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.events[controller.selectedDay.value]
                            ?.removeAt(index);
                        controller.events.refresh();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark ? Colors.amber : Colors.pink),
                      child: Text("Delete",
                          style: GoogleFonts.poppins(
                              fontSize: width * 0.032,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

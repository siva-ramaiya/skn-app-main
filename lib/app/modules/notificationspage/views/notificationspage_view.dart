import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../controllers/notificationspage_controller.dart';

// 🔔 Notifications plugin global
final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationspageView extends StatefulWidget {
  const NotificationspageView({super.key});

  @override
  State<NotificationspageView> createState() => _NotificationspageViewState();
}

class _NotificationspageViewState extends State<NotificationspageView>
    with SingleTickerProviderStateMixin {
  final NotificationspageController controller = Get.put(
    NotificationspageController(),
  );

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    // 🔔 initialize notifications with timezone
    initNotifications();
  }

  /// ✅ Init Notifications
  Future<void> initNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // 👈 Local timezone

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(initializationSettings);
  }

  // ✅ Instant notification
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'general_channel', // channel id
      'General Notifications', // channel name
      channelDescription: 'General app notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await notificationsPlugin.show(id, title, body, platformDetails);
  }

  // ✅ Schedule Reminder
  Future<void> scheduleReminder({
    required int id,
    required String title,
    String? body,
  }) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = now.add(const Duration(seconds: 5));

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel_id',
          'Daily Reminders',
          channelDescription: 'Reminder to complete daily habits',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // ✅ Cancel all notifications
  Future<void> _cancelNotifications() async {
    await notificationsPlugin.cancelAll();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark
                ? const Color.fromARGB(255, 241, 202, 84)
                : Colors.pink,
            size: width * 0.06,
          ),
          onPressed: () => Get.to(const BottomnavigationbarView()),
        ),
        centerTitle: true,
        title: Text(
          "Notification",
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white : Colors.black,
            fontSize: width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.17,
              child: Image.asset(
                "assets/images/notificationsssssssss.png",
                fit: BoxFit.cover,
                height: height * 0.35,
              ),
            ),
          ),

          // Main Content with Animation
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.04),
                    _buildSwitchTile(
                      context: context,
                      title: "Allow Notifications",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      value: controller.allowNotifications,
                    ),
                    SizedBox(height: height * 0.04),
                    _buildSwitchTile(
                      context: context,
                      title: "Email Notifications",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      value: controller.emailNotifications,
                    ),
                    SizedBox(height: height * 0.04),
                    _buildSwitchTile(
                      context: context,
                      title: "Order Notifications",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      value: controller.orderNotifications,
                    ),
                    SizedBox(height: height * 0.04),
                    _buildSwitchTile(
                      context: context,
                      title: "General Notifications",
                      description:
                          "This will send instant + scheduled test notifications.",
                      value: controller.generalNotifications,
                    ),
                    const Spacer(),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String description,
    required RxBool value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.04,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.032,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value.value,
              activeThumbColor: isDark
                  ? const Color.fromARGB(255, 237, 200, 87)
                  : Colors.pink,
              activeTrackColor: isDark
                  ? const Color.fromARGB(100, 237, 200, 87) // lighter track
                  : Colors.pinkAccent.withOpacity(0.5),
              onChanged: (val) async {
                value.value = val; // update state

                if (title == "General Notifications") {
                  if (val) {
                    // ✅ Show instant notification
                    await showInstantNotification(
                      id: DateTime.now().millisecondsSinceEpoch.remainder(
                        100000,
                      ),
                      title: title,
                      body: "This is an instant notification 🚀",
                    );

                    // ✅ Schedule reminder (e.g., 5 sec later)
                    await scheduleReminder(
                      id: DateTime.now().millisecondsSinceEpoch.remainder(
                        100000,
                      ),
                      title: "Scheduled Reminder",
                      body: "This is your scheduled reminder ⏰",
                    );
                  } else {
                    // ❌ Cancel all notifications when OFF
                    await _cancelNotifications();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

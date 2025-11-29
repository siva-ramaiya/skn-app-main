import 'package:get/get.dart';
import '../modules/Calendereventpage/bindings/calendereventpage_binding.dart';
import '../modules/Calendereventpage/views/calendereventpage_view.dart';
import '../modules/aboutscreenpage/bindings/aboutscreenpage_binding.dart';
import '../modules/aboutscreenpage/views/aboutscreenpage_view.dart';
import '../modules/addcartpageviews/bindings/addcartpageviews_binding.dart';
import '../modules/addcartpageviews/views/addcartpageviews_view.dart';
import '../modules/bottomnavgationbar/bindings/bottomnavgationbar_binding.dart';
import '../modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import '../modules/categorypage/bindings/categorypage_binding.dart';
import '../modules/categorypage/views/categorypage_view.dart';
import '../modules/chatbotpage/bindings/chatbotpage_binding.dart';
import '../modules/chatbotpage/views/chatbotpage_view.dart';
import '../modules/conespagescreen/bindings/conespagescreen_binding.dart';
import '../modules/conespagescreen/views/conespagescreen_view.dart';
import '../modules/drawerpage/bindings/drawerpage_binding.dart';
import '../modules/drawerpage/views/drawerpage_view.dart';
import '../modules/favouritepageview/bindings/favouritepageview_binding.dart';
import '../modules/favouritepageview/views/favouritepageview_view.dart';
import '../modules/feedbackpage/bindings/feedbackpage_binding.dart';
import '../modules/feedbackpage/views/feedbackpage_view.dart';
import '../modules/googlepageview/bindings/googlepageview_binding.dart';
import '../modules/googlepageview/views/googlepageview_view.dart';
import '../modules/helpsupportpage/bindings/helpsupportpage_binding.dart';
import '../modules/helpsupportpage/views/helpsupportpage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loginpage/bindings/loginpage_binding.dart';
import '../modules/loginpage/views/loginpage_view.dart';
import '../modules/myorderpage/bindings/myorderpage_binding.dart';
import '../modules/myorderpage/views/myorderpage_view.dart';
import '../modules/notificationspage/bindings/notificationspage_binding.dart';
import '../modules/notificationspage/views/notificationspage_view.dart';
import '../modules/optscreenpage/bindings/optscreenpage_binding.dart';
import '../modules/optscreenpage/views/optscreenpage_view.dart';
import '../modules/orderconfrompageview/bindings/orderconfrompageview_binding.dart';
import '../modules/orderconfrompageview/views/orderconfrompageview_view.dart';
import '../modules/orderhistorypage/bindings/orderhistorypage_binding.dart';
import '../modules/orderhistorypage/views/orderhistorypage_view.dart';
import '../modules/phonescreenpage/bindings/phonescreenpage_binding.dart';
import '../modules/phonescreenpage/views/phonescreenpage_view.dart';
import '../modules/categorydetailspage/bindings/categorydetailspage_binding.dart';
import '../modules/categorydetailspage/views/categorydetailspage_view.dart';
import '../modules/productdetailspage/bindings/productdetailspage_binding.dart';
import '../modules/productdetailspage/views/productdetailspage_view.dart';
import '../modules/profilescreenpage/bindings/profilescreenpage_binding.dart';
import '../modules/profilescreenpage/views/profilescreenpage_view.dart';
import '../modules/registerpage/bindings/registerpage_binding.dart';
import '../modules/registerpage/views/registerpage_view.dart';
import '../modules/splashscreenpage/bindings/splashscreenpage_binding.dart';
import '../modules/splashscreenpage/views/splashscreenpage_view.dart';
import '../modules/trackingpage/bindings/trackingpage_binding.dart';
import '../modules/trackingpage/views/trackingpage_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREENPAGE;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.SPLASHSCREENPAGE,
      page: () => SplashscreenpageView(),
      binding: SplashscreenpageBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMNAVGATIONBAR,
      page: () => BottomnavigationbarView(),
      binding: BottomnavgationbarBinding(),
    ),
    GetPage(
      name: _Paths.ADDCARTPAGEVIEWS,
      page: () => AddcartpageviewsView(),
      binding: AddcartpageviewsBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITEPAGEVIEW,
      page: () => FavouritepageviewView(),
      binding: FavouritepageviewBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAILSPAGE,
      page: () => ProductDetailsViewpageView(),
      binding: ProductdetailspageBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLEPAGEVIEW,
      page: () => GooglepageviewView(),
      binding: GooglepageviewBinding(),
    ),
    GetPage(
      name: _Paths.DRAWERPAGE,
      page: () => DrawerView(),
      binding: DrawerpageBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOTPAGE,
      page: () => ChatbotView(),
      binding: ChatbotpageBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTSCREENPAGE,
      page: () => AboutpageView(),
      binding: AboutscreenpageBinding(),
    ),
    GetPage(
      name: _Paths.PHONESCREENPAGE,
      page: () => PhonescreenpageView(),
      binding: PhonescreenpageBinding(),
    ),
    GetPage(
      name: _Paths.OPTSCREENPAGE,
      page: () => OptscreenpageView(),
      binding: OptscreenpageBinding(),
    ),
    GetPage(
      name: _Paths.PIZZASCREENPAGE,
      page: () => CategoryDetailspageView(),
      binding: PizzascreenpageBinding(),
    ),

    GetPage(
      name: _Paths.FEEDBACKPAGE,
      page: () => FeedbackpageView(),
      binding: FeedbackpageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILESCREENPAGE,
      page: () => ProfilescreenpageView(),
      binding: ProfilescreenpageBinding(),
    ),
    GetPage(
      name: _Paths.ORDERCONFROMPAGEVIEW,
      page: () => OrderConfirmViewpageView(),
      binding: OrderconfrompageviewBinding(),
    ),
    GetPage(
      name: _Paths.CONESPAGESCREEN,
      page: () => ConespagescreenView(),
      binding: ConespagescreenBinding(),
    ),

    GetPage(
      name: _Paths.NOTIFICATIONSPAGE,
      page: () => NotificationspageView(),
      binding: NotificationspageBinding(),
    ),
    GetPage(
      name: _Paths.TRACKINGPAGE,
      page: () => TrackingpageView(),
      binding: TrackingpageBinding(),
    ),
    GetPage(
      name: _Paths.ORDERHISTORYPAGE,
      page: () => OrderhistorypageView(),
      binding: OrderhistorypageBinding(),
    ),
    GetPage(
      name: _Paths.CALENDEREVENTPAGE,
      page: () => CalendereventpageView(),
      binding: CalendereventpageBinding(),
    ),

    GetPage(
      name: _Paths.CATEGORYPAGE,
      page: () => const CategorypageView(),
      binding: CategorypageBinding(),
    ),
    GetPage(
      name: _Paths.HELPSUPPORTPAGE,
      page: () => const HelpsupportpageView(),
      binding: HelpsupportpageBinding(),
    ),
    GetPage(
      name: _Paths.MYORDERPAGE,
      page: () => const MyorderpageView(),
      binding: MyorderpageBinding(),
    ),
    GetPage(
      name: _Paths.LOGINPAGE,
      page: () => const LoginpageView(),
      binding: LoginpageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTERPAGE,
      page: () => const RegisterpageView(),
      binding: RegisterpageBinding(),
    ),
  ];
}

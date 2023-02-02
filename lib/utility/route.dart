/*
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/services/services.dart';
import 'package:tdvp/components/frontend/customer/customerservice/customer_service.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/components/frontend/guest/home/homepage.dart';
import 'package:tdvp/components/frontend/guest/register/register.dart';

final Map<String, WidgetBuilder> map = {
  '/home': (BuildContext context) => const HomePage(),
  /*
  '/calendar': (BuildContext context) => const CalendarScreen(),
  '/contect': (BuildContext context) => ContactScreen(),
  '/location': (BuildContext context) => MapsPage(),
  '/sicial': (BuildContext context) => SocialPage(),
  '/bot': (BuildContext context) => ChatbotPage(), 
  '/datacorp': (BuildContext context) => DataCorporateScreen(),
  '/info': (BuildContext context) => InfotdvpScreen(),
  '/evaluate': (BuildContext context) => EvaluatePage(),
  '/catalog': (BuildContext context) => CatalogPage(),
  */

  '/register': (BuildContext context) => RegisterPages(),
  '/authentication': (BuildContext context) => const AuthenticationPage(),
  '/customerService': (BuildContext context) => const CustomerService(),
  '/adminService': (BuildContext context) => AdminService(),
};

*/
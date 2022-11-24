import 'package:flutter/material.dart';
import 'package:flutter_mt/source/pages/Auth/login.dart';
import 'package:flutter_mt/source/pages/Auth/splash.dart';
import 'package:flutter_mt/source/pages/Home/Perawatan/AddPerawatan.dart';
import 'package:flutter_mt/source/pages/Home/Perawatan/EditPerawatan.dart';
import 'package:flutter_mt/source/pages/Home/Perawatan/perawatan.dart';
import 'package:flutter_mt/source/pages/Home/Perawatan/riwayat_perawatan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/AddPerbaikan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/EditPerbaikan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/info_msn_perbaikan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/perbaikan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/qr_perbaikan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/riwayat_perbaikan.dart';
import 'package:flutter_mt/source/pages/Home/TabBar/tabbar.dart';
import 'package:flutter_mt/source/router/string.dart';

class RouterNavigation {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => const Login());
      case HOME:
        return MaterialPageRoute(builder: (context) => const MyTabBar());
      case PERBAIKAN:
        return MaterialPageRoute(builder: (context) => const Perbaikan());
      case ADD_PERBAIKAN:
        return MaterialPageRoute(builder: (context) => const AddPerbaikan());
      case EDIT_PERBAIKAN:
        return MaterialPageRoute(settings: settings, builder: (context) => const EditPerbaikan());
      case INFO_MSN_PERBAIKAN:
        return MaterialPageRoute(settings: settings, builder: (context) => const InfoMesinPerbaikan());
      case RIWAYAT_PERBAIKAN:
        return MaterialPageRoute(builder: (context) => const RiwayatPerbaikan());
      case QR_PERBAIKAN:
        return MaterialPageRoute(settings: settings, builder: (context) => QRPerbaikan());
        // PERAWATAN
      case PERAWATAN:
        return MaterialPageRoute(settings: settings, builder: (context) => Perawatan());
      case ADD_PERAWATAN:
        return MaterialPageRoute(settings: settings, builder: (context) => AddPerawatan());
      case EDIT_PERAWATAN:
        return MaterialPageRoute(settings: settings, builder: (context) => EditPerawatan());
      case RIWAYAT_PERAWATAN:
        return MaterialPageRoute(settings: settings, builder: (context) => RiwayatPerawatan());

      default:
        return null;
    }
  }
}

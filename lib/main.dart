import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_calc/controller/historic_controller.dart';
import 'package:simple_calc/controller/operation_controller.dart';
import 'package:simple_calc/controller/theme_controller.dart';
import 'package:simple_calc/view/historic_view.dart';
import 'package:simple_calc/view/main_view.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.openBox('operations');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OperationController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => HistoricController(),)
      ],
      child: const MyApp(), //topo da árvore de widgets
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeController.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const Mainview(),
        '/hist': (context) => HistoricView(),
      },
    );
  }
}
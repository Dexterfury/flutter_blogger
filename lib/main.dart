import 'package:flutter/material.dart';
import 'package:flutter_blogger/providers/theme_provider.dart';
import 'package:flutter_blogger/providers/user_provider.dart';
import 'package:flutter_blogger/screnns/home.dart';
import 'package:flutter_blogger/themes/my_themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = await UserProvider().getUserData();
  final isDarkTheme = await ThemeProvider().getTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserProvider(
                  user: user,
                )),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkMode: isDarkTheme),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:product_explorer/presentation/product_explorer_screen.dart';
import 'package:product_explorer/presentation/settings_screen.dart';
import 'package:product_explorer/presentation/widgets/end_drawer_header.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../utilities/screen.dart';
import 'about_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  final Screen currentScreen;
  const MainScreen({super.key, this.currentScreen = Screen.home});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int selectedIndex;
  List<Widget> screens=[
    HomeScreen(),
    ProductExplorerScreen(),
    SettingsScreen(),
    AboutScreen()
  ];
  List<String> screenTitle = [
    "Home",
    "Product Explorer",
    "Settings",
    "About"
  ];
  @override
  void initState() {
    selectedIndex = widget.currentScreen.index;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 241, 253),
        leading: selectedIndex==0?null:IconButton(onPressed: (){
          setState(() {
            selectedIndex = 0;
          });
        }, icon: Icon(Icons.arrow_back_rounded)),
        centerTitle: true,
        title: Text(screenTitle[selectedIndex]),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          })
        ],
        // Removed bottom PreferredSize here
      ),
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top items including header and navigation
            Column(
              children: [
                EndDrawerHeader(userEmailAddress: authProvider.email),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text("Products"),
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.message),
                  title: const Text("About the developer"),
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            // Logout at the bottom
            Center(
                child: Tooltip(
                  message: 'Logout',
                  child: IconButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                    }, icon: Icon(Icons.logout)),
              )
            )
          ],
        ),
      ),

      body: screens[selectedIndex],
    );
  }
}

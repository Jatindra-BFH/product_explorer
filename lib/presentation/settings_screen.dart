import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_explorer/provider/layout_utilities_provider.dart';
import 'package:product_explorer/utilities/layout_type.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _gridSizeController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LayoutUtilitiesProvider>(context, listen: false);
    _gridSizeController = TextEditingController(text: provider.gridSize.toString());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LayoutUtilitiesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            title: const Text("Layout Type"),
            subtitle: Row(
              children: [
                ChoiceChip(
                  label: const Text("Grid"),
                  selected: provider.layoutType == LayoutType.grid,
                  onSelected: (_) => provider.setLayoutType(LayoutType.grid),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text("List"),
                  selected: provider.layoutType == LayoutType.list,
                  onSelected: (_) => provider.setLayoutType(LayoutType.list),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Grid Size"),
            subtitle: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (provider.gridSize > 1) {
                      provider.setGridSize(provider.gridSize - 1);
                      _gridSizeController.text = provider.gridSize.toString();
                    }
                  },
                ),
                SizedBox(
                  width: 10,
                  child: TextField(
                    controller: _gridSizeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    provider.setGridSize(provider.gridSize + 1);
                    _gridSizeController.text = provider.gridSize.toString();
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Text Size"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: provider.textSize.toDouble(),
                  min: 10,
                  max: 40,
                  divisions: 30,
                  label: provider.textSize.toString(),
                  onChanged: (val) => provider.setTextSize(val),
                ),
                Text("Current: ${provider.textSize}", style: TextStyle(fontSize: provider.textSize.toDouble())),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Font Theme"),
            subtitle: DropdownButton<String>(
              value: "Merriweather",
              onChanged: (String? newFont) {
                if (newFont != null) {
                  provider.setTextStyle(_getFontStyle(newFont));
                }
              },
              items: const [
                DropdownMenuItem(value: "Merriweather", child: Text("Merriweather")),
                DropdownMenuItem(value: "Roboto", child: Text("Roboto")),
                DropdownMenuItem(value: "Lobster", child: Text("Lobster")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getFontStyle(String fontName) {
    switch (fontName) {
      case "Roboto":
        return GoogleFonts.roboto();
      case "Lobster":
        return GoogleFonts.lobster();
      default:
        return GoogleFonts.merriweather();
    }
  }
}

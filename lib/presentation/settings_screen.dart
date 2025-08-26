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
  void dispose() {
    _gridSizeController.dispose();
    super.dispose();
  }

  void _updateGridSizeFromTextField(LayoutUtilitiesProvider provider) {
    final input = _gridSizeController.text;
    final parsed = int.tryParse(input);
    if (parsed != null && parsed > 0) {
      provider.setGridSize(parsed);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Grid size updated to $parsed')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid positive number')),
      );
    }
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
          /// Layout Type
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

          /// Grid Size Controls
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
                  width: 60,
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
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _updateGridSizeFromTextField(provider),
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
          const Divider(),

          /// Text Size Slider
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
                  onChanged: (val) => provider.setTextSize(val.toInt()),
                ),
                Text("Current: ${provider.textSize}", style: TextStyle(fontSize: provider.textSize.toDouble())),
              ],
            ),
          ),
          const Divider(),

          /// Font Theme Dropdown
          ListTile(
            title: const Text("Font Theme"),
            subtitle: DropdownButton<String>(
              value: _getCurrentFont(provider),
              onChanged: (String? newFont) {
                if (newFont != null) {
                  provider.setTextTheme(_getFontTheme(newFont));
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

  String _getCurrentFont(LayoutUtilitiesProvider provider) {
    final currentFont = provider.textTheme.bodyMedium?.fontFamily?.toLowerCase() ?? "";
    if (currentFont.contains("roboto")) return "Roboto";
    if (currentFont.contains("lobster")) return "Lobster";
    return "Merriweather"; // default
  }

  TextTheme _getFontTheme(String fontName) {
    switch (fontName) {
      case "Roboto":
        return GoogleFonts.robotoTextTheme();
      case "Lobster":
        return GoogleFonts.lobsterTextTheme();
      default:
        return GoogleFonts.merriweatherTextTheme();
    }
  }
}

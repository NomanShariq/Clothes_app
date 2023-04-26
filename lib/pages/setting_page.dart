import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Section 1'),
            tiles: [
              SettingsTile(
                title: const Text('Tile 1'),
                description: const Text('Subtitle 1'),
                leading: const Icon(Icons.access_alarm),
                // onTap: () {
                //   print('Tile 1 tapped');
                // },
              ),
              SettingsTile(
                title: const Text('Tile 2'),
                description: const Text('Subtitle 2'),
                leading: const Icon(Icons.accessibility),
                // onPressed: ,
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Section 2'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Switch Tile'),
                leading: const Icon(Icons.switch_left),
                onToggle: (bool value) {
                  print('Switch Tile toggled: $value');
                }, initialValue: null,
              ),
              SettingsTile(
                title: const Text('Tile 3'),
                description: const Text('Subtitle 3'),
                leading: const Icon(Icons.account_balance_wallet),
                // onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

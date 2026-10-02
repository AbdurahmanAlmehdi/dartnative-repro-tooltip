import 'package:dartnative/dartnative.dart';

import 'dartnative_plugin_registrant.dart';

void main() {
  DartNativePluginRegistrant.registerAll();
  runApp(const TooltipRepro());
}

class TooltipRepro extends StatefulWidget {
  const TooltipRepro({super.key});

  @override
  State<TooltipRepro> createState() => _TooltipReproState();
}

class _TooltipReproState extends State<TooltipRepro> {
  String _last = 'none';

  static const _actions = <(IconData, String)>[
    (Icons.edit, 'Edit'),
    (Icons.ios_share, 'Export PDF'),
    (Icons.attach_file, 'Attach receipt'),
    (Icons.delete, 'Delete'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      brightness: Brightness.light,
      appBar: AppBar(title: const Text('Tooltip')),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('No Tooltip, no IconButton(tooltip:)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text(
              "Expected (Flutter): long-press an icon button and a bubble names it "
              "('Export PDF'); a mouse/trackpad hover shows it too.",
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 4),
            const Text(
              'Actual: there is no Tooltip widget and IconButton takes no tooltip, so '
              'long-pressing these buttons shows nothing. Tap still works:',
              style: TextStyle(fontSize: 13, color: Color(0xFFC62828)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final (icon, name) in _actions)
                  IconButton(
                    icon: Icon(icon),
                    onPressed: () => setState(() => _last = name),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Last tapped: $_last', style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            const Text(
              "Intended tooltips, left to right: 'Edit', 'Export PDF', 'Attach receipt', 'Delete'.",
              style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
            ),
          ],
        ),
      ),
    );
  }
}

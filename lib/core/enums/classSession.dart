
import 'package:qldtandroid/core/models/selectable_Item.dart';

class ClassSession{
  static final Map<String, String> _values = {
    '1': 'Ca 1',
    '2': 'Ca 2',
    '3': 'Ca 3',
    '4': 'Ca 4',
    '5': 'Ca 5',
  };

  static int idOf(String value) {
    return int.parse(_values.entries.firstWhere((e) => e.value == value).key);
  }

  static String valueOf(String id) {
    if (id.isEmpty || id == '0') return 'Chưa cập nhật';

    String value = _values[id]!;
    return value;
  }

  static List<SelectableItem> get selectableItemList => _values.entries
      .map(
        (e) => SelectableItem(
          id: e.key,
          name: e.value,
        ),
      )
      .toList();

  static List<String> get values =>
      _values.entries.map((e) => e.value).toList();
}

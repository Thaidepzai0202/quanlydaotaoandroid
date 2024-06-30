
import 'package:qldtandroid/core/models/selectable_Item.dart';

class Course{
  static final Map<String, String> _values = {
    '1': 'K60',
    '2': 'K61',
    '3': 'K62',
    '4': 'K63',
    '5': 'K64',
    '6': 'K65',
    '7': 'K66',
    '8': 'K67',
    '9': 'K68',
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


import 'package:qldtandroid/core/models/selectable_Item.dart';

class DayOfWeek{
  static final Map<String, String> _values = {
    '2': 'Thứ 2',
    '3': 'Thứ 3',
    '4': 'Thứ 4',
    '5': 'Thứ 5',
    '6': 'Thứ 6',
    '7': 'Thứ 7',

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

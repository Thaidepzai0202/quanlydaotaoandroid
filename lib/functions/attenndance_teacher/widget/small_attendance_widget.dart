import 'package:flutter/material.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';

class SmallAttendanceWidget extends StatefulWidget {
  final int dataAttend;
  final Function(int) onChanged;
  const SmallAttendanceWidget(
      {super.key, required this.dataAttend, required this.onChanged});

  @override
  State<SmallAttendanceWidget> createState() => _SmallAttendanceWidgetState();
}

class _SmallAttendanceWidgetState extends State<SmallAttendanceWidget> {
  int typeAttend = 0;

  @override
  void initState() {
    typeAttend = widget.dataAttend;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    typeAttend = widget.dataAttend;

    return PopupMenuButton<int>(
      surfaceTintColor: Colors.white,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            height: 32,
            value: 0,
            child: Row(
              children: [
                _icon(AppColors.red),
                Text('  Vắng 0 phép'),
              ],
            ),
          ),
          PopupMenuItem<int>(
            height: 32,
            value: 1,
            child: Row(
              children: [
                _icon(AppColors.orange),
                Text('  Vắng có phép'),
              ],
            ),
          ),
          PopupMenuItem<int>(
            height: 32,
            value: 2,
            child: Row(
              children: [
                _icon(AppColors.blue),
                Text('  Có'),
              ],
            ),
          ),
        ];
      },
      onSelected: (int value) {
        setState(() {
          typeAttend = value;
          widget.onChanged(value);
        });
      },
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: typeAttend == 0
              ? AppColors.red
              : typeAttend == 1
                  ? AppColors.orange
                  : AppColors.blue,
        ),
      ),
    );
  }

  Widget _icon(Color color){
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );
  }
}

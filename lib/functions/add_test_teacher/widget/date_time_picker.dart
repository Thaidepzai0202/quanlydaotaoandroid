import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';

class CupertinoDateTimePickerDemo extends StatefulWidget {
  final String title;
  final Function(DateTime) onUpdate;
  final DateTime selectedDateTime;
  const CupertinoDateTimePickerDemo(
      {super.key,
      required this.title,
      required this.onUpdate,
      required this.selectedDateTime});
  @override
  _CupertinoDateTimePickerDemoState createState() =>
      _CupertinoDateTimePickerDemoState();
}

class _CupertinoDateTimePickerDemoState
    extends State<CupertinoDateTimePickerDemo> {
  // DateTime _selectedDateTime = DateTime.now();

  void _showDateTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      useRootNavigator: false,
      context: context,
      builder: (_) => Container(
        height: 315,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Container(
              height: 250,
              child: CupertinoDatePicker(
                initialDateTime: widget.selectedDateTime,
                mode: CupertinoDatePickerMode.dateAndTime,
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    widget.onUpdate(newDateTime);
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  String getFormattedDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}" +
        "\n" +
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => _showDateTimePicker(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.pink05,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(3, 3), // changes position of shadow
                    ),
                    BoxShadow(
                      color: AppColors.gray.withOpacity(0.1),
                      spreadRadius: 0.2,
                      blurRadius: 2,
                      offset: Offset(-1, -1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                '${widget.title}: ${getFormattedDateTime(widget.selectedDateTime)}',
                style: AppTextStyles.text16NormalGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qldtandroid/core/models/selectable_Item.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';

class AppDialogs {
  static Future<dynamic> showListDialog({
    required BuildContext context,
    required List<SelectableItem> list,
    required SelectableItem? value,
  }) async {
    FocusScope.of(context).unfocus();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap out side
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0,
          backgroundColor: AppColors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),

          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2.8,
            ),
            child: SingleChildScrollView(
              child: RawScrollbar(
                // thumbVisibility: true,
                child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: <Widget>[
                    if (list.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: const SizedBox(
                          height: 14,
                        ),
                      ),
                    for (SelectableItem item in list)
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(item);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: value != null
                              ? value.id == item.id
                                  ? AppColors.primaryHust.withOpacity(1)
                                  : AppColors.white
                              : AppColors.white,
                          child: Text(
                            item.name,
                            style: value != null
                                ? value.id == item.id
                                    ? const TextStyle(
                                        color: AppColors.white)
                                    : const TextStyle()
                                : const TextStyle(),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}
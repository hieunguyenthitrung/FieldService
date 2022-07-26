import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/utils/date_format_util.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Function()? onPressed;
  const TaskItem({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormatUtil.eeeeddMMyyyyFormat(),
          style: AppTheme.bodyTextStyle.copyWith(fontSize: 13),
        ),
        const SizedBox(
          height: AppConstants.defaultPadding / 2,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '04:03 PM',
                    style: AppTheme.bodyTextStyle.copyWith(fontSize: 13),
                  ),
                  const SizedBox(
                    height: AppConstants.defaultPadding / 4,
                  ),
                  Text(
                    '1h:27m',
                    style: AppTheme.bodyTextStyle.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AL Releclound',
                    style: AppTheme.bodyTextStyle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: AppConstants.defaultPadding / 4,
                  ),
                  Text(
                    'AL Service Printer',
                    style: AppTheme.bodyTextStyle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: AppConstants.defaultPadding / 1.5,
                    height: AppConstants.defaultPadding / 1.5,
                    decoration: BoxDecoration(
                      color: AppColors.robinEggBlue,
                      borderRadius: BorderRadius.circular(
                        AppConstants.defaultPadding / 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppConstants.defaultPadding / 4,
                  ),
                  Text(
                    'On Break',
                    style: AppTheme.bodyTextStyle.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

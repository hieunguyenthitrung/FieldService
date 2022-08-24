import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/utils/date_format_util.dart';
import 'package:field_services/widgets/di_card.dart';
import 'package:flutter/material.dart';
import 'package:field_services/data/models/notification.dart' as noti;

class NotificationItem extends StatelessWidget {
  final int index;
  final noti.Notification notification;
  final Function(int index)? onPressed;
  const NotificationItem({
    Key? key,
    required this.index,
    required this.notification,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DiCard(
      onPressed: onPressed != null ? () => onPressed!(index) : null,
      padding: const EdgeInsets.all(AppConstants.defaultPadding / 2)
          .copyWith(left: AppConstants.defaultPadding / 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(
                  AppConstants.defaultPadding / 2.5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.silver,
                      blurRadius: 4,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.email,
                  color: AppColors.primaryColor,
                ),
              ),
              if (!notification.isRead) ...[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: AppConstants.defaultPadding / 2.5,
                      height: AppConstants.defaultPadding / 2.5,
                      decoration: BoxDecoration(
                        color: AppColors.neonRed,
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultPadding,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.silver,
                            blurRadius: 2,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(
            width: AppConstants.defaultPadding / 2,
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: AppTheme.bodyTextStyle.copyWith(
                    fontWeight: notification.isRead ? null : FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: AppConstants.defaultPadding / 4,
                ),
                Text(notification.description),
                const SizedBox(
                  height: AppConstants.defaultPadding / 2,
                ),
                Text(
                  DateFormatUtil.timeDateFormat(notification.createOn),
                  style: AppTheme.bodyTextStyle.copyWith(
                    fontWeight: notification.isRead ? null : FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

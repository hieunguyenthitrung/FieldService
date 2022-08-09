import 'package:field_services/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DiCard extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? suffix;
  final Function()? onPressed;
  const DiCard({
    Key? key,
    required this.child,
    this.title = '',
    this.suffix,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        AppConstants.defaultPadding / 4,
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.defaultPadding / 4,
          ),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(
              AppConstants.defaultPadding / 2,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty || suffix != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                        ),
                      ),
                      if (suffix != null) suffix!,
                    ],
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(
                    AppConstants.defaultPadding / 2,
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

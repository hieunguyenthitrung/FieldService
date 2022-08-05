import 'package:field_services/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DiCard extends StatelessWidget {
  final Widget child;
  final String title;
  const DiCard({
    Key? key,
    required this.child,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(
          AppConstants.defaultPadding / 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty) ...[
              Text(title.toUpperCase()),
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
    );
  }
}

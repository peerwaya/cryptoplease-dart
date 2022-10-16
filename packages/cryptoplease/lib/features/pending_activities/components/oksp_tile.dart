import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/pending_activities/components/styles.dart';
import 'package:cryptoplease/features/pending_activities/pending_activity.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:flutter/material.dart';

class OSKPTile extends StatelessWidget {
  const OSKPTile({super.key, required this.activity});

  final OSKPPendingActivity activity;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Sent via link',
                style: titleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
              style: titleStyle,
            )
          ],
        ),
        subtitle: Text(activity.created.toString(), style: subtitleStyle),
        leading: Assets.icons.oskpActivitySent.svg(),
        onTap: () => context.router.navigate(OSKPRoute(id: activity.id)),
      );
}
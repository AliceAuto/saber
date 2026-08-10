import 'package:saber/components/settings/nextcloud_profile.dart';
import 'package:saber/data/nextcloud/readable_bytes.dart';

/// The value Nextcloud uses for "unlimited" quota (-3).
const unlimitedQuota = -3;

extension QuotaExtension on Quota {
  double get progressIndicatorValue {
    if (total == unlimitedQuota) {
      // Unlimited quota: don't show a meaningful progress bar
      return 0;
    }
    // At least 4% so the rounded corners render properly
    return relative.clamp(4, 100) / 100;
  }

  double get percentRounded {
    if (total == unlimitedQuota) return 0;
    return (relative * 10).round() / 10;
  }
}

extension MaybeQuotaExtension on Quota? {
  String get summary {
    final quota = this;
    if (quota == null) return '...';
    if (quota.total == unlimitedQuota) {
      return '${readableBytes(quota.used)} / ∞';
    }
    final used = readableBytes(quota.used);
    final total = readableBytes(quota.total);
    return '$used / $total';
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:saber/components/settings/nextcloud_profile.dart';
import 'package:saber/data/extensions/quota_extension.dart';

void main() {
  group('Unlimited quota (-3)', () {
    // Nextcloud reports unlimited quota as total = -3
    final unlimited = Quota.fromJson({
      'free': 0,
      'used': 68000000, // 68 MB
      'total': -3,
      'relative': 100 * 68000000 / -3,
    });

    test('summary shows used space with infinity symbol', () {
      final summary = unlimited.summary;
      expect(summary, contains('∞'));
      expect(summary, isNot(contains('-3 B')));
    });

    test('progress indicator is 0 for unlimited quota', () {
      expect(unlimited.progressIndicatorValue, 0);
    });

    test('percent rounded is 0 for unlimited quota', () {
      expect(unlimited.percentRounded, 0);
    });

    test('null quota summary shows placeholder', () {
      const Quota? nullQuota = null;
      expect(nullQuota.summary, '...');
    });
  });
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_button.dart';

class UpgradeScreen extends StatefulWidget {
  final Function(bool) onUpgradeChanged;
  final bool isPro;

  const UpgradeScreen({
    super.key,
    required this.onUpgradeChanged,
    required this.isPro,
  });

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  int _selectedPlan = 1; // 0=monthly, 1=yearly
  bool _loading = false;

  final _plans = [
    {'label': 'Monthly', 'price': '\$9.99', 'period': '/month', 'save': ''},
    {
      'label': 'Yearly',
      'price': '\$59.99',
      'period': '/year',
      'save': 'Save 50%'
    },
  ];

  final _features = [
    (Icons.block, 'No ads — ever'),
    (Icons.all_inclusive, 'Unlimited access to all features'),
    (Icons.cloud_sync, 'Cloud sync across all devices'),
    (Icons.support_agent, 'Priority customer support'),
    (Icons.download, 'Offline mode'),
    (Icons.analytics, 'Advanced analytics & reports'),
    (Icons.palette, 'Exclusive themes & customisation'),
    (Icons.star, 'Early access to new features'),
  ];

  void _subscribe() async {
    setState(() => _loading = true);
    // TODO: integrate in_app_purchase or revenue_cat
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _loading = false);
    widget.onUpgradeChanged(true);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Welcome to Pro! Enjoy your upgrade.'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Hero banner ────────────────────────────────────────────
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star_rounded,
                          color: AppTheme.gold, size: 36),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Upgrade to Pro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Unlock everything — no limits, no ads.',
                      style:
                          TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    if (widget.isPro) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.success),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle,
                                color: AppTheme.success, size: 16),
                            SizedBox(width: 6),
                            Text('You\'re already on Pro!',
                                style: TextStyle(
                                    color: AppTheme.success,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Plan selector ──────────────────────────────────
                    if (!widget.isPro) ...[
                      const Text(
                        'Choose your plan',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(_plans.length, (i) {
                          final plan = _plans[i];
                          final selected = _selectedPlan == i;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedPlan = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: EdgeInsets.only(
                                    right: i == 0 ? 8 : 0),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: selected
                                      ? AppTheme.primaryGradient
                                      : null,
                                  color: selected ? null : AppTheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: selected
                                      ? null
                                      : Border.all(
                                          color:
                                              const Color(0xFFE5E7EB)),
                                ),
                                child: Column(
                                  children: [
                                    if (plan['save']!.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: selected
                                              ? Colors.white.withOpacity(0.3)
                                              : AppTheme.primary
                                                  .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          plan['save']!,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: selected
                                                ? Colors.white
                                                : AppTheme.primary,
                                          ),
                                        ),
                                      ),
                                    if (plan['save']!.isNotEmpty)
                                      const SizedBox(height: 4),
                                    Text(
                                      plan['price']!,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: selected
                                            ? Colors.white
                                            : AppTheme.textDark,
                                      ),
                                    ),
                                    Text(
                                      plan['period']!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: selected
                                              ? Colors.white70
                                              : AppTheme.textMuted),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      plan['label']!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: selected
                                            ? Colors.white
                                            : AppTheme.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // ── Features list ──────────────────────────────────
                    const Text(
                      "Everything in Pro",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...(_features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: AppTheme.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(f.$1,
                                  color: AppTheme.primary, size: 18),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              f.$2,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textDark,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    )),
                    const SizedBox(height: 24),

                    if (!widget.isPro) ...[
                      GradientButton(
                        label: _selectedPlan == 0
                            ? 'Subscribe for \$9.99/mo'
                            : 'Subscribe for \$59.99/yr',
                        onPressed: _subscribe,
                        loading: _loading,
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Cancel anytime · Secure payment',
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.textMuted),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/providers/auth_state_provider.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/utils/auth_gate.dart';
import 'package:season_app/features/reminders/data/models/reminder_model.dart';
import 'package:season_app/features/reminders/presentation/widgets/add_reminder_modal.dart';
import 'package:season_app/features/reminders/providers.dart';
import 'package:season_app/features/home/presentation/widgets/bag/bag_reminders_section_widget.dart';

class CardPage extends ConsumerStatefulWidget {
  const CardPage({super.key});

  @override
  ConsumerState<CardPage> createState() => _CardPageState();
}

class _CardPageState extends ConsumerState<CardPage> {
  @override
  void initState() {
    super.initState();
    // Load reminders when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!AuthService.isLoggedIn()) return;
      ref.read(remindersProvider.notifier).loadReminders();
    });
  }

  void _showAddReminderModal({ReminderModel? reminder}) async {
    if (!await AuthGate.requireLogin(context)) return;
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => AddReminderModal(reminder: reminder),
      ),
    );
  }

  Future<void> _deleteReminder(int reminderId) async {
    final loc = AppLocalizations.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.bagDeleteReminderTitle),
        content: Text(loc.bagDeleteReminderMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(loc.bagDeleteCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(loc.bagDeleteConfirm),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirmed == true) {
      final success =
          await ref.read(remindersProvider.notifier).deleteReminder(reminderId);
      if (!mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.bagDeleteSuccess),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  Future<void> _refreshAll() async {
    await ref.read(remindersProvider.notifier).loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Reload reminders as soon as the user transitions from guest to logged in.
    ref.listen(authStateProvider, (previous, next) {
      if (next == true && previous != true) {
        ref.read(remindersProvider.notifier).loadReminders();
      }
    });

    final isLoggedIn = ref.watch(authStateProvider);
    if (!isLoggedIn) {
      return GuestLoginPrompt(message: l10n.cardPageContent);
    }

    final remindersState = ref.watch(remindersProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: RefreshIndicator(
          onRefresh: _refreshAll,
          child: CustomScrollView(
            slivers: [
              // Header Section
              SliverAppBar(
                expandedHeight: 180,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Title and subtitle
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.bagRemindersTitle,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      Text(
                                        l10n.reminderSubtitle,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.92),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Active reminders count badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.bagRemindersActiveCount(remindersState.activeCount),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Content Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BagRemindersSectionWidget(
                    onAddReminder: () => _showAddReminderModal(),
                    onEditReminder: (reminder) => _showAddReminderModal(reminder: reminder),
                    onDeleteReminder: _deleteReminder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


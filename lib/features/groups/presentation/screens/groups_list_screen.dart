import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/providers/auth_state_provider.dart';
import 'package:season_app/core/utils/auth_gate.dart';
import 'package:season_app/features/groups/providers.dart';
import 'package:season_app/features/groups/presentation/widgets/group_card.dart';
import 'package:season_app/shared/helpers/snackbar_helper.dart';

class GroupsListScreen extends ConsumerStatefulWidget {
  const GroupsListScreen({super.key});

  @override
  ConsumerState<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends ConsumerState<GroupsListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(groupsControllerProvider.notifier).loadGroups());
  }

  Future<void> _refreshGroups() async {
    await ref.read(groupsControllerProvider.notifier).loadGroups();
  }

  Future<void> _openCreateGroup() async {
    if (!await AuthGate.requireLogin(context)) return;
    if (!mounted) return;
    context.push('/groups/create');
  }

  Future<void> _openJoinGroup() async {
    if (!await AuthGate.requireLogin(context)) return;
    if (!mounted) return;
    context.push('/groups/join');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    // Reload groups as soon as the user transitions from guest to logged in.
    ref.listen(authStateProvider, (previous, next) {
      if (next == true && previous != true) {
        ref.read(groupsControllerProvider.notifier).loadGroups();
      }
    });

    final isLoggedIn = ref.watch(authStateProvider);
    if (!isLoggedIn) {
      return GuestLoginPrompt(message: loc.groupPageContent);
    }

    final groupsState = ref.watch(groupsControllerProvider);

    // Listen to state changes for messages/errors
    ref.listen(groupsControllerProvider, (previous, next) {
      if (next.error != null) {
        SnackbarHelper.error(context, next.error!);
        ref.read(groupsControllerProvider.notifier).clearError();
      }
      if (next.message != null) {
        SnackbarHelper.success(context, next.message!);
        ref.read(groupsControllerProvider.notifier).clearMessage();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: _refreshGroups,
        child: CustomScrollView(
          slivers: [
          // Custom App Bar - Redesigned
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
                                Icons.explore_rounded,
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
                                    loc.dontGetLost,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  Text(
                                    loc.trackYourGroup,
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
                        // Action buttons row
                        Row(
                          children: [
                            Expanded(
                              child: _buildHeaderActionButton(
                                icon: Icons.add_circle_rounded,
                                label: loc.createGroup,
                                color: Colors.white,
                                textColor: AppColors.primary,
                                onTap: _openCreateGroup,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildHeaderActionButton(
                                icon: Icons.login_rounded,
                                label: loc.joinGroup,
                                color: AppColors.secondary,
                                textColor: Colors.white,
                                onTap: _openJoinGroup,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          if (groupsState.isLoading && groupsState.groups.isEmpty)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (groupsState.groups.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32,top: 0,left: 32,right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.groups_rounded,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text(
                        loc.noGroupsYet,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        loc.createNewGroup,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontFamily: 'Cairo',
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Quick action buttons - match header style
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _openCreateGroup,
                                icon: const Icon(Icons.add_circle_rounded, size: 22),
                                label: Text(
                                  loc.createGroup,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: _openJoinGroup,
                                icon: const Icon(Icons.login_rounded, size: 22),
                                label: Text(
                                  loc.joinGroup,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: BorderSide(color: AppColors.primary, width: 2),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final group = groupsState.groups[index];
                    return GroupCard(
                      group: group,
                      onTap: () {
                        context.push('/groups/${group.id}');
                      },
                    );
                  },
                  childCount: groupsState.groups.length,
                ),
              ),
            ),
        ],
        ),
      ),
    );
  }

  Widget _buildHeaderActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: textColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


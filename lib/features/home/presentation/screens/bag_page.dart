import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/providers/auth_state_provider.dart';
import 'package:season_app/core/services/dio_client.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/utils/auth_gate.dart';
import 'package:season_app/features/home/presentation/screens/bag_detail_screen.dart';
import 'package:season_app/features/home/providers/bag_providers.dart';
import 'package:season_app/shared/widgets/custom_toast.dart';
import 'package:season_app/features/home/data/models/bag_detail_model.dart';
import 'package:season_app/features/home/data/models/bag_type_model.dart';
import 'package:season_app/features/home/presentation/widgets/bag/bag_delete_dialog.dart';

class BagPage extends ConsumerStatefulWidget {
  const BagPage({super.key});

  @override
  ConsumerState<BagPage> createState() => _BagPageState();
}

class _BagPageState extends ConsumerState<BagPage> {
  @override
  void initState() {
    super.initState();
    // Load bags when screen opens - only call bags API
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!AuthService.isLoggedIn()) return;
      // Only load bags, not bag details
      // Add a small delay to ensure provider is fully initialized
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        ref.read(bagControllerProvider.notifier).loadBagDetails();
      }
    });
  }

  Future<void> _refreshAll() async {
    await ref.read(bagControllerProvider.notifier).loadBagDetails();
  }

  void _navigateToBagDetail(BagDetailModel bag) {
    // Navigate to bag detail screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => BagDetailScreen(bagId: bag.bagId)));
  }

  Future<void> _createBag() async {
    if (!await AuthGate.requireLogin(context)) return;
    if (!mounted) return;
    context.push(Routes.createBag);
  }

  Future<void> _deleteBag(BagDetailModel bag) async {
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';
    final loc = AppLocalizations.of(context);

    final confirmed = await BagDeleteDialog.show(
      context,
      title: isRtl ? 'حذف الحقيبة' : 'Delete Bag',
      message: isRtl
          ? 'هل أنت متأكد من حذف هذه الحقيبة؟ سيتم حذف جميع الأغراض الموجودة فيها.'
          : 'Are you sure you want to delete this bag? All items will be removed.',
      confirmText: loc.bagDeleteConfirm,
      cancelText: loc.bagDeleteCancel,
    );

    if (!mounted || confirmed != true) return;

    try {
      // Use Smart Bags API delete if bag has trip info (Smart Bag), otherwise delete items
      if (bag.tripType != null) {
        // Smart Bag - use delete endpoint
        final success = await ref.read(bagControllerProvider.notifier).deleteBag(bag.bagId);
        if (!mounted) return;
        
        if (success) {
          CustomToast.success(
            context,
            isRtl ? 'تم حذف الحقيبة بنجاح' : 'Bag deleted successfully',
          );
        } else {
          CustomToast.error(
            context,
            isRtl ? 'فشل حذف الحقيبة' : 'Failed to delete bag',
          );
        }
      } else {
        // Legacy bag - delete all items
        for (final item in bag.items) {
          if (item.itemId != null) {
            await ref.read(bagControllerProvider.notifier).deleteItemFromBag(
                  itemId: item.itemId!,
                  bagTypeId: bag.bagTypeId,
                );
          }
        }
        CustomToast.success(
          context,
          isRtl ? 'تم حذف الحقيبة بنجاح' : 'Bag deleted successfully',
        );
      }
      
      await _refreshAll();
    } on ApiException catch (e) {
      if (!mounted) return;
      CustomToast.error(context, e.message);
    } catch (e) {
      if (!mounted) return;
      CustomToast.error(
        context,
        isRtl ? 'فشل حذف الحقيبة' : 'Failed to delete bag',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    // Reload bags as soon as the user transitions from guest to logged in.
    ref.listen(authStateProvider, (previous, next) {
      if (next == true && previous != true) {
        ref.read(bagControllerProvider.notifier).loadBagDetails();
      }
    });

    final isLoggedIn = ref.watch(authStateProvider);
    if (!isLoggedIn) {
      return GuestLoginPrompt(message: loc.bagPageContent);
    }

    final bagState = ref.watch(bagControllerProvider);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Debug: Print state info
    debugPrint('🔍 BagPage build - bagDetails count: ${bagState.bagDetails.length}, isLoadingBagDetails: ${bagState.isLoadingBagDetails}');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: (bagState.isLoadingBagDetails)
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: _refreshAll,
                  color: AppColors.primary,
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                          // Header Section
                          SliverAppBar(
                            expandedHeight: 180,
                            floating: false,
                            pinned: true,
                            snap: false,
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
                                        // Title and subtitle row
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
                                                Icons.luggage_outlined,
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
                                                    isRtl ? 'حقائب السفر' : 'Travel Bags',
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontFamily: 'Cairo',
                                                      letterSpacing: 0.3,
                                                    ),
                                                  ),
                                                  Text(
                                                    isRtl ? 'إدارة جميع حقائبك في مكان واحد' : 'Manage all your bags in one place',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white.withOpacity(0.92),
                                                      fontFamily: 'Cairo',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Create Bag Button
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.25),
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.1),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () => _createBag(),
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        // Bags count badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.25),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.inventory_2_outlined,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${bagState.bagDetails.length} ${isRtl ? "حقيبة" : bagState.bagDetails.length == 1 ? "bag" : "bags"}',
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
                            child: _buildBagList(bagState, isRtl),
                          ),
                        ],
                      ),
                ),
        ),
      ),
    );
  }

  Widget _buildBagList(BagState bagState, bool isRtl) {
    debugPrint('🔍 _buildBagList - bagDetails count: ${bagState.bagDetails.length}');
    
    if (bagState.bagDetails.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.luggage_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isRtl ? 'لا توجد حقائب' : 'No bags yet',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isRtl ? 'ابدأ بإنشاء حقيبة جديدة' : 'Start by creating a new bag',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _createBag(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      isRtl ? 'إنشاء حقيبة جديدة' : 'Create New Bag',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          bagState.bagDetails.length,
          (index) {
            final bag = bagState.bagDetails[index];
            final bagType = bagState.bagTypes.firstWhere(
              (type) => type.id == bag.bagTypeId,
              orElse: () => BagTypeModel(
                id: bag.bagTypeId,
                name: bag.bagName,
                defaultMaxWeight: bag.maxWeight,
                isActive: true,
              ),
            );

            return _buildModernBagCard(bag, bagType, isRtl);
          },
        ),
      ),
    );
  }

  Widget _buildModernBagCard(BagDetailModel bag, BagTypeModel bagType, bool isRtl) {
    // Get trip type color
    Color tripTypeColor = AppColors.primary;
    IconData tripTypeIcon = Icons.luggage;
    
    if (bag.tripType != null) {
      switch (bag.tripType) {
        case 'سياحة':
          tripTypeColor = const Color(0xFF6366F1);
          tripTypeIcon = Icons.flight;
          break;
        case 'عمل':
          tripTypeColor = const Color(0xFF3B82F6);
          tripTypeIcon = Icons.business;
          break;
        case 'علاج':
          tripTypeColor = const Color(0xFFEF4444);
          tripTypeIcon = Icons.medical_services;
          break;
        case 'عائلية':
          tripTypeColor = const Color(0xFFEC4899);
          tripTypeIcon = Icons.family_restroom;
          break;
        case 'الجيم':
          tripTypeColor = const Color(0xFF10B981);
          tripTypeIcon = Icons.fitness_center;
          break;
        case 'أخرى':
          tripTypeColor = const Color(0xFF6B7280);
          tripTypeIcon = Icons.more_horiz;
          break;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => _navigateToBagDetail(bag),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Bag Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tripTypeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: tripTypeColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      tripTypeIcon,
                      color: tripTypeColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Bag Name & Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bag.bagName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        if (bag.destination != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                bag.destination!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              if (bag.tripType != null) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: tripTypeColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    bag.tripType!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: tripTypeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ] else ...[
                          Text(
                            bagType.name,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Menu Button
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: AppColors.textSecondary, size: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              isRtl ? 'حذف' : 'Delete',
                              style: const TextStyle(color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                        onTap: () => Future.delayed(
                          const Duration(milliseconds: 100),
                          () => _deleteBag(bag),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Weight Progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isRtl ? 'الوزن' : 'Weight',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${bag.currentWeight.toStringAsFixed(1)} / ${bag.maxWeight.toStringAsFixed(1)} kg',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: bag.weightPercentage > 100
                              ? AppColors.error
                              : bag.weightPercentage > 80
                                  ? AppColors.warning
                                  : AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (bag.weightPercentage / 100).clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        bag.weightPercentage > 100
                            ? AppColors.error
                            : bag.weightPercentage > 80
                                ? AppColors.warning
                                : AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Footer Info
              Row(
                children: [
                  // Items Count
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${bag.items.length} ${isRtl ? "أغراض" : "items"}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Days Until Departure
                  if (bag.daysUntilDeparture != null && bag.daysUntilDeparture! >= 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: bag.daysUntilDeparture! <= 3
                            ? AppColors.error.withOpacity(0.1)
                            : AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: bag.daysUntilDeparture! <= 3
                              ? AppColors.error.withOpacity(0.2)
                              : AppColors.info.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: bag.daysUntilDeparture! <= 3
                                ? AppColors.error
                                : AppColors.info,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isRtl
                                ? '${bag.daysUntilDeparture} يوم'
                                : '${bag.daysUntilDeparture} days',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: bag.daysUntilDeparture! <= 3
                                  ? AppColors.error
                                  : AppColors.info,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

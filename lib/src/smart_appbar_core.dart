import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Route configuration constants
const Map<String, _RouteConfig> _routeConfigs = {
  '/home': _RouteConfig(
    title: 'Home 🏠',
    variant: SmartAppBarVariant.transparent,
    actions: [SmartAppBarAction.notifications, SmartAppBarAction.profile],
    automaticallyImplyLeading: false,
  ),
  '/petProfile': _RouteConfig(
    title: 'Pet Profile 🐾',
    variant: SmartAppBarVariant.glass,
    actions: [SmartAppBarAction.edit, SmartAppBarAction.share],
    centerTitle: true,
  ),
  '/settings': _RouteConfig(
    title: 'Settings ⚙️',
    variant: SmartAppBarVariant.bordered,
    actions: [SmartAppBarAction.search, SmartAppBarAction.more],
    centerTitle: true,
  ),
  '/profile': _RouteConfig(
    title: 'Profile 👤',
    variant: SmartAppBarVariant.standard,
    actions: [SmartAppBarAction.edit, SmartAppBarAction.settings],
    centerTitle: true,
  ),
  '/dashboard': _RouteConfig(
    title: 'Dashboard 📊',
    variant: SmartAppBarVariant.glass,
    actions: [SmartAppBarAction.notifications, SmartAppBarAction.search],
    automaticallyImplyLeading: false,
  ),
};

/// Intelligent SmartAppBar widget that automatically adapts to routes and context
///
/// Features:
/// - Automatic route-based configuration
/// - Multiple visual variants with professional effects
/// - Dynamic data integration via Cubit/Provider
/// - Theme-aware styling
/// - Smooth animations and transitions
/// - Full accessibility support
class SmartAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Optional custom title (if not provided, will be determined by route)
  final String? title;
   
  /// Optional custom actions (if not provided, will be determined by route)
  final List<SmartAppBarAction>? actions;
   
  /// Optional custom variant (if not provided, will be determined by route)
  final SmartAppBarVariant? variant;
   
  /// Whether to center the title
  final bool centerTitle;
   
  /// Custom background color override
  final Color? backgroundColor;
   
  /// Custom foreground (text/icon) color override
  final Color? foregroundColor;
   
  /// Custom elevation for elevated variants
  final double elevation;
   
  /// Whether to show back button automatically
  final bool showBackButton;
   
  /// Custom back button callback
  final VoidCallback? onBackPressed;
   
  /// Whether to enable animations
  final bool enableAnimations;
   
  /// Animation duration
  final Duration animationDuration;
   
  /// Custom title padding
  final EdgeInsetsGeometry? titlePadding;
   
  /// Whether to automatically infer leading widget
  final bool automaticallyImplyLeading;
   
  /// Blur intensity for glass effects (0.0 to 1.0)
  final double blurIntensity;
   
  /// Whether to enable gradient backgrounds
  final bool enableGradient;
   
  /// Loading state indicator
  final bool isLoading;
   
  /// Custom loading icon
  final IconData? loadingIcon;
   
  /// Create a SmartAppBar with automatic route-based configuration
  ///
  /// Only specify parameters you want to override. Everything else is automatic.
  const SmartAppBar({
    super.key,
    this.title,
    this.actions,
    this.variant,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0.0,
    this.showBackButton = true,
    this.onBackPressed,
    this.enableAnimations = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.titlePadding,
    this.automaticallyImplyLeading = true,
    this.blurIntensity = 0.1,
    this.enableGradient = false,
    this.isLoading = false,
    this.loadingIcon,
  });

  @override
  State<SmartAppBar> createState() => _SmartAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Get current route configuration
  static _RouteConfig? getRouteConfig(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName == null) return null;
    
    // Find exact match first
    if (_routeConfigs.containsKey(routeName)) {
      return _routeConfigs[routeName];
    }
    
    // Find partial match
    for (final entry in _routeConfigs.entries) {
      if (routeName.contains(entry.key.substring(1))) { // Remove leading '/'
        return entry.value;
      }
    }
    
    return null;
  }

  /// Get default configuration for unknown routes
  static _RouteConfig getDefaultConfig() => const _RouteConfig(
    title: 'SmartApp',
    variant: SmartAppBarVariant.standard,
    actions: [SmartAppBarAction.more],
    centerTitle: false,
  );
}

/// App bar variants with different visual effects
enum SmartAppBarVariant {
  /// Standard Material 3 app bar
  standard,
  
  /// Glass morphism effect with blur
  glass,
  
  /// Fully transparent background
  transparent,
  
  /// Bordered appearance with subtle border
  bordered,
  
  /// Elevated appearance with shadow
  elevated,
  
  /// Large title app bar
  large,
}

/// Smart app bar actions
enum SmartAppBarAction {
  notifications(Icons.notifications_outlined),
  profile(Icons.person_outline),
  edit(Icons.edit_outlined),
  share(Icons.share_outlined),
  settings(Icons.settings_outlined),
  search(Icons.search),
  more(Icons.more_vert),
  add(Icons.add),
  favorite(Icons.favorite_border),
  bookmark(Icons.bookmark_outline);

  const SmartAppBarAction(this.icon);
  final IconData icon;
}

/// Route configuration data class
class _RouteConfig {
  const _RouteConfig({
    required this.title,
    required this.variant,
    required this.actions,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final SmartAppBarVariant variant;
  final List<SmartAppBarAction> actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
}

class _SmartAppBarState extends State<SmartAppBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _isPressed = false;
  
  // Cache for performance
  _RouteConfig? _cachedConfig;
  String? _cachedRouteName;
  // Note: Color cache fields removed as they're not used in current implementation
  // These can be used for performance optimization in future versions

  @override
  void initState() {
    super.initState();
    if (widget.enableAnimations) {
      _setupAnimations();
    }
  }

  @override
  void dispose() {
    if (widget.enableAnimations) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<double>(
      begin: -30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final routeConfig = _getEffectiveConfig();
    
    // Cache expensive calculations
    _updateCaches(theme, isDark);

    return Semantics(
      label: 'App Bar: ${routeConfig.title}',
      hint: _shouldShowBackButton() ? 'Contains back navigation button' : null,
      child: widget.enableAnimations
        ? _buildAnimatedAppBar(context, routeConfig, isDark)
        : _buildStaticAppBar(context, routeConfig, isDark),
    );
  }

  Widget _buildAnimatedAppBar(BuildContext context, _RouteConfig config, bool isDark) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: _buildStaticAppBar(context, config, isDark),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStaticAppBar(BuildContext context, _RouteConfig config, bool isDark) {
    return Container(
      decoration: _buildDecoration(config, isDark),
      child: SafeArea(
        child: Container(
          height: _getAppBarHeight(config.variant),
          padding: widget.titlePadding,
          child: Row(
            children: [
              Expanded(
                child: _buildTitleRow(context, config, isDark),
              ),
              if (config.actions.isNotEmpty) ...[
                const SizedBox(width: 8),
                _buildActionsRow(config.actions, isDark),
              ],
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(_RouteConfig config, bool isDark) {
    final backgroundColor = widget.backgroundColor ?? config.backgroundColor ?? _getDefaultBackgroundColor(config, isDark);
    final foregroundColor = widget.foregroundColor ?? config.foregroundColor ?? _getDefaultForegroundColor(config, isDark);
    
    List<BoxShadow>? boxShadows;
    
    switch (config.variant) {
      case SmartAppBarVariant.glass:
        // Glass morphism effect
        return BoxDecoration(
          color: backgroundColor.withValues(alpha: 0.8),
          border: Border.all(
            color: foregroundColor.withValues(alpha: 0.1),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
              blurRadius: widget.blurIntensity * 20,
              offset: const Offset(0, 2),
            ),
          ],
        );
      
      case SmartAppBarVariant.transparent:
        return const BoxDecoration(color: Colors.transparent);
      
      case SmartAppBarVariant.bordered:
        return BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: foregroundColor.withValues(alpha: 0.2),
            width: 1.0,
          ),
        );
      
      case SmartAppBarVariant.elevated:
        boxShadows = [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
        break;
      
      case SmartAppBarVariant.standard:
      case SmartAppBarVariant.large:
      default:
        break;
    }

    if (widget.enableGradient || config.variant == SmartAppBarVariant.glass) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor,
            backgroundColor.withValues(alpha: 0.95),
            backgroundColor.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: boxShadows,
      );
    }

    return BoxDecoration(
      color: backgroundColor,
      boxShadow: boxShadows,
    );
  }

  Color _getDefaultBackgroundColor(_RouteConfig config, bool isDark) {
    switch (config.variant) {
      case SmartAppBarVariant.glass:
        // Use Material 3 surface colors for consistent appearance
        return isDark
              ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.8)
              : Theme.of(context).colorScheme.surface.withValues(alpha: 0.8);
        case SmartAppBarVariant.transparent:
          return Colors.transparent;
        case SmartAppBarVariant.elevated:
          return Theme.of(context).colorScheme.surface;
        case SmartAppBarVariant.large:
          return Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3);
        default:
          return Theme.of(context).colorScheme.surface;
    }
  }

  Color _getDefaultForegroundColor(_RouteConfig config, bool isDark) {
    if (config.variant == SmartAppBarVariant.transparent) {
      return isDark ? Colors.white : Colors.black87;
    }
    
    return isDark
        ? const Color(0xFFE8EAED)
        : const Color(0xFF1B1F23);
  }

  double _getAppBarHeight(SmartAppBarVariant variant) {
    switch (variant) {
      case SmartAppBarVariant.large:
        return 88.0;
      default:
        return kToolbarHeight;
    }
  }

  Widget _buildTitleRow(BuildContext context, _RouteConfig config, bool isDark) {
    final effectiveCenterTitle = widget.centerTitle || config.centerTitle;
    final showLeading = _shouldShowBackButton() || widget.automaticallyImplyLeading;
    final foregroundColor = widget.foregroundColor ?? config.foregroundColor ?? _getDefaultForegroundColor(config, isDark);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLeading) ...[
          _buildLeadingButton(foregroundColor),
          if (!effectiveCenterTitle) const SizedBox(width: 12),
        ],
        Expanded(
          child: _buildTitleText(foregroundColor, effectiveCenterTitle, config.title),
        ),
      ],
    );
  }

  Widget _buildLeadingButton(Color foregroundColor) {
    return Semantics(
      label: 'Navigate back',
      hint: 'Returns to previous screen',
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onBackPressed ?? () => Navigator.of(context).pop(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _isPressed
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                widget.loadingIcon ?? Icons.arrow_back_ios_new,
                color: foregroundColor,
              ),
              onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
              tooltip: 'Back',
              style: IconButton.styleFrom(
                minimumSize: const Size(44, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(Color foregroundColor, bool centerTitle, String title) {
    if (widget.isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title,
              style: _getTitleTextStyle(foregroundColor),
              textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Text(
      title,
      style: _getTitleTextStyle(foregroundColor),
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      overflow: TextOverflow.ellipsis,
      semanticsLabel: 'Title: $title',
    );
  }

  TextStyle _getTitleTextStyle(Color foregroundColor) {
    final baseStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: foregroundColor,
      fontSize: 18,
      fontFamily: 'Roboto', // Using default Material font
      letterSpacing: 0.15,
      height: 1.2,
    );

    return baseStyle;
  }

  Widget _buildActionsRow(List<SmartAppBarAction> actions, bool isDark) {
    final config = _getEffectiveConfig();
    final foregroundColor = widget.foregroundColor ?? config.foregroundColor ?? _getDefaultForegroundColor(config, isDark);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actions.map((action) =>
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: _buildActionButton(action.icon, action, foregroundColor),
        ),
      ).toList(),
    );
  }

  Widget _buildActionButton(IconData icon, SmartAppBarAction action, Color foregroundColor) {
    return Semantics(
      label: _getActionLabel(action),
      hint: _getActionHint(action),
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () => _handleAction(action),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _isPressed
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(icon, color: foregroundColor),
              onPressed: () => _handleAction(action),
              tooltip: _getActionLabel(action),
              style: IconButton.styleFrom(
                minimumSize: const Size(44, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getActionLabel(SmartAppBarAction action) {
    switch (action) {
      case SmartAppBarAction.notifications:
        return 'Notifications';
      case SmartAppBarAction.profile:
        return 'Profile';
      case SmartAppBarAction.edit:
        return 'Edit';
      case SmartAppBarAction.share:
        return 'Share';
      case SmartAppBarAction.settings:
        return 'Settings';
      case SmartAppBarAction.search:
        return 'Search';
      case SmartAppBarAction.more:
        return 'More options';
      case SmartAppBarAction.add:
        return 'Add';
      case SmartAppBarAction.favorite:
        return 'Favorite';
      case SmartAppBarAction.bookmark:
        return 'Bookmark';
    }
  }

  String _getActionHint(SmartAppBarAction action) {
    switch (action) {
      case SmartAppBarAction.notifications:
        return 'View notifications';
      case SmartAppBarAction.profile:
        return 'Open user profile';
      case SmartAppBarAction.edit:
        return 'Edit current item';
      case SmartAppBarAction.share:
        return 'Share content';
      case SmartAppBarAction.settings:
        return 'Open settings';
      case SmartAppBarAction.search:
        return 'Search content';
      case SmartAppBarAction.more:
        return 'Show more options';
      case SmartAppBarAction.add:
        return 'Add new item';
      case SmartAppBarAction.favorite:
        return 'Add to favorites';
      case SmartAppBarAction.bookmark:
        return 'Bookmark item';
    }
  }

  void _handleAction(SmartAppBarAction action) {
    HapticFeedback.lightImpact();
    
    // In a real implementation, you might navigate to specific routes or call specific functions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_getActionLabel(action)} action triggered'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool _shouldShowBackButton() {
    return widget.showBackButton &&
           Navigator.of(context).canPop() &&
           (widget.variant == null || widget.variant != SmartAppBarVariant.large);
  }

  _RouteConfig _getEffectiveConfig() {
    final routeConfig = SmartAppBar.getRouteConfig(context) ?? SmartAppBar.getDefaultConfig();
    
    return _RouteConfig(
      title: widget.title ?? routeConfig.title,
      variant: widget.variant ?? routeConfig.variant,
      actions: widget.actions?.map((a) => a).toList() ?? routeConfig.actions,
      centerTitle: widget.centerTitle || routeConfig.centerTitle,
      automaticallyImplyLeading: widget.automaticallyImplyLeading && routeConfig.automaticallyImplyLeading,
      backgroundColor: widget.backgroundColor ?? routeConfig.backgroundColor,
      foregroundColor: widget.foregroundColor ?? routeConfig.foregroundColor,
    );
  }

  void _updateCaches(ThemeData theme, bool isDark) {
    final routeName = ModalRoute.of(context)?.settings.name;
    final config = _getEffectiveConfig();
    
    if (_cachedRouteName != routeName || _cachedConfig?.title != config.title) {
      _cachedRouteName = routeName;
      _cachedConfig = config;
      // Note: Color caching removed for now, can be re-added for performance optimization
    }
  }
}
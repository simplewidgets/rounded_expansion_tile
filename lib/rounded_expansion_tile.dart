import 'package:flutter/material.dart';

class RoundedExpansionTile extends StatefulWidget {
  final bool? autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool? dense;
  final bool? enabled;
  final bool? enableFeedback;
  final Color? focusColor;
  final FocusNode? focusNode;
  final double? horizontalTitleGap;
  final Color? hoverColor;
  final bool? isThreeLine;
  final Key? key;
  final Widget? leading;
  final double? minLeadingWidth;
  final double? minVerticalPadding;
  final MouseCursor? mouseCursor;
  final void Function()? onLongPress;
  final bool? selected;
  final Color? selectedTileColor;
  final ShapeBorder? shape;
  final Widget? subtitle;
  final Widget? title;
  final Color? tileColor;
  final Widget? trailing;
  final VisualDensity? visualDensity;
  final void Function()? onTap;
  final Duration? duration;
  final List<Widget>? children;
  final Curve? curve;
  final EdgeInsets? childrenPadding;
  final bool? rotateTrailing;
  final bool? noTrailing;
  final bool initiallyExpanded;

  RoundedExpansionTile(
      {this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.duration,
      this.children,
      this.autofocus,
      this.contentPadding,
      this.dense,
      this.enabled,
      this.enableFeedback,
      this.focusColor,
      this.focusNode,
      this.horizontalTitleGap,
      this.hoverColor,
      this.isThreeLine,
      this.key,
      this.minLeadingWidth,
      this.minVerticalPadding,
      this.mouseCursor,
      this.onLongPress,
      this.selected,
      this.selectedTileColor,
      this.shape,
      this.tileColor,
      this.visualDensity,
      this.onTap,
      this.curve,
      this.childrenPadding,
      this.rotateTrailing,
      this.noTrailing,
      this.initiallyExpanded = false
    });

  @override
  _RoundedExpansionTileState createState() => _RoundedExpansionTileState();
}

class _RoundedExpansionTileState extends State<RoundedExpansionTile>
    with TickerProviderStateMixin {
  late bool _expanded;
  bool? _rotateTrailing;
  bool? _noTrailing;
  late AnimationController _controller;
  late AnimationController _iconController;

  // When the duration of the ListTile animation is NOT provided. This value will be used instead.
  Duration defaultDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    // If not provided, this will be true
    _rotateTrailing =
        widget.rotateTrailing == null ? true : widget.rotateTrailing;
    // If not provided this will be false
    _noTrailing = widget.noTrailing == null ? false : widget.noTrailing;
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration == null ? defaultDuration : widget.duration);

    _iconController = AnimationController(
      duration: widget.duration == null ? defaultDuration : widget.duration,
      vsync: this,
    );

    _controller.forward();
    // _iconController.forward();
  }

  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
      _iconController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            // If bool is not provided the default will be false.
            autofocus: widget.autofocus ?? false,
            contentPadding: widget.contentPadding,
            // If bool is not provided the default will be false.
            dense: widget.dense,
            // If bool is not provided the default will be true.
            enabled: widget.enabled ?? true,
            enableFeedback:
                // If bool is not provided the default will be false.
                widget.enableFeedback ?? false,
            focusColor: widget.focusColor,
            focusNode: widget.focusNode,
            horizontalTitleGap: widget.horizontalTitleGap,
            hoverColor: widget.hoverColor,
            // If bool is not provided the default will be false.
            isThreeLine: widget.isThreeLine ?? false,
            key: widget.key,
            leading: widget.leading,
            minLeadingWidth: widget.minLeadingWidth,
            minVerticalPadding: widget.minVerticalPadding,
            mouseCursor: widget.mouseCursor,
            onLongPress: widget.onLongPress,
            // If bool is not provided the default will be false.
            selected: widget.selected ?? false,
            selectedTileColor: widget.selectedTileColor,
            shape: widget.shape,
            subtitle: widget.subtitle,
            title: widget.title,
            tileColor: widget.tileColor,
            trailing: _noTrailing! ? null : _trailingIcon(),
            visualDensity: widget.visualDensity,
            onTap: () {
              if (widget.onTap != null) {
                /// Developers who uses this package can add custom functionality when tapped.
                ///
                /// When a developer defines an extra option on tap, this will be executed. If not provided this step will be skipped.
                /// ignore: unnecessary_statements
                widget.onTap;
              }
              setState(() {
                // Checks if the ListTile is expanded and sets state accordingly.
                if (_expanded) {
                  _expanded = !_expanded;
                  _controller.forward();
                  _iconController.reverse();
                } else {
                  _expanded = !_expanded;
                  _controller.reverse();
                  _iconController.forward();
                }
              });
            },
          ),
          AnimatedCrossFade(
              firstCurve: widget.curve == null
                  ? Curves.fastLinearToSlowEaseIn
                  : widget.curve!,
              secondCurve: widget.curve == null
                  ? Curves.fastLinearToSlowEaseIn
                  : widget.curve!,
              crossFadeState: _expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration:
                  widget.duration == null ? defaultDuration : widget.duration!,
              firstChild:

                  /// Returns Listviews for the children.
                  ///
                  /// ClampingScrollPhyiscs so the ListTile will scroll in the main screen and not its children.
                  /// Shrinkwrap is always true so the ExpansionTile will wrap its children and hide when not expanded.
                  ListView(
                physics: ClampingScrollPhysics(),
                padding: widget.childrenPadding ?? EdgeInsets.zero,
                shrinkWrap: true,
                children: widget.children!,
              ),
              // If not expanded just returns an empty containter so the ExpansionTile will only show the ListTile.
              secondChild: Container()),
        ]);
  }

  // Build trailing widget based on the user input.
  Widget? _trailingIcon() {
    if (widget.trailing != null) {
      if (_rotateTrailing!) {
        return RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(_iconController),
            child: widget.trailing);
      } else {
        // If developer sets rotateTrailing to false the widget will just be returned.
        return widget.trailing;
      }
    } else {
      // Default trailing is an Animated Menu Icon.
      return AnimatedIcon(
          icon: AnimatedIcons.close_menu, progress: _controller);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RoundedExpansionTile extends StatefulWidget {
  final bool autofocus;
  final EdgeInsetsGeometry contentPadding;
  final bool dense;
  final bool enabled;
  final bool enableFeedback;
  final Color focusColor;
  final FocusNode focusNode;
  final double horizontalTitleGap;
  final Color hoverColor;
  final bool isThreeLine;
  final Key key;
  final Widget leading;
  final double minLeadingWidth;
  final double minVerticalPadding;
  final MouseCursor mouseCursor;
  final void Function() onLongPress;
  final bool selected;
  final Color selectedTileColor;
  final ShapeBorder shape;
  final Widget subtitle;
  final Widget title;
  final Color tileColor;
  final Widget trailing;
  final VisualDensity visualDensity;
  final void Function() onTap;
  final double radius;
  final Duration duration;
  final List<Widget> children;
  final Curve curve;
  final EdgeInsets childrenPadding;
  final bool rotateTrailing;
  final bool noTrailing;

  RoundedExpansionTile(
      {this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.radius,
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
      this.noTrailing});

  @override
  _RoundedExpansionTileState createState() => _RoundedExpansionTileState();
}

class _RoundedExpansionTileState extends State<RoundedExpansionTile>
    with TickerProviderStateMixin {
  bool _expanded;
  bool _rotateTrailing;
  bool _noTrailing;
  AnimationController _controller;
  Duration defaultDuration = Duration(milliseconds: 500);
  AnimationController _iconController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _expanded = false;
    _rotateTrailing =
        widget.rotateTrailing == null ? true : widget.rotateTrailing;
    _noTrailing = widget.noTrailing == null ? false : widget.noTrailing;
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration == null ? defaultDuration : widget.duration)
      ..repeat(reverse: true);

    _iconController = AnimationController(
      duration: widget.duration == null ? defaultDuration : widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
        parent: _iconController,
        curve: Curves.linear,
        reverseCurve: Curves.linear);
    _controller.forward();
    // _iconController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _iconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            autofocus: widget.autofocus == null ? false : widget.autofocus,
            contentPadding: widget.contentPadding,
            dense: widget.dense == null ? false : widget.dense,
            enabled: widget.enabled == null ? true : widget.enabled,
            enableFeedback:
                widget.enableFeedback == null ? false : widget.enableFeedback,
            focusColor: widget.focusColor,
            focusNode: widget.focusNode,
            horizontalTitleGap: widget.horizontalTitleGap,
            hoverColor: widget.hoverColor,
            isThreeLine:
                widget.isThreeLine == null ? false : widget.isThreeLine,
            key: widget.key,
            leading: widget.leading,
            minLeadingWidth: widget.minLeadingWidth,
            minVerticalPadding: widget.minVerticalPadding,
            mouseCursor: widget.mouseCursor,
            onLongPress: widget.onLongPress,
            selected: widget.selected == null ? false : widget.selected,
            selectedTileColor: widget.selectedTileColor,
            shape: widget.shape,
            subtitle: widget.subtitle,
            title: widget.title,
            tileColor: widget.tileColor,
            trailing: _noTrailing ? null : _trailingIcon(),
            visualDensity: widget.visualDensity,
            onTap: () {
              if (widget.onTap != null) {
                // if developer defines an extra option on tap, this will be executed.
                // ignore: unnecessary_statements
                widget.onTap;
              }
              setState(() {
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
                  : widget.curve,
              secondCurve: widget.curve == null
                  ? Curves.fastLinearToSlowEaseIn
                  : widget.curve,
              crossFadeState: _expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration:
                  widget.duration == null ? defaultDuration : widget.duration,
              firstChild: ListView(
                physics: ClampingScrollPhysics(),
                padding: widget.childrenPadding,
                shrinkWrap: true,
                children: widget.children,
              ),
              secondChild: Container()),
        ]);
  }

  Widget _trailingIcon() {
    if (widget.trailing != null) {
      if (_rotateTrailing) {
        print('This one is called!');
        return RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(_iconController),
            child: widget.trailing);
      } else {
        return widget.trailing;
      }
    } else {
      return AnimatedIcon(
          icon: AnimatedIcons.close_menu, progress: _controller);
    }
  }
}

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
  final bool menuIcon;

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
      this.menuIcon});

  @override
  _RoundedExpansionTileState createState() => _RoundedExpansionTileState();
}

class _RoundedExpansionTileState extends State<RoundedExpansionTile>
    with TickerProviderStateMixin {
  bool _expanded;
  AnimationController _controller;
  Duration defaultDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _expanded = false;
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration == null ? defaultDuration : widget.duration);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            trailing: widget.trailing == null
                ? widget.menuIcon == null
                    ? AnimatedIcon(
                        icon: AnimatedIcons.close_menu, progress: _controller)
                    : widget.menuIcon
                        ? AnimatedIcon(
                            icon: AnimatedIcons.close_menu,
                            progress: _controller)
                        : AnimatedIcon(
                            icon: AnimatedIcons.view_list,
                            progress: _controller)
                : widget.trailing,
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
                } else {
                  _expanded = !_expanded;
                  _controller.reverse();
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
}

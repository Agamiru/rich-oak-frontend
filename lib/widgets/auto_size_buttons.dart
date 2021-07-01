import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rich_oak_fintech/utils/utils.dart' as utils;


class AutoSizeTransparentButton extends StatefulWidget {
  final String buttonName;
  final Size? widthAndHeight;
  final void Function()? onTapFunction;
  double? padding;
  BorderRadiusGeometry? borderRadius;


  AutoSizeTransparentButton(
      {Key? key,
      required this.buttonName, this.widthAndHeight, this.onTapFunction,
      this.padding, this.borderRadius})
      : super(key: key);

  @override
  _AutoSizeTransparentButtonState createState() =>
      _AutoSizeTransparentButtonState();
}

class _AutoSizeTransparentButtonState extends State<AutoSizeTransparentButton> {
  bool _on_hover = false;
  double numericPadding = 10;

  @override
  Widget build(BuildContext context) {
    widget.padding ??= numericPadding;
    EdgeInsetsGeometry padding = EdgeInsets.all(widget.padding!);

    return InkWell(
      onHover: (bool hover) {
        setState(() {
          hover ? _on_hover = true : _on_hover = false;
        });
      },
      onTap: widget.onTapFunction == null ? () {} : widget.onTapFunction,
      child: Container(
        padding: _on_hover ? EdgeInsets.all(widget.padding! * 0.89) : padding,
        width:
            widget.widthAndHeight != null ? widget.widthAndHeight!.width : null,
        height: widget.widthAndHeight != null
            ? widget.widthAndHeight!.height
            : null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.orangeAccent, width: 2),
        ),
        child: FittedBox(
          alignment: Alignment.center,
          child: Text(
            widget.buttonName,
            style: _on_hover
                ? utils.TextStyles.defaultStyle
                : utils.TextStyles.defaultStyle.apply(fontSizeFactor: 0.85),
          ),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextExpandable extends StatefulWidget {
  const TextExpandable(
      {super.key, required this.text, this.textStyle = const TextStyle()});
  final String text;
  final TextStyle textStyle;

  @override
  State<TextExpandable> createState() => _TextExpandableState();
}

class _TextExpandableState extends State<TextExpandable> {
  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text(
        widget.text,
        style: widget.textStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: !isExpanded ? 1 : 100,
      ),
    );
  }
}

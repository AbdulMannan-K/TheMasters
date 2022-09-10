import 'package:flutter/material.dart';

class AppBarSearch extends AppBar {
  AppBarSearch({
    super.key,
    String? searchHint,
    PreferredSizeWidget? bottom,
    TextEditingController? controller,
  }) : super(
          elevation: 4,
          bottom: bottom,
          title: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: searchHint,
              fillColor: Colors.white,
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
          ),
        );
}

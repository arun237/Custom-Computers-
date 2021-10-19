import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:se/widgets/moveup.dart';

extension Onhover on Widget {
  static final appContainer =
      html.window.document.getElementById("app-container");

  Widget get showOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }

  Widget get moveUp {
    return TranslateOnHover(child: this);
  }
}

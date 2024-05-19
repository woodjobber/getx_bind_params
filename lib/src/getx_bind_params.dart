import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GXStatefulWidget extends StatefulWidget {
  const GXStatefulWidget({super.key});
  @override
  StatefulElement createElement() => StatefulElement(this);

  @override
  @protected
  @factory
  GXState createState();
}

abstract class GXState<T extends GXStatefulWidget, P,
    S extends GXControllerBindParamsMixin<P>> extends State<T> {}

mixin GXBindParamsMixin<T extends GXStatefulWidget, P,
    S extends GXControllerBindParamsMixin<P>> on GXState<T, P, S> {
  @mustCallSuper
  P? get params;

  @override
  void initState() {
    bindParams(params);
    super.initState();
  }

  void bindParams(P? value) {
    S logic = Get.find<S>();
    logic.params = value;
    logic.didBindParams();
  }

  @override
  void dispose() {
    Get.delete<S>();
    super.dispose();
  }
}

mixin GXControllerBindParamsMixin<P> on GetxController {
  late P? params;

  P? get args => params;

  @mustCallSuper
  void didBindParams() {
    debugPrint('didBindParams: $params');
  }
}

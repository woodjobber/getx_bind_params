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
  P? get params;

  String? get tag => null;

  void onInitGX() {}

  @override
  void initState() {
    onInitGX();
    bindParams(params);
    super.initState();
  }

  void bindParams(P? value) {
    bool isRegistered = Get.isRegistered<S>(tag: tag == '' ? null : tag);
    assert(isRegistered == true,
        '"${S.runtimeType}" not found. You need to Call "Get.put(${S.runtimeType}())"');
    if (isRegistered) {
      S logic = Get.find<S>(tag: tag == '' ? null : tag);
      logic.params = value;
      logic.didBindParams();
    }
  }

  /// 使用此 属性 必须 保证 params 不等于 null
  ///
  P get args => params!;

  @override
  void dispose() {
    Get.delete<S>();
    super.dispose();
  }
}

mixin GXControllerBindParamsMixin<P> on GetxController {
  late P? params;

  /// 使用此 属性 必须 保证 params 不等于 null
  ///
  P get args => params!;

  @mustCallSuper
  void didBindParams() {
    debugPrint('didBindParams: $params');
  }
}

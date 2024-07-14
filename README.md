<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Usage

```dart
/// [1] 继承 `GXStatefulWidget`
/// 
class DemoPage extends GXStatefulWidget {
  const DemoPage({
    super.key,
    required this.params,
  });
  final DemoPageParams params;
  @override
  GXState<DemoPage, DemoPageParams, DemoPageLogic> createState() =>
      _DemoPageGetXState();
}

/// [2] 继承 `GXState<T,P,S>` 并实现 `GXBindParamsMixin`
/// 
class _DemoPageGetXState
    extends GXState<DemoPage, DemoPageParams, DemoPageLogic>
    with GXBindParamsMixin {
  final logic = Get.put(DemoPageLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Placeholder(
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SamplePage(
                      params: SamplePageParams('123'),
                    )));
              },
              icon: const Icon(Icons.abc_sharp)),
        ),
      ),
    );
  }

  @override
  DemoPageParams get params => widget.params;
  
  @override
  String? get tag => null;
}

class DemoPageParams {
  String name;
  DemoPageParams(this.name);
}

/// [3] 继承 `GXController` 并实现 `GXControllerBindParamsMixin<P>`
/// 
class DemoPageLogic extends GetxController
    with GXControllerBindParamsMixin<DemoPageParams> {
  final DemoPageState state = DemoPageState();

  @override
  void didBindParams() {
    /// TODO: implement didBindParams
    /// 参数已经绑定完成，可以做其它操作
    super.didBindParams();
    debugPrint(args.name);
  }
}

class DemoPageState {}

// SamplePage

class SamplePage extends GXStatefulWidget {
  const SamplePage({
    super.key,
    required this.params,
  });
  final SamplePageParams params;
  @override
  GXState<SamplePage, SamplePageParams, SamplePageLogic> createState() =>
      _SamplePageGetXState();
}

class _SamplePageGetXState
    extends GXState<SamplePage, SamplePageParams, SamplePageLogic>
    with GXBindParamsMixin {
  final logic = Get.put(SamplePageLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SamplePageLogic>(builder: (logic) {
        return const Placeholder();
      }),
    );
  }

  @override
  SamplePageParams get params => widget.params;
}

class SamplePageParams {
  final String name;
  SamplePageParams(this.name);
}

class SamplePageLogic extends GetxController
    with GXControllerBindParamsMixin<SamplePageParams> {
  @override
  void didBindParams() {
    /// TODO: implement didBindParams
    super.didBindParams();
    print(params?.name);
  }
}
```


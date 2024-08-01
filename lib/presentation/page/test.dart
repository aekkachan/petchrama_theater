import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final toggleProvider = StateNotifierProvider<ToggleNotifier, bool>((ref) {
  return ToggleNotifier();
});

class ToggleNotifier extends StateNotifier<bool> {
  ToggleNotifier() : super(true);

  void toggle() => state = !state;
}

class ToggleWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isText = ref.watch(toggleProvider);

    return GestureDetector(
      onTap: () => ref.read(toggleProvider.notifier).toggle(),
      child: AnimatedSwitcher(
        duration: Duration(seconds: 2),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isText
            ? Text(
                'This is a Text Widget',
                key: ValueKey('TextWidget'),
                style: TextStyle(fontSize: 24),
              )
            : Container(
                key: ValueKey('ContainerWidget'),
                width: 200,
                height: 200,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'This is a Container Widget',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}

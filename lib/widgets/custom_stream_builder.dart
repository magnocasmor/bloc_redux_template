import 'package:flutter/cupertino.dart';

class CustomStreamBuilder<T> extends StreamBuilder<T> {
  CustomStreamBuilder({
    @required Stream<T> stream,
    @required Widget Function(BuildContext, T) builder,
    Widget Function(BuildContext, T) errorBuilder,
    T initialData,
  }) : super(
          initialData: initialData,
          stream: stream,
          builder: (context, snapshot) {
            // if (snapshot.hasError && errorBuilder is Function)
            //   return errorBuilder(context, snapshot.error);
            try {
              return builder(context, snapshot.requireData);
            } catch (e) {
              if (errorBuilder is Function)
                return errorBuilder(context, snapshot.error);
              else
                return Container();
            }
          },
        );
}

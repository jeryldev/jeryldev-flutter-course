import 'dart:async';

enum CounterEvent { increment, decrement }

class CounterBloc {
  double _counter = 0;

  final StreamController<CounterEvent> _counterEventController =
      StreamController<CounterEvent>();

  Sink<CounterEvent> get _counterEventSink => _counterEventController.sink;

  void increment() {
    _counterEventSink.add(CounterEvent.increment);
  }

  void decrement() {
    _counterEventSink.add(CounterEvent.decrement);
  }

  void _mapEventToState(CounterEvent event) {
    event == CounterEvent.increment
        ? _counter++ : _counter--;
    _counterStateSink.add(_counter);
  }

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  final StreamController<double> _counterStateController =
      StreamController<double>();

  Sink<double> get _counterStateSink => _counterStateController.sink;

    Stream<double> get counter => _counterStateController.stream;

  dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}

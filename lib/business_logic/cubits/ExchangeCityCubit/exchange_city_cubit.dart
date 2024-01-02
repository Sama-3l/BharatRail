import 'package:bloc/bloc.dart';

part 'exchange_city_state.dart';

// Cubit made to toggle the Departing and Arrival Stations
class ExchangeCityCubit extends Cubit<ExchangeCityState> {
  ExchangeCityCubit() : super(ExchangeCityInitial());

  onToggleButton() {
    emit(ToggleCity());
  }
}

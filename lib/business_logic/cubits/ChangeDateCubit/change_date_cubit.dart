import 'package:bloc/bloc.dart';

part 'change_date_state.dart';

class ChangeDateCubit extends Cubit<ChangeDateState> {
  ChangeDateCubit() : super(ChangeDateInitial());

  onChangeDate(){
    emit(DateChangedState());
  }
}

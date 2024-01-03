import 'package:bloc/bloc.dart';

part 'class_update_cubit_state.dart';

class ClassUpdateCubit extends Cubit<ClassUpdateState> {
  ClassUpdateCubit() : super(ClassUpdateInitial());

  onClassChange() => emit(ClassChangedState());
}

import 'package:bloc/bloc.dart';

part 'train_updated_state.dart';

class TrainUpdatedCubit extends Cubit<TrainUpdatedState> {
  TrainUpdatedCubit() : super(TrainUpdatedInitial());

  onTrainUpdated() => emit(TrainChangedState());
}

import 'package:bloc/bloc.dart';

part 'ticket_selected_state.dart';

class TicketSelectedCubit extends Cubit<TicketSelectedState> {
  TicketSelectedCubit() : super(TicketSelectedInitial());

  onSelectingTicket() => emit(SelectTicketState());
}

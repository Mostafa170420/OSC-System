import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownCubit extends Cubit<int> {
  DropDownCubit() : super(0);
  static DropDownCubit get(context) => BlocProvider.of(context);

  void changeState(int number) {
    emit(number);
  }
}

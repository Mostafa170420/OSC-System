import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';

class SidebarCubit extends Cubit<int> {
  SidebarCubit() : super(0);
  static SidebarCubit get(context) => BlocProvider.of(context);

  final SidebarXController controller = SidebarXController(selectedIndex: 0);

  changeScreen(int index) {
    emit(index);
  }
}

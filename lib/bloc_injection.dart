import 'package:get_it/get_it.dart';
import 'package:notes/bloc/notes_bloc.dart';

final bl = GetIt.instance;
final cl= GetIt.instance;
final dl= GetIt.instance;


void registerBloc() {
  bl.registerLazySingleton<NotesBloc>(
    () => NotesBloc(),
  );
}

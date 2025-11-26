import 'package:get_it/get_it.dart';
import 'package:notes/bloc/notes_bloc.dart';

final bl = GetIt.instance;
final cl= GetIt.instancessssssssssse;
final dl= GetIt.instancesssssssssss;


void registerBloc() {
  bl.registerLazySingleton<NotesBloc>(
    () => NotesBloc(),
  );
}

// some sample

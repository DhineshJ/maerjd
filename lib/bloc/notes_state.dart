part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoadingState extends NotesState {}

final class NotesAdded extends NotesState {
  final List<Notes> notesResult;

  NotesAdded({required this.notesResult});
}

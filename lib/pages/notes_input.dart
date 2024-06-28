import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/bloc/notes_bloc.dart';
import 'package:notes/entity/notes.dart';
import 'package:notes/pages/notes_listing.dart';

class NotesInput extends StatefulWidget {
  final String inputTitleToModify;
  final String inputContentToModify;
  NotesInput(
      {super.key,
      required this.inputTitleToModify,
      required this.inputContentToModify});

  @override
  State<NotesInput> createState() => _NotesInputState();
}

class _NotesInputState extends State<NotesInput> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final getIt = GetIt.instance;
  late NotesBloc notesBloc;

  @override
  void initState() {
    notesBloc = getIt<NotesBloc>();

    if (widget.inputContentToModify != "") {
      contentController.text = widget.inputContentToModify;
    }

    if (widget.inputTitleToModify != "") {
      titleController.text = widget.inputTitleToModify;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<NotesBloc, NotesState>(
          bloc: notesBloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Enter Notes Title"),
                TextField(
                  controller: titleController,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Enter Content"),
                TextField(
                  controller: contentController,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(titleController.text);
          // context.read<NotesBloc>().add(AddNotesEvent(Notes(
          //     id: 1,
          //     name: titleController.text,
          //     notesDetails: contentController.text)
          //
          // ));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotesListing()),
          );

          notesBloc.add(AddNotesEvent(Notes(
              id: 1,
              name: titleController.text,
              notesDetails: contentController.text)));
        },
        tooltip: 'Create Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}

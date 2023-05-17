import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/modules/details/bloc/hacks_bloc.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<HacksModel> hacksList = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HacksBloc>(context).add(GetHacksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<HacksBloc, HacksState>(
        listener: (context, state) {
          if (state is GetHacksState && state.isCompleted) {
            hacksList = state.hacksModel ?? [];
          }
        },
        builder: (context, state) {
          return state is GetHacksState && state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: hacksList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        tileColor: Colors.grey.shade100,
                        title: Text(hacksList[index].hackDetails ?? ""),
                      ),
                    );
                  },
                );
        },
      )),
    );
  }
}

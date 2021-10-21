import 'package:flutter/material.dart';

import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final plan = Plan();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    // For iOS, ScrollController is used to close the keyboard once it is opened
    scrollController = ScrollController();
    scrollController.addListener(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  @override
  void dispose() {
    // Dispose it when the ListView widget is removed from the tree
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plan')),
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  //---------------------------------------------------------------------------------------
  // Material way to add Items to a List
  //---------------------------------------------------------------------------------------
  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          plan.tasks.add(Task());
        });
      },
    );
  }

  //---------------------------------------------------------------------------------------
  // Creates a Scrollable List, each element is passed to the _buildTaskTile method
  //---------------------------------------------------------------------------------------
  Widget _buildList() {
    return ListView.builder(
      controller: scrollController, // fix iOS keyboard issue
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index]),
    );
  }

  //---------------------------------------------------------------------------------------
  // Creates a ListTile for each Element received as parameter
  //---------------------------------------------------------------------------------------
  Widget _buildTaskTile(Task task) {
    return ListTile(
      leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            setState(() {
              task.complete = selected!;
            });
          }),
      title: TextField(
        onChanged: (text) {
          setState(() {
            task.description = text;
          });
        },
      ),
    );
  }
}

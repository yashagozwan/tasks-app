import 'package:flutter/material.dart';
import 'package:submission_flutter_pemula/model/task_model.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final TaskModel task;

  const DetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E2E7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Detail",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _cardTask()
        ],
      ),
    );
  }

  Widget _cardTask() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.text, style: const TextStyle(fontSize: 18),),
          const SizedBox(height: 8),
          Text(_formatDate(task.createdAt), style: const TextStyle(color: Colors.black38)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: task.isDone ? Colors.green : Colors.orange,
            ),
            child: Text(task.isDone ? "Completed" : "Ongoing", style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String _formatDate(int epochDate){
    var parseEpochToDate= DateTime.fromMillisecondsSinceEpoch(epochDate);
    var formatterDate = DateFormat.yMMMMEEEEd();
    return formatterDate.format(parseEpochToDate);
  }
}

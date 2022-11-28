import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/review_perbaikan_cubit.dart';

class ReviewPerbaikan extends StatefulWidget {
  const ReviewPerbaikan({super.key});

  @override
  State<ReviewPerbaikan> createState() => _ReviewPerbaikanState();
}

class _ReviewPerbaikanState extends State<ReviewPerbaikan> {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print(argument);
    BlocProvider.of<ReviewPerbaikanCubit>(context)
        .getReviewPerbaikan(argument['id_delegasi']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Perbaikan'),
      ),
      body: BlocBuilder<ReviewPerbaikanCubit, ReviewPerbaikanState>(
        builder: (context, state) {
          if (state is ReviewPerbaikanLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ReviewPerbaikanLoaded == false) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data False'),
            );
          }
          var json = (state as ReviewPerbaikanLoaded).json;
          if (json.isEmpty) {
            return Container(
              child: Text('Data Kosong'),
            );
          }
          return ListView.builder(
            itemCount: json.length,
            itemBuilder: (context, index) {
              var data = json[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 1.3,
                          spreadRadius: 1.3,
                          offset: Offset(1, 3))
                    ]),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(150),
                    1: FixedColumnWidth(20),
                    // 2: FixedColumnWidth(100),
                  },
                  children: [
                    TableRow(children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          'ID DELEGASI',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data['id_delegasi'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          'Review',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data['review'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

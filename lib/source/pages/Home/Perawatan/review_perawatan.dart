import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/review_perawatan_cubit.dart';

class ReviewPerawatan extends StatefulWidget {
  const ReviewPerawatan({super.key});

  @override
  State<ReviewPerawatan> createState() => _ReviewPerawatanState();
}

class _ReviewPerawatanState extends State<ReviewPerawatan> {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print(argument);
    BlocProvider.of<ReviewPerawatanCubit>(context).reviewPerawatan(argument['id_delegasi']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Perawatan'),
      ),
      body: BlocBuilder<ReviewPerawatanCubit, ReviewPerawatanState>(
        builder: (context, state) {
          if (state is ReviewPerawatanLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ReviewPerawatanLoaded == false) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data False'),
            );
          }
          var json = (state as ReviewPerawatanLoaded).json;
          if (json.isEmpty) {
            return Container(
              alignment: Alignment.center,
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
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 1.3,
                    spreadRadius: 1.3,
                    offset: Offset(1, 3),
                  )
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

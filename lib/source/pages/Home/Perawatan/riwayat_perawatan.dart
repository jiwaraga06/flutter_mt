import 'package:flutter/material.dart';

class RiwayatPerawatan extends StatefulWidget {
  const RiwayatPerawatan({super.key});

  @override
  State<RiwayatPerawatan> createState() => _RiwayatPerawatanState();
}

class _RiwayatPerawatanState extends State<RiwayatPerawatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Perawatan')),
    );
  }
}
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String? filter;
  const DetailScreen({super.key, required this.id, this.filter});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product ${widget.id}')),
      body: Center(
        child: Text("Showing product ${widget.id}\nFilter: ${widget.filter}"),
      ),
    );
  }
}

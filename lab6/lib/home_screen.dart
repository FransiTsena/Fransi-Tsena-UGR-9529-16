import 'package:flutter/material.dart';
import 'package:lab6/services/api.dart';
import 'dart:math';

import 'package:lab6/models/photo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Photo? photo;
  bool loading = false;

  int getRandomId() {
    final random = Random();
    return random.nextInt(100) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              )
            else if (photo == null)
              Text("Press a button to make API request")
            else
              Column(
                children: [
                  if (photo != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Raw Response"),
                        for (MapEntry entry in photo!.toJson().entries)
                          Wrap(
                            spacing: 8,
                            children: [
                              Text("${entry.key} :".toUpperCase()),
                              SelectableText("${entry.value}"),
                            ],
                          ),
                      ],
                    ),

                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      child: Image.network(
                        photo!.url!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      child: Image.network(
                        photo!.tubmnailUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(photo!.title, style: TextStyle(fontSize: 16)),
                ],
              ),

            const SizedBox(height: 20),
            FloatingActionButton.extended(
              onPressed: () => getPhoto(),
              label: const Text('Fetch Photo'),
            ),
          ],
        ),
      ),
    );
  }

  void getPhoto() async {
    setState(() {
      loading = true;
    });

    try {
      final fetchedPhoto = await ApiService.getPhoto(getRandomId());
      setState(() {
        photo = fetchedPhoto;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to fetch photo")));
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}

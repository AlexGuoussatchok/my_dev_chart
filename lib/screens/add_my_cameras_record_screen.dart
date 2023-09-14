import 'package:flutter/material.dart';

class AddMyCamerasRecordScreen extends StatelessWidget {
  const AddMyCamerasRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a camera to your collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Camera Brand Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Camera Brand'),
              ),
              const SizedBox(height: 16.0),

              // Camera Model Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Camera Model'),
              ),
              const SizedBox(height: 16.0),

              // Serial Number Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Serial Number'),
              ),
              const SizedBox(height: 16.0),

              // Purchase Date Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Purchase Date'),
                keyboardType: TextInputType.datetime,
                // You can add date picking functionality here
              ),
              const SizedBox(height: 16.0),

              // Price Paid Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price Paid'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),

              // Condition Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Condition'),
              ),
              const SizedBox(height: 16.0),

              // Film Loaded Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Film Loaded'),
              ),
              const SizedBox(height: 16.0),

              // Film Load Date Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Film Load Date'),
                keyboardType: TextInputType.datetime,
                // You can add date picking functionality here
              ),
              const SizedBox(height: 16.0),

              // Comments Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Comments'),
                maxLines: 3, // Adjust the number of lines as needed
              ),
              const SizedBox(height: 16.0),

              // Add Camera Button
              ElevatedButton(
                onPressed: () {
                  // Add your logic to save the camera record here
                },
                child: const Text('Add Camera'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

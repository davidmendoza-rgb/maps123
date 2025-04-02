import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerFormScreen extends StatefulWidget {
  final LatLng position;

  const MarkerFormScreen({Key? key, required this.position}) : super(key: key);

  @override
  _MarkerFormScreenState createState() => _MarkerFormScreenState();
}

class _MarkerFormScreenState extends State<MarkerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Marcador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El título es obligatorio";
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descripción"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La descripción es obligatoria";
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, {
                      "title": _title,
                      "description": _description,
                    });
                  }
                },
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

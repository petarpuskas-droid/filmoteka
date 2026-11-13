import 'package:flutter/material.dart';

import 'package:filmoteka/models/movies.dart';

class MovieFormScreen extends StatefulWidget {
  const MovieFormScreen({super.key});

  @override
  State<MovieFormScreen> createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();

  final _genres = [
    "Akcija",
    "Animirani",
    "Drama",
    "Komedija",
    "Znanstvena fanstastika",
  ];

  MovieType _type = MovieType.film;
  String _genre = "Drama";
  double _rating = 5;
  bool _watched = false;
  bool _favourite = false;

  String _summary = "";

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _clear() {
    _titleController.clear();
    _yearController.clear();
  }

  void _save() {
    setState(() {
      _summary =
          "${_titleController.text}, ${_yearController.text}, ${_type.name}, "
          "$_genre, ocjena ${_rating.round()}, pogledano: $_watched, "
          "favorit: $_favourite";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novi film")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: "Naslov",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _yearController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Godina",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          RadioGroup<MovieType>(
            groupValue: _type,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _type = value;
                });
              }
            },
            child: const Column(
              children: [
                RadioListTile(value: MovieType.film, title: Text("Film")),
                RadioListTile(value: MovieType.series, title: Text("Serija")),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text("žanr"),
          DropdownButton<String>(
            value: _genre,
            items: _genres
                .map(
                  (genre) => DropdownMenuItem(value: genre, child: Text(genre)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _genre = value;
                }
              });
            },
          ),
          const SizedBox(height: 12),
          Text("Ocjena: ${_rating.round()}"),
          Slider(
            value: _rating,
            min: 1,
            max: 10,
            divisions: 9,
            label: "${_rating.round()}",
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            title: const Text("Pogledano"),
            value: _watched,
            onChanged: (value) {
              _watched = value ?? false;
            },
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text("Favorit"),
            value: _favourite,
            onChanged: (value) {
              setState(() {
                _favourite = value;
              });
            }
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

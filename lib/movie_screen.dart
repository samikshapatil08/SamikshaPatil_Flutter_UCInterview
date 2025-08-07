import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() {
    return _MovieScreenState();
  }
}

class _MovieScreenState extends State<MovieScreen> {
  Map<String, dynamic>? _movieData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final uri = Uri.parse('https://flutterucinterviewtask.onrender.com/random');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _movieData = json;
      });
    } else {
      // Handle cases where the API call fails
    }
  }

  @override
  Widget build(BuildContext context) {
    const double uniformFontSize = 14.0;
    const double chipFontSize = 12.0;
    const double ratingFontSize = 16.0;
    const Color chipColor = Color.fromARGB(238, 71, 106, 53);

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: Column(
          children: [
            Expanded(
              child: _movieData == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: chipColor,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xFF2a2a2a),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                _movieData!['Title'] ?? '',
                                style: GoogleFonts.anton(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Image.network(
                                _movieData!['Poster'] ?? '',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 16),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: (_movieData!['Genre'] ?? '')
                                    .toString()
                                    .split(', ')
                                    .map<Widget>((genre) {
                                      if (genre.isEmpty) {
                                        return const SizedBox.shrink();
                                      }
                                      return Chip(
                                        label: Text(
                                          genre,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: chipFontSize,
                                          ),
                                        ),
                                        backgroundColor: chipColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: chipColor,
                                  ),
                                  Text(
                                    '${_movieData!['imdbRating']}/10',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ratingFontSize,
                                    ),
                                  ),
                                  Text(
                                    '(${_movieData!['imdbVotes']} votes)',
                                    style: TextStyle(
                                      color: chipColor,
                                      fontSize: ratingFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      'Director:',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: uniformFontSize,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _movieData!['Director'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: uniformFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.local_movies,
                                  color: Colors.white,
                                ),
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Writer:',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: uniformFontSize,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _movieData!['Writer'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: uniformFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: chipColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _movieData!['Plot'] ?? 'No plot available.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: uniformFontSize,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: Image.asset(
                                        'assets/globe3.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                      title: Text(
                                        'Language',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: uniformFontSize,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _movieData!['Language'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: uniformFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading: Image.asset(
                                        'assets/globe2.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                      title: Text(
                                        'Country',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: uniformFontSize,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _movieData!['Country'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: uniformFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListTile(
                                leading: Image.asset(
                                  'assets/image.png',
                                  height: 25,
                                  width: 25,
                                ),
                                title: Text(
                                  'Awards:',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: uniformFontSize,
                                  ),
                                ),
                                subtitle: Text(
                                  _movieData!['Awards'] ?? 'N/A',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: uniformFontSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: fetchData,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    chipColor,
                  ),
                ),
                child: Text(
                  'Shuffle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: uniformFontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../services/PetService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> pet;

  const PetDetailsScreen({super.key, required this.pet});

  Future<void> _sendAdoptRequest(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';

    final result = await PetService.adoptPet(userId, pet['id']);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Adoption request sent successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? "Request failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiConstants.imageBaseUrl}${pet['image']}';

    return Scaffold(
      appBar: AppBar(
        title: Text(pet['animal_name']),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Pet Image with shadow & rounded corners
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          imageUrl,
                          height: 280,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return SizedBox(
                              height: 280,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: progress.expectedTotalBytes != null
                                      ? progress.cumulativeBytesLoaded /
                                            (progress.expectedTotalBytes ?? 1)
                                      : null,
                                  color: Colors.teal,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 280,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.pets,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Pet Name
                      Text(
                        pet['animal_name'],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(
                              color: Colors.tealAccent,
                              blurRadius: 8,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      // Card with details & subtle shadow
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        shadowColor: Colors.teal.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...[
                                ['Breed', pet['breed_name']],
                                ['Age', pet['age']],
                                ['Color', pet['color']],
                                ['Gender', pet['gender']],
                                ['City', pet['city']],
                                ['Health Condition', pet['helth_condition']],
                              ].map((e) => _buildDetailRow(e[0], e[1])),

                              const SizedBox(height: 16),

                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                pet['description'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Adopt Button with padding and ripple effect
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _sendAdoptRequest(context),
                    icon: const Icon(Icons.favorite, size: 26),
                    label: const Text(
                      'Adopt Me',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: Colors.pink.shade200,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.teal,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

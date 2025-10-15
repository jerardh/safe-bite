import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';

class ActivitySuggestion extends StatefulWidget {
  const ActivitySuggestion({super.key});

  @override
  State<ActivitySuggestion> createState() => _ActivitySuggestionState();
}

class _ActivitySuggestionState extends State<ActivitySuggestion> {
  // Example exercise list
  final List<Map<String, String>> exercises = [
    {
      "name": "Jumping Jacks",
      "icon": "assets/icons/jumping.svg",
      "desc": "A full-body warm-up exercise.",
    },
    {
      "name": "Push Ups",
      "icon": "assets/icons/pushup.svg",
      "desc": "Strengthen your chest and arms.",
    },
    {
      "name": "Squats",
      "icon": "assets/icons/squat.svg",
      "desc": "Build lower body strength.",
    },
    {
      "name": "Yoga Stretch",
      "icon": "assets/icons/yoga.svg",
      "desc": "Relax and increase flexibility.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Util().appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Header Icon + Text
            SvgPicture.asset(
              'assets/icons/fitness-icon.svg',
              width: 80,
              height: 80,
              color: AppColor.primaryDark,
            ),
            const SizedBox(height: 16),
            const Text(
              "Today's Exercise Suggestions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Stay active and energized throughout your day!",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Exercise Grid
            Expanded(
              child: GridView.builder(
                itemCount: exercises.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final ex = exercises[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ex["icon"]!,
                          width: 50,
                          height: 50,
                          color: AppColor.primaryDark,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ex["name"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ex["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

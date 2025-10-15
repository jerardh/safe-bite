import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safebite/util/AppCircularProgress.dart';
import 'package:safebite/util/AppText.dart';
import 'package:safebite/util/appColor.dart';
import 'package:safebite/util/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitySuggestion extends StatefulWidget {
  const ActivitySuggestion({super.key});

  @override
  State<ActivitySuggestion> createState() => _ActivitySuggestionState();
}

class _ActivitySuggestionState extends State<ActivitySuggestion> {
  bool _isLoading = false;
  List<Map<String, String>>? exercises;

  final CollectionReference activityInfo =
      FirebaseFirestore.instance.collection('exerciseInfo');

  // 🔹 Fetch data from Firestore
  Future<void> fetchActivity() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot = await activityInfo.get();

      var data = querySnapshot.docs.map((doc) {
        final raw = doc.data() as Map<String, dynamic>;
        return {
          'name': raw['name']?.toString() ?? '',
          'calories': raw['cbh']?.toString() ?? '',
          'desc': raw['desc']?.toString() ?? '',
        };
      }).toList();

      setState(() {
        exercises = data;
      });
    } catch (e) {
      print("Error fetching activities: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchActivity(); // 🔹 Fetch data when the widget loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Util().appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? Center(
                child: Container(
                    width: 40, height: 40, child: Appcircularprogress()))
            : (exercises == null || exercises!.isEmpty)
                ? const Center(
                    child: Text(
                      "No exercises found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // Header Icon + Text
                      SvgPicture.asset(
                        'assets/icons/fitness-icon.svg',
                        width: 80,
                        height: 80,
                        color: AppColor.primary,
                      ),
                      const SizedBox(height: 16),
                       Text(
                        "Exercise Suggestions",
                        style: AppText().secondaryStyle
                      ),
                      const SizedBox(height: 10),
                       Text(
                        "Stay active and energized throughout your day!",
                        style: AppText().analysistextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Exercise Grid
                      Expanded(
                        child: GridView.builder(
                          itemCount: exercises!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            final ex = exercises![index];
                            return _buildExerciseCard(ex);
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  // 🔹 Separated widget for cleaner code
  Widget _buildExerciseCard(Map<String, String> ex) {
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
            ex["icon"]!, // ✅ corrected path
            width: 50,
            height: 50,
            color: AppColor.primary,
          ),
          const SizedBox(height: 10),
          Text(
            ex["name"] ?? "Unknown",
            style: AppText().analysistextStyle,
          ),
          const SizedBox(height: 6),
          Text(
            ex["calories"]!+" minutes" ?? "",
            textAlign: TextAlign.center,
            style: AppText().activitydurctextStyle,
          ),
          const SizedBox(height: 6),
          Text(
            ex["desc"] ?? "",
            textAlign: TextAlign.center,
            style:  AppText().activitydesctextStyle,
          ),
        ],
      ),
    );
  }
}

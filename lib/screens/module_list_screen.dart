import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trogon_test/provider/module_screen_provider.dart';
import 'package:trogon_test/screens/video_list_screen.dart';
import 'package:trogon_test/shared/colors.dart';

class ModuleListScreen extends StatefulWidget {
  final String subjectId; // NEW
  final String title;
  final String description;

  const ModuleListScreen({
    super.key,
    required this.subjectId,
    required this.title,
    required this.description,
  });

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final subjectId = widget.subjectId;
      Provider.of<ModuleProvider>(context, listen: false)
          .fetchModulesBySubjectId(subjectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title), // Display subject title as the app bar title
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<ModuleProvider>(
          builder: (context, provider, _) {
            // Show loading indicator while data is loading
            if (provider.isDataLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show a message if there are no modules
            if (provider.moduleList.isEmpty) {
              return const Center(child: Text("No modules available."));
            }

            // Display the list of modules
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: ListView.builder(
                itemCount: provider.moduleList.length,
                itemBuilder: (context, index) {
                  final module = provider.moduleList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                         vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                VideoListScreen(moduleId: module.id.toString()),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: ColorClass.getRandomColor(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      module.title ?? 'No Title',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      module.description ?? 'No Description',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

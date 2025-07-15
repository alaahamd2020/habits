import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:habits/extension/on_num.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/model/topic_model.dart';
import '../widgets/custom_text.dart';

class AddTopic extends StatefulWidget {
  AddTopic({super.key, this.topicModel});
  final TopicModel? topicModel;

  static show(BuildContext context, TopicModel? topicModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AddTopic(topicModel: topicModel,);
      },
    );
  }

  @override
  State<AddTopic> createState() => _AddTopicState();
}

class _AddTopicState extends State<AddTopic> {



  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.topicModel?.title);
    final descriptionController = TextEditingController(text: widget.topicModel?.description);
    final targetController = TextEditingController(text: widget.topicModel?.target.toString());
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32,),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.topic_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                                widget.topicModel?.userId == null ?
                                'Add New Topic':
                                'Update a ${widget.topicModel?.title}',
                              fontSize: 22,
                              bold: true,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            const SizedBox(height: 4),
                            TextCustom(
                              widget.topicModel?.id == null ?
                              'Create a new topic to organize your content':
                              'Update ${widget.topicModel!.title}',
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Title Input
                  _buildInputField(
                    context,
                    icon: Icons.title_rounded,
                    label: 'Topic Title',
                    controller: titleController,
                    hint: 'Enter topic title...',
                  ),
                  const SizedBox(height: 12),

                  // Target Input
                  _buildInputField(
                    context,
                    icon: Icons.flag_rounded,
                    label: 'Target (Days)',
                    controller: targetController,
                    hint: 'Enter target in days...',
                    keyboardType: TextInputType.number,
                    suffixText: 'Days',
                  ),
                  const SizedBox(height: 12),

                  // Description Input
                  _buildInputField(
                    context,
                    icon: Icons.description_rounded,
                    label: 'Description',
                    controller: descriptionController,
                    hint: 'Enter topic description...',
                    maxLines: 2,
                  ),
                  const SizedBox(height: 18),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                              ),
                            ),
                          ),
                          child: TextCustom(
                            'Cancel',
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (titleController.text.isNotEmpty) {
                                  FB.addTopic(
                                    TopicModel(
                                      id: widget.topicModel?.id,
                                      title: titleController.text,
                                      description: descriptionController.text
                                          .isEmpty
                                          ? null
                                          : descriptionController.text,
                                      target: targetController.text.isEmpty
                                          ? 0
                                          : int.parse(targetController.text),
                                    )
                                  );
                                Navigator.pop(context);
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.topicModel?.id == null ? Icons.add_rounded : Icons.edit_rounded,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                TextCustom(
                                  '${widget.topicModel?.id == null ? 'Add' : 'Edit'} Topic',
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  bold: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
            16.space,
          ]
        ),
      ),
    );
  }

  Widget _buildInputField(
      BuildContext context, {
        required IconData icon,
        required String label,
        required TextEditingController controller,
        required String hint,
        TextInputType? keyboardType,
        String? suffixText,
        int maxLines = 1,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary, size: 18),
                const SizedBox(width: 8),
                TextCustom(
                  label,
                  fontSize: 14,
                  bold: true,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              // initialValue: controller.text,
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: suffixText != null
                    ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextCustom(
                    suffixText,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
                    : null,
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

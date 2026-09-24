import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key, required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengumuman')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: warna.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                announcement.category,
                style: TextStyle(
                  color: warna.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              announcement.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(Icons.person_outline, size: 16, color: warna.outline),
                const SizedBox(width: 4),
                Text(announcement.author, style: TextStyle(color: warna.outline)),
                const SizedBox(width: 16),
                Icon(Icons.calendar_today_outlined, size: 14, color: warna.outline),
                const SizedBox(width: 4),
                Text(announcement.date, style: TextStyle(color: warna.outline)),
              ],
            ),
            const Divider(height: 32),
            Text(
              announcement.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Icon(Icons.remove_red_eye_outlined, size: 16, color: warna.outline),
                const SizedBox(width: 4),
                Text(
                  '${announcement.readCount} kali dibaca',
                  style: TextStyle(color: warna.outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
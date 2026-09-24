import 'package:flutter/material.dart';

import '../models/announcement.dart';

/// Kartu ini murni tampilan: tidak tahu apa-apa soal HTTP atau Future.
/// Semua yang dibutuhkannya datang lewat konstruktor.
class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onTap,
  });

  final Announcement announcement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Baris atas: tag kategori di kiri, tanggal di kanan.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: warna.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      announcement.category,
                      style: TextStyle(
                        color: warna.onPrimaryContainer,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    announcement.date,
                    style: TextStyle(
                      color: warna.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Judul.
              Text(
                announcement.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              // Cuplikan isi.
              Text(
                announcement.content,
                style: TextStyle(color: warna.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              // Baris bawah: penulis dan jumlah dibaca.
              Row(
                children: <Widget>[
                  Icon(Icons.person_outline, size: 14, color: warna.outline),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      announcement.author,
                      style: TextStyle(fontSize: 12, color: warna.outline),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.remove_red_eye_outlined,
                    size: 14,
                    color: warna.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${announcement.readCount}',
                    style: TextStyle(fontSize: 12, color: warna.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
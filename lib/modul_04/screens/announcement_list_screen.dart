import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../services/announcement_api.dart';
import '../widgets/announcement_card.dart';
import 'announcement_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  /// Dapat disuntikkan dari luar (widget test atau demo offline).
  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() =>
      _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api = widget.api ?? AnnouncementApi();

  late Future<List<Announcement>> _futurePengumuman;

  String _kategoriTerpilih = 'Semua';

  @override
  void initState() {
    super.initState();
    _futurePengumuman = _api.ambilPengumuman(); // sekali saja, saat layar dibuat
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru = _api.ambilPengumuman();
    setState(() {
      _futurePengumuman = futureBaru; // satu-satunya tempat penggantian
    });

    try {
      await futureBaru;
    } catch (_) {
      // Error sudah ditangani FutureBuilder lewat snapshot.hasError.
      // Blok catch ini hanya mencegah "unhandled exception" dan
      // memastikan RefreshIndicator berhenti berputar.
    }
  }

  void _pilihKategori(String kategori) {
    if (kategori == _kategoriTerpilih) return;
    setState(() => _kategoriTerpilih = kategori);
  }

  void _bukaDetail(Announcement announcement) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AnnouncementDetailScreen(announcement: announcement),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildBarisFilter(),
          const Divider(height: 1),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _muatUlang,
              child: FutureBuilder<List<Announcement>>(
                future: _futurePengumuman,
                builder: (context, snapshot) {
                  // -- Keadaan 1: MEMUAT -------------------------------
                  if (snapshot.connectionState != ConnectionState.done) {
                    return _buildMemuat();
                  }
                  // -- Keadaan 2: GAGAL ---------------------------------
                  if (snapshot.hasError) {
                    return _buildGagal(snapshot.error!);
                  }
                  // -- Keadaan 3 & 4: KOSONG / BERHASIL ------------------
                  final List<Announcement> semua =
                      snapshot.data ?? const <Announcement>[];

                  final List<Announcement> tampil = _kategoriTerpilih == 'Semua'
                      ? semua
                      : semua
                          .where(
                            (Announcement item) =>
                                item.category.toLowerCase() ==
                                _kategoriTerpilih.toLowerCase(),
                          )
                          .toList(growable: false);

                  if (tampil.isEmpty) return _buildKosong();
                  return _buildDaftar(tampil);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarisFilter() {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _kategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final String kategori = _kategori[index];
          final bool terpilih = kategori == _kategoriTerpilih;
          return ChoiceChip(
            label: Text(kategori),
            selected: terpilih,
            onSelected: (_) => _pilihKategori(kategori),
          );
        },
      ),
    );
  }

  // -- Keadaan 1: MEMUAT ------------------------------------------------
  Widget _buildMemuat() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat pengumuman...'),
        ],
      ),
    );
  }

  // -- Keadaan 2: GAGAL ---------------------------------------------------
  Widget _buildGagal(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              error.toString().replaceFirst('Exception: ', ''),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _muatUlang,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  // -- Keadaan 3: KOSONG --------------------------------------------------
  Widget _buildKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              _kategoriTerpilih == 'Semua'
                  ? 'Belum ada pengumuman.'
                  : 'Belum ada pengumuman pada kategori "$_kategoriTerpilih".',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // -- Keadaan 4: BERHASIL --------------------------------------------------
  Widget _buildDaftar(List<Announcement> data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final Announcement item = data[index];
        return AnnouncementCard(
          announcement: item,
          onTap: () => _bukaDetail(item),
        );
      },
    );
  }
}
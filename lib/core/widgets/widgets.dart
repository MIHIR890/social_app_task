import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Widgets {
   static buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ABOUT',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Building products by day, planning my next trek by night. Looking for someone equally driven and equally curious. 🌹',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static buildBasicsSection() {
    return _SectionCard(
      title: 'THE BASICS',
      children: [
        _InfoRow(
          icon: Icons.cake_outlined,
          label: 'Age',
          value: '21 years old',
          subValue: '19 Feb 1999',
        ),
        _InfoRow(
          icon: Icons.straighten_outlined,
          label: 'Height',
          value: '5\'5" (165 cm)',
        ),
        _InfoRow(
          icon: Icons.location_on_outlined,
          label: 'Lives in',
          value: 'Koregaon Park',
          subValue: 'Pune, Maharashtra',
        ),
        _InfoRow(
          icon: Icons.favorite_outline,
          label: 'Love language',
          value: 'Compliment',
          subValue: 'Words of affirmation',
        ),
      ],
    );
  }

  static buildSelfCard(
      String title, String content
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            title,
            style: TextStyle(
              color: Colors.pink,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
          content,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '🌹',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  static buildCareerSection() {
    return _SectionCard(
      title: 'CAREER & AMBITION',
      children: [
        _InfoRow(
          icon: Icons.school_outlined,
          label: 'Education',
          value: 'NIFT Pune',
          subValue: 'B.Des Fashion Design · 3rd Year',
        ),
        _InfoRow(
          icon: Icons.work_outline,
          label: 'Work as',
          value: 'Fashion Designer',
          subValue: 'Freelance · 2 yrs exp',
        ),
        _InfoRow(
          icon: Icons.bolt_outlined,
          label: 'Ambition level',
          value: 'HIGHLY DRIVEN',
        ),
      ],
    );
  }

  static buildLifestyleSection() {
    return _SectionCard(
      title: 'LIFESTYLE',
      children: [
        _InfoRow(
          icon: Icons.restaurant_outlined,
          label: 'Diet',
          value: 'Vegetarian',
        ),
        _InfoRow(
          icon: Icons.local_bar_outlined,
          label: 'Drinking',
          value: 'Socially',
        ),
        _InfoRow(
          icon: Icons.smoke_free_outlined,
          label: 'Smoking',
          value: 'Non-smoker',
        ),
        _InfoRow(
          icon: Icons.fitness_center_outlined,
          label: 'Fitness',
          value: 'Gym 4x/week',
        ),
      ],
    );
  }

  static buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text("INTERESTS",
              style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _InterestChip(
                label: 'Travel',
                icon: '✈️',
              ),
              _InterestChip(
                label: 'Coffee',
                icon: '☕',
              ),
              _InterestChip(
                label: 'Trekking',
                icon: '🏔️',
              ),
              _InterestChip(
                label: 'Books',
                icon: '📖',
              ),
              _InterestChip(
                label: 'Yoga',
                icon: '🧘',
              ),
              _InterestChip(
                label: 'Photography',
                icon: '📷',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static badge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subValue;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.pink,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subValue != null)
                Text(
                  subValue!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  final String icon;

  const _InterestChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}


class CustomError extends StatelessWidget {
  final String message;

  const CustomError({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftfl_assignment/core/widgets/widgets.dart';
import 'package:ftfl_assignment/modules/home/data/user_model.dart';
import 'package:ftfl_assignment/modules/home/domain/home_usecase.dart';
import 'package:ftfl_assignment/modules/home/view/home_bloc.dart';
import 'package:ftfl_assignment/modules/home/view/home_event.dart';
import 'package:ftfl_assignment/modules/home/view/home_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../injection/dependency_injection.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(
      LoadUsersEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        if (state is HomeLoading) {
          return const Scaffold(
            body: CustomLoader(),
          );
        }

        if (state is HomeError) {
          return Scaffold(
            body: CustomError(
              message: state.message,
            ),
          );
        }

        if (state is HomeLoaded) {
          return DiscoveryScreen(
            profiles: state.users,
          );
        }

        return const SizedBox();
      },
    );
  }
}

class DiscoveryScreen extends StatefulWidget {
  final List<dynamic> profiles;
  const DiscoveryScreen({super.key, required this. profiles});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {


  void _removeCard() {
    setState(() {
      if (widget.profiles.isNotEmpty) {
        widget.profiles.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.circle,
                size: 8,
                color: Colors.pink,
              ),
              const SizedBox(width: 8),
              Text(
                'Daily 25',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bolt),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: widget.profiles.isEmpty
          ? const Center(
        child: Text("No more profiles!"),
      )
          : RefreshIndicator(
        onRefresh: () async {
          context
              .read<HomeBloc>()
              .add(RefreshUsersEvent());
        },
            child: SingleChildScrollView(
              child: Column(
                      children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: widget.profiles.reversed.map((profile) {
                    final isTop =
                        widget.profiles.indexOf(profile) == 0;

                    return SwipeableCard(
                      profile: profile,
                      isTopCard: isTop,
                      onSwipeCompleted: _removeCard,
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                Widgets.badge('92% Match', Colors.blue),
                Widgets.badge('92% Trust', Colors.green),
                Widgets.badge('5m Replies', Colors.orange)
              ],),
              Widgets.buildAboutSection(),
              Widgets.buildBasicsSection(),
              Widgets.buildSelfCard('THE WAY TO WIN ME OVER IS...','A good book rec and a strong chai opinion.' ),
              Widgets.buildCareerSection(),
              Widgets.buildInterestsSection(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Image.network(
                              widget.profiles[0].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
              Widgets.buildSelfCard("We'll get along if ." , "You can debate for an hour and still want dessert" ),
               Widgets.buildLifestyleSection(),

                      ],
                    ),
            ),
          ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFF4B63),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Date Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Admirers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Events',
          ),
        ],
      ),
    );
  }
}

class SwipeableCard extends StatefulWidget {
  final UserModel profile;
  final bool isTopCard;
  final VoidCallback onSwipeCompleted;

  const SwipeableCard({
    super.key,
    required this.profile,
    required this.isTopCard,
    required this.onSwipeCompleted,
  });

  @override
  State<SwipeableCard> createState() =>
      _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isTopCard) return;

    setState(() {
      _offset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isTopCard) return;

    if (_offset.dx.abs() > 150) {
      _completeSwipe();
    } else {
      setState(() {
        _offset = Offset.zero;
      });
    }
  }

  void _completeSwipe() {
    widget.onSwipeCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final rotation = _offset.dx / 20;
    final opacity =
    (_offset.dx.abs() / 100).clamp(0.0, 1.0);

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _offset,
        child: Transform.rotate(
          angle: rotation * (math.pi / 180),
          child: ProfileCard(profile: widget.profile, offset : _offset ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final UserModel profile;
  final Offset offset;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    final opacity =
    (offset.dx.abs() / 100).clamp(0.0, 1.0);
    return Container(
      width: double.infinity,
      height: 480, // Optimized for mobile viewport
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile Image
            Image.network(
              profile.image,
              fit: BoxFit.cover,
            ),
                  if (offset.dx > 20)
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 4,
                              ),
                              borderRadius:
                              BorderRadius.circular(
                                  8),
                            ),
                            child: const Text(
                              'LIKE',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 32,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (offset.dx < -20)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.rotate(
                          angle: 0.2,
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 4,
                              ),
                              borderRadius:
                              BorderRadius.circular(
                                  8),
                            ),
                            child: const Text(
                              'NOPE',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 32,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

            // Bottom Gradient Overlay for Text Readability
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),

            // Profile Information Overlay
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Match & Trust Badges
                  Row(
                    children: [
                      _buildBadge(
                        '98',
                        'Match',
                        const Color(0xFF4B91FF),
                      ),
                      const SizedBox(width: 8),
                      _buildBadge(
                        '98',
                        'Trust',
                        const Color(0xFF4CAF50),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Name & Age
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          '${profile.fullName} ${profile.age}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.verified,
                        color: Color(0xFFFF4B63),
                        size: 24,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  _buildIconText(
                    Icons.location_on_outlined,
                    profile.country,
                  ),

                  const SizedBox(height: 4),

                  _buildIconText(
                    Icons.work_outline,
                    '${profile.fullName} · ${profile.fullName}',
                  ),

                  const SizedBox(height: 4),

                  _buildIconText(
                    Icons.favorite_outline,
                    profile.fullName,
                  ),
                ],
              ),
            ),

            // Undo / Refresh Button
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.replay,
                  color: Colors.black54,
                  size: 24,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black54,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(
      String value,
      String label,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
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
            '$value $label',
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

  Widget _buildIconText(
      IconData icon,
      String text,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white70,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}



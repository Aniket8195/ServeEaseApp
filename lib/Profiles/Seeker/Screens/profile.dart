import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/profile_model.dart';
import '../../../Theme/app_pallete.dart';
import '../bloc/seeker_bloc.dart';

class ProfileSeeker extends StatefulWidget {
  const ProfileSeeker({super.key});

  @override
  State<ProfileSeeker> createState() => _ProfileSeekerState();
}

class _ProfileSeekerState extends State<ProfileSeeker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SeekerBloc>().add(FetchProfile());
  }
  @override
  Widget build(BuildContext context) {

        return BlocConsumer<SeekerBloc, SeekerState>(
          listener: (context, state) {
            // Handle state changes if needed
          },
          builder: (context, state) {
            if(state is ProfileFetched){
              UserProfile userProfile = state.userProfile;

              return Scaffold(
                backgroundColor: AppPallete.backgroundColor,
                appBar: AppBar(
                  backgroundColor: AppPallete.surfaceColor,
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      color: AppPallete.primaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: AppPallete.primaryColor),
                      onPressed: () {
                        // Handle edit profile
                      },
                    ),
                  ],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Profile Header with Stats
                      Card(
                        elevation: 0,
                        color: AppPallete.surfaceColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: AppPallete.borderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              // Profile Picture
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppPallete.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://www.placecage.com/200/200', // Update with actual URL
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: AppPallete.primaryColor,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: AppPallete.elevatedButtonTextColor,
                                      ),
                                      onPressed: () {
                                        // Handle profile picture update
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Name and Basic Info
                              Text(
                                userProfile.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppPallete.primaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Email: ${userProfile.email}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppPallete.secondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Role: ${userProfile.role}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppPallete.secondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rating: ${userProfile.rating}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppPallete.secondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Stats Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatItem('Total Bookings', userProfile.totalBookings.toString()),
                                  _buildStatItem('Completed', userProfile.completedBookings.toString()),
                                  _buildStatItem('Active', userProfile.activeBookings.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Contact Information
                      _buildSection(
                        'Contact Information',
                        [
                          _buildInfoRow(Icons.email, userProfile.email),
                          // Add more contact info if necessary
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),

              ),
              body: Center(
                child: CircularProgressIndicator(

                ),
              ),
            );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppPallete.primaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppPallete.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      elevation: 0,
      color: AppPallete.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppPallete.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppPallete.primaryTextColor,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: AppPallete.primaryColor),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: AppPallete.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingItem(
      String serviceName,
      String date,
      String status,
      Color statusColor,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppPallete.surfaceColor,
        border: Border.all(color: AppPallete.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPallete.primaryTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              color: AppPallete.secondaryTextColor,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppPallete.secondaryTextColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppPallete.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
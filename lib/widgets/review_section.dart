import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  // Sample data. In a real app, you'd fetch this from an API or database.
  final List<Map<String, String>> reviews = const [
    {
      "avatarUrl": "https://via.placeholder.com/150",
      "userName": "Ananya Joshi",
      "roleLocation": "Owner, Calicut",
      "review": "You get an exclusive RM from PropConnect team who tracks your property closely"
    },
    {
      "avatarUrl": "https://via.placeholder.com/150",
      "userName": "Amit Sharma",
      "roleLocation": "Investor, Kochi",
      "review": "A wonderful experience. The platform is user-friendly and the team is super helpful!"
    },
    {
      "avatarUrl": "https://via.placeholder.com/150",
      "userName": "Arjun Patel",
      "roleLocation": "Owner,Kottayam",
      "review": "“Greate app for tenants and landlords.Everything in one place!”"
    },
    {
      "avatarUrl": "https://via.placeholder.com/150",
      "userName": "Sneha Iyer",
      "roleLocation": "Owner,Kannur",
      "review": "“Simple and intutive UI.Makes property hunting stress-feel”"
    },
    {
      "avatarUrl": "https://via.placeholder.com/150",
      "userName": "Vikram Reddy",
      "roleLocation": "Owner,Kochi",
      "review": "“Good App,but adding a wishlist feature would make it even better”"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What our users have to say...",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Horizontal scroll of review cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: screenWidth * 0.04),
          child: Row(
            children: reviews.map((review) {
              return _buildReviewCard(
                avatarUrl: review["avatarUrl"]!,
                userName: review["userName"]!,
                roleLocation: review["roleLocation"]!,
                reviewText: review["review"]!,
                screenWidth: screenWidth,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Each review card
  Widget _buildReviewCard({
    required String avatarUrl,
    required String userName,
    required String roleLocation,
    required String reviewText,
    required double screenWidth,
  }) {
    return Container(
      width: screenWidth * 0.8, // Adjust card width as needed
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x4D204ECF),
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Avatar + Name + Role/Location
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      roleLocation,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Review Text in quotes
          Text(
            '"$reviewText"',
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Colors.grey[800],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

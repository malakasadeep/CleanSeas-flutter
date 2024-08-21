import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final UserModel loggedInUser;
  const UserProfile({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("PROFILE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_rounded),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359554_1280.png",
                ),
              ),
              SizedBox(height: 5),
              Text(
                loggedInUser.fullName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(loggedInUser.email),
              Text(loggedInUser.userType),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "My Pollution Reportings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 119, 171),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 160,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // New card to be added as the first card
                  return SizedBox(
                    width: 140,
                    child: Card(
                      shadowColor: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/add.png',
                              width: 50,
                            ),
                            const SizedBox(height: 25),
                            Text(
                              "Report Marine Pollution",
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  final card = profileCompletionCards[index - 1];
                  return SizedBox(
                    width: 130,
                    child: Card(
                      shadowColor: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                card.image,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              card.title,
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length + 1,
            ),
          ),

          const SizedBox(height: 20),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(tile.icon),
                    title: Text(tile.title),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final String image;
  ProfileCompletionCard({
    required this.title,
    required this.image,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Mirissa Beach Pollution",
    image:
        "https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/3J4N2TCSX4I6ZA6S3HNLBYR3PY.jpg",
  ),
  ProfileCompletionCard(
    title: "Hikkaduwa Beach, Galle",
    image:
        "https://st2.depositphotos.com/4741801/9930/i/450/depositphotos_99307546-stock-photo-plastic-trash-on-beach.jpg",
  ),
  ProfileCompletionCard(
    title: "Panadura beach plastic waste",
    image:
        "https://archives1.dailynews.lk/sites/default/files/styles/node-detail/public/news/2017/11/16/z_p04-MARINE.jpg",
  ),
];

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.insights,
    title: "My Participations",
  ),
  CustomListTile(
    icon: Icons.favorite_outline_outlined,
    title: "Saved Articals",
  ),
  CustomListTile(
    title: "Notifications",
    icon: Icons.notifications_active_outlined,
  ),
  CustomListTile(
    title: "Logout",
    icon: Icons.logout_outlined,
  ),
];

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String username;

  // The constructor now properly uses the super key parameter.
  const HomePage({super.key, required this.username}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/page_header.png',
                height: 144,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 60,
                          color: Color.fromARGB(255, 111, 164, 130),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text('Logout'),  
                      style: ElevatedButton.styleFrom(
                        iconColor: const Color.fromARGB(255, 111, 164, 130),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Image.asset(
                'assets/home_page_pic.png',
                height: 370,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Take the quiz to know about your mental health status',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz1');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 111, 164, 130),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: const Text('Proceed',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
          Image.asset(
            'assets/page_footer.png',
            height: 81,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}

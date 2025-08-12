import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                const Expanded(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "My Website one of our main priorities is the privacy of our visitors. "
                      "This Privacy Policy document contains types of information that is collected and recorded by My Website and how we use it.\n",
                      style: TextStyle(
                          color: Colors.black87, fontSize: 14, height: 1.5),
                    ),
                    Text(
                      "If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.\n",
                      style: TextStyle(
                          color: Colors.black87, fontSize: 14, height: 1.5),
                    ),
                    Text(
                      "This privacy policy applies only to our online activities and is valid for visitors to our website "
                      "with regards to the information that they shared and/or collect in My Website. This policy is not applicable "
                      "to any information collected offline or via channels other than this website. Consent\n"
                      "By using our website, you hereby consent to ",
                      style: TextStyle(
                          color: Colors.black87, fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage()),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

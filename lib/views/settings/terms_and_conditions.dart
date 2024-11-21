import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restaurant_vendor_app/widgets/CustomCircularProgressIndicator.dart';

class TermsAndConditionView extends StatelessWidget {
  const TermsAndConditionView({super.key});

Future<Map<String, String>?> fetch() async {
  final dio.Dio _dio = dio.Dio();
  try {
    final response = await _dio.get("$host/terms/");
    if (response.statusCode == 200 && response.data != null) {
      final data = response.data as Map<String, dynamic>;
      final result = data.map((key, value) => MapEntry(key.toString(), value.toString()));
      return result;
    }
  } catch (error) {
    if (kDebugMode) {
      print("error fetching terms and conditions data : $error");
    }
  }
  return null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: const Color.fromRGBO(73, 73, 73, 1),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromRGBO(218, 218, 218, 1),
            height: 1.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetch(),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Failed to Fetch data",
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              );
            }
            final data = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
              itemCount: data!.entries.length,
              itemBuilder: (context, index) {
                final entry = data.entries.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "${index + 1}. ${entry.key}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: const Color.fromRGBO(73, 73, 73, 1),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      entry.value,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color.fromRGBO(73, 73, 73, 1),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      ),
    );
  }
}
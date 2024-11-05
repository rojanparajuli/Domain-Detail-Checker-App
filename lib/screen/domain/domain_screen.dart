import 'package:domain_checker/bloc/domain_name/domain_name_bloc.dart';
import 'package:domain_checker/bloc/domain_name/domain_name_event.dart';
import 'package:domain_checker/bloc/domain_name/domain_name_state.dart';
import 'package:domain_checker/model/domain_name_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class DomainSearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  DomainSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Domain Search",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter domain name",
                filled: true,
                fillColor: Colors.grey[100],
                labelStyle: const TextStyle(color: Colors.deepPurpleAccent),
                suffixIcon: IconButton(
                  icon:
                      const Icon(Icons.search, color: Colors.deepPurpleAccent),
                  onPressed: () {
                    final domainName = _controller.text;
                    if (domainName.isNotEmpty) {
                      if (domainName.contains('.')) {
                        context
                            .read<DomainBloc>()
                            .add(SearchDomainEvent(domainName));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid domain name."),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    }
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 146, 144, 144)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 146, 144, 144)), 
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 146, 144, 144)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<DomainBloc, DomainState>(
                builder: (context, state) {
                  if (state is DomainLoading) {
                    return Center(
                      child: SizedBox(
                        height: 400,
                        width: 400,
                        child: Lottie.asset('assets/loading.json'),
                      ),
                    );
                  } else if (state is DomainLoaded) {
                    return _buildDomainList(state.domainName.domains);
                  } else if (state is DomainError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 16),
                      ),
                    );
                  }
                  return const Center(child: Text("Enter a domain to search"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainList(List<Domain>? domains) {
    if (domains == null || domains.isEmpty) {
      return const Center(child: Text("No domains found"));
    }
    return ListView.builder(
      itemCount: domains.length,
      itemBuilder: (context, index) {
        final domain = domains[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          shadowColor: Colors.deepPurpleAccent.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurpleAccent.withOpacity(0.2),
                  Colors.deepPurpleAccent.withOpacity(0.05)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  domain.domain ?? "N/A",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 10),
                _buildDetailRow(
                    "Create Date:", domain.createDate?.toIso8601String()),
                _buildDetailRow(
                    "Update Date:", domain.updateDate?.toIso8601String()),
                _buildDetailRow("Country:", domain.country),
                _buildDetailRow(
                    "Is Dead:", domain.isDead != null ? "Yes" : "No"),
                _buildDetailRow("A Records:", domain.a?.join(', ')),
                _buildDetailRow("NS Records:", domain.ns?.join(', ')),
                _buildDetailRow("CNAME Records:", domain.cname?.join(', ')),
                _buildDetailRow("MX Records:", domain.mx?.join(', ')),
                _buildDetailRow("TXT Records:", domain.txt?.join(', ')),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.deepPurpleAccent),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

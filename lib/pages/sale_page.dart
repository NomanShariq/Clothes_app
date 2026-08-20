import 'package:clothing_app/pages/product_detail.dart';
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:flutter/material.dart';

enum PriceFilter { all, under5k, range5to10k, above10k }

class SalePage extends StatefulWidget {
  final List<ProductCardData> products;

  const SalePage({Key? key, required this.products}) : super(key: key);

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _searchQuery = "";
  String _selectedGender = "All";
  PriceFilter _selectedPrice = PriceFilter.all;

  List<ProductCardData> get _filteredProducts {
    return widget.products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesGender = _selectedGender == "All" ||
          product.image.toLowerCase().contains(_selectedGender.toLowerCase());

      bool matchesPrice;
      switch (_selectedPrice) {
        case PriceFilter.under5k:
          matchesPrice = product.price < 5000;
          break;
        case PriceFilter.range5to10k:
          matchesPrice = product.price >= 5000 && product.price <= 10000;
          break;
        case PriceFilter.above10k:
          matchesPrice = product.price > 10000;
          break;
        case PriceFilter.all:
          matchesPrice = true;
          break;
      }

      return matchesSearch && matchesGender && matchesPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredProducts;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "Sale",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: "Search sale items...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor ??
                    Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ["All", "Ladies", "Gents", "Kids"].map((gender) {
                final isSelected = _selectedGender == gender;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(gender),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedGender = gender),
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Theme.of(context).cardColor,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _priceChip(context, "All Prices", PriceFilter.all),
                _priceChip(context, "Under Rs 5,000", PriceFilter.under5k),
                _priceChip(
                    context, "Rs 5,000 - 10,000", PriceFilter.range5to10k),
                _priceChip(context, "Above Rs 10,000", PriceFilter.above10k),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Text(
                      "No items match your filters",
                      style: TextStyle(color: primaryColor),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.62,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: results[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(product: results[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _priceChip(BuildContext context, String label, PriceFilter value) {
    final isSelected = _selectedPrice == value;
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _selectedPrice = value),
        selectedColor: Colors.black,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : primaryColor,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}

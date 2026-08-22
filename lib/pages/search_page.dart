import 'package:clothing_app/models/wishlist.dart';
import 'package:clothing_app/pages/product_detail.dart';
import 'package:clothing_app/widgets/home/product_card.dart';
import 'package:clothing_app/widgets/smart_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final List<ProductCardData> allProducts;

  const SearchPage({Key? key, required this.allProducts}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = "";
  bool _submitted = false;

  final List<String> _popularSearches = [
    "Dresses",
    "Suits",
    "Kurtas",
    "Watches",
    "Shirts",
    "Accessories"
  ];

  List<String> _recentSearches = [
    "Embroidered Suit",
    "Black Kurta",
    "Luxury Watch"
  ];

  List<ProductCardData> get _suggestions {
    if (_query.isEmpty) return [];
    return widget.allProducts
        .where((p) => p.title.toLowerCase().contains(_query.toLowerCase()))
        .take(5)
        .toList();
  }

  List<ProductCardData> get _results {
    if (_query.isEmpty) return [];
    return widget.allProducts
        .where((p) => p.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  void _runSearch(String value) {
    setState(() {
      _query = value;
      _submitted = value.isNotEmpty;
      if (value.isNotEmpty && !_recentSearches.contains(value)) {
        _recentSearches = [value, ..._recentSearches].take(5).toList();
      }
    });
  }

  void _selectChip(String value) {
    _controller.text = value;
    _runSearch(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;
    final surfaceColor = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: SizedBox(
            height: 42,
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: (value) => setState(() {
                _query = value;
                _submitted = false;
              }),
              onSubmitted: _runSearch,
              style: TextStyle(color: primaryColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Search products...",
                hintStyle: TextStyle(color: grayText, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: grayText, size: 20),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close, color: grayText, size: 18),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            _query = "";
                            _submitted = false;
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: surfaceColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: goldColor),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_query.isEmpty) return _buildInitialState(context);
    if (!_submitted) return _buildSuggestionsState(context);
    return _results.isEmpty
        ? _buildEmptyState(context)
        : _buildResultsState(context);
  }

  Widget _buildInitialState(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "POPULAR SEARCHES",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: grayText),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _popularSearches.map((label) {
              return GestureDetector(
                onTap: () => _selectChip(label),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(label,
                      style: TextStyle(fontSize: 13, color: primaryColor)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          if (_recentSearches.isNotEmpty) ...[
            Text(
              "RECENT SEARCHES",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                  color: grayText),
            ),
            const SizedBox(height: 8),
            for (final term in _recentSearches)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.history, size: 20, color: grayText),
                title: Text(term,
                    style: TextStyle(fontSize: 14, color: primaryColor)),
                trailing: GestureDetector(
                  onTap: () => setState(() => _recentSearches.remove(term)),
                  child: Icon(Icons.close, size: 18, color: grayText),
                ),
                onTap: () => _selectChip(term),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildSuggestionsState(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    if (_suggestions.isEmpty) {
      return Center(
        child: Text("No suggestions",
            style: TextStyle(color: grayText, fontSize: 13)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        final product = _suggestions[index];
        return ListTile(
          leading: Icon(Icons.search, size: 18, color: grayText),
          title: Text(product.title,
              style: TextStyle(fontSize: 14, color: primaryColor)),
          onTap: () {
            _controller.text = product.title;
            _runSearch(product.title);
          },
        );
      },
    );
  }

  Widget _buildResultsState(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final results = _results;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            'Search results for "$_query"',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${results.length} Products",
                  style: TextStyle(fontSize: 12, color: grayText)),
              Row(
                children: [
                  _pillButton(context, Icons.sort, "Sort"),
                  const SizedBox(width: 8),
                  _pillButton(context, Icons.tune, "Filter"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              final product = results[index];
              return _SearchResultCard(
                product: product,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(product: product)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _pillButton(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final borderColor = theme.dividerTheme.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: primaryColor)),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final goldColor = theme.colorScheme.secondary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off,
                size: 70, color: goldColor.withValues(alpha: 0.5)),
            const SizedBox(height: 20),
            Text("No products found",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor)),
            const SizedBox(height: 8),
            Text(
              "Try searching for another product or category.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: grayText),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Continue Shopping",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final ProductCardData product;
  final VoidCallback onTap;

  const _SearchResultCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final wishlist = Provider.of<Wishlist>(context);
    final isWishlisted = wishlist.isWishlisted(product.title);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SmartImage(path: product.image, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => wishlist.toggle(product.title, product),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? Colors.red : Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: primaryColor),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "Rs ${product.price.toStringAsFixed(0)}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              if (product.isOnSale) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "Rs ${product.originalPrice!.toStringAsFixed(0)}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11,
                        color: grayText,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

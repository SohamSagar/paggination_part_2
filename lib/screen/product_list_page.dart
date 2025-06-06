import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:paggination_part_2/models/product_model.dart';
import 'package:paggination_part_2/services/product_service.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  static const _pageSize = 10;

  late final _pagingController = PagingController<int, Product>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) => fetchProducts(pageKey, _pageSize),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paginated Products')),
      body: PagingListener(
        controller: _pagingController,
        builder: (context, state, fetchNextPage) => PagedListView<int, Product>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, product, index) {
              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 300 + index * 30),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)), // Slide from bottom
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.lightBlue.withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${product.title}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) =>
            const Center(child: Text('No products found.')),
            firstPageErrorIndicatorBuilder: (_) =>
            const Center(child: Text('Error loading products.')),
            newPageErrorIndicatorBuilder: (_) =>
            const Center(child: Text('Failed to load more.')),
          ),
        ),
      ),
    );
  }
}

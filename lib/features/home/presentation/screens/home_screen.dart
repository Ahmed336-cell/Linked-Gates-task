import 'package:apitask/features/home/presentation/cubit/product_cubit.dart';
import 'package:apitask/features/home/presentation/cubit/product_state.dart';
import 'package:apitask/features/home/presentation/screens/widgets/product_item.dart';
import 'package:apitask/features/home/presentation/screens/widgets/product_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Discover", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (state is ProductLoading) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: 8,
                separatorBuilder: (_, __) => SizedBox(height: 4),
                itemBuilder: (context, index) => ShimmerProductListItem(),
              );
            } else if (state is ProductFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        state.error,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductCubit>().fetchProducts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text("Try Again",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            } else if (state is ProductSuccess) {
              if (state.products.isEmpty) {
                return Center(child: Text("No products available."));
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: state.products.length,
                separatorBuilder: (_, __) => SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductListItem(
                    imageUrl: product.images.isNotEmpty ? product.images[0] : product.category.image,
                    title: product.title,
                    price: "${product.price} EGP",
                    rating: 4.8,
                    isFavorite: false,
                  );
                },
              );
            } else {
              return Center(child: Text("No Data Available"));
            }
          },
        );
      }),
    );
  }
}






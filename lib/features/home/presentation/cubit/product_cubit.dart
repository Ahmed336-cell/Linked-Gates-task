import 'package:apitask/features/home/domain/usecases/get_products.dart';
import 'package:apitask/features/home/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;

  ProductCubit(this.getProducts) : super(ProductInitial());

  void fetchProducts() async {
    emit(ProductLoading());

    final result = await getProducts();

    result.fold(
      (failure) => emit(ProductFailure(failure.errMessage)),
      (products) => emit(ProductSuccess(products)),
    );
  }
}
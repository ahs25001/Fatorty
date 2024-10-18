import 'package:fatorty/models/product_model.dart';
import 'package:fatorty/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'item_field.dart';

class ProductItem extends StatelessWidget {
  ProductModel productModel;
Function onDelete;
  ProductItem(this.productModel,this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
            backgroundColor: redColor,
            label: "Delete",
            onPressed: (context) {
              onDelete();
            }, icon: Icons.delete)
      ]),
      child: Table(
        border: TableBorder.all(
          color: redColor,
          width: 2,
        ),
        children: [
          TableRow(
            children: [
              ItemField(
                  label: "Product Name",
                  onSubmit: () {
                    FocusScope.of(context)
                        .requestFocus(productModel.priceFocusNode);
                  },
                  controller: productModel.nameController,
                  focusNode: productModel.nameFocusNode),
              ItemField(
                  isDouble: true,
                  label: "Product Price",
                  onSubmit: () {
                    FocusScope.of(context)
                        .requestFocus(productModel.quantityFocusNode);
                  },
                  controller: productModel.priceController,
                  focusNode: productModel.priceFocusNode),
              ItemField(
                  isDouble: true,
                  label: "Quantity",
                  onSubmit: () {
                    FocusScope.of(context).unfocus();
                  },
                  controller: productModel.quantityController,
                  focusNode: productModel.quantityFocusNode),
            ],
          ),
        ],
      ),
    );
  }
}

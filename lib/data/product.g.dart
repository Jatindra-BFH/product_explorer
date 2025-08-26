// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[4] as double,
      category: fields[3] as String?,
      discountPercentage: fields[5] as double?,
      rating: fields[6] as double?,
      tags: (fields[7] as List?)?.cast<String>(),
      warrantyInformation: fields[8] as String?,
      shippingInformation: fields[9] as String?,
      images: (fields[10] as List?)?.cast<String>(),
      thumbnail: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.discountPercentage)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.warrantyInformation)
      ..writeByte(9)
      ..write(obj.shippingInformation)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

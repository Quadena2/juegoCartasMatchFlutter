// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelo_vocabulario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModeloVocabularioAdapter extends TypeAdapter<ModeloVocabulario> {
  @override
  final int typeId = 0;

  @override
  ModeloVocabulario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModeloVocabulario(
      id: fields[0] as String,
      rutaImagen: fields[1] as String,
      traducciones: (fields[2] as Map).cast<String, String>(),
      idCategoria: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModeloVocabulario obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rutaImagen)
      ..writeByte(2)
      ..write(obj.traducciones)
      ..writeByte(3)
      ..write(obj.idCategoria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModeloVocabularioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

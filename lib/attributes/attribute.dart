import 'package:userx_flutter/attributes/attribute_value_type.dart';
import 'package:userx_flutter/attributes/attribute_kind.dart';
import 'package:userx_flutter/attributes/attribute_action.dart';

class Attribute {
  final String name;
  final dynamic value;
  final AttributeValueType valueType;
  final AttributeKind kind;
  final AttributeAction action;

  Attribute._(
      {required this.name,
      required this.value,
      required this.valueType,
      required this.kind,
      required this.action});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "value": value,
      "valueType": valueType.toString(),
      "kind": kind.toString(),
      "action": action.toString()
    };
  }

  factory Attribute.bool(String name, {required bool value}) {
    return Attribute._(
        name: name,
        value: value,
        valueType: AttributeValueType.bool,
        kind: AttributeKind.simple,
        action: AttributeAction.set);
  }

  factory Attribute.int(String name, {required int value}) {
    return Attribute._(
        name: name,
        value: value,
        valueType: AttributeValueType.int,
        kind: AttributeKind.simple,
        action: AttributeAction.set);
  }

  factory Attribute.double(String name, {required double value}) {
    return Attribute._(
        name: name,
        value: value,
        valueType: AttributeValueType.double,
        kind: AttributeKind.simple,
        action: AttributeAction.set);
  }

  factory Attribute.string(String name, {required String value}) {
    return Attribute._(
        name: name,
        value: value,
        valueType: AttributeValueType.string,
        kind: AttributeKind.simple,
        action: AttributeAction.set);
  }

  factory Attribute.counter(String name, {int value = 0}) {
    return Attribute._(
        name: name,
        value: value,
        valueType: AttributeValueType.int,
        kind: AttributeKind.counter,
        action: AttributeAction.set);
  }

  factory Attribute.increasedCounter(String name, {int incValue = 1}) {
    return Attribute._(
        name: name,
        value: incValue,
        valueType: AttributeValueType.int,
        kind: AttributeKind.counter,
        action: AttributeAction.inc);
  }

  factory Attribute.decreasedCounter(String name, {int decValue = 1}) {
    return Attribute._(
        name: name,
        value: decValue,
        valueType: AttributeValueType.int,
        kind: AttributeKind.counter,
        action: AttributeAction.dec);
  }
}

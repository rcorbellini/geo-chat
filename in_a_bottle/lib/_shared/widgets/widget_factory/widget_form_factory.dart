import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/utils.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_button.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_date_range.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_slider.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_switch.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_text_field.dart';

class WidgetFormFactory<T> {
  final BaseBloc bloc;
  final BuildContext context;

  WidgetFormFactory({
    @required this.bloc,
    @required this.context,
  })  : assert(bloc != null),
        assert(context != null);

  Widget createdByEnum(T enumValue, {Map parameters}) {
    if (!isEnum(enumValue)) {
      throw Exception('Only enums allowed');
    }

    final stringValue = enumToString(enumValue);

    if (stringValue.startsWith(enumToString(EnumPrefix.text))) {
      return WidgetTextField<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<TextFieldParameter, dynamic>,
      );
    }
    if (stringValue.startsWith(enumToString(EnumPrefix.action))) {
      return WidgetButton<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<String, dynamic>,
      );
    }
    if (stringValue.startsWith(enumToString(EnumPrefix.dateRange))) {
      return WidgetDateRange<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<DateRangeParameter, dynamic>,
      );
    }

    if (stringValue.startsWith(enumToString(EnumPrefix.bool))) {
      return WidgetSwitch<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<String, dynamic>,
      );
    }

    if (stringValue.startsWith(enumToString(EnumPrefix.slider))) {
      return WidgetSlider<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<SliderParameter, dynamic>,
      );
    }

    return const Text("Widget Not found :[");
  }
}

extension EnumKey on Object {
  String toYamlKey() {
    return toString()
        .replaceFirst(enumToString(EnumPrefix.action), '')
        .replaceFirst(enumToString(EnumPrefix.text), '')
        .replaceFirst(enumToString(EnumPrefix.dateRange), '')
        .replaceFirst(enumToString(EnumPrefix.bool), '')
        .replaceFirst(enumToString(EnumPrefix.slider), '');
  }
}


enum EnumPrefix { action, text, dateRange, bool, slider }
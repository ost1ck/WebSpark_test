import 'package:flutter/material.dart';
import 'package:webspark_test_task/core/constants/app_colors.dart';

enum CellType {
  start(AppColors.start),
  end(AppColors.end),
  blocked(AppColors.blocked),
  path(AppColors.path),
  empty(AppColors.empty);

  const CellType(this.color);

  final Color color;
}

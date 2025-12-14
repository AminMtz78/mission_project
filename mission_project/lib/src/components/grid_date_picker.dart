import 'package:flutter/material.dart';

enum PickerMode { day, month, year }

class GridDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;

  const GridDatePicker({
    super.key,
    this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<GridDatePicker> createState() => _GridDatePickerState();
}

class _GridDatePickerState extends State<GridDatePicker> {
  late int selectedYear;
  late int selectedMonth;
  int? selectedDay;
  PickerMode mode = PickerMode.day;

  @override
  void initState() {
    super.initState();
    final now = widget.initialDate ?? DateTime.now();
    selectedYear = now.year;
    selectedMonth = now.month;
    selectedDay = now.day;
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _selectDay(int day) {
    setState(() {
      selectedDay = day;
    });
    widget.onDateSelected(DateTime(selectedYear, selectedMonth, selectedDay!));
  }

  void _selectMonth(int month) {
    setState(() {
      selectedMonth = month;
      selectedDay = null; // ریست روز
      mode = PickerMode.day;
    });
  }

  void _selectYear(int year) {
    setState(() {
      selectedYear = year;
      selectedDay = null; // ریست روز
      mode = PickerMode.month;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget gridContent;

    switch (mode) {
      case PickerMode.day:
        final days = _daysInMonth(selectedYear, selectedMonth);
        gridContent = _buildGrid(
          itemCount: days,
          builder: (index) => _buildDayItem(index + 1),
        );
        break;

      case PickerMode.month:
        gridContent = _buildGrid(
          itemCount: 12,
          builder: (index) => _buildMonthItem(index + 1),
        );
        break;

      case PickerMode.year:
        final currentYear = DateTime.now().year;
        final startYear = currentYear - 50;
        gridContent = _buildGrid(
          itemCount: 100,
          builder: (index) => _buildYearItem(startYear + index),
        );
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header برای تغییر mode
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  mode = PickerMode.year;
                });
              },
              child: Text("$selectedYear"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  mode = PickerMode.month;
                });
              },
              child: Text(selectedMonth.toString().padLeft(2, '0')),
            ),
            if (mode == PickerMode.day)
              Text(
                selectedDay != null ? selectedDay.toString() : "--",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
        const SizedBox(height: 12),
        // Grid اصلی
        Expanded(child: gridContent),
      ],
    );
  }

  Widget _buildGrid({required int itemCount, required Widget Function(int) builder}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => builder(index),
    );
  }

  Widget _buildDayItem(int day) {
    final isSelected = day == selectedDay;
    return GestureDetector(
      onTap: () => _selectDay(day),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          day.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildMonthItem(int month) {
    final isSelected = month == selectedMonth;
    return GestureDetector(
      onTap: () => _selectMonth(month),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          month.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildYearItem(int year) {
    final isSelected = year == selectedYear;
    return GestureDetector(
      onTap: () => _selectYear(year),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          year.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

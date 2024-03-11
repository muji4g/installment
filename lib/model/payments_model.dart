class Payments {
  final String paymenttype;
  bool isSelected;

  Payments({
    required this.paymenttype,
    required this.isSelected,
  });
}

List<Payments> paymentslist = [
  Payments(paymenttype: 'All', isSelected: true),
  Payments(paymenttype: 'Pending', isSelected: false),
  Payments(paymenttype: 'Paid', isSelected: false),
  Payments(paymenttype: 'Completed', isSelected: false),
];

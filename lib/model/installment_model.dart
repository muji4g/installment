class InstallmentModel {
  final String installmentName;
  final num months;
  final num downPayment;
  final num monthlyInstallment;

  InstallmentModel(
      {required this.installmentName,
      required this.downPayment,
      required this.months,
      required this.monthlyInstallment});
}

List<InstallmentModel> installmentModel = [
  // InstallmentModel(
  //     installmentName: 'Iphone Installment',
  //     downPayment: 10000,
  //     months: 3,
  //     monthlyInstallment: 10000),
  // InstallmentModel(
  //     installmentName: 'Iphone Installment',
  //     downPayment: 30000,
  //     months: 3,
  //     monthlyInstallment: 20000),
];

class CustomerDetails {
  final String customerName;
  final String customerID;
  final String customerAddress;
  final String order;
  final String quantity;
  final String customerNIC;
  final String customerContact;
  final String customerEmail;
  final String installmentDuration;
  final String customerPassword;

  CustomerDetails({
    required this.customerName,
    required this.customerID,
    required this.customerAddress,
    required this.customerContact,
    required this.customerEmail,
    required this.customerNIC,
    required this.quantity,
    required this.order,
    required this.installmentDuration,
    required this.customerPassword,
  });

  // toJson() {
  //   return {
  //     "Full Name": customerName,
  //     "Email": customerEmail,
  //     "Address": customerAddress,
  //     " NIC": customerNIC,
  //     "Contact": customerContact,
  //     "Password": customerPassword,
  //   };
  // }
}

List<CustomerDetails> detailsList = [
  CustomerDetails(
      customerName: '',
      customerID: '',
      customerAddress: '',
      customerContact: '',
      customerEmail: '115120',
      customerNIC: '',
      quantity: '',
      order: '',
      installmentDuration: '',
      customerPassword: '')
];

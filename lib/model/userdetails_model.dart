class CustomerDetails {
  final String customerName;
  final String customerID;
  final String customerAddress;
  final String order;
  final String quantity;
  final String customerNIC;
  final String customerContact;
  final String customerEmail;
  final num installmentDuration;

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
  });
}

List<CustomerDetails> detailsList = [
  CustomerDetails(
      customerName: 'JohnWick',
      installmentDuration: 0,
      customerID: '6352186548154',
      customerAddress: 'Islamabad I-10',
      customerContact: '+92 357318581581',
      customerEmail: 'johnwick@gmail.com',
      order: 'Iphone 15 128GB',
      quantity: '1',
      customerNIC: '3106-5713518538-6')
];

class customermodel {
  final String customerName;
  final String customerID;
  final String customerAddress;
  final String statustype;
  final String status;
  bool isPaid = true;
  bool isPending = true;
  bool isOverdue = true;
  final String customerNIC;
  final String customerContact;
  final String customerEmail;
  final String? order;
  final num? quantity;

  customermodel({
    required this.customerName,
    required this.customerID,
    required this.customerAddress,
    required this.statustype,
    required this.status,
    this.order,
    this.quantity,
    required this.isPaid,
    required this.isPending,
    required this.isOverdue,
    required this.customerContact,
    required this.customerEmail,
    required this.customerNIC,
  });
}

List<customermodel> customerList = [
  customermodel(
    customerName: 'Customer Name',
    customerID: '7353528358',
    customerAddress: 'Islamabad I-10 ',
    statustype: 'Pending',
    customerContact: '+92-357318581581',
    customerEmail: 'johnwick@gmail.com',
    customerNIC: '3106-5713518538-6',
    isPaid: false,
    isPending: true,
    isOverdue: false,
    status: 'pending',
  ),
  customermodel(
    customerName: 'customerName',
    customerID: '7353528358',
    customerAddress: 'Islamabad I-10 ',
    statustype: 'Paid 12 April,2023',
    status: 'paid',
    customerContact: '+92-357318581581',
    customerEmail: 'johnwick@gmail.com',
    customerNIC: '3106-5713518538-6',
    isPaid: true,
    isOverdue: false,
    isPending: false,
  ),
  customermodel(
    customerName: 'customerName',
    customerID: '7353528358',
    customerAddress: 'Islamabad I-10 ',
    statustype: 'OverDue',
    status: 'overdue',
    customerContact: '+92-357318581581',
    customerEmail: 'johnwick@gmail.com',
    customerNIC: '3106-5713518538-6',
    isPaid: false,
    isOverdue: true,
    isPending: false,
  ),
];

class CustomerModeldeactive {
  final String customerName;
  final String customerID;
  final String customerAddress;
  final String status;
  CustomerModeldeactive({
    required this.customerName,
    required this.customerID,
    required this.customerAddress,
    required this.status,
  });
}

List<CustomerModeldeactive> deactivecustomerList = [
  CustomerModeldeactive(
    customerName: 'customerName',
    customerID: '55332556',
    customerAddress: 'Islamabad I-10 ',
    status: 'deactive',
  ),
  CustomerModeldeactive(
      customerName: 'customerName',
      customerID: '3364526',
      customerAddress: 'Islamabad I-10 ',
      status: 'deactive'),
  CustomerModeldeactive(
      customerName: 'customerName',
      customerID: '3364336',
      customerAddress: 'Islamabad I-10 ',
      status: 'deactive'),
];

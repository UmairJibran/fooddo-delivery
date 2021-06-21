class Assignment {
  final String id;
  final String donationId;
  final String donorContact;
  final String pickUpAddress;
  final int servings;
  final String date;
  final Map<String, dynamic> longlat;
  final bool seen;

  Assignment({
    this.id,
    this.donationId,
    this.donorContact,
    this.pickUpAddress,
    this.servings,
    this.date,
    this.longlat,
    this.seen
  });
}

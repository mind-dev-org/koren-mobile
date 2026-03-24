class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final String? avatarUrl;
  final int? pointsBalance;
  final String? loyaltyTier;
  final String? googleId;
  final String? appleId;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    this.avatarUrl,
    this.pointsBalance,
    this.loyaltyTier,
    this.googleId,
    this.appleId,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) {
    return UserModel(
      id: j['id'] as int,
      name: j['name'] as String,
      email: j['email'] as String? ?? '',
      phone: j['phone'] as String?,
      role: j['role'] as String? ?? 'user',
      avatarUrl: j['avatar_url'] as String?,
      pointsBalance: j['points_balance'] as int?,
      loyaltyTier: j['loyalty_tier'] as String?,
      googleId: j['google_id'] as String?,
      appleId: j['apple_id'] as String?,
    );
  }

  bool get isOAuthUser => googleId != null || appleId != null;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../services/google_ads.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  User? get user => auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Color(0xffeac056),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Gokceada'),
            accountEmail: _userUid(),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
                    child: Image.asset(
              'images/gokceadapp.jpg',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ))),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/nbbackground.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          NavBarListTile(
              title: 'neredeYenir'.tr(),
              icon: Icons.fastfood,
              path: () {
                context.read<GoogleAds>().loadInterstitialAd();
                Navigator.of(context).popAndPushNamed('/foodareas');
              }),
          NavBarListTile(
              title: 'gormeyeDeger'.tr(),
              icon: Icons.remove_red_eye_outlined,
              path: () => Navigator.of(context).popAndPushNamed('/gezilecek')),
          NavBarListTile(
              title: 'aktiviteler'.tr(),
              icon: Icons.surfing,
              path: () => Navigator.of(context).popAndPushNamed('/activities')),
          NavBarListTile(
              title: 'atm'.tr(),
              icon: Icons.atm,
              path: () => Navigator.of(context).popAndPushNamed('/atm')),
          NavBarListTile(
              title: 'koyler'.tr(),
              icon: Icons.holiday_village_outlined,
              path: () => Navigator.of(context).popAndPushNamed('/koyler')),
          NavBarListTile(
              title: 'otobusSaatleri'.tr(),
              icon: Icons.directions_bus,
              path: () {
                context.read<GoogleAds>().loadInterstitialAd();
                Navigator.of(context).popAndPushNamed('/bus');
              }),
          NavBarListTile(
              title: 'feribotSaatleri'.tr(),
              icon: Icons.directions_ferry,
              path: () {
                context.read<GoogleAds>().loadInterstitialAd();
                Navigator.of(context).popAndPushNamed('/fery');
              }),
          NavBarListTile(
              title: 'hediyelikEsyalar'.tr(),
              icon: Icons.card_giftcard_outlined,
              path: () => Navigator.of(context).popAndPushNamed('/hediyelik')),
          NavBarListTile(
              title: 'tavsiyeler'.tr(),
              icon: Icons.recommend_rounded,
              path: () => Navigator.of(context).popAndPushNamed('/advices')),
          NavBarListTile(
              title: 'iletisim'.tr(),
              icon: Icons.comment_outlined,
              path: () => Navigator.of(context).popAndPushNamed('/iletisim')),
          NavBarListTile(
              title: 'sizinGozunuzdenAda'.tr(),
              icon: CupertinoIcons.eye,
              path: () =>
                  Navigator.of(context).popAndPushNamed('/usersConsole')),
          const Divider(),
          if (user != null)
            ListTile(
              leading: Icon(Icons.delete_forever_outlined,
                  color: Colors.red.shade400),
              title: Text('hesabiSil'.tr(),
                  style: TextStyle(color: Colors.red.shade400)),
              onTap: () => _confirmDeleteAccount(context),
            ),
          _signOutButton(context),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('hesabiSil'.tr()),
        content: Text('hesapSilOnay'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('vazgec'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('sil'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _deleteAccount(context);
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final u = auth.currentUser;
    if (u == null) return;
    final uid = u.uid;
    try {
      // Best-effort: remove the user's profile document, then the auth account.
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      if (GoogleSignIn().currentUser != null) {
        await GoogleSignIn().disconnect();
      }
      await u.delete();
      await auth.signOut();
      if (!context.mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/homepage', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('hesapSilindi'.tr())),
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      final msg = e.code == 'requires-recent-login'
          ? 'hesapSilTekrarGiris'.tr()
          : (e.message ?? 'hesapSilTekrarGiris'.tr());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  Widget _userUid() {
    return Text(user?.email ?? 'Gokceada');
  }

  void signOut() async {
    var user = GoogleSignIn().currentUser;
    if (user != null) {
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
    }
    await auth.signOut();
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(elevation: 10),
      onPressed: () {
        signOut();
        Navigator.pop(context);
        setState(() {
          _userUid();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('cikisYapildi'.tr()),
          ),
        );
      },
      child: Text('signOut'.tr()),
    );
  }
}

class NavBarListTile extends StatelessWidget {
  const NavBarListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.path,
  });

  final IconData icon;
  final String title;
  final void Function() path;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: path,
    );
  }
}

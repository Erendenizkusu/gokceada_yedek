import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/plajlarMap.dart';


class PlajlarView extends StatefulWidget {
  const PlajlarView({super.key});

  @override
  State<PlajlarView> createState() => _PlajlarViewState();
}

class _PlajlarViewState extends State<PlajlarView> {
  final List<PlajCard> _plajList = [
    const PlajCard(path: 'images/yildizkoy/yildizkoy2.jpg', name: 'Yıldızkoy', description: 'Türkiye\'nin ilk ve tek su altı milli parkı',navigator: 'yildizkoy'),
    const PlajCard(path: 'images/kefalos/kefalos1.jpg', name: 'Kefalos', description: 'İnce kum taneleri, berrak deniz ve surfing alanları',navigator: 'kefalos'),
    const PlajCard(path: 'images/lazkoyu/lazkoyu.jpg', name: 'Laz Koyu', description: 'Güney kıyısında ufak bir kumsal koy',navigator: 'lazkoyu'),
    const PlajCard(path: 'images/gizliliman/gizliliman.jpg', name: 'Gizli Liman', description: 'Ada\'nın en batı ucu ve mağara',navigator: 'gizliliman'),
    const PlajCard(path: 'images/kuzulimani/kuzulimanı1.jpg', name: 'Kuzu Limanı', description: 'Feribotun yanaştığı limanın yanında geniş,kumluk bir plaj',navigator: 'kuzulimanı'),
    const PlajCard(path: 'images/marmaros/marmaros.jpg', name: 'Marmaros', description: 'Orman\'ın derinliklerinde sizi karşılayan taşlık bir koy',navigator: 'marmaros'),

  ];
  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Scaffold(
      backgroundColor: c.salt,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: c.titleColor),
        ),
        title: Text('plajlar'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            itemCount: _plajList.length,
            itemBuilder: (context, index) {
              return PlajCard(
                  path: _plajList[index].path,
                  name: _plajList[index].name,
                  description: _plajList[index].description,
                  navigator: _plajList[index].navigator);
            }),
      ),
    );
  }
}

class PlajCard extends StatelessWidget {
    const PlajCard({
    super.key,required this.path,required this.name,required this.description,required this.navigator
  });

  final String path;
  final String name;
  final String description;
  final String navigator;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return InkWell(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => plajlar(context)[navigator] as Widget,
          ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: c.shell,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 1, color: c.lightGreyCardCollor),
          boxShadow: [
            BoxShadow(
              color: c.ink.withValues(alpha: 0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with the beach name overlaid bottom-left (reference style).
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(path, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 14,
                  right: 16,
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextFonts.instance.imageFront.copyWith(
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.6),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Text(
                description,
                style: TextFonts.instance.commentTextBold
                    .copyWith(color: c.ink, fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class TOS extends StatefulWidget {
  const TOS({super.key});

  @override
  State<TOS> createState() => _TOSState();
}

class _TOSState extends State<TOS> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WoltModalSheet.show(context: context, pageListBuilder: (context) {
          return [ WoltModalSheetPage(
            pageTitle: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("Adatvédelmi szabályzat",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  
                  SizedBox(height: 25,),
                  Text("Milyen információkat szerez az Alkalmazás, és hogyan használja fel azokat?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  
                  SizedBox(height: 10,),
                  Text("Felhasználó által megadott információk:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text("A Iaso megszerzi ön által az Iaso letöltésekor és regisztrálásakor megadott információkat. A Szolgáltatónál történő regisztráció kötelező. Ne feledje azonban, hogy előfordulhat, hogy nem tudja használni az Alkalmazás által kínált funkciókat, hacsak nem regisztrál hozzájuk."),
                  SizedBox(height: 2,),
                  Text("A Szolgáltató az Ön által megadott információkat arra is felhasználhatja, hogy időről időre felvegye Önnel a kapcsolatot, hogy fontos információkkal, szükséges értesítésekkel lássa el Önt."),
                  SizedBox(height: 5,),
                  Text("Automatikusan gyűjtött információk:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Ezenkívül az Alkalmazás automatikusan gyűjthet bizonyos információkat, többek között, de nem kizárólagosan az Ön által használt mobileszköz típusát, a mobileszköz egyedi eszközazonosítóját, a mobileszköz IP-címét, az Ön mobil operációs rendszerét, a mobil típusát. Az Ön által használt internetböngészők és az Alkalmazás használatának módjáról szóló információk."),
                  
                  SizedBox(height: 10,),
                  Text("Az alkalmazás pontos valós idejű helyadatokat gyűjt az eszközről?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Ez az alkalmazás nem gyűjt pontos információkat a mobileszköz helyéről."),
                  
                  SizedBox(height: 10,),
                  Text("Látják-e és/vagy hozzáférhetnek-e harmadik felek az Alkalmazás által megszerzett információkhoz?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Csak összesített, anonimizált adatok kerül továbbításra időszakonként külső szolgáltatások felé, hogy segítse a Szolgáltatót az Alkalmazás és szolgáltatásuk fejlesztésében. A Szolgáltató megoszthatja adatait harmadik felekkel a jelen adatvédelmi nyilatkozatban leírt módon."),
                  SizedBox(height: 5,),
                  Text("Felhívjuk figyelmét, hogy az Alkalmazás olyan harmadik féltől származó szolgáltatásokat vesz igénybe, amelyek saját adatvédelmi szabályzattal rendelkeznek az adatok kezelésére. Az alábbiakban az Alkalmazás által használt harmadik fél szolgáltatók adatvédelmi szabályzatára mutató hivatkozások találhatók:"),
                  SizedBox(height: 5,),
                  Text("Google Play Services",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("A Szolgáltató a Felhasználó által megadott és automatikusan gyűjtött információkat nyilvánosságra hozhatja:"),
                  SizedBox(height: 5,),
                  Text("a törvény által előírtak szerint, például egy idézés vagy hasonló jogi eljárás teljesítése érdekében;"),
                  SizedBox(height: 5,),
                  Text("ha jóhiszeműen úgy vélik, hogy a nyilvánosságra hozatal szükséges jogaik védelme, az Ön vagy mások biztonságának védelme, a csalás kivizsgálása vagy a kormányzati kérés megválaszolása;"),
                  SizedBox(height: 5,),
                  Text("megbízható szolgáltatóikkal, akik a nevükben dolgoznak, nem használják fel önállóan az általunk közölt információkat, és beleegyeztek abba, hogy betartják a jelen adatvédelmi nyilatkozatban foglalt szabályokat."),

                  SizedBox(height: 10,),
                  Text("Mik a leiratkozási jogaim?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text("Az Alkalmazás eltávolításával egyszerűen leállíthatja az Alkalmazás általi összes információgyűjtést. Használhatja a szabványos eltávolítási eljárásokat, amelyek elérhetőek lehetnek mobileszköze részeként vagy a mobilalkalmazások piacterén vagy hálózatán keresztül."),

                  SizedBox(height: 10,),
                  Text("Mik a leiratkozási jogaim?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("A Szolgáltató a Felhasználó által megadott adatokat mindaddig megőrzi, amíg Ön az Alkalmazást használja, és azt követően ésszerű ideig. A Szolgáltató az Automatikusan gyűjtött információkat legfeljebb 24 hónapig megőrzi, majd azt követően összesítve tárolhatja. Ha szeretné, hogy a Szolgáltató törölje az Alkalmazáson keresztül megadott Felhasználó által megadott adatokat, kérjük, lépjen kapcsolatba vele a benedek.praga@gmail.com címen, és ésszerű időn belül válaszolunk. Felhívjuk figyelmét, hogy a Felhasználó által megadott adatok egy része vagy mindegyike szükséges lehet az Alkalmazás megfelelő működéséhez."),

                  SizedBox(height: 10,),
                  Text("Gyermekek",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("A Szolgáltató nem használja az Alkalmazást 13 éven aluli gyermekek szándékos adatszerzésére vagy értékesítésére."),
                  SizedBox(height: 5,),
                  Text("Az Alkalmazás 13 éven alulinak nem szól. A Szolgáltató 13 év alatti gyermekektől tudatosan nem gyűjt személyazonosításra alkalmas adatokat. Amennyiben a Szolgáltató észleli, hogy 13 éven aluli gyermek személyes adatot adott meg, azt haladéktalanul törli a szervereiről. Ha Ön szülő vagy gyám, és tudomása van arról, hogy gyermeke személyes adatokat adott meg nekünk, kérjük, vegye fel a kapcsolatot a Szolgáltatóval (benedek.praga@gmail.com), hogy meg tudja tenni a szükséges lépéseket."),

                  SizedBox(height: 10,),
                  Text("Biztonság",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("A Szolgáltató törődik az Ön adatainak bizalmas kezelésével. A Szolgáltató fizikai, elektronikus és eljárási biztosítékokat nyújt az általunk feldolgozott és karbantartott információk védelme érdekében. Például korlátozzuk az információkhoz való hozzáférést az arra feljogosított alkalmazottakra és vállalkozókra, akiknek ismerniük kell ezeket az információkat Alkalmazásuk működtetéséhez, fejlesztéséhez vagy javításához. Kérjük, vegye figyelembe, hogy bár törekszünk az általunk feldolgozott és karbantartott információk ésszerű biztonságára, egyetlen biztonsági rendszer sem képes megakadályozni az összes lehetséges biztonsági rést."),

                  SizedBox(height: 10,),
                  Text("Változások",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Ez az adatvédelmi szabályzat időről időre, bármilyen okból frissülhet. A Szolgáltató az Adatvédelmi Szabályzat változásairól az oldal frissítésével értesíti Önt az új Adatvédelmi szabályzattal. Javasoljuk, hogy rendszeresen olvassa el ezt az Adatvédelmi szabályzatot bármilyen változás esetén, mivel a folyamatos használat minden változtatás jóváhagyásának minősül."),
                  SizedBox(height: 5,),
                  Text("Ez az adatvédelmi szabályzat 2024-05-09-től hatályos"),


                  SizedBox(height: 10,),
                  Text("Az Ön hozzájárulása",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Az Alkalmazás használatával Ön beleegyezését adja ahhoz, hogy a Szolgáltató kezelje adatait a jelen Adatkezelési tájékoztatóban foglaltak szerint és az általunk módosított formában. „Feldolgozás”: cookie-k használata számítógépen/kézi eszközön, vagy információk bármilyen módon történő felhasználása vagy megérintése, beleértve, de nem kizárólagosan, az információk gyűjtését, tárolását, törlését, felhasználását, kombinálását és közzétételét."),

                  SizedBox(height: 10,),
                  Text("Lépjen kapcsolatba velünk",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Ha bármilyen kérdése van az Alkalmazás használata során az adatvédelemmel kapcsolatban, vagy kérdése van a gyakorlattal kapcsolatban, kérjük, lépjen kapcsolatba a Szolgáltatóval a benedek.praga@gmail.com e-mail címen."),

                ],
              ),
            ),
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white.withAlpha(200) // Light theme color
                : Colors.blueGrey[900]?.withAlpha(200),
          )];
        });
      },
      child: Icon(FontAwesomeIcons.chevronRight),
    );
  }
}
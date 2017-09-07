
BPRS
======

BPRS eli Bluetooth Position Reporting System on ohjelma, jolla saadaan
määrätyssä paikassa, esimerkiksi radioamatöörikerholla tai -leirillä, olevat
radioamatöörit automaattisesti näkymään APRS-kartalla oikeassa paikassa. 
Paikoissa, joissa BPRS toimii, on näkyvällä paikalla kyltti jossa lukee
isolla BPRS sekä pienemmällä alla oleva käyttöohje.


BPRS:n käyttöohje
-------------------

1. Aseta puhelimesi (tai läppärin tai vastaavan mukana olevan
   Bluetooth-härpättimen) nimeksi "bprs omakutsu", esim.
   "bprs oh2ööö", isolla tahi pienillä kirjaimilla ei ole väliä.
   4-kirjaimiset suffiksit eivät toimi, 1-3-kirjaimiset toimivat.
   Varo, ettet kirjoita vahingossa OH:ta nollalla (0H). Älä lisää
   SSID:tä, BPRS lisää automaattisesti -BP:n kutsun loppuun
2. Aseta puhelimen bluetooth päälle ja näkyväksi (discoverable).
3. Odottele jokunen minuutti (1-5).
4. BPRS-asema omakutsu-BP (esim. OH2ÖÖÖ-BP) ilmestynee APRS-kartalle
   kerhon kohdalle.
5. Nyt voit korjata kohdissa 1 sekä 2 tehdyt muutokset, eli puhelimen
   nimi alkuperäiseksi ja pois pahojen hakkereiden näkyvistä (not
   discoverable).
6. Kun seuraavan kerran ilmaannut kerholle, BPRS havaitsee puhelimesi
   läsnäolon jokusen minuutin kuluttua. Kohtiin 1 ja 2 ei tarvitse
   palata. Rekisteröinti täytyy kuitenkin nykyisellään tehdä uudestaan
   eri BPRS-paikoissa.


BPRS-palvelimen asennusohje
-----------------------------

Tällä ohjeella saat BPRS:n käyttöön kerhollesi tai vaikkapa kesäleirille tai
talvipäiville.

Palvelinohjelmisto on kirjoitettu perl-ohjelmointikielellä ja se asentuu
helpoimmin Linux-palvelimeen.  Windows-asennuksen perään ei kannata kysellä,
alkuperäisellä tekijällä ei ole pienintäkään aikomusta tahi osaamista sen
suhteen.  Perl-ohjelma todennäköisesti sinällään toimisi muissakin
käyttöjärjestelmissä, mutta bprsd käyttää suoraan Linuxin
bluetooth-työkaluja (hcitool) joita ei muista järjestelmistä löydy.

Ensin asennetaan tarpeellisia paketteja (tämä loitsu on Ubuntulle tai
Debianille, muillekin löytynee vastaava):

    sudo apt-get install perl libjson-perl libstring-crc32-perl bluez \
        libyaml-tiny-perl libdate-calc-perl

Sitten asennetaan APRS-paketit, viimeisin versio:

    wget http://he.fi/bprs/Ham-APRS-FAP-1.18.tar.gz
    tar xvfz Ham-APRS-FAP-1.18.tar.gz
    cd Ham-APRS-FAP-1.18
    perl Makefile.PL
    make
    sudo make install

Ja sitten itse BPRS-ohjelmisto:

    wget http://he.fi/bprs/bprsd-1.00.tar.gz
    tar xvfz bprsd-1.00.tar.gz
    cd bprsd-1.00
    perl Makefile.PL
    make
    sudo make install


bprsd-ohjelma asentuu polkuun /usr/local/bin/bprsd.

Kopioi bprsd-paketista tullut bprsd.conf.example nimelle /etc/bprsd.conf
(tai /usr/local/etc/bprsd.conf), ja editoi sinne omat asetuksesi.

Käynnistä.  Ohjelmaa ajetaan tavallisena käyttäjänä (ei roottina).  Mukana
ei tässä ensimmäisessä kokeiluversiossa tule käynnistysskriptejä ja kaikki
loggaus tapahtuu stdout/stderr linjalle.  Suorittaminen buutissa ja lokien
kierrätys onnistuu näppärimmin supervisord:n avulle (apt-get install
supervisor).

Bluetooth-dongle serveriin
----------------------------

Jos koneessa ei ennestään ole bluetoothia, ihan toimivia ja edullisia
dongleja saa Dealextremestä.  Kannattaa samalla tilata varadonglet.  Maksa
paypalilla, toimitus muutaman viikon, katso että tilaat ns.  varastossa
olevaa mallia.  Ulkoisen näkyvän antennin omaavat donglet eivät ole sen
parempia, ainakin allekirjoittaneen ostamassa yksilössä antenni oli muovinen
tyhjä tikku ja antenni oikeasti piirilevylle muotoiltu.

Search bluetooth on Dealextreme

Jos/kun palvelin on piilossa räkissä tai pöydän alla, bluetooth-kantomatkaa
voi kasvattaa siirtämällä donglen ylemmäs seinälle parin metrin
USB2.0-jatkopiuhalla.  Pelkkä tietokoneen runko aiheuttaa varmaan
jonkinmoisen katvealueen.

USB extension cables on Dealextreme

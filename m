From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: SATA intel High loads due to writes vs ata_piix switch
Date: Thu, 17 May 2007 14:10:53 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7028FE801@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
References: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca><20070516214236.08dd02c9@the-village.bc.nu><8E8F647D7835334B985D069AE964A4F7033AB605@ECQCMTLMAIL1.quebec.int.ec.gc.ca><8E8F647D7835334B985D069AE964A4F7033AB60A@ECQCMTLMAIL1.quebec.int.ec.gc.ca><8E8F647D7835334B985D069AE964A4F7033AB60B@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <20070517182709.54a831dd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:58467 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751661AbXEQSLO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 14:11:14 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> -----Message d'origine-----
> De : Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]=20
> Envoy=E9 : 17 mai 2007 13:27
>=20
> > [root@kayak /root]# hdparm -T -t /dev/hda
> >=20
> > /dev/hda:
> >  Timing cached reads:   4816 MB in  2.00 seconds =3D 2408.44 MB/sec
> >  Timing buffered disk reads:   12 MB in  3.23 seconds =3D 3.72 MB/s=
ec
>=20
> This is using PIO. How recent is your kernel - you may need a=20
> newer kernel for the ICH8 if you only get PIO with the old IDE layer.
>=20

Just upgraded to 2.6.21.1 and I am now capable of using ahci instead of=
 ata_piix.

This makes the disks even faster:

OLD-IDE
-------
[root@kayak /root]# hdparm -T -t /dev/hda

/dev/hda:
 Timing cached reads:   4816 MB in  2.00 seconds =3D 2408.44 MB/sec
 Timing buffered disk reads:   12 MB in  3.23 seconds =3D   3.72 MB/sec



Libata ata_piix
---------------
[root@kayak /root]# hdparm -T -t /dev/sda

/dev/sda:
 Timing cached reads:   4960 MB in  2.00 seconds =3D 2480.38 MB/sec
 Timing buffered disk reads:  168 MB in  3.00 seconds =3D  55.94 MB/sec



Liata AHCI
----------
[root@kayak /root]# hdparm -T -t /dev/sda

/dev/sda:
 Timing cached reads:   5036 MB in  2.00 seconds =3D 2518.96 MB/sec
 Timing buffered disk reads:  178 MB in  3.03 seconds =3D  58.73 MB/sec

Wew... This makes it a worthy upgrade!

Thnx.

- vin

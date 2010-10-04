From: Ben Hutchings <ben@decadent.org.uk>
Subject: piix vs ata_piix device ID tables
Date: Mon, 04 Oct 2010 04:50:52 +0100
Message-ID: <1286164252.3916.312.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-x6u4gjqbKPivNUz7Jm55"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38798 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630Ab0JDDvC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2010 23:51:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org


--=-x6u4gjqbKPivNUz7Jm55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I converted the Debian kernel configurations over from IDE to
libata-based drivers, I compared the device ID tables for all the PCI
drivers.  I found that ata_piix handles most of the same devices as piix
while pata_oldpiix and pata_mpiix each handle one more.  However, 2
device IDs in piix are not in the device ID tables of any libata-based
driver:

PCI_DEVICE_ID_INTEL_82371FB_0 =3D=3D 0x122e (PIIX function 0)

piix seems to treat this the same as PCI_DEVICE_ID_INTEL_82371FB_1 =3D=3D
0x1230, which is handled by pata_oldpiix.  (This is weird; function 0 is
supposed to be the ISA bridge!)

PCI_DEVICE_ID_INTEL_82801DB_1 =3D=3D 0x24c1 (ICH4 device 31 function 1)

piix seems to treat this the same as most other ICH PATA interfaces,
which are handled by ata_piix.

Does anyone know why these aren't handled by the libata-based drivers?

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-x6u4gjqbKPivNUz7Jm55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATKlPF+e/yOyVhhEJAQIxkg//bUUucvw87qot2WX+bRoS586/gnl+Bsad
YF+iQGhVbU9RnzkiuVi50w62IqBYP70b7S4uwjgD3O0QGjIrwXvHuaA4u5DEYnyQ
YNRweE74SpEZvqdVeGD9NL9OLEwC36Gn0a2RVvfDH29+O4M1AwRp2/heU0qJtuP7
FYFIr/VZUPOp/RFIh9BTe0a4SQjUFPBdy4Ek8LcYOYtQSUNdQ6igcnb/Rdixu2S5
Fp/w0EhnYwyBD3JGosOtakGmdkstNmp1gWA+pYr5One2Do4qRSuX4PXzR2oj3OMz
IcPrn3PBsuJa0lPOLoecGpxH5gu3y2nGZtU5vkY/jZW1aAZeprPahKzezcRiBebk
Ecb1eHtSE3XYxktkJYiwgZVQyA+h5oGvXNaCkjhaHqKv4q/lY36j/aeVTFaoTafW
Y4PampqDV85mWOmVigK2wrFMwBbXF8BFfogGA26Dfcz7ykB6xaDt1jrsDO1Fynmv
xgr0yi2YyKNTwLEPiQmjrOgi7//FCDiFoCJ+sR6xx4gEKr1c1OCy0Gvc3epj/Xrv
4mcMO4zZBAzsTD7wFVMqMMlH84N3OP5b5xEAD6DHRplIASSZ5yVUpZUCL8r45UDN
ujFVqrErOMK/N43krTUeih0Cfz0C9I33TXJj1zgYnBQa/G3A3iG6mklr49z5c7Ga
xXUUWypehXY=
=BDwp
-----END PGP SIGNATURE-----

--=-x6u4gjqbKPivNUz7Jm55--

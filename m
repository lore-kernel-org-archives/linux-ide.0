From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH RESEND] ahci: Add JMicron 362 device IDs
Date: Mon, 10 Sep 2012 01:09:04 +0100
Message-ID: <1347235744.5134.14.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-E1xe5M7Jka+rhiddQnje"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52060 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899Ab2IJAJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2012 20:09:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>, 634180@bugs.debian.org


--=-E1xe5M7Jka+rhiddQnje
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The JMicron JMB362 controller supports AHCI only, but some revisions
use the IDE class code.  These need to be matched by device ID.

These additions have apparently been included by QNAP in their NAS
devices using these controllers.

References: http://bugs.debian.org/634180
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
Previously sent last year(!); please respond...

Ben.

 drivers/ata/ahci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index fd318ac..67dbd6a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -263,6 +263,9 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
+	/* JMicron 362B and 362C have an AHCI function with IDE class code */
+	{ PCI_VDEVICE(JMICRON, 0x2362), board_ahci_ign_iferr },
+	{ PCI_VDEVICE(JMICRON, 0x236f), board_ahci_ign_iferr },
=20
 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */


--=20
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert=
.

--=-E1xe5M7Jka+rhiddQnje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUE0voOe/yOyVhhEJAQrJeg/+L4H6DBZqHHyehbFFR+OgmT1ApKacF6pO
EUP4kY84A565fm702e4Ia3JjCk/ngTrDk1QLkyvDHYjriYtR/H7dIqQqq+N/jLf/
8na+zpHBe5hEg8yZwazO3vXOax52BY0lzfjok61auQRaeZFDzAc+OE4CZJ7jJLJ5
tHQ9p3FVpI7DRq87eVgQRl1cH0SIseOEfUgxhCRftv/EEf8VT31F6NQhJQcp8j1M
B8ry5yru+9uD6rPSjppMV4fNAbbVr1OagEtgRh3CW6F8uHQBjt7W9Cg5+suTOE+L
oCcDj6eVxwUpjasSH0hzB/ZeFLsiQ29NeZJ8ropU7m80ZcWDH8WtsUKMJCjBcu1L
RhmClTwmNTeLaC4+AU8zDEfd3davxjSd8cm9Mc+DtK+YWWKu3WhQn1LJcQ7wL+G/
6Nql+7qXDtep17P97Wu/mtU7BwTvHkLzmPdfoifSuxe6zKA+htV4FZKrTkCexU+d
L1tTJ3A7Vvv0Vpsog8eZ48X5+uyVhZqGPYX7oyXPKy/TxudfEtCs+eWwQrovzZQR
TJi8LZetHASCzQ32Uh0L05rzK/rMYYAGCYyqlZ3p4mfcr5ooKqzb3lu76gSH5SDD
6w/j5b1iQxU+ElWWcLWBHbGqMRYISsUhPdhL/L4sfUfa/Ke3e3c6DSXP6MMjsvyd
dM7SpTUp+GU=
=6xnr
-----END PGP SIGNATURE-----

--=-E1xe5M7Jka+rhiddQnje--

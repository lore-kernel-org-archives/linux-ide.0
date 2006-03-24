From: Uwe Hermann <uwe@hermann-uwe.de>
Subject: [PATCH] Support for DMA on ICH6M / piix.
Date: Fri, 24 Mar 2006 05:17:06 +0100
Message-ID: <20060324041706.GA1337@aragorn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wp050.webpack.hosteurope.de ([80.237.132.57]:61629 "EHLO
	wp050.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1423001AbWCXERR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Mar 2006 23:17:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the disk drive in my laptop cannot enable DMA with "hdparm -d1 /dev/hda",
unless I use a kernel with the supplied patch.

The patch was originally written by Erik Slagter for 2.6.12
(see http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D112030174904055&w=3D2)=
 and
I have successfully used it until 2.6.14. I want to upgrade to 2.6.16 ASAP,
so I adapted the patch for vanilla 2.6.16.

It works for me, but you might want to check whether it messes up things...

More info on my hardware:

$ dmesg | grep SAMSUNG
hda: SAMSUNG MP0804H, ATA DISK drive

$ lspci | grep ICH6M
0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Control=
ler (rev 03)

The patch:

diff -Naurp linux-2.6.16.orig/drivers/ide/pci/piix.c linux-2.6.16/drivers/i=
de/pci/piix.c
--- linux-2.6.16.orig/drivers/ide/pci/piix.c	2006-03-20 06:53:29.000000000 =
+0100
+++ linux-2.6.16/drivers/ide/pci/piix.c	2006-03-24 00:29:34.000000000 +0100
@@ -132,6 +132,7 @@ static u8 piix_ratemask (ide_drive_t *dr
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
+		case PCI_DEVICE_ID_INTEL_ICH6_5:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
@@ -447,6 +448,7 @@ static unsigned int __devinit init_chips
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
+		case PCI_DEVICE_ID_INTEL_ICH6_5:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
@@ -578,6 +580,7 @@ static ide_pci_device_t piix_pci_info[]=20
 	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
 	/* 23 */ DECLARE_PIIX_DEV("ESB2"),
 	/* 24 */ DECLARE_PIIX_DEV("ICH8M"),
+	/* 25 */ DECLARE_PIIX_DEV("ICH6M"),
 };
=20
 /**
@@ -655,6 +658,7 @@ static struct pci_device_id piix_pci_tbl
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, 22},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID, PCI_ANY_I=
D, 0, 0, 23},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_6, PCI_ANY_ID, PCI_ANY_ID=
, 0, 0, 24},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_5, PCI_ANY_ID, PCI_ANY_ID=
, 0, 0, 25},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
diff -Naurp linux-2.6.16.orig/include/linux/pci_ids.h linux-2.6.16/include/=
linux/pci_ids.h
--- linux-2.6.16.orig/include/linux/pci_ids.h	2006-03-20 06:53:29.000000000=
 +0100
+++ linux-2.6.16/include/linux/pci_ids.h	2006-03-24 00:28:35.000000000 +0100
@@ -2092,6 +2092,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_0	0x2640
 #define PCI_DEVICE_ID_INTEL_ICH6_1	0x2641
 #define PCI_DEVICE_ID_INTEL_ICH6_2	0x2642
+#define PCI_DEVICE_ID_INTEL_ICH6_5	0x2653
 #define PCI_DEVICE_ID_INTEL_ICH6_16	0x266a
 #define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e


HTH, Uwe.
--=20
Uwe Hermann=20
http://www.hermann-uwe.de
http://www.it-services-uh.de  | http://www.crazy-hacks.org=20
http://www.holsham-traders.de | http://www.unmaintained-free-software.org

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEI3LCXdVoV3jWIbQRArx1AJ4/WEdCV1Yr+nqubu6adLZFszimAACZAd4E
7+arvb85BJq91KZtBODrjyI=
=6HKc
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

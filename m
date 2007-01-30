From: ethanhsiao@jmicron.com
Subject: [PATCH -mm] jmicron: 40/80pin primary detection
Date: Tue, 30 Jan 2007 12:03:25 +0800
Message-ID: <OF59067410.11A20F48-ON48257273.00150F04@jmicron.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01EC_01C74466.A5E68750"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spamfilter.jmicron.com ([220.130.51.235]:43102 "EHLO
	spamfilter.jmicron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbXA3ELX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 23:11:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, alan@redhat.com

This is a multi-part message in MIME format.

------=_NextPart_000_01EC_01C74466.A5E68750
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Patch is against 2.6.20-rc6-mm2, jmicron module detects all JMB36x as =
JMB361 and PATA0 has wrong pin status of XICBLID.

--- a/drivers/ide/pci/jmicron.c	2007-01-30 10:08:35.000000000 +0800
+++ b/drivers/ide/pci/jmicron.c	2007-01-30 10:11:31.000000000 +0800
@@ -70,8 +70,8 @@
 	{
 	case PORT_PATA0:
 		if (control & (1 << 3))	/* 40/80 pin primary */
-			return 1;
-		return 0;
+			return 0;
+		return 1;
 	case PORT_PATA1:
 		if (control5 & (1 << 19))	/* 40/80 pin secondary */
 			return 0;
@@ -205,11 +205,11 @@
 }
=20
 static struct pci_device_id jmicron_pci_tbl[] =3D {
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 0},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 1},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 3},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 4},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 3},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 4},
 	{ 0, },
 };

Best Regards,
Ethan Hsiao
=E6=99=BA=E5=BE=AE=E7=A7=91=E6=8A=80=E8=82=A1=E4=BB=BD=E6=9C=89=E9=99=90=E5=
=85=AC=E5=8F=B8 ( JMicron Technology )
=E6=96=B0=E7=AB=B9=E7=A7=91=E5=AD=B8=E5=B7=A5=E6=A5=AD=E5=9C=92=E5=8D=80=E6=
=96=B0=E7=AB=B9=E7=B8=A3=E5=89=B5=E6=96=B0=E4=B8=80=E8=B7=AF13=E8=99=9F1F=
=20
1F,No. 13, Innovation Road 1, Science-Based Industrial Park,=20
Hsinchu, Taiwan.
Tel : 886-3-579-7389  # 8729
Fax : 886-3-579-9566

------=_NextPart_000_01EC_01C74466.A5E68750
Content-Type: application/octet-stream;
	name="jmicron.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="jmicron.c.patch"

--- jmicron.c.orig	2007-01-30 10:08:35.000000000 +0800=0A=
+++ jmicron.c	2007-01-30 10:11:31.000000000 +0800=0A=
@@ -70,8 +70,8 @@=0A=
 	{=0A=
 	case PORT_PATA0:=0A=
 		if (control & (1 << 3))	/* 40/80 pin primary */=0A=
-			return 1;=0A=
-		return 0;=0A=
+			return 0;=0A=
+		return 1;=0A=
 	case PORT_PATA1:=0A=
 		if (control5 & (1 << 19))	/* 40/80 pin secondary */=0A=
 			return 0;=0A=
@@ -205,11 +205,11 @@=0A=
 }=0A=
 =0A=
 static struct pci_device_id jmicron_pci_tbl[] =3D {=0A=
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 0},=0A=
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 1},=0A=
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 2},=0A=
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 3},=0A=
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 4},=0A=
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 0},=0A=
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 1},=0A=
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 2},=0A=
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 3},=0A=
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 4},=0A=
 	{ 0, },=0A=
 };=0A=
 =0A=

------=_NextPart_000_01EC_01C74466.A5E68750--


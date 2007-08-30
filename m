From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.23-rc4] ata_piix: IDE mode SATA patch for Intel Tolapai
Date: Thu, 30 Aug 2007 15:44:32 -0700
Message-ID: <200708301544.32864.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54999 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762891AbXH3WmW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 18:42:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jason.d.gaston@intel.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

This updated patch adds the Intel Tolapai IDE mode SATA controller DID.

Signed-off-by: =A0Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.23-rc4/drivers/ata/ata_piix.c.orig	2007-08-27 18:32:35.00=
0000000=20
-0700
+++ linux-2.6.23-rc4/drivers/ata/ata_piix.c	2007-08-29 17:13:13.0000000=
00=20
-0700
@@ -130,6 +130,7 @@
 	ich6m_sata_ahci		=3D 8,
 	ich8_sata_ahci		=3D 9,
 	piix_pata_mwdma		=3D 10,	/* PIIX3 MWDMA only */
+	tolapai_sata_ahci	=3D 11,
=20
 	/* constants for mapping table */
 	P0			=3D 0,  /* port 0 */
@@ -253,6 +254,8 @@
 	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (ICH9M) */
 	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (Tolapai) */
+	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, tolapai_sata_ahci },
=20
 	{ }	/* terminate list */
 };
@@ -441,12 +444,25 @@
 	},
 };
=20
+static const struct piix_map_db tolapai_map_db =3D {
+        .mask =3D 0x3,
+        .port_enable =3D 0x3,
+        .map =3D {
+                /* PM   PS   SM   SS       MAP */
+                {  P0,  NA,  P1,  NA }, /* 00b */
+                {  RV,  RV,  RV,  RV }, /* 01b */
+                {  RV,  RV,  RV,  RV }, /* 10b */
+                {  RV,  RV,  RV,  RV },
+        },
+};
+
 static const struct piix_map_db *piix_map_db_table[] =3D {
 	[ich5_sata]		=3D &ich5_map_db,
 	[ich6_sata]		=3D &ich6_map_db,
 	[ich6_sata_ahci]	=3D &ich6_map_db,
 	[ich6m_sata_ahci]	=3D &ich6m_map_db,
 	[ich8_sata_ahci]	=3D &ich8_map_db,
+	[tolapai_sata_ahci]	=3D &tolapai_map_db,
 };
=20
 static struct ata_port_info piix_port_info[] =3D {
@@ -560,6 +576,17 @@
 		.mwdma_mask	=3D 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow *=
/
 		.port_ops	=3D &piix_pata_ops,
 	},
+
+	/* tolapai_sata_ahci: 11: */
+	{
+		.sht		=3D &piix_sht,
+		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.udma_mask	=3D ATA_UDMA6,
+		.port_ops	=3D &piix_sata_ops,
+	},
 };
=20
 static struct pci_bits piix_enable_bits[] =3D {

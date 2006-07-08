From: Tejun Heo <htejun@gmail.com>
Subject: [RFT][PATCH] ata_piix: implement proper PCS handling for ICH8
Date: Sun, 9 Jul 2006 01:23:33 +0900
Message-ID: <20060708162333.GF2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.201]:53922 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964873AbWGHQWl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 12:22:41 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1240213wxc
        for <linux-ide@vger.kernel.org>; Sat, 08 Jul 2006 09:22:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ICH8 uses different shift for present bits in PCS and MAP.MV is
reserved (SATA only).  Add map_db.present_shift and add proper MAP
handling for ICH8.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against

  upstream (309bade002e9226781c2d7a015340d0089e399b5)
  + [1] ata_piix-add_host_set-private-structure
  + [2] ata_piix-implement-cached-PCS

I don't have a ICH8, so this is only compile-tested.  I think ICH8
uses [P0 P2 P1 P3] for 4 ports device and [P0 NA P1 NA] for 2 ports as
ICH6/7 does, but the spec doesn't say anything about this, so it needs
testing.  Thanks.

[1] http://article.gmane.org/gmane.linux.ide/11721
[2] http://article.gmane.org/gmane.linux.ide/11722

 drivers/scsi/ata_piix.c |   67 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 60 insertions(+), 7 deletions(-)

95c3dfd6ab6153497166ee107cfcd9e47f5e938d
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index cbb3293..f81f293 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -127,6 +127,8 @@ enum {
 	ich6_sata		= 4,
 	ich6_sata_ahci		= 5,
 	ich6m_sata_ahci		= 6,
+	ich8_4p			= 7,
+	ich8_2p			= 8,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -142,11 +144,13 @@ enum {
 
 struct piix_map_db {
 	const u32 mask;
+	const int present_shift;
 	const int map[][4];
 };
 
 struct piix_host_priv {
 	const int *map;
+	int present_shift;
 	u8 cached_pcs;
 };
 
@@ -192,12 +196,12 @@ #endif
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
 	/* Enterprise Southbridge 2 (where's the datasheet?) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
-	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* SATA Controller 2 IDE (ICH8, ditto) */
-	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* Mobile SATA Controller IDE (ICH8M, ditto) */
-	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
+	/* SATA Controller 1 IDE (ICH8) */
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_4p },
+	/* SATA Controller 2 IDE (ICH8) */
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2p },
+	/* Mobile SATA Controller IDE (ICH8M) */
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2p },
 
 	{ }	/* terminate list */
 };
@@ -296,6 +300,7 @@ static const struct ata_port_operations 
 
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
+	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP  */
 		{  P0,  NA,  P1,  NA }, /* 000b */
@@ -311,6 +316,7 @@ static const struct piix_map_db ich5_map
 
 static const struct piix_map_db ich6_map_db = {
 	.mask = 0x3,
+	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b */
@@ -322,6 +328,7 @@ static const struct piix_map_db ich6_map
 
 static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
+	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  RV,  RV }, /* 00b */
@@ -331,12 +338,32 @@ static const struct piix_map_db ich6m_ma
 	},
 };
 
+static const struct piix_map_db ich8_4p_map_db = {
+	.mask = 0x0,
+	.present_shift = 8,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  P2,  P1,  P3 }, /*  0b */
+	},
+};
+
+static const struct piix_map_db ich8_2p_map_db = {
+	.mask = 0x0,
+	.present_shift = 8,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  NA,  P1,  NA }, /*  0b */
+	},
+};
+
 static const struct piix_map_db *piix_map_db_table[] = {
 	[ich5_sata]		= &ich5_map_db,
 	[esb_sata]		= &ich5_map_db,
 	[ich6_sata]		= &ich6_map_db,
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
+	[ich8_4p]		= &ich8_4p_map_db,
+	[ich8_2p]		= &ich8_2p_map_db,
 };
 
 static struct ata_port_info piix_port_info[] = {
@@ -424,6 +451,30 @@ #endif
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* ich8_4p */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
+
+	/* ich8_2p */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
@@ -551,7 +602,8 @@ static int piix_sata_prereset(struct ata
 		port = map[base + i];
 		if (port < 0)
 			continue;
-		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
+		if ((ap->flags & PIIX_FLAG_IGNORE_PCS) ||
+		    (pcs & 1 << (hpriv->present_shift + port)))
 			present_mask |= 1 << i;
 		else
 			pcs &= ~(1 << port);
@@ -824,6 +876,7 @@ static void __devinit piix_init_sata_map
 			   "invalid MAP value %u\n", map_value);
 
 	hpriv->map = map;
+	hpriv->present_shift = map_db->present_shift;
 }
 
 /**
-- 
1.3.2


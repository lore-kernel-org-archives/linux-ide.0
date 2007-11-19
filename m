From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: reorganize controller IDs
Date: Mon, 19 Nov 2007 13:14:59 +0900
Message-ID: <20071119041459.GA30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:53281 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbXKSEPF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 23:15:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1834684wah
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 20:15:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Move piix_pata_mwdma to top, rename ich9_2port_sata to ich8_2port_sata
for consistency and use automatically incremented values instead of
assigning fixed values to ease adding new controller IDs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
applied to #tj-upstream-fixes.

 drivers/ata/ata_piix.c |   62 ++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 80b735b..77fea05 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -119,18 +119,18 @@ enum {
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
 
 	/* controller IDs */
-	piix_pata_33		= 0,	/* PIIX4 at 33Mhz */
-	ich_pata_33		= 1,	/* ICH up to UDMA 33 only */
-	ich_pata_66		= 2,	/* ICH up to 66 Mhz */
-	ich_pata_100		= 3,	/* ICH up to UDMA 100 */
-	ich5_sata		= 5,
-	ich6_sata		= 6,
-	ich6_sata_ahci		= 7,
-	ich6m_sata_ahci		= 8,
-	ich8_sata_ahci		= 9,
-	piix_pata_mwdma		= 10,	/* PIIX3 MWDMA only */
-	tolapai_sata_ahci	= 11,
-	ich9_2port_sata		= 12,
+	piix_pata_mwdma		= 0,	/* PIIX3 MWDMA only */
+	piix_pata_33,			/* PIIX4 at 33Mhz */
+	ich_pata_33,			/* ICH up to UDMA 33 only */
+	ich_pata_66,			/* ICH up to 66 Mhz */
+	ich_pata_100,			/* ICH up to UDMA 100 */
+	ich5_sata,
+	ich6_sata,
+	ich6_sata_ahci,
+	ich6m_sata_ahci,
+	ich8_sata_ahci,
+	ich8_2port_sata,
+	tolapai_sata_ahci,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -239,19 +239,19 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* SATA Controller 1 IDE (ICH8) */
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller 2 IDE (ICH8) */
-	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (ICH9) */
 	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (ICH9) */
-	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
+	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (ICH9) */
-	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
+	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (ICH9M) */
-	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
+	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (ICH9M) */
-	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
+	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (ICH9M) */
 	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (Tolapai) */
@@ -437,7 +437,7 @@ static const struct piix_map_db ich8_map_db = {
 	},
 };
 
-static const struct piix_map_db tolapai_map_db = {
+static const struct piix_map_db ich8_2port_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x3,
 	.map = {
@@ -449,7 +449,7 @@ static const struct piix_map_db tolapai_map_db = {
 	},
 };
 
-static const struct piix_map_db ich9_2port_map_db = {
+static const struct piix_map_db tolapai_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x3,
 	.map = {
@@ -467,11 +467,20 @@ static const struct piix_map_db *piix_map_db_table[] = {
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
 	[ich8_sata_ahci]	= &ich8_map_db,
+	[ich8_2port_sata]	= &ich8_2port_map_db,
 	[tolapai_sata_ahci]	= &tolapai_map_db,
-	[ich9_2port_sata]	= &ich9_2port_map_db,
 };
 
 static struct ata_port_info piix_port_info[] = {
+	[piix_pata_mwdma] = 	/* PIIX3 MWDMA only */
+	{
+		.sht		= &piix_sht,
+		.flags		= PIIX_PATA_FLAGS,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
+		.port_ops	= &piix_pata_ops,
+	},
+
 	[piix_pata_33] =	/* PIIX4 at 33MHz */
 	{
 		.sht		= &piix_sht,
@@ -565,16 +574,7 @@ static struct ata_port_info piix_port_info[] = {
 		.port_ops	= &piix_sata_ops,
 	},
 
-	[piix_pata_mwdma] = 	/* PIIX3 MWDMA only */
-	{
-		.sht		= &piix_sht,
-		.flags		= PIIX_PATA_FLAGS,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
-		.port_ops	= &piix_pata_ops,
-	},
-
-	[tolapai_sata_ahci] =
+	[ich8_2port_sata] =
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -585,7 +585,7 @@ static struct ata_port_info piix_port_info[] = {
 		.port_ops	= &piix_sata_ops,
 	},
 
-	[ich9_2port_sata] =
+	[tolapai_sata_ahci] =
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-- 
1.5.2.4


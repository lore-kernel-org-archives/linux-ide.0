From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] ata_piix: strip now unneded MAP related stuff
Date: Fri, 10 Nov 2006 18:08:10 +0900
Message-ID: <11631496904023-git-send-email-htejun@gmail.com>
References: <11631496893280-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:1300 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1946098AbWKJJIW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 04:08:22 -0500
Received: by nz-out-0102.google.com with SMTP id l1so257954nzf
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 01:08:22 -0800 (PST)
In-Reply-To: <11631496893280-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that PCS isn't used for device detection anymore...

* esb_sata is identical to ich5_sata
* no reason to know present_shift
* no reason to store map_db in host private area

The MAP table itself is left because it can be used for SCR access.
---
 drivers/ata/ata_piix.c |   39 ++++++++++-----------------------------
 1 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 7bf2386..788a269 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -125,11 +125,10 @@ enum {
 	ich_pata_100		= 3,	/* ICH up to UDMA 100 */
 	ich_pata_133		= 4,	/* ICH up to UDMA 133 */
 	ich5_sata		= 5,
-	esb_sata		= 6,
-	ich6_sata		= 7,
-	ich6_sata_ahci		= 8,
-	ich6m_sata_ahci		= 9,
-	ich8_sata_ahci		= 10,
+	ich6_sata		= 6,
+	ich6_sata_ahci		= 7,
+	ich6m_sata_ahci		= 8,
+	ich8_sata_ahci		= 9,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -146,13 +145,11 @@ enum {
 struct piix_map_db {
 	const u32 mask;
 	const u16 port_enable;
-	const int present_shift;
 	const int map[][4];
 };
 
 struct piix_host_priv {
 	const int *map;
-	const struct piix_map_db *map_db;
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -217,9 +214,9 @@ static const struct pci_device_id piix_p
 	/* 82801EB (ICH5) */
 	{ 0x8086, 0x24df, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	/* 6300ESB (ICH5 variant with broken PCS present bits) */
-	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb_sata },
+	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	/* 6300ESB pretending RAID */
-	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb_sata },
+	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	/* 82801FB/FW (ICH6/ICH6W) */
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
 	/* 82801FR/FRW (ICH6R/ICH6RW) */
@@ -370,7 +367,6 @@ static const struct ata_port_operations
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.port_enable = 0x3,
-	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP  */
 		{  P0,  NA,  P1,  NA }, /* 000b */
@@ -387,7 +383,6 @@ static const struct piix_map_db ich5_map
 static const struct piix_map_db ich6_map_db = {
 	.mask = 0x3,
 	.port_enable = 0xf,
-	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b */
@@ -400,7 +395,6 @@ static const struct piix_map_db ich6_map
 static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x5,
-	.present_shift = 4,
 
 	/* Map 01b isn't specified in the doc but some notebooks use
 	 * it anyway.  MAP 01b have been spotted on both ICH6M and
@@ -418,7 +412,6 @@ static const struct piix_map_db ich6m_ma
 static const struct piix_map_db ich8_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x3,
-	.present_shift = 8,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
@@ -430,7 +423,6 @@ static const struct piix_map_db ich8_map
 
 static const struct piix_map_db *piix_map_db_table[] = {
 	[ich5_sata]		= &ich5_map_db,
-	[esb_sata]		= &ich5_map_db,
 	[ich6_sata]		= &ich6_map_db,
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
@@ -497,17 +489,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* i6300esb_sata: 6 */
-	{
-		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &piix_sata_ops,
-	},
-
-	/* ich6_sata: 7 */
+	/* ich6_sata: 6 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR,
@@ -517,7 +499,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich6_sata_ahci: 8 */
+	/* ich6_sata_ahci: 7 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -528,7 +510,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich6m_sata_ahci: 9 */
+	/* ich6m_sata_ahci: 8 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -539,7 +521,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich8_sata_ahci: 10 */
+	/* ich8_sata_ahci: 9 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -1046,7 +1028,6 @@ static void __devinit piix_init_sata_map
 			   "invalid MAP value %u\n", map_value);
 
 	hpriv->map = map;
-	hpriv->map_db = map_db;
 }
 
 /**
-- 
1.4.3.3



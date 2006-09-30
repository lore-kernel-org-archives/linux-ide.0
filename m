From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] ata_piix: strip now unneded MAP related stuff
Date: Sat, 30 Sep 2006 15:46:50 +0900
Message-ID: <11595988102485-git-send-email-htejun@gmail.com>
References: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:990 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWI3GrB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:47:01 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1162646wxc
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:47:01 -0700 (PDT)
In-Reply-To: <11595988092938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that PCS isn't used for device detection anymore...

* esb_sata is identical to ich5_sata
* no reason to know present_shift
* no reason to store map_db in host private area

The MAP table itself is left because it can be used for SCR access.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   44 ++++++++++++--------------------------------
 1 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a92c798..944d534 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -125,12 +125,11 @@ enum {
 	ich_pata_100		= 3,	/* ICH up to UDMA 100 */
 	ich_pata_133		= 4,	/* ICH up to UDMA 133 */
 	ich5_sata		= 5,
-	esb_sata		= 6,
-	ich6_sata		= 7,
-	ich6_sata_ahci		= 8,
-	ich6m_sata_ahci		= 9,
-	ich7m_sata_ahci		= 10,
-	ich8_sata_ahci		= 11,
+	ich6_sata		= 6,
+	ich6_sata_ahci		= 7,
+	ich6m_sata_ahci		= 8,
+	ich7m_sata_ahci		= 9,
+	ich8_sata_ahci		= 10,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -147,13 +146,11 @@ enum {
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
@@ -218,9 +215,9 @@ #endif
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
@@ -371,7 +368,6 @@ static const struct ata_port_operations 
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.port_enable = 0x3,
-	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP  */
 		{  P0,  NA,  P1,  NA }, /* 000b */
@@ -388,7 +384,6 @@ static const struct piix_map_db ich5_map
 static const struct piix_map_db ich6_map_db = {
 	.mask = 0x3,
 	.port_enable = 0xf,
-	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b */
@@ -401,7 +396,6 @@ static const struct piix_map_db ich6_map
 static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x5,
-	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  RV,  RV }, /* 00b */
@@ -414,7 +408,6 @@ static const struct piix_map_db ich6m_ma
 static const struct piix_map_db ich7m_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x5,
-	.present_shift = 4,
 
 	/* Map 01b isn't specified in the doc but some notebooks use
 	 * it anyway.  ATM, the only case spotted carries subsystem ID
@@ -432,7 +425,6 @@ static const struct piix_map_db ich7m_ma
 static const struct piix_map_db ich8_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x3,
-	.present_shift = 8,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  NA,  P1,  NA }, /* 00b (hardwired) */
@@ -444,7 +436,6 @@ static const struct piix_map_db ich8_map
 
 static const struct piix_map_db *piix_map_db_table[] = {
 	[ich5_sata]		= &ich5_map_db,
-	[esb_sata]		= &ich5_map_db,
 	[ich6_sata]		= &ich6_map_db,
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
@@ -512,17 +503,7 @@ static struct ata_port_info piix_port_in
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
@@ -532,7 +513,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich6_sata_ahci: 8 */
+	/* ich6_sata_ahci: 7 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -543,7 +524,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich6m_sata_ahci: 9 */
+	/* ich6m_sata_ahci: 8 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -554,7 +535,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich7m_sata_ahci: 10 */
+	/* ich7m_sata_ahci: 9 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -565,7 +546,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich8_sata_ahci: 11 */
+	/* ich8_sata_ahci: 10 */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
@@ -1043,7 +1024,6 @@ static void __devinit piix_init_sata_map
 			   "invalid MAP value %u\n", map_value);
 
 	hpriv->map = map;
-	hpriv->map_db = map_db;
 }
 
 /**
-- 
1.4.2.1



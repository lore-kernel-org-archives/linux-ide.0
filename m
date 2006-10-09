From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: allow 01b MAP for both ICH6M and ICH7M
Date: Mon, 9 Oct 2006 13:23:58 +0900
Message-ID: <20061009042358.GC10832@htj.dyndns.org>
References: <452268B1.8090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:20017 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932228AbWJIEYG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 00:24:06 -0400
Received: by py-out-1112.google.com with SMTP id n25so2161554pyg
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 21:24:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <452268B1.8090304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Dieter <jdieter@gmail.com>
Cc: linux-ide@vger.kernel.org, Tom Deblauwe <tom.deblauwe@telenet.be>

ICH7M was separated from ICH6M to allow undocumented MAP value 01b
which was spotted on an ASUS notebook.  However, there is also
notebooks with MAP value 01b on ICH6M.  This patch re-merges ICH6M and
ICH7M entries and allows MAP value 01b for both.

This problem has been reported and initial patch provided by Jonathan
Dieter.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jonathan Dieter <jdieter@gmail.com>
Cc: Tom Deblauwe <tom.deblauwe@telenet.be>
---
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 5719704..e0a329c 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -126,8 +126,7 @@ enum {
 	ich6_sata		= 7,
 	ich6_sata_ahci		= 8,
 	ich6m_sata_ahci		= 9,
-	ich7m_sata_ahci		= 10,
-	ich8_sata_ahci		= 11,
+	ich8_sata_ahci		= 10,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -227,7 +226,7 @@ #endif
 	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
-	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7m_sata_ahci },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
 	/* Enterprise Southbridge 2 (where's the datasheet?) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
@@ -399,23 +398,10 @@ static const struct piix_map_db ich6m_ma
 	.mask = 0x3,
 	.port_enable = 0x5,
 	.present_shift = 4,
-	.map = {
-		/* PM   PS   SM   SS       MAP */
-		{  P0,  P2,  RV,  RV }, /* 00b */
-		{  RV,  RV,  RV,  RV },
-		{  P0,  P2, IDE, IDE }, /* 10b */
-		{  RV,  RV,  RV,  RV },
-	},
-};
-
-static const struct piix_map_db ich7m_map_db = {
-	.mask = 0x3,
-	.port_enable = 0x5,
-	.present_shift = 4,
 
 	/* Map 01b isn't specified in the doc but some notebooks use
-	 * it anyway.  ATM, the only case spotted carries subsystem ID
-	 * 1025:0107.  This is the only difference from ich6m.
+	 * it anyway.  MAP 01b have been spotted on both ICH6M and
+	 * ICH7M.
 	 */
 	.map = {
 		/* PM   PS   SM   SS       MAP */
@@ -445,7 +431,6 @@ static const struct piix_map_db *piix_ma
 	[ich6_sata]		= &ich6_map_db,
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
-	[ich7m_sata_ahci]	= &ich7m_map_db,
 	[ich8_sata_ahci]	= &ich8_map_db,
 };
 
@@ -556,19 +541,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich7m_sata_ahci: 10 */
-	{
-		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &piix_sata_ops,
-	},
-
-	/* ich8_sata_ahci: 11 */
+	/* ich8_sata_ahci: 10 */
 	{
 		.sht		= &piix_sht,
 		.flags		= ATA_FLAG_SATA |

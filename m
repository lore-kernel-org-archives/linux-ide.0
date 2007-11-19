From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: only enable the first port on apple macbook pro
Date: Mon, 19 Nov 2007 13:16:00 +0900
Message-ID: <20071119041600.GB30919@htj.mynetwork.cxm>
References: <20071119041459.GA30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:55300 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbXKSEQF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 23:16:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1834894wah
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 20:16:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071119041459.GA30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: tr@tng.de

From: Thomas Rohwer <tr@tng.de>

ICH8M on apple macbook pro occasionally locks up completely during PCS
initialization if ports other than the first one are enabled.  Add a
separate controller ID and only enable the first port.

tj: commit description added and patch updated to fit with the
    previous controller ID update.

Signed-off-by: Thomas Rohwer <tr@tng.de>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
applied to #tj-upstream-fixes

 drivers/ata/ata_piix.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 77fea05..d5ff1d8 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -130,6 +130,7 @@ enum {
 	ich6m_sata_ahci,
 	ich8_sata_ahci,
 	ich8_2port_sata,
+	ich8m_apple_sata_ahci,		/* locks up on second port enable */
 	tolapai_sata_ahci,
 
 	/* constants for mapping table */
@@ -242,6 +243,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* Mobile SATA Controller IDE (ICH8M), Apple */
+	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata_ahci },
 	/* SATA Controller IDE (ICH9) */
 	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (ICH9) */
@@ -449,6 +452,18 @@ static const struct piix_map_db ich8_2port_map_db = {
 	},
 };
 
+static const struct piix_map_db ich8m_apple_map_db = {
+	.mask = 0x3,
+	.port_enable = 0x1,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  NA,  NA,  NA }, /* 00b */
+		{  RV,  RV,  RV,  RV },
+		{  P0,  P2, IDE, IDE }, /* 10b */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
 static const struct piix_map_db tolapai_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x3,
@@ -468,6 +483,7 @@ static const struct piix_map_db *piix_map_db_table[] = {
 	[ich6m_sata_ahci]	= &ich6m_map_db,
 	[ich8_sata_ahci]	= &ich8_map_db,
 	[ich8_2port_sata]	= &ich8_2port_map_db,
+	[ich8m_apple_sata_ahci]	= &ich8m_apple_map_db,
 	[tolapai_sata_ahci]	= &tolapai_map_db,
 };
 
@@ -595,6 +611,18 @@ static struct ata_port_info piix_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &piix_sata_ops,
 	},
+
+	[ich8m_apple_sata_ahci] =
+	{
+		.sht		= &piix_sht,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &piix_sata_ops,
+	},
+
 };
 
 static struct pci_bits piix_enable_bits[] = {
-- 
1.5.2.4


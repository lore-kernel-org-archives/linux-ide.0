From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] ata_piix: finer-grained port_info
Date: Wed, 1 Mar 2006 01:25:39 +0900
Message-ID: <11411439391790-git-send-email-htejun@gmail.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:22577 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751866AbWB1QZz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:55 -0500
Received: by zproxy.gmail.com with SMTP id k1so1294811nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:52 -0800 (PST)
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make port_info finer-grained.  This patch doesn't cause any functional
change.  Later init reimplementation will make use of it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   77 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 58 insertions(+), 19 deletions(-)

cd78103a27cf7b7f6bdfe30515708a683171d00d
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index c662bf5..5988d5f 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -119,11 +119,14 @@ enum {
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
 
-	ich5_pata		= 0,
-	ich5_sata		= 1,
-	piix4_pata		= 2,
-	ich6_sata		= 3,
-	ich6_sata_ahci		= 4,
+	/* controller IDs */
+	piix4_pata		= 0,
+	ich5_pata		= 1,
+	ich5_sata		= 2,
+	esb_sata		= 3,
+	ich6_sata		= 4,
+	ich6_sata_ahci		= 5,
+	ich6m_sata_ahci		= 6,
 
 	PIIX_AHCI_DEVICE	= 6,
 };
@@ -149,19 +152,32 @@ static const struct pci_device_id piix_p
 	 * list in drivers/pci/quirks.c.
 	 */
 
+	/* 82801EB (ICH5) */
 	{ 0x8086, 0x24d1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+	/* 82801EB (ICH5) */
 	{ 0x8086, 0x24df, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+	/* 6300ESB (ICH5 variant with broken PCS present bits) */
+	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb_sata },
+	/* 6300ESB pretending RAID */
+	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb_sata },
+	/* 82801FB/FW (ICH6/ICH6W) */
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
+	/* 82801FR/FRW (ICH6R/ICH6RW) */
 	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	/* 82801FBM ICH6M (ICH6R with only port 0 and 2 implemented) */
+	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
+	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
+	/* Enterprise Southbridge 2 (where's the datasheet?) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	/* SATA Controller 2 IDE (ICH8, ditto) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	/* Mobile SATA Controller IDE (ICH8M, ditto) */
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
 
 	{ }	/* terminate list */
 };
@@ -255,6 +271,20 @@ static const struct ata_port_operations 
 };
 
 static struct ata_port_info piix_port_info[] = {
+	/* piix4_pata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+#if 0
+		.mwdma_mask	= 0x06, /* mwdma1-2 */
+#else
+		.mwdma_mask	= 0x00, /* mwdma broken */
+#endif
+		.udma_mask	= ATA_UDMA_MASK_40C,
+		.port_ops	= &piix_pata_ops,
+	},
+
 	/* ich5_pata */
 	{
 		.sht		= &piix_sht,
@@ -280,18 +310,15 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* piix4_pata */
+	/* i6300esb_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
+				  PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
-#if 0
-		.mwdma_mask	= 0x06, /* mwdma1-2 */
-#else
-		.mwdma_mask	= 0x00, /* mwdma broken */
-#endif
-		.udma_mask	= ATA_UDMA_MASK_40C,
-		.port_ops	= &piix_pata_ops,
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
 	},
 
 	/* ich6_sata */
@@ -316,6 +343,18 @@ static struct ata_port_info piix_port_in
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* ich6m_sata_ahci */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
-- 
1.2.1



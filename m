From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] piix: ICH7 MWDMA1 errata
Date: Tue, 11 Oct 2011 19:24:55 +0200
Message-ID: <201110111924.55510.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] piix: ICH7 MWDMA1 errata

Based on libata commit c611bed7.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/piix.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: b/drivers/ide/piix.c
===================================================================
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -330,7 +330,7 @@ static const struct ide_port_ops ich_por
 		.udma_mask	= udma,			\
 	}
 
-#define DECLARE_ICH_DEV(udma) \
+#define DECLARE_ICH_DEV(mwdma, udma) \
 	{ \
 		.name		= DRV_NAME, \
 		.init_chipset	= init_chipset_ich, \
@@ -339,7 +339,7 @@ static const struct ide_port_ops ich_por
 		.port_ops	= &ich_port_ops, \
 		.pio_mask	= ATA_PIO4, \
 		.swdma_mask	= ATA_SWDMA2_ONLY, \
-		.mwdma_mask	= ATA_MWDMA12_ONLY, \
+		.mwdma_mask	= mwdma, \
 		.udma_mask	= udma, \
 	}
 
@@ -361,13 +361,15 @@ static const struct ide_port_info piix_p
 	/* 2: PIIX4 */
 	DECLARE_PIIX_DEV(ATA_UDMA2),
 	/* 3: ICH0 */
-	DECLARE_ICH_DEV(ATA_UDMA2),
+	DECLARE_ICH_DEV(ATA_MWDMA12_ONLY, ATA_UDMA2),
 	/* 4: ICH */
-	DECLARE_ICH_DEV(ATA_UDMA4),
+	DECLARE_ICH_DEV(ATA_MWDMA12_ONLY, ATA_UDMA4),
 	/* 5: PIIX4 */
 	DECLARE_PIIX_DEV(ATA_UDMA4),
-	/* 6: ICH[2-7]/ICH[2-3]M/C-ICH/ICH5-SATA/ESB2/ICH8M */
-	DECLARE_ICH_DEV(ATA_UDMA5),
+	/* 6: ICH[2-6]/ICH[2-3]M/C-ICH/ICH5-SATA/ESB2/ICH8M */
+	DECLARE_ICH_DEV(ATA_MWDMA12_ONLY, ATA_UDMA5),
+	/* 7: ICH7/7-R, no MWDMA1 */
+	DECLARE_ICH_DEV(ATA_MWDMA2_ONLY, ATA_UDMA5),
 };
 
 /**
@@ -437,9 +439,9 @@ static const struct pci_device_id piix_p
 #endif
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB_2),      6 },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH6_19),    6 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH7_21),    6 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH7_21),    7 },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801DB_1),  6 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB2_18),    6 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB2_18),    7 },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH8_6),     6 },
 	{ 0, },
 };

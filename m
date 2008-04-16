From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/07] sata_mv cosmetics
Date: Wed, 16 Apr 2008 14:56:51 -0400
Message-ID: <48064BF3.8010301@rtr.ca>
References: <48064BCC.5070505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2651 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbYDPS4w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 14:56:52 -0400
In-Reply-To: <48064BCC.5070505@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

More cosmetic cleanups to unclutter the changes needed for PMP support.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-14 13:36:50.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-15 18:16:29.000000000 -0400
@@ -224,14 +224,20 @@
 	SATA_STATUS_OFS		= 0x300,  /* ctrl, err regs follow status */
 	SATA_ACTIVE_OFS		= 0x350,
 	SATA_FIS_IRQ_CAUSE_OFS	= 0x364,
+
 	LTMODE_OFS		= 0x30c,
+	LTMODE_BIT8		= (1 << 8),	/* unknown, but necessary */
+
 	PHY_MODE3		= 0x310,
 	PHY_MODE4		= 0x314,
 	PHY_MODE2		= 0x330,
 	SATA_IFCTL_OFS		= 0x344,
 	SATA_IFSTAT_OFS		= 0x34c,
 	VENDOR_UNIQUE_FIS_OFS	= 0x35c,
+
 	FIS_CFG_OFS		= 0x360,
+	FIS_CFG_SINGLE_SYNC	= (1 << 16),	/* SYNC on DMA activation */
+
 	MV5_PHY_MODE		= 0x74,
 	MV5_LT_MODE		= 0x30,
 	MV5_PHY_CTL		= 0x0C,
@@ -616,10 +622,10 @@
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_soc */
-		.flags = MV_COMMON_FLAGS | MV_FLAG_SOC,
-		.pio_mask = 0x1f,      /* pio0-4 */
-		.udma_mask = ATA_UDMA6,
-		.port_ops = &mv_iie_ops,
+		.flags		= MV_COMMON_FLAGS | MV_FLAG_SOC,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &mv_iie_ops,
 	},
 };
 
@@ -1377,7 +1383,8 @@
 
 	if ((qc->tf.protocol != ATA_PROT_DMA) &&
 	    (qc->tf.protocol != ATA_PROT_NCQ)) {
-		/* We're about to send a non-EDMA capable command to the
+		/*
+		 * We're about to send a non-EDMA capable command to the
 		 * port.  Turn off EDMA so there won't be problems accessing
 		 * shadow block, etc registers.
 		 */
@@ -2293,14 +2300,13 @@
 
 	/* Workaround for errata FEr SATA#10 (part 2) */
 	do {
-		const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+		const unsigned long *timing =
+				sata_ehc_deb_timing(&link->eh_context);
 
-		rc = sata_link_hardreset(link, timing, deadline + extra, &online, NULL);
-		if (rc) {
-			ata_link_printk(link, KERN_ERR,
-					"COMRESET failed (errno=%d)\n", rc);
+		rc = sata_link_hardreset(link, timing, deadline + extra,
+					 &online, NULL);
+		if (rc)
 			return rc;
-		}
 		sata_scr_read(link, SCR_STATUS, &sstatus);
 		if (!IS_GEN_I(hpriv) && ++attempts >= 5 && sstatus == 0x121) {
 			/* Force 1.5gb/s link speed and try again */
@@ -2310,7 +2316,7 @@
 		}
 	} while (sstatus != 0x0 && sstatus != 0x113 && sstatus != 0x123);
 
-	return online ? -EAGAIN : rc;
+	return rc;
 }
 
 static void mv_eh_freeze(struct ata_port *ap)
@@ -2975,7 +2981,7 @@
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
-MODULE_ALIAS("platform:sata_mv");
+MODULE_ALIAS("platform:" DRV_NAME);
 
 #ifdef CONFIG_PCI
 module_param(msi, int, 0444);

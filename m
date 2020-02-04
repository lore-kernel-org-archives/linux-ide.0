Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE3C3524D
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D3620674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBDQ4U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbgBDQ4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 58A88B1E7;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 37/46] pata_pdc2027x: Replace PDPRINTK() with standard ata logging
Date:   Tue,  4 Feb 2020 17:55:38 +0100
Message-Id: <20200204165547.115220-38-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Use standard ata logging macros instead of the hand-crafted
PDPRINTK and remove duplicate logging messages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_pdc2027x.c | 81 ++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index de834fbb6dfe..2c397c135ccd 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -30,13 +30,6 @@
 
 #define DRV_NAME	"pata_pdc2027x"
 #define DRV_VERSION	"1.0"
-#undef PDC_DEBUG
-
-#ifdef PDC_DEBUG
-#define PDPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define PDPRINTK(fmt, args...)
-#endif
 
 enum {
 	PDC_MMIO_BAR		= 5,
@@ -214,11 +207,13 @@ static int pdc2027x_cable_detect(struct ata_port *ap)
 	if (cgcr & (1 << 26))
 		goto cbl40;
 
-	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
+	ata_port_dbg(ap, "No cable or 80-conductor cable on port %d\n",
+		     ap->port_no);
 
 	return ATA_CBL_PATA80;
 cbl40:
-	printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port %d\n", ap->port_no);
+	ata_port_info(ap, "40-conductor cable detected on port %d\n",
+		      ap->port_no);
 	return ATA_CBL_PATA40;
 }
 
@@ -292,17 +287,17 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	unsigned int pio = adev->pio_mode - XFER_PIO_0;
 	u32 ctcr0, ctcr1;
 
-	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);
+	ata_port_dbg(ap, "adev->pio_mode[%X]\n", adev->pio_mode);
 
 	/* Sanity check */
 	if (pio > 4) {
-		printk(KERN_ERR DRV_NAME ": Unknown pio mode [%d] ignored\n", pio);
+		ata_port_err(ap, "Unknown pio mode [%d] ignored\n", pio);
 		return;
 
 	}
 
 	/* Set the PIO timing registers using value table for 133MHz */
-	PDPRINTK("Set pio regs... \n");
+	ata_port_dbg(ap, "Set pio regs... \n");
 
 	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 	ctcr0 &= 0xffff0000;
@@ -315,9 +310,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
 	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-	PDPRINTK("Set pio regs done\n");
-
-	PDPRINTK("Set to pio mode[%u] \n", pio);
+	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);
 }
 
 /**
@@ -350,7 +343,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
 		}
 
-		PDPRINTK("Set udma regs... \n");
+		ata_port_dbg(ap, "Set udma regs... \n");
 
 		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
 		ctcr1 &= 0xff000000;
@@ -359,16 +352,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
 		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-		PDPRINTK("Set udma regs done\n");
-
-		PDPRINTK("Set to udma mode[%u] \n", udma_mode);
+		ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);
 
 	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
 		   (dma_mode <= XFER_MW_DMA_2)) {
 		/* Set the MDMA timing registers with value table for 133MHz */
 		unsigned int mdma_mode = dma_mode & 0x07;
 
-		PDPRINTK("Set mdma regs... \n");
+		ata_port_dbg(ap, "Set mdma regs... \n");
 		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 
 		ctcr0 &= 0x0000ffff;
@@ -376,11 +367,10 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			(pdc2027x_mdma_timing_tbl[mdma_mode].value1 << 24);
 
 		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
-		PDPRINTK("Set mdma regs done\n");
 
-		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);
+		ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);
 	} else {
-		printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", dma_mode);
+		ata_port_err(ap, "Unknown dma mode [%u] ignored\n", dma_mode);
 	}
 }
 
@@ -414,7 +404,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
 			ctcr1 |= (1 << 25);
 			iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
 
-			PDPRINTK("Turn on prefetch\n");
+			ata_dev_dbg(dev, "Turn on prefetch\n");
 		} else {
 			pdc2027x_set_dmamode(ap, dev);
 		}
@@ -485,8 +475,10 @@ static long pdc_read_counter(struct ata_host *host)
 
 	counter = (bccrh << 15) | bccrl;
 
-	PDPRINTK("bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
-	PDPRINTK("bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
+	dev_dbg(host->dev, "%s: bccrh [%X] bccrl [%X]\n",
+		__func__, bccrh,  bccrl);
+	dev_dbg(host->dev, "%s: bccrhv[%X] bccrlv[%X]\n",
+		__func__, bccrhv, bccrlv);
 
 	/*
 	 * The 30-bit decreasing counter are read by 2 pieces.
@@ -495,7 +487,7 @@ static long pdc_read_counter(struct ata_host *host)
 	 */
 	if (retry && !(bccrh == bccrhv && bccrl >= bccrlv)) {
 		retry--;
-		PDPRINTK("rereading counter\n");
+		dev_dbg(host->dev, "%s: rereading counter\n", __func__);
 		goto retry;
 	}
 
@@ -520,20 +512,21 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 
 	/* Sanity check */
 	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
-		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
+		dev_err(host->dev,
+			"Invalid PLL input clock %ldkHz, give up!\n",
+			pll_clock_khz);
 		return;
 	}
 
-#ifdef PDC_DEBUG
-	PDPRINTK("pout_required is %ld\n", pout_required);
+	dev_dbg(host->dev, "%s: pout_required is %ld\n",
+		__func__, pout_required);
 
 	/* Show the current clock value of PLL control register
 	 * (maybe already configured by the firmware)
 	 */
 	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
 
-	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
-#endif
+	dev_dbg(host->dev, "%s: pll_ctl[%X]\n", __func__, pll_ctl);
 
 	/*
 	 * Calculate the ratio of F, R and OD
@@ -552,7 +545,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 		R = 0x00;
 	} else {
 		/* Invalid ratio */
-		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
+		dev_err(host->dev, "Invalid ratio %ld, give up!\n", ratio);
 		return;
 	}
 
@@ -560,15 +553,16 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 
 	if (unlikely(F < 0 || F > 127)) {
 		/* Invalid F */
-		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
+		dev_err(host->dev, "F[%d] invalid!\n", F);
 		return;
 	}
 
-	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
+	dev_dbg(host->dev, "%s: F[%d] R[%d] ratio*1000[%ld]\n",
+		__func__, F, R, ratio);
 
 	pll_ctl = (R << 8) | F;
 
-	PDPRINTK("Writing pll_ctl[%X]\n", pll_ctl);
+	dev_dbg(host->dev, "%s: Writing pll_ctl[%X]\n", __func__, pll_ctl);
 
 	iowrite16(pll_ctl, mmio_base + PDC_PLL_CTL);
 	ioread16(mmio_base + PDC_PLL_CTL); /* flush */
@@ -576,15 +570,12 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	/* Wait the PLL circuit to be stable */
 	msleep(30);
 
-#ifdef PDC_DEBUG
 	/*
 	 *  Show the current clock value of PLL control register
 	 * (maybe configured by the firmware)
 	 */
-	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
-
-	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
-#endif
+	dev_dbg(host->dev, "%s: pll_ctl[%X]\n", __func__,
+		ioread16(mmio_base + PDC_PLL_CTL));
 
 	return;
 }
@@ -605,7 +596,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 
 	/* Start the test mode */
 	scr = ioread32(mmio_base + PDC_SYS_CTL);
-	PDPRINTK("scr[%X]\n", scr);
+	dev_dbg(host->dev, "%s: scr[%X]\n", __func__, scr);
 	iowrite32(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
 	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
@@ -622,7 +613,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 
 	/* Stop the test mode */
 	scr = ioread32(mmio_base + PDC_SYS_CTL);
-	PDPRINTK("scr[%X]\n", scr);
+	dev_dbg(host->dev, "%s: scr[%X]\n", __func__, scr);
 	iowrite32(scr & ~(0x01 << 14), mmio_base + PDC_SYS_CTL);
 	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
@@ -632,8 +623,8 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
 		(100000000 / usec_elapsed);
 
-	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
-	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
+	dev_dbg(host->dev, "%s: start[%ld] end[%ld] PLL input clock[%ld]HZ\n",
+		__func__, start_count, end_count, pll_clock);
 
 	return pll_clock;
 }
-- 
2.16.4


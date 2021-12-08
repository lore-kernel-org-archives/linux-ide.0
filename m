Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F39AC4321E
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhLHQgq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 879E41FE15;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIWtJ061dNZxVhkMNbtLB5KwIXLdM8iTsZlGUw0n2EE=;
        b=1+jEO4OApwCBhkLof4hBuTn1clO1S8e0HFdtxXCfEStKxIFDU//HBEW3sgHVujbcgSBW/7
        nDBdRpkF4HQP0nu8P2UDp1ahAIybwLwk1tFLCDQvWpxdoJRY6NS80Y+ZBDnhMO7DpdpQQE
        B9iGb2fa544Qx6R5wNdOv3HvNKDL3HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIWtJ061dNZxVhkMNbtLB5KwIXLdM8iTsZlGUw0n2EE=;
        b=nfMgPW+VbJbP9XWpCya7G5cN0/sZAkvvLAgmTMSu3bf4Bl0GNFbZjRkzu87rpowtyjOZDW
        9SPlGGWyQ0IBXjDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 82D6FA3BB0;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 7E7D45191F97; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 29/73] pata_pdc2027x: Replace PDPRINTK() with standard ata logging
Date:   Wed,  8 Dec 2021 17:32:11 +0100
Message-Id: <20211208163255.114660-30-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Use standard ata logging macros instead of the hand-crafted
PDPRINTK and remove duplicate logging messages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_pdc2027x.c | 71 +++++++++++++++----------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index effc1a09444d..4fbb3eed8b0b 100644
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
@@ -214,11 +207,11 @@ static int pdc2027x_cable_detect(struct ata_port *ap)
 	if (cgcr & (1 << 26))
 		goto cbl40;
 
-	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
+	ata_port_dbg(ap, "No cable or 80-conductor cable\n");
 
 	return ATA_CBL_PATA80;
 cbl40:
-	printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port %d\n", ap->port_no);
+	ata_port_info(ap, DRV_NAME ":40-conductor cable detected\n");
 	return ATA_CBL_PATA40;
 }
 
@@ -292,17 +285,17 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
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
@@ -315,9 +308,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
 	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
-	PDPRINTK("Set pio regs done\n");
-
-	PDPRINTK("Set to pio mode[%u] \n", pio);
+	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);
 }
 
 /**
@@ -350,7 +341,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
 		}
 
-		PDPRINTK("Set udma regs... \n");
+		ata_port_dbg(ap, "Set udma regs... \n");
 
 		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
 		ctcr1 &= 0xff000000;
@@ -359,16 +350,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
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
@@ -376,11 +365,10 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
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
 
@@ -414,7 +402,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
 			ctcr1 |= (1 << 25);
 			iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
 
-			PDPRINTK("Turn on prefetch\n");
+			ata_dev_dbg(dev, "Turn on prefetch\n");
 		} else {
 			pdc2027x_set_dmamode(ap, dev);
 		}
@@ -485,8 +473,8 @@ static long pdc_read_counter(struct ata_host *host)
 
 	counter = (bccrh << 15) | bccrl;
 
-	PDPRINTK("bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
-	PDPRINTK("bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
+	dev_dbg(host->dev, "bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
+	dev_dbg(host->dev, "bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
 
 	/*
 	 * The 30-bit decreasing counter are read by 2 pieces.
@@ -495,7 +483,7 @@ static long pdc_read_counter(struct ata_host *host)
 	 */
 	if (retry && !(bccrh == bccrhv && bccrl >= bccrlv)) {
 		retry--;
-		PDPRINTK("rereading counter\n");
+		dev_dbg(host->dev, "rereading counter\n");
 		goto retry;
 	}
 
@@ -520,20 +508,19 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 
 	/* Sanity check */
 	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
-		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
+		dev_err(host->dev, "Invalid PLL input clock %ldkHz, give up!\n",
+			pll_clock_khz);
 		return;
 	}
 
-#ifdef PDC_DEBUG
-	PDPRINTK("pout_required is %ld\n", pout_required);
+	dev_dbg(host->dev, "pout_required is %ld\n", pout_required);
 
 	/* Show the current clock value of PLL control register
 	 * (maybe already configured by the firmware)
 	 */
 	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
 
-	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
-#endif
+	dev_dbg(host->dev, "pll_ctl[%X]\n", pll_ctl);
 
 	/*
 	 * Calculate the ratio of F, R and OD
@@ -552,7 +539,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 		R = 0x00;
 	} else {
 		/* Invalid ratio */
-		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
+		dev_err(host->dev, "Invalid ratio %ld, give up!\n", ratio);
 		return;
 	}
 
@@ -560,15 +547,15 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 
 	if (unlikely(F < 0 || F > 127)) {
 		/* Invalid F */
-		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
+		dev_err(host->dev, "F[%d] invalid!\n", F);
 		return;
 	}
 
-	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
+	dev_dbg(host->dev, "F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
 
 	pll_ctl = (R << 8) | F;
 
-	PDPRINTK("Writing pll_ctl[%X]\n", pll_ctl);
+	dev_dbg(host->dev, "Writing pll_ctl[%X]\n", pll_ctl);
 
 	iowrite16(pll_ctl, mmio_base + PDC_PLL_CTL);
 	ioread16(mmio_base + PDC_PLL_CTL); /* flush */
@@ -576,15 +563,13 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	/* Wait the PLL circuit to be stable */
 	msleep(30);
 
-#ifdef PDC_DEBUG
 	/*
 	 *  Show the current clock value of PLL control register
 	 * (maybe configured by the firmware)
 	 */
 	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
 
-	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
-#endif
+	dev_dbg(host->dev, "pll_ctl[%X]\n", pll_ctl);
 
 	return;
 }
@@ -605,7 +590,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 
 	/* Start the test mode */
 	scr = ioread32(mmio_base + PDC_SYS_CTL);
-	PDPRINTK("scr[%X]\n", scr);
+	dev_dbg(host->dev, "scr[%X]\n", scr);
 	iowrite32(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
 	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
@@ -622,7 +607,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 
 	/* Stop the test mode */
 	scr = ioread32(mmio_base + PDC_SYS_CTL);
-	PDPRINTK("scr[%X]\n", scr);
+	dev_dbg(host->dev, "scr[%X]\n", scr);
 	iowrite32(scr & ~(0x01 << 14), mmio_base + PDC_SYS_CTL);
 	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
@@ -632,8 +617,8 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
 	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
 		(100000000 / usec_elapsed);
 
-	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
-	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
+	dev_dbg(host->dev, "start[%ld] end[%ld] PLL input clock[%ld]HZ\n",
+		     start_count, end_count, pll_clock);
 
 	return pll_clock;
 }
-- 
2.29.2


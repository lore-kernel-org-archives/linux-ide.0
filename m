From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/12] sata_mv wait for empty+idle
Date: Fri, 02 May 2008 02:09:14 -0400
Message-ID: <481AB00A.3000206@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1120 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756370AbYEBGJQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:09:16 -0400
In-Reply-To: <481AAFE0.9090101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

When performing EH, it is recommended to wait for the EDMA engine
to empty out requests-in-progress before disabling EDMA.

Introduce code to poll the EDMA_STATUS register for idle/empty bits
before disabling EDMA.  For non-EH operation, this will normally exit
without delay, other than the register read.

A later series of patches may focus on eliminating this and various
other register reads (when possible) throughout the driver,
but for now we're focussing on solid reliablity.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 17:49:53.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 17:56:54.000000000 -0400
@@ -888,6 +888,25 @@
 	}
 }
 
+static void mv_wait_for_edma_empty_idle(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	const u32 empty_idle = (EDMA_STATUS_CACHE_EMPTY | EDMA_STATUS_IDLE);
+	const int per_loop = 5, timeout = (15 * 1000 / per_loop);
+	int i;
+
+	/*
+	 * Wait for the EDMA engine to finish transactions in progress.
+	 */
+	for (i = 0; i < timeout; ++i) {
+		u32 edma_stat = readl(port_mmio + EDMA_STATUS_OFS);
+		if ((edma_stat & empty_idle) == empty_idle)
+			break;
+		udelay(per_loop);
+	}
+	/* ata_port_printk(ap, KERN_INFO, "%s: %u+ usecs\n", __func__, i); */
+}
+
 /**
  *      mv_stop_edma_engine - Disable eDMA engine
  *      @port_mmio: io base address
@@ -920,6 +939,7 @@
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
 		return 0;
 	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
+	mv_wait_for_edma_empty_idle(ap);
 	if (mv_stop_edma_engine(port_mmio)) {
 		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
 		return -EIO;

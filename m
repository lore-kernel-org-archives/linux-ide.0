From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 1/4] libata sata_qstor fix oops on rmmod
Date: Wed, 07 Nov 2007 10:51:34 -0500
Message-ID: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4397 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbXKGPvg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 10:51:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_qstor fix oops on rmmod.

sata_qstor likes to disable the chip on module unload,
so it provides a libata "host_stop" method to do this.
But in recent kernels, this routine is now called too late,
after the PCI mmio resources have already been released.
Which produces an oops.

This really needs to be fixed higher up.
For an interim workaround, we disable this function for now.

This belongs in 2.6.24.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_qstor.c	2007-10-12 12:43:44.000000000 -0400
+++ linux/drivers/ata/sata_qstor.c	2007-11-06 22:32:34.000000000 -0500
@@ -523,10 +523,20 @@
 
 static void qs_host_stop(struct ata_host *host)
 {
+#if 0
+	/*
+	 * This code used to work, but now segfaults
+	 * because we get called *after* our mmio resources
+	 * have already been unmapped.  That's probably a bug
+	 * in an upper layer somewhere, so this code has been
+	 * disabled (but left in place) until it gets tracked
+	 * down properly.
+	 */
 	void __iomem *mmio_base = qs_mmio_base(host);
 
 	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
+#endif
 }
 
 static void qs_host_init(struct ata_host *host, unsigned int chip_id)

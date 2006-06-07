From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2.6.17-rc6] sata_mv: grab host lock inside eng_timeout
Date: Wed, 7 Jun 2006 12:53:29 -0400
Message-ID: <200606071253.29745.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:31127 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932329AbWFGQxh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2006 12:53:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>

Bug fix:  mv_eng_timeout() calls mv_err_intr() without first grabbing the host lock,
which can lead to all sorts of interesting scenarios.

This whole error-handling portion of sata_mv is nasty (and will get fixed for
the new EH stuff), but for now this patch will help keep it on life-support.

Signed-off-by:  Mark Lord <liml@rtr.ca>
---

--- linux/drivers/scsi/sata_mv.c.orig	2006-06-07 12:30:08.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-06-07 12:30:55.000000000 -0400
@@ -2035,6 +2035,7 @@
 static void mv_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
+	unsigned long flags;
 
 	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
 	DPRINTK("All regs @ start of eng_timeout\n");
@@ -2046,8 +2047,10 @@
 	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
 	mv_err_intr(ap, 0);
 	mv_stop_and_reset(ap);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
 	if (qc->flags & ATA_QCFLAG_ACTIVE) {

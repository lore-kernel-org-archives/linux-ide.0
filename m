From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] sil24: add sil24_restart_controller
Date: Fri, 18 Nov 2005 14:09:05 +0900
Message-ID: <20051118050905.GB27358@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:10624 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVKRFJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2005 00:09:23 -0500
Received: by zproxy.gmail.com with SMTP id 14so104022nzn
        for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 21:09:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

When an error condition is raised by device via D2H FIS or SDB.  sil24
controller should be restarted by setting PORT_CS_INIT and waiting
until PORT_CS_RDY is asserted instead of resetting the controller.
This patch implements sil24_restart_controller for those cases.  This
patch also makes sure that PORT_CS_RDY is asserted on
sil24_reset_controller completion.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jeff, delay is reduced to 1us and cnt increased to 10k.  My sil3124
turns on PORT_CS_RDY on the second iteration even without any delay.
I think 10k * 1us should be more than enough.

I tried to convert both restart and reset to use msleep's with work
queue, but if we do that, host_set lock should be released after
initiating restart or reset, leading to race condition among
reset/restart, other interrupts and timeout.  Implementing
synchronization among those in low-level driver doesn't seem right.
Well, reduced timeout should work for the time being.

Thanks.

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-18 13:57:47.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-18 13:57:51.000000000 +0900
@@ -486,6 +486,31 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
+static int __sil24_restart_controller(void __iomem *port)
+{
+	u32 tmp;
+	int cnt;
+
+	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
+
+	/* Max ~10ms */
+	for (cnt = 0; cnt < 10000; cnt++) {
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (tmp & PORT_CS_RDY)
+			return 0;
+		udelay(1);
+	}
+
+	return -1;
+}
+
+static void sil24_restart_controller(struct ata_port *ap)
+{
+	if (__sil24_restart_controller((void __iomem *)ap->ioaddr.cmd_addr))
+		printk(KERN_ERR DRV_NAME
+		       " ata%u: failed to restart controller\n", ap->id);
+}
+
 static int __sil24_reset_controller(void __iomem *port)
 {
 	int cnt;
@@ -505,7 +530,11 @@ static int __sil24_reset_controller(void
 
 	if (tmp & PORT_CS_DEV_RST)
 		return -1;
-	return 0;
+
+	if (tmp & PORT_CS_RDY)
+		return 0;
+
+	return __sil24_restart_controller(port);
 }
 
 static void sil24_reset_controller(struct ata_port *ap)
@@ -577,6 +606,7 @@ static void sil24_error_intr(struct ata_
 		 */
 		sil24_update_tf(ap);
 		err_mask = ac_err_mask(pp->tf.command);
+		sil24_restart_controller(ap);
 	} else {
 		/*
 		 * Other errors.  libata currently doesn't have any
@@ -584,12 +614,11 @@ static void sil24_error_intr(struct ata_
 		 * ATA_ERR.
 		 */
 		err_mask = AC_ERR_OTHER;
+		sil24_reset_controller(ap);
 	}
 
 	if (qc)
 		ata_qc_complete(qc, err_mask);
-
-	sil24_reset_controller(ap);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)

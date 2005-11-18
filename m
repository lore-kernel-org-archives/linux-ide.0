From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] sil24: make error_intr less verbose
Date: Fri, 18 Nov 2005 14:22:03 +0900
Message-ID: <20051118052203.GE27358@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:22349 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030236AbVKRFWK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2005 00:22:10 -0500
Received: by zproxy.gmail.com with SMTP id 13so113051nzn
        for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 21:22:10 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

sil24_error_intr logs all error interrupts.  ATAPI devices generates
many harmless errors which can be ignored and all serious ones are
reported via sense data by SCSI layer.  Don't log device errors from
ATAPI devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-18 14:15:02.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-18 14:17:25.000000000 +0900
@@ -684,9 +684,15 @@ static void sil24_error_intr(struct ata_
 	if (serror)
 		writel(serror, port + PORT_SERROR);
 
-	printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
-	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
-	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
+	/*
+	 * Don't log ATAPI device errors.  They're supposed to happen
+	 * and any serious errors will be logged using sense data by
+	 * the SCSI layer.
+	 */
+	if (ap->device[0].class != ATA_DEV_ATAPI || cmd_err > PORT_CERR_SDB)
+		printk("ata%u: error interrupt on port%d\n"
+		       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
+		       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
 
 	if (cmd_err == PORT_CERR_DEV || cmd_err == PORT_CERR_SDB) {
 		/*

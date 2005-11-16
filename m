From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] sil24:  make error_intr less verbose
Date: Wed, 16 Nov 2005 17:09:35 +0900
Message-ID: <20051116080935.GE22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:26473 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030214AbVKPIJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 03:09:42 -0500
Received: by zproxy.gmail.com with SMTP id 13so1711422nzn
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 00:09:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

sil24_error_intr is too verbose.  Shut it up.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-16 17:05:19.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-16 17:08:05.000000000 +0900
@@ -678,9 +678,9 @@ static void sil24_error_intr(struct ata_
 	if (serror)
 		writel(serror, port + PORT_SERROR);
 
-	printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
-	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
-	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
+	DPRINTK("ata%u: error interrupt on port%d\n"
+		"  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
+		ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
 
 	if (cmd_err == PORT_CERR_DEV || cmd_err == PORT_CERR_SDB) {
 		/*

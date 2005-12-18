From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata: export ata_busy_sleep()
Date: Sun, 18 Dec 2005 22:41:21 +0900
Message-ID: <20051218134121.GE31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:54917 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932707AbVLRNl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:41:26 -0500
Received: by zproxy.gmail.com with SMTP id 14so1715173nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:41:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Some low level drivers need ata_busy_sleep while performing resets.
Export it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-18 20:50:11.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-18 20:50:22.000000000 +0900
@@ -61,9 +61,6 @@
 
 #include "libata.h"
 
-static unsigned int ata_busy_sleep (struct ata_port *ap,
-				    unsigned long tmout_pat,
-			    	    unsigned long tmout);
 static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev);
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
@@ -1893,9 +1890,8 @@ err_out:
  *
  */
 
-static unsigned int ata_busy_sleep (struct ata_port *ap,
-				    unsigned long tmout_pat,
-			    	    unsigned long tmout)
+unsigned int ata_busy_sleep (struct ata_port *ap,
+			     unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
 	u8 status;
@@ -5324,6 +5320,7 @@ EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-12-18 20:49:56.000000000 +0900
+++ work/include/linux/libata.h	2005-12-18 20:50:22.000000000 +0900
@@ -457,6 +457,9 @@ extern int ata_scsi_error(struct Scsi_Ho
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_ratelimit(void);
+extern unsigned int ata_busy_sleep(struct ata_port *ap,
+				   unsigned long timeout_pat,
+				   unsigned long timeout);
 
 /*
  * Default driver ops implementations

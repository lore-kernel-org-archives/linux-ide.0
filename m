From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/05] libata: export ata_busy_sleep
Date: Mon, 19 Dec 2005 22:35:46 +0900
Message-ID: <20051219133546.GB26769@htj.dyndns.org>
References: <20051219133502.GA26769@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:35778 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932111AbVLSNfv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 08:35:51 -0500
Received: by zproxy.gmail.com with SMTP id 14so1921271nzn
        for <linux-ide@vger.kernel.org>; Mon, 19 Dec 2005 05:35:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051219133502.GA26769@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Export ata_busy_sleep().

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fb1e186..b03d412 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,9 +61,6 @@
 
 #include "libata.h"
 
-static unsigned int ata_busy_sleep (struct ata_port *ap,
-				    unsigned long tmout_pat,
-			    	    unsigned long tmout);
 static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev);
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
@@ -1896,9 +1893,8 @@ err_out:
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
@@ -5008,6 +5004,7 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7e38705..d90909c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -447,6 +447,9 @@ extern int ata_scsi_error(struct Scsi_Ho
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_ratelimit(void);
+extern unsigned int ata_busy_sleep(struct ata_port *ap,
+				   unsigned long timeout_pat,
+				   unsigned long timeout);
 
 /*
  * Default driver ops implementations

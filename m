From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: export ata_busy_sleep
Date: Tue, 24 Jan 2006 17:05:21 +0900
Message-ID: <113808992179-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:55317 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030233AbWAXIF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:29 -0500
Received: by wproxy.gmail.com with SMTP id 57so1047990wri
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:28 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Export ata_busy_sleep(), to be used by low level driver reset functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++------
 include/linux/libata.h     |    3 +++
 2 files changed, 6 insertions(+), 6 deletions(-)

902e47427cf54147ffa1450794b5d953696ea10e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a6be973..bc13729 100644
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
@@ -2007,9 +2004,8 @@ err_out:
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
@@ -5207,6 +5203,7 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7837ba3..b33f035 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -503,6 +503,9 @@ extern int ata_scsi_device_suspend(struc
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
 extern int ata_device_suspend(struct ata_port *, struct ata_device *);
 extern int ata_ratelimit(void);
+extern unsigned int ata_busy_sleep(struct ata_port *ap,
+				   unsigned long timeout_pat,
+				   unsigned long timeout);
 
 /*
  * Default driver ops implementations
-- 
1.1.3



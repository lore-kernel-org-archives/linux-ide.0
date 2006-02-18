From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] rate-limit libata-scsi status/error message
Date: Fri, 17 Feb 2006 21:37:33 -0800
Message-ID: <20060217213733.36040150.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:46828 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750830AbWBRFgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Feb 2006 00:36:38 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2006 21:36:37 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Rate-limit a translated ATA status/error message.
I have a kernel log that is 2/3 full of these messages
due to a CD/DVD drive being empty.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/libata-scsi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2616-rc4.orig/drivers/scsi/libata-scsi.c
+++ linux-2616-rc4/drivers/scsi/libata-scsi.c
@@ -520,9 +520,10 @@ void ata_to_sense_error(unsigned id, u8 
 	*ascq = 0x04; /*  "auto-reallocation failed" */
 
  translate_done:
-	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
-	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
-	       *sk, *asc, *ascq);
+	if (printk_ratelimit())
+		printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
+			"SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n",
+			id, drv_stat, drv_err, *sk, *asc, *ascq);
 	return;
 }
 


---

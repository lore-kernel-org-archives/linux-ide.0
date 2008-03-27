From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: kill unused ata_flush_cache()
Date: Thu, 27 Mar 2008 19:14:25 +0900
Message-ID: <12066128663976-git-send-email-htejun@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1304 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbYC0KOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 06:14:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4737787wah.23
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 03:14:35 -0700 (PDT)
In-Reply-To: <12066128663306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

ata_flush_code() hasn't been in use for quite some time now.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-core.c |   26 --------------------------
 drivers/ata/libata.h      |    1 -
 2 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1a8601f..aba9a71 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6475,32 +6475,6 @@ int ata_link_offline(struct ata_link *link)
 	return 0;
 }
 
-int ata_flush_cache(struct ata_device *dev)
-{
-	unsigned int err_mask;
-	u8 cmd;
-
-	if (!ata_try_flush_cache(dev))
-		return 0;
-
-	if (dev->flags & ATA_DFLAG_FLUSH_EXT)
-		cmd = ATA_CMD_FLUSH_EXT;
-	else
-		cmd = ATA_CMD_FLUSH;
-
-	/* This is wrong. On a failed flush we get back the LBA of the lost
-	   sector and we should (assuming it wasn't aborted as unknown) issue
-	   a further flush command to continue the writeback until it
-	   does not error */
-	err_mask = ata_do_simple_cmd(dev, cmd);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 			       unsigned int action, unsigned int ehi_flags,
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 20edee0..e48d17f 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -96,7 +96,6 @@ extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
-extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
 extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
 extern int sata_link_init_spd(struct ata_link *link);
-- 
1.5.2.4


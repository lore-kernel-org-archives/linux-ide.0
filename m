From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/8] libata: move ata_flush_cache() from libata-core.c to libata-eh.c
Date: Wed, 28 Jun 2006 15:23:05 +0900
Message-ID: <11514757852722-git-send-email-htejun@gmail.com>
References: <11514757842728-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:14514 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030441AbWF1GWr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:22:47 -0400
Received: by wr-out-0506.google.com with SMTP id i24so346493wra
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 23:22:46 -0700 (PDT)
In-Reply-To: <11514757842728-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With recent PM reimplementation, there's no user left in
libata-core.c.  Move the function to libata-eh.c and make it static.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   22 ----------------------
 drivers/scsi/libata-eh.c   |   22 ++++++++++++++++++++++
 drivers/scsi/libata.h      |    1 -
 3 files changed, 22 insertions(+), 23 deletions(-)

563390c48a0dfaee3eb26e36b1cd4bad877087e2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7e584c9..e42a7f6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4981,28 +4981,6 @@ int ata_port_offline(struct ata_port *ap
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
-	if (ata_id_has_flush_ext(dev->id))
-		cmd = ATA_CMD_FLUSH_EXT;
-	else
-		cmd = ATA_CMD_FLUSH;
-
-	err_mask = ata_do_simple_cmd(dev, cmd);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index f05334a..1c2b48c 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1653,6 +1653,28 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
 }
 
+static int ata_flush_cache(struct ata_device *dev)
+{
+	unsigned int err_mask;
+	u8 cmd;
+
+	if (!ata_try_flush_cache(dev))
+		return 0;
+
+	if (ata_id_has_flush_ext(dev->id))
+		cmd = ATA_CMD_FLUSH_EXT;
+	else
+		cmd = ATA_CMD_FLUSH;
+
+	err_mask = ata_do_simple_cmd(dev, cmd);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /**
  *	ata_eh_suspend - handle suspend EH action
  *	@ap: target host port
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c325679..990d0b4 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -65,7 +65,6 @@ extern int ata_check_atapi_dma(struct at
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
-extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
-- 
1.3.2



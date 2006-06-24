From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/15] libata: move ata_flush_cache() from libata-core.c to libata-eh.c
Date: Sat, 24 Jun 2006 20:30:20 +0900
Message-ID: <11511486203054-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:19846 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933044AbWFXLaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:14 -0400
Received: by nz-out-0102.google.com with SMTP id o37so445543nzf
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:13 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
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

31f414d15d2994866853e48ee4d9c94d7dd21a59
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5e9108e..1aa8a03 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4974,28 +4974,6 @@ int ata_port_offline(struct ata_port *ap
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
index 16ce23a..539b0b5 100644
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



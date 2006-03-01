From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: convert dev->id to pointer
Date: Wed, 1 Mar 2006 16:09:35 +0900
Message-ID: <11411969753100-git-send-email-htejun@gmail.com>
References: <11411969752304-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:6973 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932562AbWCAHJo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 02:09:44 -0500
Received: by zproxy.gmail.com with SMTP id m7so71451nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 23:09:41 -0800 (PST)
In-Reply-To: <11411969752304-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert dev->id from array to pointer.  This is to accomodate
revalidation.  During revalidation, both old and new IDENTIFY pages
should be accessible and single ->id array doesn't cut it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 +++++++++++++++++---
 include/linux/libata.h     |    2 +-
 2 files changed, 18 insertions(+), 4 deletions(-)

6ae458d0e6b0f04d5092e79a8e45a4c187037d27
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 436520e..a630cda 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -907,7 +907,7 @@ unsigned int ata_pio_need_iordy(const st
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
  *	@post_reset: is this read ID post-reset?
- *	@id: buffer to fill IDENTIFY page into
+ *	@p_id: read IDENTIFY page (newly allocated)
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
  *	performed on ATA devices and ATA_CMD_ID_ATAPI on ATAPI
@@ -922,12 +922,13 @@ unsigned int ata_pio_need_iordy(const st
  *	0 on success, -errno otherwise.
  */
 static int ata_dev_read_id(struct ata_port *ap, struct ata_device *dev,
-			   unsigned int *p_class, int post_reset, u16 *id)
+			   unsigned int *p_class, int post_reset, u16 **p_id)
 {
 	unsigned int class = *p_class;
 	unsigned int using_edd;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
+	u16 *id;
 	const char *reason;
 	int rc;
 
@@ -941,6 +942,13 @@ static int ata_dev_read_id(struct ata_po
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
+	id = kmalloc(sizeof(id[0]) * ATA_ID_WORDS, GFP_KERNEL);
+	if (id == NULL) {
+		rc = -ENOMEM;
+		reason = "out of memory";
+		goto err_out;
+	}
+
  retry:
 	ata_tf_init(ap, &tf, dev->devno);
 
@@ -1031,11 +1039,13 @@ static int ata_dev_read_id(struct ata_po
 	}
 
 	*p_class = class;
+	*p_id = id;
 	return 0;
 
  err_out:
 	printk(KERN_WARNING "ata%u: dev %u failed to IDENTIFY (%s)\n",
 	       ap->id, dev->devno, reason);
+	kfree(id);
 	return rc;
 }
 
@@ -1075,7 +1085,8 @@ static void ata_dev_identify(struct ata_
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
 
-	rc = ata_dev_read_id(ap, dev, &dev->class, 1, dev->id);
+	WARN_ON(dev->id != NULL);
+	rc = ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id);
 	if (rc)
 		goto err_out;
 
@@ -4728,11 +4739,14 @@ void ata_host_set_remove(struct ata_host
 int ata_scsi_release(struct Scsi_Host *host)
 {
 	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	int i;
 
 	DPRINTK("ENTER\n");
 
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		kfree(ap->device[i].id);
 
 	DPRINTK("EXIT\n");
 	return 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 66b6847..68666b9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -339,7 +339,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
-	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+	u16			*id;		/* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
-- 
1.2.1



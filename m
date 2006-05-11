From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/22] libata: use preallocated buffers
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487902895-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:33397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751586AbWEKMAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:01 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170506nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:01 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

It's not a very good idea to allocate memory during EH.  Use
statically allocated buffer for dev->id[] and add 512byte buffer
ap->sector_buf.  This buffer is owned by EH (or probing) and to be
used as temporary buffer for various purposes (IDENTIFY, NCQ log page
10h, PM GSCR block).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   32 ++++++++------------------------
 include/linux/libata.h     |    4 +++-
 2 files changed, 11 insertions(+), 25 deletions(-)

dbdf1ff319e3e4f70ea9582f9db67b613c02ab7e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4c8e602..1806c7c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1099,7 +1099,7 @@ unsigned int ata_pio_need_iordy(const st
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
  *	@post_reset: is this read ID post-reset?
- *	@p_id: read IDENTIFY page (newly allocated)
+ *	@id: buffer to read IDENTIFY data into
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
  *	performed on ATA devices and ATA_CMD_ID_ATAPI on ATAPI
@@ -1113,12 +1113,11 @@ unsigned int ata_pio_need_iordy(const st
  *	0 on success, -errno otherwise.
  */
 static int ata_dev_read_id(struct ata_port *ap, struct ata_device *dev,
-			   unsigned int *p_class, int post_reset, u16 **p_id)
+			   unsigned int *p_class, int post_reset, u16 *id)
 {
 	unsigned int class = *p_class;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
-	u16 *id;
 	const char *reason;
 	int rc;
 
@@ -1126,13 +1125,6 @@ static int ata_dev_read_id(struct ata_po
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
-	id = kmalloc(sizeof(id[0]) * ATA_ID_WORDS, GFP_KERNEL);
-	if (id == NULL) {
-		rc = -ENOMEM;
-		reason = "out of memory";
-		goto err_out;
-	}
-
  retry:
 	ata_tf_init(ap, &tf, dev->devno);
 
@@ -1194,13 +1186,12 @@ static int ata_dev_read_id(struct ata_po
 	}
 
 	*p_class = class;
-	*p_id = id;
+
 	return 0;
 
  err_out:
 	printk(KERN_WARNING "ata%u: dev %u failed to IDENTIFY (%s)\n",
 	       ap->id, dev->devno, reason);
-	kfree(id);
 	return rc;
 }
 
@@ -1425,9 +1416,7 @@ static int ata_bus_probe(struct ata_port
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		kfree(dev->id);
-		dev->id = NULL;
-		rc = ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id);
+		rc = ata_dev_read_id(ap, dev, &dev->class, 1, dev->id);
 		if (rc)
 			goto fail;
 
@@ -2788,7 +2777,7 @@ int ata_dev_revalidate(struct ata_port *
 		       int post_reset)
 {
 	unsigned int class = dev->class;
-	u16 *id = NULL;
+	u16 *id = (void *)ap->sector_buf;
 	int rc;
 
 	if (!ata_dev_enabled(dev)) {
@@ -2796,8 +2785,8 @@ int ata_dev_revalidate(struct ata_port *
 		goto fail;
 	}
 
-	/* allocate & read ID data */
-	rc = ata_dev_read_id(ap, dev, &class, post_reset, &id);
+	/* read ID data */
+	rc = ata_dev_read_id(ap, dev, &class, post_reset, id);
 	if (rc)
 		goto fail;
 
@@ -2807,8 +2796,7 @@ int ata_dev_revalidate(struct ata_port *
 		goto fail;
 	}
 
-	kfree(dev->id);
-	dev->id = id;
+	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
 
 	/* configure device according to the new ID */
 	rc = ata_dev_configure(ap, dev, 0);
@@ -2818,7 +2806,6 @@ int ata_dev_revalidate(struct ata_port *
  fail:
 	printk(KERN_ERR "ata%u: dev %u revalidation failed (errno=%d)\n",
 	       ap->id, dev->devno, rc);
-	kfree(id);
 	return rc;
 }
 
@@ -4873,14 +4860,11 @@ void ata_host_set_remove(struct ata_host
 int ata_scsi_release(struct Scsi_Host *host)
 {
 	struct ata_port *ap = ata_shost_to_port(host);
-	int i;
 
 	DPRINTK("ENTER\n");
 
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		kfree(ap->device[i].id);
 
 	DPRINTK("EXIT\n");
 	return 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9c2d4bb..a117ca2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -360,7 +360,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
-	u16			*id;		/* IDENTIFY xxx DEVICE data */
+	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
@@ -425,6 +425,8 @@ struct ata_port {
 	struct list_head	eh_done_q;
 
 	void			*private_data;
+
+	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
 
 struct ata_port_operations {
-- 
1.2.4



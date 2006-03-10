From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/5] libata-dev: Make dev->id dynamically allocated
Date: Fri, 10 Mar 2006 23:43:13 +0800
Message-ID: <44119E91.1080109@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:39120 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751592AbWCJPnf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 10:43:35 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2AFh82f026057
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 10:43:08 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2AFeMva242258
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:40:22 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2AFh6Cq016156
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:43:07 -0700
In-Reply-To: <44119BC9.8080502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Make dev->id dynamically allocated

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

This is respin of Tejun's patch, too.
Maybe git can pull it from upstream easily?

--- catchup0/include/linux/libata.h	2006-03-10 17:25:48.000000000 +0800
+++ catchup1/include/linux/libata.h	2006-03-10 17:40:50.000000000 +0800
@@ -344,7 +344,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
-	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+	u16			*id;		/* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
@@ -648,10 +648,14 @@ static inline unsigned int ata_tag_valid
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
 
+static inline unsigned int ata_class_present(unsigned int class)
+{
+	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
+}
+
 static inline unsigned int ata_dev_present(const struct ata_device *dev)
 {
-	return ((dev->class == ATA_DEV_ATA) ||
-		(dev->class == ATA_DEV_ATAPI));
+	return ata_class_present(dev->class);
 }
 
 static inline u8 ata_chk_status(struct ata_port *ap)
--- catchup0/drivers/scsi/libata-core.c	2006-03-10 18:18:04.000000000 +0800
+++ catchup1/drivers/scsi/libata-core.c	2006-03-10 18:19:11.000000000 +0800
@@ -904,7 +904,7 @@ unsigned int ata_pio_need_iordy(const st
  *	@dev: target device
  *	@p_class: pointer to class of the target device (may be changed)
  *	@post_reset: is this read ID post-reset?
- *	@id: buffer to fill IDENTIFY page into
+ *	@p_id: read IDENTIFY page (newly allocated)
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
  *	performed on ATA devices and ATA_CMD_ID_ATAPI on ATAPI
@@ -919,12 +919,13 @@ unsigned int ata_pio_need_iordy(const st
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
 
@@ -938,6 +939,13 @@ static int ata_dev_read_id(struct ata_po
 
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
 
@@ -1028,11 +1036,13 @@ static int ata_dev_read_id(struct ata_po
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
 
@@ -5008,11 +5018,14 @@ void ata_host_set_remove(struct ata_host
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



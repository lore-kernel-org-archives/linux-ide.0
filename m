From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] libata: kill sector_buf temporary buffer
Date: Thu, 16 Aug 2007 04:04:51 -0400
Message-ID: <20070816080451.GA6547@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57384 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbXHPIEw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 04:04:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Rather than carrying around this buffer all the time, for rare
circumstances, it seems that we can easily alloc/free a temp buffer as
needed.

Saves a big chunk of per-port memory.

I forget the justification for what it was in ata_port to begin with,
but the code uses don't see to justify any need.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 735f74b..5e9049f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3679,20 +3679,29 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
 {
 	unsigned int class = dev->class;
-	u16 *id = (void *)dev->link->ap->sector_buf;
-	int rc;
+	u16 *id;
+	int rc = 0;
+
+	id = kzalloc(ATA_SECT_SIZE, GFP_KERNEL);
+	if (!id)
+		return -ENOMEM;
 
 	/* read ID data */
 	rc = ata_dev_read_id(dev, &class, readid_flags, id);
 	if (rc)
-		return rc;
+		goto out;
 
 	/* is the device still there? */
-	if (!ata_dev_same_device(dev, class, id))
-		return -ENODEV;
+	if (!ata_dev_same_device(dev, class, id)) {
+		rc = -ENODEV;
+		goto out;
+	}
 
 	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
-	return 0;
+
+out:
+	kfree(id);
+	return rc;
 }
 
 /**
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2ddc2ed..fc731e2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1133,14 +1133,20 @@ static unsigned int ata_read_log_page(struct ata_device *dev,
 static int ata_eh_read_log_10h(struct ata_device *dev,
 			       int *tag, struct ata_taskfile *tf)
 {
-	u8 *buf = dev->link->ap->sector_buf;
+	u8 *buf;
 	unsigned int err_mask;
 	u8 csum;
-	int i;
+	int i, rc = 0;
+
+	buf = kzalloc(ATA_SECT_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	err_mask = ata_read_log_page(dev, ATA_LOG_SATA_NCQ, buf, 1);
-	if (err_mask)
-		return -EIO;
+	if (err_mask) {
+		rc = -EIO;
+		goto out;
+	}
 
 	csum = 0;
 	for (i = 0; i < ATA_SECT_SIZE; i++)
@@ -1149,8 +1155,10 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 		ata_dev_printk(dev, KERN_WARNING,
 			       "invalid checksum 0x%x on log page 10h\n", csum);
 
-	if (buf[0] & 0x80)
-		return -ENOENT;
+	if (buf[0] & 0x80) {
+		rc = -ENOENT;
+		goto out;
+	}
 
 	*tag = buf[0] & 0x1f;
 
@@ -1166,7 +1174,9 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 	tf->nsect = buf[12];
 	tf->hob_nsect = buf[13];
 
-	return 0;
+out:
+	kfree(buf);
+	return rc;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a9a4e43..09637a0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -595,7 +595,6 @@ struct ata_port {
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	acpi_gtm;
 #endif
-	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
 
 struct ata_port_operations {

From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: clean up read/set native_max address functions
Date: Mon, 3 Sep 2007 12:32:30 +0900
Message-ID: <20070903033230.GC16890@htj.dyndns.org>
References: <20070903033158.GB16890@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:26776 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbXICDch (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 23:32:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so855168rvb
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 20:32:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070903033158.GB16890@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Merge ata_read_native_max_addres_ext() into ata_read_native_max_address()
and combine ata_set_native_max_address_ext() and
ata_set_native_max_address() into ata_set_max_sectors().

* reduce duplicate code
* return 0 or -errno depending on error conditions
* report if command fails
* use ATA_LBA instead of 0x40

This is in preparation of ata_hpa_resize() update.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  174 ++++++++++++++++++++-------------------------
 1 files changed, 77 insertions(+), 97 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b7b0c42..cdead90 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -863,129 +863,113 @@ static u64 ata_tf_to_lba(struct ata_taskfile *tf)
 }
 
 /**
- *	ata_read_native_max_address_ext	-	LBA48 native max query
- *	@dev: Device to query
+ *	ata_read_native_max_address - Read native max address
+ *	@dev: target device
+ *	@max_sectors: out parameter for the result native max address
  *
- *	Perform an LBA48 size query upon the device in question. Return the
- *	actual LBA48 size or zero if the command fails.
- */
-
-static u64 ata_read_native_max_address_ext(struct ata_device *dev)
-{
-	unsigned int err;
-	struct ata_taskfile tf;
-
-	ata_tf_init(dev, &tf);
-
-	tf.command = ATA_CMD_READ_NATIVE_MAX_EXT;
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR;
-	tf.protocol |= ATA_PROT_NODATA;
-	tf.device |= 0x40;
-
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		return 0;
-
-	return ata_tf_to_lba48(&tf);
-}
-
-/**
- *	ata_read_native_max_address	-	LBA28 native max query
- *	@dev: Device to query
+ *	Perform an LBA48 or LBA28 native size query upon the device in
+ *	question.
  *
- *	Performa an LBA28 size query upon the device in question. Return the
- *	actual LBA28 size or zero if the command fails.
+ *	RETURNS:
+ *	0 on success, -EACCES if command is aborted by the drive.
+ *	-EIO on other errors.
  */
-
-static u64 ata_read_native_max_address(struct ata_device *dev)
+static int ata_read_native_max_address(struct ata_device *dev, u64 *max_sectors)
 {
-	unsigned int err;
+	unsigned int err_mask;
 	struct ata_taskfile tf;
+	int lba48 = ata_id_has_lba48(dev->id);
 
 	ata_tf_init(dev, &tf);
 
-	tf.command = ATA_CMD_READ_NATIVE_MAX;
+	/* always clear all address registers */
 	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf.protocol |= ATA_PROT_NODATA;
-	tf.device |= 0x40;
 
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		return 0;
-
-	return ata_tf_to_lba(&tf);
-}
-
-/**
- *	ata_set_native_max_address_ext	-	LBA48 native max set
- *	@dev: Device to query
- *	@new_sectors: new max sectors value to set for the device
- *
- *	Perform an LBA48 size set max upon the device in question. Return the
- *	actual LBA48 size or zero if the command fails.
- */
-
-static u64 ata_set_native_max_address_ext(struct ata_device *dev, u64 new_sectors)
-{
-	unsigned int err;
-	struct ata_taskfile tf;
-
-	new_sectors--;
-
-	ata_tf_init(dev, &tf);
+	if (lba48) {
+		tf.command = ATA_CMD_READ_NATIVE_MAX_EXT;
+		tf.flags |= ATA_TFLAG_LBA48;
+	} else
+		tf.command = ATA_CMD_READ_NATIVE_MAX;
 
-	tf.command = ATA_CMD_SET_MAX_EXT;
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR;
 	tf.protocol |= ATA_PROT_NODATA;
-	tf.device |= 0x40;
-
-	tf.lbal = (new_sectors >> 0) & 0xff;
-	tf.lbam = (new_sectors >> 8) & 0xff;
-	tf.lbah = (new_sectors >> 16) & 0xff;
+	tf.device |= ATA_LBA;
 
-	tf.hob_lbal = (new_sectors >> 24) & 0xff;
-	tf.hob_lbam = (new_sectors >> 32) & 0xff;
-	tf.hob_lbah = (new_sectors >> 40) & 0xff;
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_WARNING, "failed to read native "
+			       "max address (err_mask=0x%x)\n", err_mask);
+		if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
+			return -EACCES;
+		return -EIO;
+	}
 
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		return 0;
+	if (lba48)
+		*max_sectors = ata_tf_to_lba48(&tf);
+	else
+		*max_sectors = ata_tf_to_lba(&tf);
 
-	return ata_tf_to_lba48(&tf);
+	return 0;
 }
 
 /**
- *	ata_set_native_max_address	-	LBA28 native max set
- *	@dev: Device to query
+ *	ata_set_max_sectors - Set max sectors
+ *	@dev: target device
  *	@new_sectors: new max sectors value to set for the device
+ *	@res_sectors: result max sectors
  *
- *	Perform an LBA28 size set max upon the device in question. Return the
- *	actual LBA28 size or zero if the command fails.
+ *	Set max sectors of @dev to @new_sectors.
+ *
+ *	RETURNS:
+ *	0 on success, -EACCES if command is aborted or denied (due to
+ *	previous non-volatile SET_MAX) by the drive.  -EIO on other
+ *	errors.
  */
-
-static u64 ata_set_native_max_address(struct ata_device *dev, u64 new_sectors)
+static int ata_set_max_sectors(struct ata_device *dev, u64 new_sectors,
+			       u64 *res_sectors)
 {
-	unsigned int err;
+	unsigned int err_mask;
 	struct ata_taskfile tf;
+	int lba48 = ata_id_has_lba48(dev->id);
 
 	new_sectors--;
 
 	ata_tf_init(dev, &tf);
 
-	tf.command = ATA_CMD_SET_MAX;
 	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+
+	if (lba48) {
+		tf.command = ATA_CMD_SET_MAX_EXT;
+		tf.flags |= ATA_TFLAG_LBA48;
+
+		tf.hob_lbal = (new_sectors >> 24) & 0xff;
+		tf.hob_lbam = (new_sectors >> 32) & 0xff;
+		tf.hob_lbah = (new_sectors >> 40) & 0xff;
+	} else
+		tf.command = ATA_CMD_SET_MAX;
+
 	tf.protocol |= ATA_PROT_NODATA;
+	tf.device |= ATA_LBA;
 
 	tf.lbal = (new_sectors >> 0) & 0xff;
 	tf.lbam = (new_sectors >> 8) & 0xff;
 	tf.lbah = (new_sectors >> 16) & 0xff;
-	tf.device |= ((new_sectors >> 24) & 0x0f) | 0x40;
 
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		return 0;
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_WARNING, "failed to set "
+			       "max address (err_mask=0x%x)\n", err_mask);
+		if (err_mask == AC_ERR_DEV &&
+		    (tf.feature & (ATA_ABORTED | ATA_IDNF)))
+			return -EACCES;
+		return -EIO;
+	}
 
-	return ata_tf_to_lba(&tf);
+	if (lba48)
+		*res_sectors = ata_tf_to_lba48(&tf);
+	else
+		*res_sectors = ata_tf_to_lba(&tf);
+
+	return 0;
 }
 
 /**
@@ -1001,11 +985,11 @@ static u64 ata_hpa_resize(struct ata_device *dev)
 {
 	u64 sectors = dev->n_sectors;
 	u64 hpa_sectors;
+	int rc;
 
-	if (ata_id_has_lba48(dev->id))
-		hpa_sectors = ata_read_native_max_address_ext(dev);
-	else
-		hpa_sectors = ata_read_native_max_address(dev);
+	rc = ata_read_native_max_address(dev, &hpa_sectors);
+	if (rc)
+		return 0;
 
 	if (hpa_sectors > sectors) {
 		ata_dev_printk(dev, KERN_INFO,
@@ -1015,13 +999,9 @@ static u64 ata_hpa_resize(struct ata_device *dev)
 			(long long)sectors, (long long)hpa_sectors);
 
 		if (ata_ignore_hpa) {
-			if (ata_id_has_lba48(dev->id))
-				hpa_sectors = ata_set_native_max_address_ext(dev, hpa_sectors);
-			else
-				hpa_sectors = ata_set_native_max_address(dev,
-								hpa_sectors);
+			rc = ata_set_max_sectors(dev, hpa_sectors, &hpa_sectors);
 
-			if (hpa_sectors) {
+			if (rc == 0) {
 				ata_dev_printk(dev, KERN_INFO, "native size "
 					"increased to %lld sectors\n",
 					(long long)hpa_sectors);
-- 
1.5.0.3


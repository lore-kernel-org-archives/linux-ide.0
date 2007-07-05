From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc7 1/3] libata: clean up horkage handling
Date: Thu, 5 Jul 2007 13:31:27 +0900
Message-ID: <20070705043127.GX29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:11899 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbXGEEbf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 00:31:35 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1744487nze
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 21:31:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Horkage handling had the following problems.

* dev->horkage was positioned after ATA_DEVICE_CLEAR_OFFSET, so it was
  cleared before the device is configured.  This broke
  HORKAGE_DIAGNOSTIC.

* Some used dev->horkage while others called ata_device_blacklisted()
  directly.  This was at best confusing.

This patch moves dev->horkage right after dev->flags and set the field
according to the blacklist during device configuration.  All users
test against dev->horkage.  ata_device_blacklisted() now has only one
user, make it static.  While at it, rename it to ata_dev_blacklisted()
for consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   13 ++++++++-----
 include/linux/libata.h    |    3 +--
 2 files changed, 9 insertions(+), 7 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -71,6 +71,7 @@ static unsigned int ata_dev_init_params(
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
+static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 unsigned int ata_print_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1814,7 +1815,7 @@ static void ata_dev_config_ncq(struct at
 		desc[0] = '\0';
 		return;
 	}
-	if (ata_device_blacklisted(dev) & ATA_HORKAGE_NONCQ) {
+	if (dev->horkage & ATA_HORKAGE_NONCQ) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return;
 	}
@@ -1862,6 +1863,9 @@ int ata_dev_configure(struct ata_device 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
+	/* set horkage */
+	dev->horkage |= ata_dev_blacklisted(dev);
+
 	/* set _SDD */
 	rc = ata_acpi_push_id(dev);
 	if (rc) {
@@ -2042,7 +2046,7 @@ int ata_dev_configure(struct ata_device 
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
-	if (ata_device_blacklisted(dev) & ATA_HORKAGE_MAX_SEC_128)
+	if (dev->horkage & ATA_HORKAGE_MAX_SEC_128)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
 
@@ -3809,7 +3813,7 @@ static const struct ata_blacklist_entry 
 	{ }
 };
 
-unsigned long ata_device_blacklisted(const struct ata_device *dev)
+static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
@@ -3839,7 +3843,7 @@ static int ata_dma_blacklisted(const str
 	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
 	    (dev->flags & ATA_DFLAG_CDB_INTR))
 		return 1;
-	return (ata_device_blacklisted(dev) & ATA_HORKAGE_NODMA) ? 1 : 0;
+	return (dev->horkage & ATA_HORKAGE_NODMA) ? 1 : 0;
 }
 
 /**
@@ -6875,7 +6879,6 @@ EXPORT_SYMBOL_GPL(ata_host_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_id_to_dma_mode);
-EXPORT_SYMBOL_GPL(ata_device_blacklisted);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -428,6 +428,7 @@ struct ata_device {
 	struct ata_port		*ap;
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
+	unsigned int		horkage;	/* List of broken features */
 	struct scsi_device	*sdev;		/* attached SCSI device */
 	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
 	u64			n_sectors;	/* size of device, if ATA */
@@ -456,7 +457,6 @@ struct ata_device {
 	/* error history */
 	struct ata_ering	ering;
 	int			spdn_cnt;
-	unsigned int		horkage;	/* List of broken features */
 #ifdef CONFIG_ATA_ACPI
 	/* ACPI objects info */
 	acpi_handle obj_handle;
@@ -772,7 +772,6 @@ extern void ata_id_string(const u16 *id,
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
 extern void ata_id_to_dma_mode(struct ata_device *dev, u8 unknown);
-extern unsigned long ata_device_blacklisted(const struct ata_device *dev);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);

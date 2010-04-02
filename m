From: Tejun Heo <tj@kernel.org>
Subject: Re: Working around bogus HPAs in libata
Date: Fri, 02 Apr 2010 12:24:46 +0900
Message-ID: <4BB5637E.4050604@kernel.org>
References: <1269192318.18314.218.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42519 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab0DBDZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2010 23:25:43 -0400
In-Reply-To: <1269192318.18314.218.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org

On 03/22/2010 02:25 AM, Ben Hutchings wrote:
> Since SCSI has no concept of the Host Protected Area (HPA) supported by
> ATA, ATA disks handled by libata have no set_capacity() operation and it
> appears to be impossible to override an HPA except through the libata
> module parameter.
> 
> In particular, this means that the workaround for bogus HPAs in
> rescan_partitions() does not work:
> 
> 			if (bdops->set_capacity &&
> 			    (disk->flags & GENHD_FL_NATIVE_CAPACITY) == 0) {
> 				printk(KERN_CONT "enabling native capacity\n");
> 				capacity = bdops->set_capacity(disk, ~0ULL);
> 				disk->flags |= GENHD_FL_NATIVE_CAPACITY;
> 				if (capacity > get_capacity(disk)) {
> 					set_capacity(disk, capacity);
> 					check_disk_size_change(disk, bdev);
> 					bdev->bd_invalidated = 0;
> 				}

Hmmm, yeah, this is much better than the dumb switch we have now.  I
wonder why nobody pointed it out before.  Does the following patch
work as expected?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a28420..81a0820 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1493,6 +1493,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
 	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
+	bool unlock_hpa = ata_ignore_hpa || dev->flags & ATA_DFLAG_UNLOCK_HPA;
 	u64 sectors = ata_id_n_sectors(dev->id);
 	u64 native_sectors;
 	int rc;
@@ -1509,7 +1510,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 		/* If device aborted the command or HPA isn't going to
 		 * be unlocked, skip HPA resizing.
 		 */
-		if (rc == -EACCES || !ata_ignore_hpa) {
+		if (rc == -EACCES || !unlock_hpa) {
 			ata_dev_printk(dev, KERN_WARNING, "HPA support seems "
 				       "broken, skipping HPA handling\n");
 			dev->horkage |= ATA_HORKAGE_BROKEN_HPA;
@@ -1524,7 +1525,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 	dev->n_native_sectors = native_sectors;

 	/* nothing to do? */
-	if (native_sectors <= sectors || !ata_ignore_hpa) {
+	if (native_sectors <= sectors || !unlock_hpa) {
 		if (!print_info || native_sectors == sectors)
 			return 0;

@@ -4185,36 +4186,50 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 		goto fail;

 	/* verify n_sectors hasn't changed */
-	if (dev->class == ATA_DEV_ATA && n_sectors &&
-	    dev->n_sectors != n_sectors) {
-		ata_dev_printk(dev, KERN_WARNING, "n_sectors mismatch "
-			       "%llu != %llu\n",
-			       (unsigned long long)n_sectors,
-			       (unsigned long long)dev->n_sectors);
-		/*
-		 * Something could have caused HPA to be unlocked
-		 * involuntarily.  If n_native_sectors hasn't changed
-		 * and the new size matches it, keep the device.
-		 */
-		if (dev->n_native_sectors == n_native_sectors &&
-		    dev->n_sectors > n_sectors &&
-		    dev->n_sectors == n_native_sectors) {
-			ata_dev_printk(dev, KERN_WARNING,
-				       "new n_sectors matches native, probably "
-				       "late HPA unlock, continuing\n");
-			/* keep using the old n_sectors */
-			dev->n_sectors = n_sectors;
-		} else {
-			/* restore original n_[native]_sectors and fail */
-			dev->n_native_sectors = n_native_sectors;
-			dev->n_sectors = n_sectors;
-			rc = -ENODEV;
-			goto fail;
-		}
+	if (dev->class != ATA_DEV_ATA || !n_sectors ||
+	    dev->n_sectors == n_sectors)
+		return 0;
+
+	/* n_sectors has changed */
+	ata_dev_printk(dev, KERN_WARNING, "n_sectors mismatch %llu != %llu\n",
+		       (unsigned long long)n_sectors,
+		       (unsigned long long)dev->n_sectors);
+
+	/*
+	 * Something could have caused HPA to be unlocked
+	 * involuntarily.  If n_native_sectors hasn't changed and the
+	 * new size matches it, keep the device.
+	 */
+	if (dev->n_native_sectors == n_native_sectors &&
+	    dev->n_sectors > n_sectors && dev->n_sectors == n_native_sectors) {
+		ata_dev_printk(dev, KERN_WARNING,
+			       "new n_sectors matches native, probably "
+			       "late HPA unlock, n_sectors adjusted\n");
+		/* keep using the larger n_sectors */
+		return 0;
 	}

-	return 0;
+	/*
+	 * Some BIOSes boot w/o HPA but resume w/ HPA locked.  Try
+	 * unlocking HPA in those cases.
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=15396
+	 */
+	if (dev->n_native_sectors == n_native_sectors &&
+	    dev->n_sectors < n_sectors && n_sectors == n_native_sectors &&
+	    !(dev->horkage & ATA_HORKAGE_BROKEN_HPA)) {
+		ata_dev_printk(dev, KERN_WARNING,
+			       "old n_sectors matches native, probably "
+			       "late HPA lock, will try to unlock HPA\n");
+		/* try unlocking HPA */
+		dev->flags |= ATA_DFLAG_UNLOCK_HPA;
+		rc = -EIO;
+	} else
+		rc = -ENODEV;

+	/* restore original n_[native_]sectors and fail */
+	dev->n_native_sectors = n_native_sectors;
+	dev->n_sectors = n_sectors;
  fail:
 	ata_dev_printk(dev, KERN_ERR, "revalidation failed (errno=%d)\n", rc);
 	return rc;
@@ -6785,6 +6800,7 @@ EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 EXPORT_SYMBOL_GPL(ata_link_next);
 EXPORT_SYMBOL_GPL(ata_dev_next);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
+EXPORT_SYMBOL_GPL(ata_scsi_set_capacity);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bea003a..e81dc54 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -413,6 +413,32 @@ int ata_std_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 	return 0;
 }

+sector_t ata_scsi_set_capacity(struct scsi_device *sdev, sector_t new_capacity)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	sector_t capacity = 0;
+	struct ata_device *dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (dev && dev->n_sectors < new_capacity &&
+	    dev->n_sectors < dev->n_native_sectors) {
+		struct ata_eh_info *ehi = &dev->link->eh_info;
+
+		dev->flags |= ATA_DFLAG_UNLOCK_HPA;
+		ehi->action |= ATA_EH_RESET;
+		ata_port_schedule_eh(ap);
+		spin_unlock_irqrestore(ap->lock, flags);
+		ata_port_wait_eh(ap);
+		capacity = dev->n_sectors;
+	} else
+		spin_unlock_irqrestore(ap->lock, flags);
+
+	return capacity;
+}
+
 /**
  *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
  *	@ap: target port
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7b75c8a..a0a6b9e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -96,6 +96,8 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_RBC);
 #endif

 static int  sd_revalidate_disk(struct gendisk *);
+static unsigned long long sd_set_capacity(struct gendisk *disk,
+					  unsigned long long new_capacity);
 static int  sd_probe(struct device *);
 static int  sd_remove(struct device *);
 static void sd_shutdown(struct device *);
@@ -1099,6 +1101,7 @@ static const struct block_device_operations sd_fops = {
 #endif
 	.media_changed		= sd_media_changed,
 	.revalidate_disk	= sd_revalidate_disk,
+	.set_capacity		= sd_set_capacity,
 };

 static unsigned int sd_completed_bytes(struct scsi_cmnd *scmd)
@@ -2099,6 +2102,17 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	return 0;
 }

+static unsigned long long sd_set_capacity(struct gendisk *disk,
+					  unsigned long long new_capacity)
+{
+	struct scsi_device *sdev = scsi_disk(disk)->device;
+	sector_t capacity = 0;
+
+	if (sdev->host->hostt->set_capacity)
+		capacity = sdev->host->hostt->set_capacity(sdev, new_capacity);
+	return capacity ?: get_capacity(disk);
+}
+
 /**
  *	sd_format_disk_name - format disk name
  *	@prefix: name prefix - ie. "sd" for SCSI disks
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f8ea71e..4f0fb5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -146,6 +146,7 @@ enum {
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
+	ATA_DFLAG_UNLOCK_HPA	= (1 << 18), /* unlock HPA */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,

 	ATA_DFLAG_DETACH	= (1 << 24),
@@ -328,7 +329,7 @@ enum {
 	ATA_EH_HARDRESET	= (1 << 2), /* meaningful only in ->prereset */
 	ATA_EH_RESET		= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_ENABLE_LINK	= (1 << 3),
-	ATA_EH_LPM		= (1 << 4),  /* link power management action */
+	ATA_EH_LPM		= (1 << 4), /* link power management action */
 	ATA_EH_PARK		= (1 << 5), /* unload heads and stop I/O */

 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_PARK,
@@ -1025,6 +1026,8 @@ extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
+extern sector_t ata_scsi_set_capacity(struct scsi_device *sdev,
+				      sector_t new_capacity);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
@@ -1179,6 +1182,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.slave_configure	= ata_scsi_slave_config,	\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
+	.set_capacity		= ata_scsi_set_capacity,	\
 	.sdev_attrs		= ata_common_sdev_attrs

 #define ATA_NCQ_SHT(drv_name)					\
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index c50a97f..58048cb 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -326,6 +326,8 @@ struct scsi_host_template {
 	int (* bios_param)(struct scsi_device *, struct block_device *,
 			sector_t, int []);

+	sector_t (*set_capacity)(struct scsi_device *, sector_t);
+
 	/*
 	 * Can be used to export driver statistics and other infos to the
 	 * world outside the kernel ie. userspace and it also provides an


-- 
tejun

From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] libata: during revalidation, check n_sectors after device is configured
Date: Mon, 23 Apr 2007 02:41:06 +0900
Message-ID: <11772636663728-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Device might be resized during ata_dev_configure() due to HPA or
(later) ACPI _GTF.  Currently it's worked around by caching n_sectors
before turning off HPA.  The cached original size is overwritten if
the device is reconfigured without being hardreset - which always
happens after configuring trasnfer mode.  If the device gets hardreset
for some reason after that, revalidation fails with -ENODEV.

This patch makes size checking more robust by moving n_sectors check
from ata_dev_reread_id() to ata_dev_revalidate() after the device is
fully configured.  No matter what happens during configuration, a
device must have the same n_sectors after fully configured to be
treated as the same device.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   33 +++++++++++++++------------------
 include/linux/libata.h    |    1 -
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7a6e8fd..2171af6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1862,7 +1862,6 @@ int ata_dev_configure(struct ata_device *dev)
 			snprintf(revbuf, 7, "ATA-%d",  ata_id_major_version(id));
 
 		dev->n_sectors = ata_id_n_sectors(id);
-		dev->n_sectors_boot = dev->n_sectors;
 
 		/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
 		ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
@@ -3519,7 +3518,6 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 	const u16 *old_id = dev->id;
 	unsigned char model[2][ATA_ID_PROD_LEN + 1];
 	unsigned char serial[2][ATA_ID_SERNO_LEN + 1];
-	u64 new_n_sectors;
 
 	if (dev->class != new_class) {
 		ata_dev_printk(dev, KERN_INFO, "class mismatch %d != %d\n",
@@ -3531,7 +3529,6 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 	ata_id_c_string(new_id, model[1], ATA_ID_PROD, sizeof(model[1]));
 	ata_id_c_string(old_id, serial[0], ATA_ID_SERNO, sizeof(serial[0]));
 	ata_id_c_string(new_id, serial[1], ATA_ID_SERNO, sizeof(serial[1]));
-	new_n_sectors = ata_id_n_sectors(new_id);
 
 	if (strcmp(model[0], model[1])) {
 		ata_dev_printk(dev, KERN_INFO, "model number mismatch "
@@ -3545,19 +3542,6 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 		return 0;
 	}
 
-	if (dev->class == ATA_DEV_ATA && dev->n_sectors != new_n_sectors) {
-		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
-			       "%llu != %llu\n",
-			       (unsigned long long)dev->n_sectors,
-			       (unsigned long long)new_n_sectors);
-		/* Are we the boot time size - if so we appear to be the
-		   same disk at this point and our HPA got reapplied */
-		if (ata_ignore_hpa && dev->n_sectors_boot == new_n_sectors 
-		    && ata_id_hpa_enabled(new_id))
-			return 1;
-		return 0;
-	}
-
 	return 1;
 }
 
@@ -3610,6 +3594,7 @@ int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
  */
 int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
 {
+	u64 n_sectors = dev->n_sectors;
 	int rc;
 
 	if (!ata_dev_enabled(dev))
@@ -3622,8 +3607,20 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
 
 	/* configure device according to the new ID */
 	rc = ata_dev_configure(dev);
-	if (rc == 0)
-		return 0;
+	if (rc)
+		goto fail;
+
+	/* verify n_sectors hasn't changed */
+	if (dev->class == ATA_DEV_ATA && dev->n_sectors != n_sectors) {
+		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
+			       "%llu != %llu\n",
+			       (unsigned long long)n_sectors,
+			       (unsigned long long)dev->n_sectors);
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	return 0;
 
  fail:
 	ata_dev_printk(dev, KERN_ERR, "revalidation failed (errno=%d)\n", rc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d8cfc72..3cffbf6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -448,7 +448,6 @@ struct ata_device {
 	struct scsi_device	*sdev;		/* attached SCSI device */
 	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
 	u64			n_sectors;	/* size of device, if ATA */
-	u64			n_sectors_boot;	/* size of ATA device at startup */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
-- 
1.5.0.3



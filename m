From: Tejun Heo <tj@kernel.org>
Subject: [PATCH upstream-fixes] libata: unlock HPA if device shrunk
Date: Mon, 05 Apr 2010 10:33:13 +0900
Message-ID: <4BB93DD9.7030909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53266 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab0DEBd0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Apr 2010 21:33:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, yaa.bta@gmail.com

Some BIOSes don't configure HPA during boot but do so while resuming.
This causes harddrives to shrink during resume making libata detach
and reattach them.  This can be worked around by unlocking HPA if old
size equals native size.

Add ATA_DFLAG_UNLOCK_HPA so that HPA unlocking can be controlled
per-device and update ata_dev_revalidate() such that it sets
ATA_DFLAG_UNLOCK_HPA and fails with -EIO when the above condition is
detected.

This patch fixes the following bug.

  https://bugzilla.kernel.org/show_bug.cgi?id=15396

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleksandr Yermolenko <yaa.bta@gmail.com>
---
 drivers/ata/libata-core.c |   74 +++++++++++++++++++++++++++-------------------
 include/linux/libata.h    |    1
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a28420..8b97609 100644
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

@@ -4185,36 +4186,51 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
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
+			       "late HPA unlock, continuing\n");
+		/* keep using the old n_sectors */
+		dev->n_sectors = n_sectors;
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f8ea71e..b2f2003 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -146,6 +146,7 @@ enum {
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
+	ATA_DFLAG_UNLOCK_HPA	= (1 << 18), /* unlock HPA */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,

 	ATA_DFLAG_DETACH	= (1 << 24),

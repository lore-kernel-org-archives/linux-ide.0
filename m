From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: accept late unlocking of HPA
Date: Wed, 15 Jul 2009 17:11:41 +0900
Message-ID: <4A5D8F3D.3070709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40659 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbZGOIMp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Jul 2009 04:12:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>, Christof Warlich <christof@warlich.name>

On certain configurations, HPA isn't or can't be unlocked during
probing but it somehow ends up unlocked afterwards.  In the following
thread, the problem can be reliably reproduced after resuming from
STR.  The BIOS turns on HPA during boot but forgets to do it during
resume.

  http://thread.gmane.org/gmane.linux.kernel/858310

This patch updates libata revalidation such that it considers native
n_sectors.  If the device size has increased to match native
n_sectors, it's assumed that HPA has been unlocked involuntarily and
the device is recognized as the same one.  This should be fairly safe
while nicely working around the problem.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Christof Warlich <christof@warlich.name>
---
 drivers/ata/libata-core.c |   30 +++++++++++++++++++++++-------
 include/linux/libata.h    |    1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2c6aeda..8ac98ff 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1515,6 +1515,7 @@ static int ata_hpa_resize(struct ata_device *dev)

 		return rc;
 	}
+	dev->n_native_sectors = native_sectors;

 	/* nothing to do? */
 	if (native_sectors <= sectors || !ata_ignore_hpa) {
@@ -4099,6 +4100,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 		       unsigned int readid_flags)
 {
 	u64 n_sectors = dev->n_sectors;
+	u64 n_native_sectors = dev->n_native_sectors;
 	int rc;

 	if (!ata_dev_enabled(dev))
@@ -4128,16 +4130,30 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	/* verify n_sectors hasn't changed */
 	if (dev->class == ATA_DEV_ATA && n_sectors &&
 	    dev->n_sectors != n_sectors) {
-		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
+		ata_dev_printk(dev, KERN_WARNING, "n_sectors mismatch "
 			       "%llu != %llu\n",
 			       (unsigned long long)n_sectors,
 			       (unsigned long long)dev->n_sectors);
-
-		/* restore original n_sectors */
-		dev->n_sectors = n_sectors;
-
-		rc = -ENODEV;
-		goto fail;
+		/*
+		 * Something could have caused HPA to be unlocked
+		 * involuntarily.  If n_native_sectors hasn't changed
+		 * and the new size matches it, keep the device.
+		 */
+		if (dev->n_native_sectors == n_native_sectors &&
+		    dev->n_sectors > n_sectors &&
+		    dev->n_sectors == n_native_sectors) {
+			ata_dev_printk(dev, KERN_WARNING,
+				       "new n_sectors matches native, probably "
+				       "late HPA unlock, continuing\n");
+			/* keep using the old n_sectors */
+			dev->n_sectors = n_sectors;
+		} else {
+			/* restore original n_[native]_sectors and fail */
+			dev->n_native_sectors = n_native_sectors;
+			dev->n_sectors = n_sectors;
+			rc = -ENODEV;
+			goto fail;
+		}
 	}

 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 79b6d7f..e5b6e33 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -589,6 +589,7 @@ struct ata_device {
 #endif
 	/* n_sector is CLEAR_BEGIN, read comment above CLEAR_BEGIN */
 	u64			n_sectors;	/* size of device, if ATA */
+	u64			n_native_sectors; /* native size, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned long		unpark_deadline;


From: Tejun Heo <htejun@gmail.com>
Subject: Re: "EXT3-fs error" after resume from s2ram
Date: Thu, 09 Jul 2009 00:21:47 +0900
Message-ID: <4A54B98B.50806@gmail.com>
References: <4A4771FD.1020207@warlich.name> <4A480859.5010206@gmail.com> <4A48C799.2010102@warlich.name> <4A495C2D.1040706@gmail.com> <4A49A49C.10104@warlich.name> <4A4C42E2.6030305@gmail.com> <4A51C929.5010909@warlich.name> <4A52931D.5070109@gmail.com> <4A52F39A.1030704@warlich.name> <4A5311C7.1020507@warlich.name> <4A535973.9090206@gmail.com> <4A5388EA.7030503@warlich.name> <4A53DA88.5080703@gmail.com> <4A543FA5.1090608@warlich.name> <4A54AD1A.1040009@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020200020505000104090607"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:42796 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZGHPV6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jul 2009 11:21:58 -0400
In-Reply-To: <4A54AD1A.1040009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christof Warlich <christof@warlich.name>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020200020505000104090607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> One thing we can do is to make libata remember the native size on
> initial probing and let revalidation consider it.  Yeap, that would
> work.  Can you please test the attached patch and post full log
> including boot and suspend/resume?

Patch slightly updated.  Please test this one.

-- 
tejun

--------------020200020505000104090607
Content-Type: text/x-patch;
 name="revalidate-consider-native.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revalidate-consider-native.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 045a486..111c5c9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1515,6 +1515,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 
 		return rc;
 	}
+	dev->n_native_sectors = native_sectors;
 
 	/* nothing to do? */
 	if (native_sectors <= sectors || !ata_ignore_hpa) {
@@ -4089,6 +4090,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 		       unsigned int readid_flags)
 {
 	u64 n_sectors = dev->n_sectors;
+	u64 n_native_sectors = dev->n_native_sectors;
 	int rc;
 
 	if (!ata_dev_enabled(dev))
@@ -4118,16 +4120,31 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	/* verify n_sectors hasn't changed */
 	if (dev->class == ATA_DEV_ATA && n_sectors &&
 	    dev->n_sectors != n_sectors) {
-		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
+		ata_dev_printk(dev, KERN_WARNING, "n_sectors mismatch "
 			       "%llu != %llu\n",
 			       (unsigned long long)n_sectors,
 			       (unsigned long long)dev->n_sectors);
 
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
+			dev->n_native_sectors = n_native_sectors;
+			dev->n_sectors = n_sectors;
+		} else {
+			/* restore original n_[native]_sectors */
+			dev->n_native_sectors = n_native_sectors;
+			dev->n_sectors = n_sectors;
+			rc = -ENODEV;
+			goto fail;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d501db..5fde0a9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -588,6 +588,7 @@ struct ata_device {
 #endif
 	/* n_sector is CLEAR_BEGIN, read comment above CLEAR_BEGIN */
 	u64			n_sectors;	/* size of device, if ATA */
+	u64			n_native_sectors; /* native size, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned long		unpark_deadline;
 

--------------020200020505000104090607--

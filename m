From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] change CONFIG_IDEDISK_STOKE to a runtime option
Date: Mon, 31 May 2004 18:39:42 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040531163942.GA20275@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([212.34.189.10]:6065 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264665AbUEaQjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 May 2004 12:39:52 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

To be useful for distribution kernels it needs to be a runtime option.
The original patch is from Joerg Platte via the Debian kernel package,
with some adjustments from me.


--- 1.16/Documentation/ide.txt	2004-04-12 19:54:31 +02:00
+++ edited/Documentation/ide.txt	2004-05-31 17:47:33 +02:00
@@ -248,6 +248,13 @@
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
 
+ "hdx=stroke"		: Should you have a system w/ an AWARD Bios and your
+ 			  drives are larger than 32GB and it will not boot,
+			  one is required to perform a few OEM operations first.
+			  The option is called "stroke" because it allows one
+			  to "soft clip" the drive to work around a barrier
+			  limit.
+
  "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
 			  where "xx" is between 20 and 66 inclusive,
 			  used when tuning chipset PIO modes.
--- 1.45/drivers/ide/Kconfig	2004-05-20 19:41:35 +02:00
+++ edited/drivers/ide/Kconfig	2004-05-31 17:45:22 +02:00
@@ -157,20 +157,6 @@
 
 	  If in doubt, say N.
 
-config IDEDISK_STROKE
-	bool "Auto-Geometry Resizing support"
-	depends on BLK_DEV_IDEDISK
-	help
-	  Should you have a system w/ an AWARD Bios and your drives are larger
-	  than 32GB and it will not boot, one is required to perform a few OEM
-	  operations first.  The option is called "STROKE" because it allows
-	  one to "soft clip" the drive to work around a barrier limit.  For
-	  Maxtor drives it is called "jumpon.exe".  Please search Maxtor's
-	  web-site for "JUMPON.EXE".  IBM has a similar tool at:
-	  <http://www.storage.ibm.com/hdd/support/download.htm>.
-
-	  If you are unsure, say N here.
-
 config BLK_DEV_IDECS
 	tristate "PCMCIA IDE support"
 	depends on PCMCIA
--- 1.81/drivers/ide/ide-disk.c	2004-05-26 13:52:48 +02:00
+++ edited/drivers/ide/ide-disk.c	2004-05-31 17:45:39 +02:00
@@ -963,7 +963,6 @@
 	return addr;
 }
 
-#ifdef CONFIG_IDEDISK_STROKE
 /*
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
@@ -1032,8 +1031,6 @@
 	return addr_set;
 }
 
-#endif /* CONFIG_IDEDISK_STROKE */
-
 static unsigned long long sectors_to_MB(unsigned long long n)
 {
 	n <<= 9;		/* make it bytes */
@@ -1080,17 +1077,17 @@
 			 drive->name,
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
-#ifdef CONFIG_IDEDISK_STROKE
-	if (lba48)
-		set_max = idedisk_set_max_address_ext(drive, set_max);
-	else
-		set_max = idedisk_set_max_address(drive, set_max);
-	if (set_max) {
-		drive->capacity64 = set_max;
-		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
-				 drive->name);
+	if (drive->stroke) {
+		if (lba48)
+			set_max = idedisk_set_max_address_ext(drive, set_max);
+		else
+			set_max = idedisk_set_max_address(drive, set_max);
+		if (set_max) {
+			drive->capacity64 = set_max;
+			printk(KERN_INFO "%s: Host Protected Area disabled.\n",
+					 drive->name);
+		}
 	}
-#endif
 }
 
 /*
--- 1.144/drivers/ide/ide.c	2004-05-24 20:51:21 +02:00
+++ edited/drivers/ide/ide.c	2004-05-31 13:08:01 +02:00
@@ -1806,7 +1806,7 @@
 		const char *hd_words[] = {
 			"none", "noprobe", "nowerr", "cdrom", "serialize",
 			"autotune", "noautotune", "minus8", "swapdata", "bswap",
-			"minus11", "remap", "remap63", "scsi", NULL };
+			"minus11", "remap", "remap63", "scsi", "stroke", NULL };
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -1851,6 +1851,9 @@
 				goto done;
 			case -14: /* "scsi" */
 				drive->scsi = 1;
+				goto done;
+			case -15: /* "stroke" */
+				drive->stroke = 1;
 				goto done;
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
--- 1.116/include/linux/ide.h	2004-05-24 20:51:21 +02:00
+++ edited/include/linux/ide.h	2004-05-31 13:08:00 +02:00
@@ -742,6 +742,7 @@
 	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
+ 	unsigned stroke		: 1;	/* from:  hdx=stroke */
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit

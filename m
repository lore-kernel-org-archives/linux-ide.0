From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove CONFIG_BLK_DEV_IDE config option
Date: Wed, 13 Aug 2008 23:23:02 +0200
Message-ID: <200808132323.02369.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:22831 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYHMV0j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 17:26:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so176707ugf.16
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 14:26:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Because hd.c was moved to drivers/block/ this config option
is superfluous now and may be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |   38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -54,38 +54,6 @@ menuconfig IDE
 
 if IDE
 
-config BLK_DEV_IDE
-	tristate "Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support"
-	---help---
-	  If you say Y here, you will use the full-featured IDE driver to
-	  control up to ten ATA/IDE interfaces, each being able to serve a
-	  "master" and a "slave" device, for a total of up to twenty ATA/IDE
-	  disk/cdrom/tape/floppy drives.
-
-	  Useful information about large (>540 MB) IDE disks, multiple
-	  interfaces, what to do if ATA/IDE devices are not automatically
-	  detected, sound card ATA/IDE ports, module support, and other
-	  topics, is contained in <file:Documentation/ide/ide.txt>. For detailed
-	  information about hard drives, consult the Disk-HOWTO and the
-	  Multi-Disk-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  To fine-tune ATA/IDE drive/interface parameters for improved
-	  performance, look for the hdparm package at
-	  <ftp://ibiblio.org/pub/Linux/system/hardware/>.
-
-	  To compile this driver as a module, choose M here and read
-	  <file:Documentation/ide/ide.txt>. The module will be called ide-mod.
-	  Do not compile this driver as a module if your root file system (the
-	  one containing the directory /) is located on an IDE device.
-
-	  If you have one or more IDE drives, say Y or M here. If your system
-	  has no IDE drives, or if memory requirements are really tight, you
-	  could say N here, and select the "Old hard disk driver" below
-	  instead to save about 13 KB of memory in the kernel.
-
-if BLK_DEV_IDE
-
 comment "Please see Documentation/ide/ide.txt for help/info on IDE drives"
 
 config IDE_TIMINGS
@@ -348,7 +316,7 @@ config BLK_DEV_IDEPCI
 
 config IDEPCI_PCIBUS_ORDER
 	bool "Probe IDE PCI devices in the PCI bus order (DEPRECATED)"
-	depends on BLK_DEV_IDE=y && BLK_DEV_IDEPCI
+	depends on IDE=y && BLK_DEV_IDEPCI
 	default y
 	help
 	  Probe IDE PCI devices in the order in which they appear on the
@@ -729,7 +697,7 @@ endif
 
 config BLK_DEV_IDE_PMAC
 	tristate "PowerMac on-board IDE support"
-	depends on PPC_PMAC && IDE=y && BLK_DEV_IDE=y
+	depends on PPC_PMAC && IDE=y
 	select IDE_TIMINGS
 	help
 	  This driver provides support for the on-board IDE controller on
@@ -967,6 +935,4 @@ config BLK_DEV_IDEDMA
 	def_bool BLK_DEV_IDEDMA_SFF || BLK_DEV_IDEDMA_PMAC || \
 		 BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 
-endif
-
 endif # IDE

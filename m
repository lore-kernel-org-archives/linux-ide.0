From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 53/63] ide-cd: factor out transfer size checking from cdrom_read_intr()
Date: Thu, 20 Dec 2007 02:32:37 +0100
Message-ID: <200712200232.38064.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:12071 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560AbXLTBe5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:57 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389250ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:56 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


This is a preparation for cdrom_read_intr() and cdrom_write_intr() merge.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
+26 bytes
 drivers/ide/ide-cd.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -714,6 +714,31 @@ int cdrom_read_check_ireason (ide_drive_
 }
 
 /*
+ * Assume that the drive will always provide data in multiples of at least
+ * SECTOR_SIZE, as it gets hairy to keep track of the transfers otherwise.
+ */
+static int ide_cd_check_transfer_size(ide_drive_t *drive, int len)
+{
+	struct cdrom_info *cd = drive->driver_data;
+
+	if ((len % SECTOR_SIZE) == 0)
+		return 0;
+
+	printk(KERN_ERR "%s: %s: Bad transfer size %d\n",
+			drive->name, __FUNCTION__, len);
+
+	if (cd->cd_flags & IDE_CD_FLAG_LIMIT_NFRAMES)
+		printk(KERN_ERR "  This drive is not supported by "
+				"this version of the driver\n");
+	else {
+		printk(KERN_ERR "  Trying to limit transfer sizes\n");
+		cd->cd_flags |= IDE_CD_FLAG_LIMIT_NFRAMES;
+	}
+
+	return 1;
+}
+
+/*
  * Interrupt routine.  Called when a read request has completed.
  */
 static ide_startstop_t cdrom_read_intr (ide_drive_t *drive)
@@ -774,18 +799,7 @@ static ide_startstop_t cdrom_read_intr (
 	if (cdrom_read_check_ireason (drive, len, ireason))
 		return ide_stopped;
 
-	/* Assume that the drive will always provide data in multiples
-	   of at least SECTOR_SIZE, as it gets hairy to keep track
-	   of the transfers otherwise. */
-	if ((len % SECTOR_SIZE) != 0) {
-		printk (KERN_ERR "%s: cdrom_read_intr: Bad transfer size %d\n",
-			drive->name, len);
-		if (info->cd_flags & IDE_CD_FLAG_LIMIT_NFRAMES)
-			printk (KERN_ERR "  This drive is not supported by this version of the driver\n");
-		else {
-			printk (KERN_ERR "  Trying to limit transfer sizes\n");
-			info->cd_flags |= IDE_CD_FLAG_LIMIT_NFRAMES;
-		}
+	if (ide_cd_check_transfer_size(drive, len)) {
 		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}

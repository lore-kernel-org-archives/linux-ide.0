From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/18] ide-disk: fix IDE_DFLAG_LBA48 handling on resume
Date: Mon, 08 Sep 2008 00:14:30 +0200
Message-ID: <20080907221430.24285.1307.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:2394 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYIGWQj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:16:39 -0400
Received: by ug-out-1314.google.com with SMTP id s2so93617uge.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:16:38 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Some code in idedisk_setup() should be in idedisk_capacity() instead.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -397,6 +397,26 @@ static void init_idedisk_capacity(ide_dr
 		if (ata_id_hpa_enabled(id))
 			idedisk_check_hpa(drive);
 	}
+
+	/* limit drive capacity to 137GB if LBA48 cannot be used */
+	if ((drive->dev_flags & IDE_DFLAG_LBA48) == 0 &&
+	    drive->capacity64 > 1ULL << 28) {
+		printk(KERN_WARNING "%s: cannot use LBA48 - full capacity "
+		       "%llu sectors (%llu MB)\n",
+		       drive->name, (unsigned long long)drive->capacity64,
+		       sectors_to_MB(drive->capacity64));
+		drive->capacity64 = 1ULL << 28;
+	}
+
+	if ((drive->hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA) &&
+	    (drive->dev_flags & IDE_DFLAG_LBA48)) {
+		if (drive->capacity64 > 1ULL << 28) {
+			printk(KERN_INFO "%s: cannot use LBA48 DMA - PIO mode"
+					 " will be used for accessing sectors "
+					 "> %u\n", drive->name, 1 << 28);
+		} else
+			drive->dev_flags &= ~IDE_DFLAG_LBA48;
+	}
 }
 
 sector_t ide_disk_capacity(ide_drive_t *drive)
@@ -648,26 +668,6 @@ static void idedisk_setup(ide_drive_t *d
 	/* calculate drive capacity, and select LBA if possible */
 	init_idedisk_capacity(drive);
 
-	/* limit drive capacity to 137GB if LBA48 cannot be used */
-	if ((drive->dev_flags & IDE_DFLAG_LBA48) == 0 &&
-	    drive->capacity64 > 1ULL << 28) {
-		printk(KERN_WARNING "%s: cannot use LBA48 - full capacity "
-		       "%llu sectors (%llu MB)\n",
-		       drive->name, (unsigned long long)drive->capacity64,
-		       sectors_to_MB(drive->capacity64));
-		drive->capacity64 = 1ULL << 28;
-	}
-
-	if ((hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA) &&
-	    (drive->dev_flags & IDE_DFLAG_LBA48)) {
-		if (drive->capacity64 > 1ULL << 28) {
-			printk(KERN_INFO "%s: cannot use LBA48 DMA - PIO mode"
-					 " will be used for accessing sectors "
-					 "> %u\n", drive->name, 1 << 28);
-		} else
-			drive->dev_flags &= ~IDE_DFLAG_LBA48;
-	}
-
 	/*
 	 * if possible, give fdisk access to more of the drive,
 	 * by correcting bios_cyls:

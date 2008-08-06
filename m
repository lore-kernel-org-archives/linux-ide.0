From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide-floppy: remove needless parens
Date: Wed, 6 Aug 2008 18:37:21 +0200
Message-ID: <200808061837.21240.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:12384 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759434AbYHFQn2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 12:43:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1542fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 09:43:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -738,7 +738,7 @@ static int idefloppy_get_sfrp_bit(ide_dr
 		return 1;
 
 	floppy->srfp = pc.buf[8 + 2] & 0x40;
-	return (0);
+	return 0;
 }
 
 /*
@@ -866,16 +866,17 @@ static int ide_floppy_get_format_capacit
 	int __user *argp;
 
 	if (get_user(u_array_size, arg))
-		return (-EFAULT);
+		return -EFAULT;
 
 	if (u_array_size <= 0)
-		return (-EINVAL);
+		return -EINVAL;
 
 	idefloppy_create_read_capacity_cmd(&pc);
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
 		printk(KERN_ERR "ide-floppy: Can't get floppy parameters\n");
-		return (-EIO);
+		return -EIO;
 	}
+
 	header_len = pc.buf[3];
 	desc_cnt = header_len / 8; /* capacity descriptor of 8 bytes */
 
@@ -897,19 +898,22 @@ static int ide_floppy_get_format_capacit
 		length = be16_to_cpup((__be16 *)&pc.buf[desc_start + 6]);
 
 		if (put_user(blocks, argp))
-			return(-EFAULT);
+			return -EFAULT;
+
 		++argp;
 
 		if (put_user(length, argp))
-			return (-EFAULT);
+			return -EFAULT;
+
 		++argp;
 
 		++u_index;
 	}
 
 	if (put_user(u_index, arg))
-		return (-EFAULT);
-	return (0);
+		return -EFAULT;
+
+	return 0;
 }
 
 /*
@@ -931,7 +935,7 @@ static int idefloppy_get_format_progress
 	if (floppy->srfp) {
 		idefloppy_create_request_sense_cmd(&pc);
 		if (idefloppy_queue_pc_tail(drive, &pc))
-			return (-EIO);
+			return -EIO;
 
 		if (floppy->sense_key == 2 &&
 		    floppy->asc == 4 &&
@@ -950,10 +954,11 @@ static int idefloppy_get_format_progress
 
 		progress_indication = ((stat & ATA_DSC) == 0) ? 0 : 0x10000;
 	}
+
 	if (put_user(progress_indication, arg))
-		return (-EFAULT);
+		return -EFAULT;
 
-	return (0);
+	return 0;
 }
 
 static sector_t idefloppy_capacity(ide_drive_t *drive)

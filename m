From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 5/6] IDE: Coding Style fixes to drivers/ide/ide-floppy.c
Date: Sat, 23 Feb 2008 18:38:36 +0100
Message-ID: <20080223183836.09cb53ff@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:23914 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760408AbYBWRim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 12:38:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so200122ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 09:38:41 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

File is now error free.
Compile tested.


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/ide-floppy.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5f133df..cea77e0 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -396,7 +396,7 @@ static void idefloppy_retry_pc(ide_drive_t *drive)
 }
 
 /* The usual interrupt handler called during a packet command. */
-static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
+static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
@@ -1602,7 +1602,7 @@ static struct block_device_operations idefloppy_ops = {
 	.ioctl		= idefloppy_ioctl,
 	.getgeo		= idefloppy_getgeo,
 	.media_changed	= idefloppy_media_changed,
-	.revalidate_disk= idefloppy_revalidate_disk
+	.revalidate_disk = idefloppy_revalidate_disk
 };
 
 static int ide_floppy_probe(ide_drive_t *drive)
-- 
1.5.4.2.316.gf7a7


From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove try_to_flush_leftover_data()
Date: Sat, 3 May 2008 22:39:29 +0200
Message-ID: <200805032239.29745.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:40262 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYECUXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 May 2008 16:23:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1410917fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 03 May 2008 13:23:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Just use the new & shiny ide_pad_transfer() helper instead.

Also remove the superfluous check for 'drive->media == ide_disk'
while at it (ide_ata_error() is used only for ide_disk devices).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -358,31 +358,6 @@ void ide_end_drive_cmd (ide_drive_t *dri
 
 EXPORT_SYMBOL(ide_end_drive_cmd);
 
-/**
- *	try_to_flush_leftover_data	-	flush junk
- *	@drive: drive to flush
- *
- *	try_to_flush_leftover_data() is invoked in response to a drive
- *	unexpectedly having its DRQ_STAT bit set.  As an alternative to
- *	resetting the drive, this routine tries to clear the condition
- *	by read a sector's worth of data from the drive.  Of course,
- *	this may not help if the drive is *waiting* for data from *us*.
- */
-static void try_to_flush_leftover_data (ide_drive_t *drive)
-{
-	int i = (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
-
-	if (drive->media != ide_disk)
-		return;
-	while (i > 0) {
-		u32 buffer[16];
-		u32 wcount = (i > 16) ? 16 : i;
-
-		i -= wcount;
-		drive->hwif->input_data(drive, NULL, buffer, wcount * 4);
-	}
-}
-
 static void ide_kill_rq(ide_drive_t *drive, struct request *rq)
 {
 	if (rq->rq_disk) {
@@ -422,8 +397,11 @@ static ide_startstop_t ide_ata_error(ide
 	}
 
 	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ &&
-	    (hwif->host_flags & IDE_HFLAG_ERROR_STOPS_FIFO) == 0)
-		try_to_flush_leftover_data(drive);
+	    (hwif->host_flags & IDE_HFLAG_ERROR_STOPS_FIFO) == 0) {
+		int nsect = drive->mult_count ? drive->mult_count : 1;
+
+		ide_pad_transfer(drive, READ, nsect * SECTOR_SIZE);
+	}
 
 	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq)) {
 		ide_kill_rq(drive, rq);

From: "Dario Oliva" <doliva@arcoide.com>
Subject: Removable IDE/ATA device
Date: Mon, 25 Oct 2004 14:03:18 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAROcsBjpda0STrtuFqqmVycKAAAAQAAAAjmwTaZlO/kyr6gl0Tg00hQEAAAAA@arcoide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.atl.registeredsite.com ([64.224.219.77]:4521 "EHLO
	mail3.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S261191AbUJYSD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 14:03:27 -0400
Received: from imta02a2.registeredsite.com (imta02a2.registeredsite.com [64.225.255.11])
	by mail3.atl.registeredsite.com (8.12.11/8.12.8) with ESMTP id i9PI3QdU013912
	for <linux-ide@vger.kernel.org>; Mon, 25 Oct 2004 18:03:26 GMT
Received: from DJT9VL41 ([67.104.187.162]) by imta02a2.registeredsite.com
          with ESMTP
          id <20041025180326.WHTL7559.imta02a2.registeredsite.com@DJT9VL41>
          for <linux-ide@vger.kernel.org>; Mon, 25 Oct 2004 14:03:26 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have the following problem with a removable IDE/ATA media device. Linux
attempts to read from the media even if it not present. I had spoken to
Bartlomiej about it and he pointed out that idedisk_open() in ide-disk.c was
ignoring whether media was present or not. I wrote a change to the function,
but Linux still tries to read from the media. I believe this is being done
by some file system check, but it should not try it if the media is not
present. Any ideas?

Here is the patch for idedisk_open()

--- ../linux-2.6.8.1/drivers/ide/ide-disk.c	2004-08-14
06:55:19.000000000 -0400
+++ drivers/ide/ide-disk.c	2004-10-20 09:21:57.806286608 -0400
@@ -754,7 +754,7 @@ ide_startstop_t idedisk_error (ide_drive
 		try_to_flush_leftover_data(drive);
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG); 
 	}
 	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
 		DRIVER(drive)->end_request(drive, 0, 0);
@@ -1643,6 +1643,25 @@ static int idedisk_open(struct inode *in
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args,
NULL))
 			drive->doorlocking = 0;
 	}
+	if(drive->removable) {
+		ide_task_t args;
+		ide_hwif_t *hwif = HWIF(drive);
+	        u8 err;
+		memset(&args, 0, sizeof(ide_task_t));
+		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_GETMEDIASTATUS;
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.handler      = &task_no_data_intr;	
+		ide_raw_taskfile(drive, &args, NULL);
+		err = hwif->INB(IDE_ERROR_REG);
+		/*
+                 * Check to see if media is present.
+		 * If no media is present, return -1.
+                 */
+		if (err & TRK0_ERR) {	
+			drive->usage--;
+			return -1;
+		}
+	}
 	return 0;
 }

Dario Oliva





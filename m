From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/20] ide: use wait_drive_not_busy() in drive_cmd_intr()
Date: Wed, 12 Dec 2007 22:34:17 +0100
Message-ID: <200712122234.17302.bzolnier@gmail.com>
References: <200712092215.45956.bzolnier@gmail.com> <475D38C8.3020908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:39660 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbXLLW54 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 17:57:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so724500ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 14:57:54 -0800 (PST)
In-Reply-To: <475D38C8.3020908@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 10 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/ide-taskfile.c
> > ===================================================================
> > --- a/drivers/ide/ide-taskfile.c
> > +++ b/drivers/ide/ide-taskfile.c
> > @@ -260,7 +260,7 @@ static ide_startstop_t task_no_data_intr
> >  	return ide_stopped;
> >  }
> >  
> > -static u8 wait_drive_not_busy(ide_drive_t *drive)
> > +u8 wait_drive_not_busy(ide_drive_t *drive)
> >  {
> >  	ide_hwif_t *hwif = HWIF(drive);
> >  	int retries;
> 
>    I think you should remove the comment line below:
> 
> 	* (drive_cmd_intr waits that long).

Done.

[PATCH] ide: use wait_drive_not_busy() in drive_cmd_intr() (take 2)

Use wait_drive_not_busy() in drive_cmd_intr().

v2:
* Fix wait_drive_not_busy() comment (noticed by Sergei).

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |    4 +---
 drivers/ide/ide-taskfile.c |    5 ++---
 include/linux/ide.h        |    2 ++
 3 files changed, 5 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -640,7 +640,6 @@ static ide_startstop_t drive_cmd_intr (i
 	ide_hwif_t *hwif = HWIF(drive);
 	u8 *args = (u8 *) rq->buffer;
 	u8 stat = hwif->INB(IDE_STATUS_REG);
-	int retries = 10;
 
 	local_irq_enable_in_hardirq();
 	if (rq->cmd_type == REQ_TYPE_ATA_CMD &&
@@ -649,8 +648,7 @@ static ide_startstop_t drive_cmd_intr (i
 		drive->io_32bit = 0;
 		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
 		drive->io_32bit = io_32bit;
-		while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
-			udelay(100);
+		stat = wait_drive_not_busy(drive);
 	}
 
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -260,7 +260,7 @@ static ide_startstop_t task_no_data_intr
 	return ide_stopped;
 }
 
-static u8 wait_drive_not_busy(ide_drive_t *drive)
+u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	int retries;
@@ -268,8 +268,7 @@ static u8 wait_drive_not_busy(ide_drive_
 
 	/*
 	 * Last sector was transfered, wait until drive is ready.
-	 * This can take up to 10 usec, but we will wait max 1 ms
-	 * (drive_cmd_intr() waits that long).
+	 * This can take up to 10 usec, but we will wait max 1 ms.
 	 */
 	for (retries = 0; retries < 100; retries++) {
 		if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -994,6 +994,8 @@ ide_startstop_t do_rw_taskfile(ide_drive
 
 void task_end_request(ide_drive_t *, struct request *, u8);
 
+u8 wait_drive_not_busy(ide_drive_t *);
+
 int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
 

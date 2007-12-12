From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 15/20] ide: don't enable local IRQs for PIO-in in driver_cmd_intr()
Date: Wed, 12 Dec 2007 22:28:37 +0100
Message-ID: <200712122228.37569.bzolnier@gmail.com>
References: <200712092218.30672.bzolnier@gmail.com> <475D419A.1050506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40413 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbXLLW5y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 17:57:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so724490ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 14:57:52 -0800 (PST)
In-Reply-To: <475D419A.1050506@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 10 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Don't enable local IRQs for PIO-in protocol in driver_cmd_intr().
> 
> > While at it:
> 
> > * Remove redundant rq->cmd_type check.
> 
> > * Read status register after enabling local IRQs for no-data protocol.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/ide-io.c
> > ===================================================================
> > --- a/drivers/ide/ide-io.c
> > +++ b/drivers/ide/ide-io.c
> > @@ -638,17 +638,18 @@ static ide_startstop_t drive_cmd_intr (i
> >  {
> >  	struct request *rq = HWGROUP(drive)->rq;
> >  	ide_hwif_t *hwif = HWIF(drive);
> > -	u8 *args = (u8 *) rq->buffer;
> > -	u8 stat = hwif->INB(IDE_STATUS_REG);
> > +	u8 *args = (u8 *)rq->buffer, pio_in = (args && args[3]) ? 1 : 0, stat;
> >  
> > -	local_irq_enable_in_hardirq();
> > -	if (rq->cmd_type == REQ_TYPE_ATA_CMD &&
> > -	    (stat & DRQ_STAT) && args && args[3]) {
> > +	if (pio_in) {
> >  		u8 io_32bit = drive->io_32bit;
> > +		stat = hwif->INB(IDE_STATUS_REG);
> 
>     You've lost DRQ=1 check (which is returned in the next patch however)...

Thanks, revised patch below.

[PATCH] ide: don't enable local IRQs for PIO-in in driver_cmd_intr() (take 2)

Don't enable local IRQs for PIO-in protocol in driver_cmd_intr().

While at it:

* Remove redundant rq->cmd_type check.

* Read status register after enabling local IRQs for no-data protocol.

v2:
* Re-add DRQ=1 check lost in v1 (noticed by Sergei).

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -638,19 +638,22 @@ static ide_startstop_t drive_cmd_intr (i
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	ide_hwif_t *hwif = HWIF(drive);
-	u8 *args = (u8 *) rq->buffer;
-	u8 stat = hwif->INB(IDE_STATUS_REG);
+	u8 *args = (u8 *)rq->buffer, pio_in = (args && args[3]) ? 1 : 0, stat;
 
-	local_irq_enable_in_hardirq();
-	if (rq->cmd_type == REQ_TYPE_ATA_CMD &&
-	    (stat & DRQ_STAT) && args && args[3]) {
+	if (pio_in) {
 		u8 io_32bit = drive->io_32bit;
+		stat = hwif->INB(IDE_STATUS_REG);
+		if ((stat & DRQ_STAT) == 0)
+			goto out;
 		drive->io_32bit = 0;
 		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
 		drive->io_32bit = io_32bit;
 		stat = wait_drive_not_busy(drive);
+	} else {
+		local_irq_enable_in_hardirq();
+		stat = hwif->INB(IDE_STATUS_REG);
 	}
-
+out:
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
 		return ide_error(drive, "drive_cmd", stat);
 		/* calls ide_end_drive_cmd */


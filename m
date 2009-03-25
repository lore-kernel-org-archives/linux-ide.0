From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: bug in use-ide_pio_bytes patch?
Date: Wed, 25 Mar 2009 10:15:55 +0100
Message-ID: <20090325091555.GA5073@liondog.tnic>
References: <49C72C1B.5080601@kernel.org> <200903231127.25698.bzolnier@gmail.com> <49C7680D.6070108@kernel.org> <200903231243.51078.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:62669 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759083AbZCYJQC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2009 05:16:02 -0400
Received: by bwz17 with SMTP id 17so2572756bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2009 02:15:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200903231243.51078.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Mar 23, 2009 at 12:43:50PM +0100, Bartlomiej Zolnierkiewicz wrote:

> It seems like we really should remove "1:" but it would be best to retest
> ide-floppy with this change.  Borislav, could you add this to your queue?

Done.

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Wed, 25 Mar 2009 10:10:18 +0100
Subject: [PATCH] ide-floppy: do not complete rq's prematurely

... and access them afterwards. Simplify rq completing code while at it.

Spotted-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 11a680c..6d2f97f 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -308,16 +308,14 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 			pc->xferred = pc->req_xfer;
 			if (drive->pc_update_buffers)
 				drive->pc_update_buffers(drive, pc);
-
-			if (drive->media == ide_floppy)
-				ide_complete_rq(drive, 0, blk_rq_bytes(rq));
 		}
 		debug_log("%s: DMA finished\n", drive->name);
 	}
 
 	/* No more interrupts */
 	if ((stat & ATA_DRQ) == 0) {
-		int uptodate;
+		int uptodate, error;
+		unsigned int done;
 
 		debug_log("Packet command completed, %d bytes transferred\n",
 			  pc->xferred);
@@ -364,9 +362,9 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 
 		if (blk_special_request(rq)) {
 			rq->errors = 0;
-			ide_complete_rq(drive, 0, blk_rq_bytes(rq));
+			done = blk_rq_bytes(rq);
+			error = 0;
 		} else {
-			unsigned int done;
 
 			if (blk_fs_request(rq) == 0 && uptodate <= 0) {
 				if (rq->errors == 0)
@@ -378,9 +376,10 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 			else
 				done = blk_rq_bytes(rq);
 
-			ide_complete_rq(drive, uptodate ? 0 : -EIO, done);
+			error = uptodate ? 0 : -EIO;
 		}
 
+		ide_complete_rq(drive, error, done);
 		return ide_stopped;
 	}
 
-- 
1.6.2.1

-- 
Regards/Gruss,
    Boris.

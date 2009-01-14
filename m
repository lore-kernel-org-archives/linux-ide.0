From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: regression: 295f000 breaks suspend to disk
Date: Wed, 14 Jan 2009 18:16:47 +0100
Message-ID: <200901141816.47422.bzolnier@gmail.com>
References: <1231797615.2797.5.camel@odie.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63969 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350AbZANRW1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 12:22:27 -0500
In-Reply-To: <1231797615.2797.5.camel@odie.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Holm =?iso-8859-1?q?Th=F8gersen?= <odie@cs.aau.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Monday 12 January 2009, Simon Holm Th=F8gersen wrote:
> commit 295f000 ("ide: don't execute the next queued command from the
> hard-IRQ context (v2)") breaks suspend to disk for me. On
> 'echo disk > /sys/power/state' the systems hangs, letting me switch
> virtual consoles, but not responding to Alt+SysRq

Thanks, please try the patch below (it fixes the problem for me):

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix suspend regression

On Monday 12 January 2009, Simon Holm Th=F8gersen wrote:
> commit 295f000 ("ide: don't execute the next queued command from the
> hard-IRQ context (v2)") breaks suspend to disk for me. On
> 'echo disk > /sys/power/state' the systems hangs, letting me switch
> virtual consoles, but not responding to Alt+SysRq

Restart the request queue early for REQ_TYPE_PM_RESUME requests
(though there is only one resume request for the whole resume
sequence it stays in the queue until is fully completed and now
depends on kblockd for processing consequential resume states).

Reported-and-bisected-by: Simon Holm Th=F8gersen <odie@cs.aau.dk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-pm.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -186,12 +186,10 @@ void ide_complete_pm_request(ide_drive_t
 	       blk_pm_suspend_request(rq) ? "suspend" : "resume");
 #endif
 	spin_lock_irqsave(q->queue_lock, flags);
-	if (blk_pm_suspend_request(rq)) {
+	if (blk_pm_suspend_request(rq))
 		blk_stop_queue(q);
-	} else {
+	else
 		drive->dev_flags &=3D ~IDE_DFLAG_BLOCKED;
-		blk_start_queue(q);
-	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
=20
 	drive->hwif->rq =3D NULL;
@@ -219,6 +217,8 @@ void ide_check_pm_state(ide_drive_t *dri
 		 * point.
 		 */
 		ide_hwif_t *hwif =3D drive->hwif;
+		struct request_queue *q =3D drive->queue;
+		unsigned long flags;
 		int rc;
 #ifdef DEBUG_PM
 		printk("%s: Wakeup request inited, waiting for !BSY...\n", drive->na=
me);
@@ -231,5 +231,9 @@ void ide_check_pm_state(ide_drive_t *dri
 		rc =3D ide_wait_not_busy(hwif, 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name)=
;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		blk_start_queue(q);
+		spin_unlock_irqrestore(q->queue_lock, flags);
 	}
 }

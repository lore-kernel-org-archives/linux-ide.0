From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Tue, 30 Dec 2008 05:51:20 -0800 (PST)
Message-ID: <20081230135120.24A3710800E@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47261 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677AbYL3NvW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 08:51:22 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBUDpKs5009082
	for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 05:51:21 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #12 from bbpetkov@yahoo.de  2008-12-30 05:51 -------
(In reply to comment #11)
> (In reply to comment #9)
> > (In reply to comment #8)

[.. ]

> > > Borislav, it seems that ide_map_sg() need to check for REQ_TYPE_ATA_PC now that
> > > DMA is allowed for such requests (so it can use sg_init_one() path for them
> > > instead of the usual blk_rq_map_sg() one)?
> > 
> > Hmm,
> > 
> > shouldn't we do that for all rq's which aren't bio-backed? As a means to handle
> > the more general case?
> 
> It would be even better...

How about something similar to the following:

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index cc35d6d..4bee817 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -574,14 +574,15 @@ void ide_map_sg(ide_drive_t *drive, struct request *rq)
        ide_hwif_t *hwif = drive->hwif;
        struct scatterlist *sg = hwif->sg_table;

-       if (hwif->sg_mapped)    /* needed by ide-scsi */
-               return;
-
-       if (rq->cmd_type != REQ_TYPE_ATA_TASKFILE) {
-               hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
-       } else {
+       if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
                sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
                hwif->sg_nents = 1;
+       } else if (!rq->bio) {
+               sg_init_one(sg, rq->data, rq->data_len);
+               hwif->sg_nents = 1;
+       }
+       else {
+               hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
        }
 }

?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

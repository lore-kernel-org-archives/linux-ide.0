From: Prarit Bhargava <prarit@sgi.com>
Subject: [PATCH]: Fix erroneous rq->buffer = NULL in ide-io.c:ide_dma_timeout_retry
Date: Tue, 04 Jan 2005 09:47:25 -0500
Message-ID: <41DAAC7D.7060002@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58259 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261662AbVADOr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2005 09:47:28 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j04ElRc9009083
	for <linux-ide@vger.kernel.org>; Tue, 4 Jan 2005 09:47:27 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j04ElRr05416
	for <linux-ide@vger.kernel.org>; Tue, 4 Jan 2005 09:47:27 -0500
Received: from [172.16.83.37] (dhcp83-37.boston.redhat.com [172.16.83.37])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j04ElPf7011376
	for <linux-ide@vger.kernel.org>; Tue, 4 Jan 2005 09:47:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have found an IDE bug in the IDE DMA timeout function,
ide-io.c: ide_dma_timeout_retry erroneously sets the first_rq->buffer = 
NULL.

ide_dma_timeout_retry will be called whenever a command is issued, times 
out,
and the drive is waiting for DMA.  The function, ide_dma_timeout_retry,
un-busies the hardware group and attempts to clean up the current request.
As part of this cleanup the current failed first_rq->buffer is set to NULL.

However, as part of this retry process first_rq is retried up to 3 times in
PIO mode (with DMA off).

During the retry, ide-cd.c: cdrom_start_read is called, which in turn
calls, restore_request.  restore_request references first_rq->buffer 
(which is
NULL) in order to calculate hard_cur_sectors, hard_nr_sectors, etc.

ie) All of these values will be bogus because of the first_rq->buffer = 
NULL.

This request will fail and the IDE core will enter error handling.  IDE
core generates a new request, sense_rq, in order to request sense.  Attached
this request is a back pointer to the original first_rq request.

        ie) sense_rq->buffer = first_rq

Eventually ide-cd.c:cdrom_end_request is called on sense_rq, and
then ide-io.c:ide_end_dequeued_request is called on first_rq.  Note
that ide_end_dequeued_request is called with the bogus values from first_rq.

The return value essentially depends on the return value of
ll_rw_blk.c:__end_that_request_first.  The arguements to this function 
include
nr_sectors, which as noted above, is bogus.

This leads to a return of 1 from ll_rw_blk.c:__end_that_request_first
which eventually leads to an erroneous call to BUG() in
ide-cd.c:cdrom_end_request.

I have forced this issue to occur by modifying code to effectively DMA
timeout on CDROM accesses on i686 and ia64 platforms.  I hit the bug
100% of the time.

It appears that the modification should be to rid the ide-io.c code of
the rq->buffer = NULL call.

Patch is based off of latest BK linux-2.5 as of 2005-01-04 09:00.

--- linux-2.5.orig/drivers/ide/ide-io.c 2005-01-04 09:31:45.000000000 -0500
+++ linux-2.5/drivers/ide/ide-io.c      2005-01-04 09:32:23.000000000 -0500
@@ -1205,21 +1205,20 @@
        HWGROUP(drive)->rq = NULL;

        rq->errors = 0;

        if (!rq->bio)
                goto out;

        rq->sector = rq->bio->bi_sector;
        rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
        rq->hard_cur_sectors = rq->current_nr_sectors;
-       rq->buffer = NULL;
 out:
        return ret;
 }

 /**
  *     ide_timer_expiry        -       handle lack of an IDE interrupt
  *     @data: timer callback magic (hwgroup)
  *
  *     An IDE command has timed out before the expected drive return
  *     occurred. At this point we attempt to clean up the current


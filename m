From: Prarit Bhargava <prarit@sgi.com>
Subject: Request for Info: DMA timeout rq->buffer = NULL ?
Date: Thu, 30 Dec 2004 13:23:02 -0500
Message-ID: <41D44786.6060708@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:8125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261693AbUL3SXv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2004 13:23:51 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id iBUINpWv026562
	for <linux-ide@vger.kernel.org>; Thu, 30 Dec 2004 13:23:51 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id iBUINpr17303
	for <linux-ide@vger.kernel.org>; Thu, 30 Dec 2004 13:23:51 -0500
Received: from [172.16.83.37] (dhcp83-37.boston.redhat.com [172.16.83.37])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id iBUINmPD011045
	for <linux-ide@vger.kernel.org>; Thu, 30 Dec 2004 13:23:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've come across a situation which appears to be an issue where a 
request has had a DMA timeout and then been reissued in PIO mode.  The 
core issue is that the function ide_dma_timeout_retry sets the 
rq->buffer = NULL.  Later on, when this request is retried in PIO mode 
we hit a BUG() because of the NULL rq->buffer pointer.

I'm wondering exactly why rq->buffer = NULL?

I'm on 2 processor IA64 platform using the SGI IOC4 IDE driver. 

Details are as follows:

A request is created, bogus request = 0xe00000307a98cf18 .

The request is issued to the drive.  For some reason it's timer
fires waiting for DMA.

ide-io.c:1264: ide_timer_expiry is called because of the timeout

ide-io.c:1334 ide_dma_timeout_retry is called.

ide-io.c:1204: ide_dma_timeout_retry

This function puts the drive into PIO mode and turns off DMA.
The drive is un-busy'd.  Part of this procedure is to NULL out the
rq->buffer.

ide-io.c:1346: ide_do_request is called

ide-io.c;1055: ide_do_request

The request is re-issued with the drive in PIO mode and the busted 
rq->buffer = NULL request.

ide-io.c:1178: start_request is called.

ide-io.c:837: start_request

ide-io.c:920: (DRIVER(drive)->do_request(drive, rq, block)) is called.

This resolves to a call to ide-cd.c:2048:ide_do_rw_cdrom.

ide-cd.c;2048: ide_do_rw_cdrom

ide-cd.c:2071:cdrom_start_read is called

ide-cd.c:1411:cdrom_start_read

ide-cd.c:1421:restore_request is called

ide-cd.c:1393:restore_request

This function calculates rq->hard_cur_sectors, etc., based on the
values of rq->buffer.  The problem is that rq->buffer = NULL.
Obviously, all calculations in this function are bogus.

ide-cd.c:1441: cdrom_start_packet_command is issued with the bogus request,
and with cdrom_read_intr as the interrupt handler.

Sometime later, an interrupt occurs and ide-cd.c:1110:cdrom_read_intr
runs.

ide-cd.c:1110:cdrom_read_intr

ide-cd.c:1129:cdrom_decode_status is called

ide-cd.c:711:cdrom_decode_status

ide-cd.c:870:cdrom_queue_request_sense is called

ide-cd.c:573 cdrom_queue_request_sense

This function adds a new request (I will refer to this as the sense 
request) 0xe00000307be66960,
to the queue which simply will query the CDROM for sense.

The sense request stores the bogus request on line 592:
        rq->buffer = (void *) 0xe00000307a98cf18;

This function issues the command directly to the drive and preempts any 
existing commands.

Eventually a cdrom_pc_intr occurs which returns the sense request.

Another cdrom_pc_intr occurs in order to remove
the sense request, 0xe00000307be66960, from the queue.

ide-cd.c:1449:cdrom_pc_intr

ide-cd.c:1482: cdrom_end_request called

ide-cd.c:653:cdrom_end_request

((rq->flags & REQ_SENSE) && uptodate) = 1 and the value of failed is the 
bogus request.

ide-cd.c:678:ide_end_dequeued_request called

ide-io.c:206: ide_end_dequeued_request

This function has been called with the bogus request, and a negative 
value for nr_sectors.
As you climb through the code, the return in this function depends on 
the return value from
drivers/block/ll_rw_blk.c:2798:__end_that_request_first .

In this function, nr_bytes = nr_sectors << 9.  However, nr_bytes and 
nr_sectors are
negative numbers because of the bogus request value of 
rq->nr_hard_sectors being
munged earlier on.

This causes a return of 1 from __end_that_request_first.
...

We're totally out in the weeds here.  __end_that_request_first is coded 
correctly and
correctly returns 1 ("not done") all the way up to 
ide_end_dequeued_request ... and
then you hit

ide-cd.c:679:BUG()




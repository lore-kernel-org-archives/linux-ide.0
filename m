From: Tejun Heo <tj@kernel.org>
Subject: Re: bug in use-ide_pio_bytes patch?
Date: Mon, 23 Mar 2009 19:44:29 +0900
Message-ID: <49C7680D.6070108@kernel.org>
References: <49C72C1B.5080601@kernel.org> <200903231127.25698.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49670 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbZCWKof (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Mar 2009 06:44:35 -0400
In-Reply-To: <200903231127.25698.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

Bartlomiej Zolnierkiewicz wrote:
>> It completes ide_floppy requests in the DMA handling block; however,
>> those requests are gonna be completed again later in the regular
>> completion path again.  I think the above part can be simply dropped?
> 
> I'm not sure I get it -- could you point me to the other completion path?

static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
{
....	
	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
....
		if (rc || (drive->media == ide_tape && (stat & ATA_ERR))) {
			if (drive->media == ide_floppy)
				printk(KERN_ERR "%s: DMA %s error\n",
					drive->name, rq_data_dir(pc->rq)
						     ? "write" : "read");
			pc->flags |= PC_FLAG_DMA_ERROR;
		} else {
			pc->xferred = pc->req_xfer;
			if (drive->pc_update_buffers)
				drive->pc_update_buffers(drive, pc);

			if (drive->media == ide_floppy)
1:				ide_complete_rq(drive, 0, blk_rq_bytes(rq));
		}
		debug_log("%s: DMA finished\n", drive->name);
	}

	/* No more interrupts */
	if ((stat & ATA_DRQ) == 0) {
...
		/* Command finished - Call the callback function */
		uptodate = drive->pc_callback(drive, dsc);

		if (uptodate == 0)
			drive->failed_pc = NULL;

		if (blk_special_request(rq)) {
			rq->errors = 0;
2:			ide_complete_rq(drive, 0, blk_rq_bytes(rq));
		} else {
			unsigned int done;

			if (blk_fs_request(rq) == 0 && uptodate <= 0) {
				if (rq->errors == 0)
					rq->errors = -EIO;
			}

			if (drive->media == ide_tape)
				done = ide_rq_bytes(rq); /* FIXME */
			else
				done = blk_rq_bytes(rq);

3:			ide_complete_rq(drive, uptodate ? 0 : -EIO, done);
		}

		return ide_stopped;
	}
...
}

#1 completely completes the request after which it shouldn't be
accessed, but rq is accessed afterwards and #2 or #3 will be called on
the rq again.  Am I missing something?

Thanks.

-- 
tejun

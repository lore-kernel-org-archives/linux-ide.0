From: Tejun Heo <tj@kernel.org>
Subject: bug in use-ide_pio_bytes patch?
Date: Mon, 23 Mar 2009 15:28:43 +0900
Message-ID: <49C72C1B.5080601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60005 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbZCWG2u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Mar 2009 02:28:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Bartlomiej.

I've been looking at the pata-2.6 patches and use-ide_pio_bytes patch
contains the following snippet.

  void ide_init_pc(struct ide_atapi_pc *pc)
  {
	 memset(pc, 0, sizeof(*pc));
 @@ -351,6 +308,9 @@ static ide_startstop_t ide_pc_intr(ide_d
			 pc->xferred = pc->req_xfer;
			 if (drive->pc_update_buffers)
				 drive->pc_update_buffers(drive, pc);
 +
 +			if (drive->media == ide_floppy)
 +				ide_complete_rq(drive, 0, blk_rq_bytes(rq));
		 }
		 debug_log("%s: DMA finished\n", drive->name);
	 }

It completes ide_floppy requests in the DMA handling block; however,
those requests are gonna be completed again later in the regular
completion path again.  I think the above part can be simply dropped?

Thanks.

-- 
tejun

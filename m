From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Mon, 10 Dec 2007 19:08:48 +0100
Message-ID: <20071210180847.GF22445@kernel.dk>
References: <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org> <20071209190913.GB13382@kernel.dk> <475C48EE.8020701@pianoinflames.de> <20071209200440.GC13382@kernel.dk> <475C536B.5070409@pianoinflames.de> <20071209210137.GD13382@kernel.dk> <475D7F03.7050100@pianoinflames.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:5909 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbXLJSIw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 13:08:52 -0500
Content-Disposition: inline
In-Reply-To: <475D7F03.7050100@pianoinflames.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marco Gatti <marco@pianoinflames.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>

On Mon, Dec 10 2007, Marco Gatti wrote:
> Jens Axboe schrieb:
> >>>>Hello Jens,
> >>>>Thanks for help. I just applied the patch. Unfortunately it doesn't 
> >>>>work.
> >>>Can you try and additionally boot with iommu=off as a boot parameter?
> >>>
> >>Yes. This is the end of getting any sata devices. See screenshots for 
> >>errors. It continued untill ata4. At the end no root device was found.
> >
> >Hmm, even though the address is set to 0xffffffff we still seem to
> >receive requests outside that range. Lets assume it's the scsi logic,
> >can you test this? IOW, patch + iommu=off + this patch.
> >
> >I probably wont see any more mails tonight, we can continue this
> >tomorrow (or someone else can step in, whatever comes first :-)
> >
> >diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> >index 2faced6..769ce3a 100644
> >--- a/drivers/scsi/scsi_lib.c
> >+++ b/drivers/scsi/scsi_lib.c
> >@@ -1572,7 +1572,9 @@ struct request_queue *__scsi_alloc_queue(struct 
> >Scsi_Host *shost,
> > #endif
> > 
> > 	blk_queue_max_sectors(q, shost->max_sectors);
> >+#if 0
> > 	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
> >+#else
> > 	blk_queue_segment_boundary(q, shost->dma_boundary);
> > 
> > 	if (!shost->use_clustering)
> I applied the path. Got Hunk #1 succeeded at 1562 with fuzz 2 (offset 
> -10 lines).
> 
> I didn't compile completly.
> 
> drivers/scsi/scsi_lib.c:1565:1: error: unterminated #else
> make[2]: *** [drivers/scsi/scsi_lib.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

Doh sorry, that #else wants to be an #endif

-- 
Jens Axboe


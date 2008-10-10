From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/7] ide: ide_hwgroup_t.rq doesn't need an ide_lock held
Date: Fri, 10 Oct 2008 11:37:22 +0200
Message-ID: <87wsggdc4t.fsf@denkblock.local>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
	<20081008203002.19112.519.sendpatchset@localhost.localdomain>
	<87abdcg86j.fsf@denkblock.local> <20081010090116.GX19428@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41151 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbYJJJhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Oct 2008 05:37:31 -0400
In-Reply-To: <20081010090116.GX19428@kernel.dk> (Jens Axboe's message of "Fri,
	10 Oct 2008 11:01:17 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> wrote:
> On Fri, Oct 10 2008, Elias Oltmanns wrote:
>> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
>> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> > Subject: [PATCH] ide: ide_hwgroup_t.rq doesn't need an ide_lock held
>> >
>> > While at it:
>> > - no need to check for hwgroup presence in ide_dump_opcode()
>> >
>> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> > ---
>> [...]
>> > Index: b/drivers/ide/ide-io.c
>> > ===================================================================
>> > --- a/drivers/ide/ide-io.c
>> > +++ b/drivers/ide/ide-io.c
>> [...]
>> > @@ -274,7 +269,11 @@ static void ide_complete_pm_request (ide
>> >  		drive->dev_flags &= ~IDE_DFLAG_BLOCKED;
>> >  		blk_start_queue(drive->queue);
>> >  	}
>> > -	HWGROUP(drive)->rq = NULL;
>> > +	spin_unlock_irqrestore(&ide_lock, flags);
>> > +
>> > +	drive->hwif->hwgroup->rq = NULL;
>> > +
>> > +	spin_lock_irqsave(&ide_lock, flags);
>> >  	if (__blk_end_request(rq, 0, 0))
>> >  		BUG();
>> >  	spin_unlock_irqrestore(&ide_lock, flags);
>> 
>> Is it really an improvement to release the lock here?
>
> And more importantly, is it even safe? What serializes ->rq assignments
> and checks without the ide_lock? Looks fishy.

Well, I haven't quite made up my mind whether it'll work in all cases,
but I think the hwgroup->busy flag is supposed to take care of that.

Regards,

Elias

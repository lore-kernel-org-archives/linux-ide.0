From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] IDE TCQ #2
Date: Fri, 3 May 2002 18:45:55 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020503164555.GQ839@suse.de>
References: <20020503110652.GF839@suse.de> <20020503163248.633c8358.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20020503163248.633c8358.sebastian.droege@gmx.de>
List-Id: linux-ide@vger.kernel.org
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, May 03 2002, Sebastian Droege wrote:
> On Fri, 3 May 2002 13:06:52 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > Hi,
> > 
> > 2.5.13 now has the generic tag support that I wrote included, here's an
> > IDE TCQ that uses that. Changes since the version posted for 2.5.12:
> > 
> > - Fix the ide_tcq_invalidate_queue() WIN_NOP usage needed to clear the
> >   internal queue on errors. It was disabled in the last version due to
> >   the ata_request changes, it should work now.
> > 
> > - Remove Promise tcq disable check, it works just fine on Promise as
> >   long as we handle the two-drives-with-tcq case like we currently do.
> 
> Hi,
> I get following oops after a while... it's not really reproducable but
> happens a few minutes after bootup
> With TCQ disabled the kernel is rock-solid ;)
> I only use TCQ on one harddisk (hda)... hdb doesn't support it.
> The IDE controller is an Intel Corp. 82371AB PIIX4 IDE (rev 01)
> hda is a IBM-DTTA-351010

Hmm strange, please send me your .config so I can see some more facts
about your setup.

> ide_tcq_intr_timeout: timeout waiting for interrupt...
> ide_tcq_intr_timeout: hwgroup not busy

We timed out waiting for an interrupt for service or dma completion.
Damn, I forgot to print which one. Please change that printk in
drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:

	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
		hwgroup->rq ? "completion" : "service");

and reproduce!

> hda: invalidating pending queue (10)

Ok, so a service check produced nothing for the drive (ok, odds are good
this is a completion interrupt timeout), so we proceeded to invalidate
the block tag queue.

> kernel BUG at ll_rw_blk.c:407!

And apparently one of the request on the tag queue had no tag assigned,
very odd. This means someone else ended it, but it didn't get cleared.
Hmm. This is probably your problem, I'll have to think about this.

[snip oops]

At least part of the decode seems bogus (eip should be
blk_queue_end_tag...) and the last traces should be ide_tcq_intr_timeout
-> ide_tcq_invalidate_queue -> blk_queue_invalidate_tags

Thanks for testing!

-- 
Jens Axboe


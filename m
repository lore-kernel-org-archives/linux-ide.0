From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
Date: Wed, 29 Dec 2004 22:32:12 +0100
Message-ID: <58cb370e04122913323cdf05e8@mail.gmail.com>
References: <1104246926.22366.97.camel@localhost.localdomain>
	 <58cb370e041229092919c1b4a8@mail.gmail.com>
	 <1104351122.31052.9.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:29645 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261419AbUL2VcN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Dec 2004 16:32:13 -0500
Received: by wproxy.gmail.com with SMTP id 36so114069wra
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2004 13:32:12 -0800 (PST)
In-Reply-To: <1104351122.31052.9.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org, linux-ide@vger.kernel.org

On Wed, 29 Dec 2004 20:12:04 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-12-29 at 17:29, Bartlomiej Zolnierkiewicz wrote:
> > Let me complain once again :-), libata based driver would be better...
> 
> Eventually probably but libata's PATA support is pretty pathetic right
> now, it doesn't know anything about PATA drive errata. I did look at it
> and when it grows up into a real IDE layer for PATA I'm all for moving
> *every* IDE driver to it because some of the IDE error path corner cases

OK

> are almost rewrite level fixes (eg DMA changedown, timer/interrupt CD
> race oops)

fully agreed

> > > +                *      If we are in pass through mode then not much
> > > +                *      needs to be done, but we do bother to clear the
> > > +                *      IRQ mask in case the drives are PIO (eg rev 0x10)
> > > +                *      for now.
> > > +                */
> >
> > comment or code is wrong, unmask is turned on unconditionally
> 
> Disagree. It says "e.g."

"e.g." is okay, "in case the drives are PIO" is not,
unmask also affects DMA (I believe it is not needed for DMA but ...)
 
> > > +                       hwif->ide_dma_off_quietly(drive);
> > > +#ifdef CONFIG_IDEDMA_ONLYDISK
> > > +                       if (drive->media == ide_disk)
> > > +#endif
> > > +                               hwif->ide_dma_check(drive);
> >
> > hack, it looks like fixup code in ide-probe.c need to be moved to probe_hwif()
> 
> I'm not sure of the best way to do that cleanly. What do you have in
> mind ?

moving ->fixup() execution from probe_hwif_init_with_fixup() to probe_hwif()
(just before code which does PIO / DMA tuning)

>From what I see it shouldn't affect current ->fixup users
(and is saner because currently "undecoded slave" is also tuned).

> Thanks. I'll go and polish these up.

Thanks.

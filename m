From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: PATA DMA problem leading to kernel panic on reading movie DVDs
Date: Sun, 17 May 2009 22:30:33 +0200
Message-ID: <20090517203033.GB5142@liondog.tnic>
References: <20090517091224.GA8280@wanza.invalid> <200905172145.45756.bzolnier@gmail.com> <20090517195051.GA5142@liondog.tnic> <200905172218.01606.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:65391 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbZEQUag (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 16:30:36 -0400
Content-Disposition: inline
In-Reply-To: <200905172218.01606.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, Martin Lottermoser <Martin.Lottermoser@t-online.de>, linux-ide@vger.kernel.org

Hi,

On Sun, May 17, 2009 at 10:18:01PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 17 May 2009 21:50:51 Borislav Petkov wrote:
> > On Sun, May 17, 2009 at 09:45:45PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Sunday 17 May 2009 21:34:09 Borislav Petkov wrote:
> > > > (adding Bart to CC)
> > > > 
> > > > Hi Bart,
> > > > 
> > > > please take a look at the OOPS below, seems like we BUG() in ide_intr() at
> > > > BUG_ON(!hwif->handler) which shouldn't happen. Full message is at:
> > > > 
> > > > http://www.gossamer-threads.com/lists/linux/kernel/1077445.
> > > > 
> > > > It is 2.6.29.3 with both PIIX_IDE and ata_piix compiled and it could be
> > > > that those two step on each other's toes, but this is only wild stab in
> > > > the dark.
> > > > 
> > > > I'm sure you have more ideas.
> > > 
> > > Yes, see my other mail.
> > 
> > Saw it right after hitting send.
> > 
> > > [ After writing "I will cc: linux-ide on IDE/ATA problems" 100x times
> > >   on the whiteboard... ;-) ]
> > 
> > And I CC'ed you instead, this has even bigger effect :)
> 
> Actually no.
> 
> I'm following all IDE discussions on linux-ide anyway and whenever I see
> that I can help immediately I do it (and if I can't the issue gets its
> priority level according to which it will be looked at later).  CC:ing me
> on not fully debugged problems is not helping anything.  More likely that
> it disrupts the work-flow since people are waiting on me instead of just
> pushing for the solution harder...

In this case, however, it made more sense to CC you - you know that code
better than me, you have the bunch of experience while I have to read
a ton of stuff before I get up to speed with the problem. You, on the
other hand, have seen similar errors like that before and can at least
have a hunch - and you did. Besides, it's not like I'm waiting for you
- I have other things on my plate which I could tackle while you handle
the case you're more knowledgeable at. It is simple as that.

But I'll start CCing linux-ide if that's your preference.

-- 
Regards/Gruss,
    Boris.

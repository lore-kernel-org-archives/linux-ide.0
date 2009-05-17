From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: PATA DMA problem leading to kernel panic on reading movie DVDs
Date: Sun, 17 May 2009 21:50:51 +0200
Message-ID: <20090517195051.GA5142@liondog.tnic>
References: <20090517091224.GA8280@wanza.invalid> <20090517121444.GA8733@wanza.invalid> <20090517193409.GC2976@liondog.tnic> <200905172145.45756.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62835 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbZEQTuy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 15:50:54 -0400
Content-Disposition: inline
In-Reply-To: <200905172145.45756.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-kernel@vger.kernel.org, Martin Lottermoser <Martin.Lottermoser@t-online.de>, linux-ide@vger.kernel.org

On Sun, May 17, 2009 at 09:45:45PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 17 May 2009 21:34:09 Borislav Petkov wrote:
> > (adding Bart to CC)
> > 
> > Hi Bart,
> > 
> > please take a look at the OOPS below, seems like we BUG() in ide_intr() at
> > BUG_ON(!hwif->handler) which shouldn't happen. Full message is at:
> > 
> > http://www.gossamer-threads.com/lists/linux/kernel/1077445.
> > 
> > It is 2.6.29.3 with both PIIX_IDE and ata_piix compiled and it could be
> > that those two step on each other's toes, but this is only wild stab in
> > the dark.
> > 
> > I'm sure you have more ideas.
> 
> Yes, see my other mail.

Saw it right after hitting send.

> [ After writing "I will cc: linux-ide on IDE/ATA problems" 100x times
>   on the whiteboard... ;-) ]

And I CC'ed you instead, this has even bigger effect :)

-- 
Regards/Gruss,
    Boris.

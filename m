From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: Use the fixup layer to fix the various SI3112 hangs
Date: Sat, 6 Nov 2004 02:00:20 +0100
Message-ID: <58cb370e04110517005a88562e@mail.gmail.com>
References: <1099672950.5630.59.camel@localhost.localdomain>
	 <58cb370e04110514594adcb6e2@mail.gmail.com>
	 <58cb370e041105152431299ff7@mail.gmail.com>
	 <1099697668.5564.82.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:56194 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261299AbUKFBAa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 20:00:30 -0500
Received: by rproxy.gmail.com with SMTP id a36so139904rnf
        for <linux-ide@vger.kernel.org>; Fri, 05 Nov 2004 17:00:20 -0800 (PST)
In-Reply-To: <1099697668.5564.82.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, 05 Nov 2004 23:34:29 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-11-05 at 23:24, Bartlomiej Zolnierkiewicz wrote:
> 
> 
> > On Fri, 5 Nov 2004 23:59:09 +0100, Bartlomiej Zolnierkiewicz
> > <bzolnier@gmail.com> wrote:
> > > all fixup patches applied
> > > (after merging into 2 changesets & cleanup)
> >
> > and fixed bug preventing both fixups from correct working,
> > fixup() must be called _before_ hwif_init() call!!!
> 
> Moving it is definitely better I agree there - it also allows fixup to
> be used for irq mangling and sg table tweaks which couldn't be done
> before.
> 
> I don't see why ita a bug in the present situation - and the code
> certainly works against 10rc1 and 2.6.9 that way but since moving it is
> better I've no problem at all

It depends which fixup you are talking about...

undecoded slave: hwif_init()->init_gendisk()-> drive->present checked
(sysfs and devfs entries registered for "ghost" drive but fixup works)

siimage: hwif_init()->init_irq()->ide_init_queue()-> hwif->rqsize used
(so fixup was executed too late previously)

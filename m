From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ide-pmac: media-bay support fixes
Date: Sun, 06 Jul 2008 08:25:29 +1000
Message-ID: <1215296729.8970.17.camel@pasglop>
References: <200806162124.43005.bzolnier@gmail.com>
	 <1215067667.21182.98.camel@pasglop> <1215070435.21182.107.camel@pasglop>
	 <200807051756.26506.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37458 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbYGEWZf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jul 2008 18:25:35 -0400
In-Reply-To: <200807051756.26506.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> In init_irq() we unmask IRQs just before registering IRQ handler but we
> we don't clear pending IRQs before the unmask (simply reading the Status
> register should be enough).
> 
> [ Previously ide_port_wait_ready() would do it during ide_device_add()
>   call and before the IRQ handler is registered but now it will be skipped
>   because of ->noprobe being set. ]

I'm pretty sure I added some reads of the status reg before enable_irq()
and that didn't fix it but I may have fubar'ed. I'll dbl check.

> Arrghhh, this was actually caused by a brain glitch on my side...
> 
> While preparing this patch I was under the impression that ->init_dev can
> be called only by ide through ide_device_add(), which is of course untrue
> since it can be called by mediabay through ide_port_scan()...
> 
> However when I think deeper about it I recall that I first implemented
> it as ->init_hwif (for which the assumption was true) and later converted
> the patch to ->init_dev because I noticed the assumption and realized
> that it needs to be ->init_dev to make it work for warm-plug...
> 
> Scary... :)

Yup. Later, I though about ways not to add a new state but the
patch was done, so let's go with it for now.

> This is a kind of tangential issue to pmac stuff.
> 
> Could you resend it as a separate patch with your S-o-b: line?

Oh, that's just debug stuff for me to track down the bug. Do you want
to merge it ? I told you I just send whatever hacks I did to get it
going so far, I'll clean things up when I have the irq stuff solved.

> >  	/*
> >  	 * We must always disable IRQ, as probe_for_drive will assert IRQ, but
> >  	 * we'll install our IRQ driver much later...
> > @@ -798,6 +802,7 @@ static int ide_probe_port(ide_hwif_t *hw
> >  		(void) probe_for_drive(drive);
> >  		if (drive->present)
> >  			rc = 0;
> > +		ide_busy_sleep(hwif);
> 
> I don't quite get this chunk.
> 
> Is it a workaround for interrupt storm problem?

Yup, tho didn't work.

> [...]
> 
> I integrated the rest in a verbatim form with pmac patches
> (two of them got 'take 4' as a result, the other two remain unchanged):
> 
> pmac-media-bay-support-fixes-take-4.patch
> pmac-store-pmif-instead-of-hwif-in-driver_data-take-2.patch
> pmac-add-init_dev-method-take-4.patch
> pmac-move-ide_find_port-call-to-pmac_ide_setup_device-take-2.patch
> 
> [ in the usual place ]

Ok. Will look at it on monday (ie. tomorrow for me).

Cheers,
Ben.


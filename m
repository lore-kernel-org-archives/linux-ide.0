From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] ide-pmac: PIO fixes
Date: Fri, 13 Jul 2007 22:03:16 +0200
Message-ID: <200707132203.16470.bzolnier@gmail.com>
References: <200707110204.07540.bzolnier@gmail.com> <4697A47F.8060704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:44346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbXGMVbA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647444ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:30:59 -0700 (PDT)
In-Reply-To: <4697A47F.8060704@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kyle McMartin <kyle@mcmartin.ca>

On Friday 13 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add { 0, 0 } entry to {kauai,shasta}_pio_timings[] so kauai_lookup_timing()
> >   always returns a valid PIO timing (fixes PIO timing not being set for devices
> >   with minimum PIO cycle <= 120ns).
> 
>     Ugh... the way those tables are following each other, the driver should be 
> programming MWDMA2 timings instead. :-/

Indeed... nasty...

> > * Add setting transfer mode on the device to pmac_ide_set_pio_mode().
> 
> > * Fix pmac_ide_set_pio() to always program chipset for given PIO timing instead
> >   of only when the device we want to program PIO timing for is the currently
> >   selected one.
> 
>     Hm, why this was necessary?

No idea...

...(mis)optimization? :)

>     AFAIU, pmac_ide_do_setfeature() will cause selectproc() to be called 
> anyway, via SELECT_DRIVE()...

Yes, but pmac_ide_do_setfeature() wasn't called et all in the old version
of pmac_ide_set_pio().

> > * Now that pmac_ide_set_pio() is fixed there is no need to set transfer mode
> >   on the device and program chipset for PIO in pmac_ide_tune_chipset()
> 
>     BTW, I'm also not seeing much sense in calling 
> pmac_ide_do_update_timings() from there as well since pmac_ide_do_setfeature() 
> is called before that anyway.

The patch only intended to make pmac_ide_set_pio() match the code in
pmac_ide_tune_chipset().  Thanks to your analysis I see now that more
fixups/cleanups are possible in this driver but I'm not up to it...

> >   (returning 0 == success is not entirely correct but is OK for now since
> >   the upper layers are only checking ->speedproc return value for DMA modes).
> 
> > This patch should have no effect on the default kernel behavior because
> > IDE pmac driver doesn't enable ->autotune (this would also explain why some
> > of the above bugs remained unfixed for so long).
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

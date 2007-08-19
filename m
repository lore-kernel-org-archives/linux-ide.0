From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Sun, 19 Aug 2007 19:17:55 +0200 (MEST)
Message-ID: <200708191717.l7JHHtMO021933@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:49575 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbXHSRSR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 13:18:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikpe@it.uu.se, sshtylyov@ru.mvista.com
Cc: alan@lxorguk.ukuu.org.uk, albertl@mail.com, jeff@garzik.org, linux-ide@vger.kernel.org

On Sun, 19 Aug 2007 20:13:46 +0400, Sergei Shtylyov wrote:
> Mikael Pettersson wrote:
> 
> > Previously I reported that the pata_pdc2027x PLL detection changes
> > in kernel 2.6.22 broke the driver on my PowerMac:
> 
> >>pata_pdc2027x: Invalid PLL input clock 1691742kHz, give up!
> 
> > This is followed by a number of errors and speed reduction
> > steps on the affected ports.
> 
> > There are two bugs in pata_pdc2027x's PLL detection code:
> 
> > 1. The PLL counter's start value is read before the chip is
> >    put in "test mode". Outside of test mode the counter is
> >    halted, and on the PowerMac the counter is zero because
> >    the chip hasn't been initialised by its BIOS.
> 
>     So what?

a) causes an unnecessary wraparound, which in turn is one of the
   causes for PLL detection failures on non-x86
b) puts more work [the enter test mode stuff] in between the start
   and and sampling points, reducing the precision of the PLL
   detection; I actually observed quite noticeable differences
   in detected PLL frequency based on whether the start was sampled
   before or after the test mode enter code

> >    The fix is to move the read of the start value to after
> >    test mode is started, but before the mdelay() in test mode.
> 
>     This is not an issue, so no fix is needed.
> 
> >    This also improves the precision of the PLL detection.
> 
>     BTW, looks like we don't even need to bother reading the darn counter 
> beforehand: bit 1 of the indexed register 1 (the same used to enter/exit test 
> mode by twiddling its bit 6) when being cleared should reset the counter to 0 
> -- I'm looking at the internal sources which were written based on the 
> *fragment* of the PDC20270 datasheet (yeah, Promise didn't even give us the 
> whole datasheet!) about the PLL calibration.

Well, I have no data sheet and no sources except what's in the kernel
and what debug info PDC_DEBUG generates.

> > 2. The code to compute the number of PLL decrements during the
> >    mdelay() in test mode fails to consider that the PLL counter
> >    only is 30 bits wide. If there is a wraparound, it will compute
> >    an incorrect and much too large value. On the PowerMac, the
> >    start count is zero, the end count is a large 30-bit value, so
> >    wraparound occurs and an out of bounds PLL clock is detected.
> 
> >    The fix is to mask the (start - end) computation to 30 bits.
> 
>     Yeah, that's what I've done for the old IDE driver...

Except that due to what may be a typo pdc202xx_new masks to
26 bits, not 30. I was going to address that if/when this patch
goes in.

> > While debugging this I also noticed that pdc_read_counter()
> > reads the two halves of the 30-bit PLL counter as 16-bit values,
> > and then combines them as if the halves only are 15 bits wide.
> > To avoid confusion, the halves should be read as 15-bit values.
> 
>     Shouldn't matter, the bit is most probably reseved and so always remains 0.
> Actually, those 2 counters count the data bytes transferred over PCI bus when 
> the chip in not in the test mode.

It matters when someone reads the code and wonders why two 16-bit values
(readl() & 0xffff) are combined with a 15-bit shift ((x << 15) | y).

> > This patch implements all three changes. It fixes the PLL detection
> > failure on my PowerMac, and doesn't cause any regressions on an x86
> > with an identical card.
> 
> > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > diff -rupN linux-2.6.23-rc3/drivers/ata/pata_pdc2027x.c linux-2.6.23-rc3.pata_pdc2027x-pll-detection-fixes/drivers/ata/pata_pdc2027x.c
> > --- linux-2.6.23-rc3/drivers/ata/pata_pdc2027x.c	2007-07-09 22:01:31.000000000 +0200
> > +++ linux-2.6.23-rc3.pata_pdc2027x-pll-detection-fixes/drivers/ata/pata_pdc2027x.c	2007-08-18 21:53:40.000000000 +0200
> [...]
> > @@ -719,7 +719,7 @@ static long pdc_detect_pll_input_clock(s
> >  	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
> >  		(end_time.tv_usec - start_time.tv_usec);
> >  
> > -	pll_clock = (start_count - end_count) / 100 *
> > +	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
> >  		(100000000 / usec_elapsed);
> >  
> >  	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
> 
>     Only this fragment really matters.

Yeah, this is the key fix. But the other changes still improve things.

/Mikael

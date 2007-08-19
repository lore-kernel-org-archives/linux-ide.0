From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Sun, 19 Aug 2007 08:01:32 +0800
Message-ID: <46C7885C.9010604@tw.ibm.com>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:43080 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXHSABr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 20:01:47 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7J01kgB027574
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 20:01:46 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7J01kHx268696
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 18:01:46 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7J01km5030581
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 18:01:46 -0600
In-Reply-To: <200708182058.l7IKwrcJ016820@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, albertl@mail.com, jeff@garzik.org

Mikael Pettersson wrote:
> Previously I reported that the pata_pdc2027x PLL detection changes
> in kernel 2.6.22 broke the driver on my PowerMac:
> 
> 
>>pata_pdc2027x: Invalid PLL input clock 1691742kHz, give up!
> 
> 
> This is followed by a number of errors and speed reduction
> steps on the affected ports.
> 
> There are two bugs in pata_pdc2027x's PLL detection code:
> 
> 1. The PLL counter's start value is read before the chip is
>    put in "test mode". Outside of test mode the counter is
>    halted, and on the PowerMac the counter is zero because
>    the chip hasn't been initialised by its BIOS.
> 
>    The fix is to move the read of the start value to after
>    test mode is started, but before the mdelay() in test mode.
>    This also improves the precision of the PLL detection.
> 
> 2. The code to compute the number of PLL decrements during the
>    mdelay() in test mode fails to consider that the PLL counter
>    only is 30 bits wide. If there is a wraparound, it will compute
>    an incorrect and much too large value. On the PowerMac, the
>    start count is zero, the end count is a large 30-bit value, so
>    wraparound occurs and an out of bounds PLL clock is detected.
> 
>    The fix is to mask the (start - end) computation to 30 bits.

The wrap-around situation was handled by checking if (pll_clock < 0)
in pdc_hardware_init() then retrying pdc_detect_pll_input_clock().
But it seems not working correctly. :(

> 
> While debugging this I also noticed that pdc_read_counter()
> reads the two halves of the 30-bit PLL counter as 16-bit values,
> and then combines them as if the halves only are 15 bits wide.
> To avoid confusion, the halves should be read as 15-bit values.
> 
> This patch implements all three changes. It fixes the PLL detection
> failure on my PowerMac, and doesn't cause any regressions on an x86
> with an identical card.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
>  drivers/ata/pata_pdc2027x.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff -rupN linux-2.6.23-rc3/drivers/ata/pata_pdc2027x.c linux-2.6.23-rc3.pata_pdc2027x-pll-detection-fixes/drivers/ata/pata_pdc2027x.c
> --- linux-2.6.23-rc3/drivers/ata/pata_pdc2027x.c	2007-07-09 22:01:31.000000000 +0200
> +++ linux-2.6.23-rc3.pata_pdc2027x-pll-detection-fixes/drivers/ata/pata_pdc2027x.c	2007-08-18 21:53:40.000000000 +0200
> @@ -563,13 +563,13 @@ static long pdc_read_counter(struct ata_
>  	u32 bccrl, bccrh, bccrlv, bccrhv;
>  
>  retry:
> -	bccrl = readl(mmio_base + PDC_BYTE_COUNT) & 0xffff;
> -	bccrh = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0xffff;
> +	bccrl = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
> +	bccrh = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
>  	rmb();
>  
>  	/* Read the counter values again for verification */
> -	bccrlv = readl(mmio_base + PDC_BYTE_COUNT) & 0xffff;
> -	bccrhv = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0xffff;
> +	bccrlv = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
> +	bccrhv = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
>  	rmb();

Agreed this looks safer. (Although the high bit 15 of the counter
is always zero during my test.)

>  
>  	counter = (bccrh << 15) | bccrl;
> @@ -692,16 +692,16 @@ static long pdc_detect_pll_input_clock(s
>  	struct timeval start_time, end_time;
>  	long pll_clock, usec_elapsed;
>  
> -	/* Read current counter value */
> -	start_count = pdc_read_counter(host);
> -	do_gettimeofday(&start_time);
> -
>  	/* Start the test mode */
>  	scr = readl(mmio_base + PDC_SYS_CTL);
>  	PDPRINTK("scr[%X]\n", scr);
>  	writel(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
>  	readl(mmio_base + PDC_SYS_CTL); /* flush */
>  
> +	/* Read current counter value */
> +	start_count = pdc_read_counter(host);
> +	do_gettimeofday(&start_time);
> +
>  	/* Let the counter run for 100 ms. */
>  	mdelay(100);

Looks good (though reading the start_count before or after doesn't
really matter since we can treat "start the test mode" as part of
the 100ms delay time).

>  
> @@ -719,7 +719,7 @@ static long pdc_detect_pll_input_clock(s
>  	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
>  		(end_time.tv_usec - start_time.tv_usec);
>  
> -	pll_clock = (start_count - end_count) / 100 *
> +	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
>  		(100000000 / usec_elapsed);
>  
>  	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
> 
> 

Hmm, this one alone looks like the real fix for the problem. I guess my
previous patch changing pll_clock from "(start_count - end_count) * 10"
to "(start_count - end_count) / 100 * (100000000 / usec_elapsed)" somehow
broke the (pll_clock < 0) check...

Thanks for fixing it. Maybe we also need this fix for the IDE
pdc202xx_new.c driver...

Acked-by: Albert Lee <albertcc@tw.ibm.com>
--
albert


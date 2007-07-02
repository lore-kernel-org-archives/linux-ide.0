From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Mon, 2 Jul 2007 20:13:04 +0200
Message-ID: <200707022013.04383.bzolnier@gmail.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com> <46809EA7.5090005@tw.ibm.com> <4680A773.2020009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:32087 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbXGBR4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 13:56:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1307864ugf
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 10:56:30 -0700 (PDT)
In-Reply-To: <4680A773.2020009@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Doug Maxey <dwm@enoyolf.org>


Hi,

Could you also fix pdc202xx_new driver?

"buggy" code should be very similar if not identical...

On Tuesday 26 June 2007, Albert Lee wrote:
> Recently the PLL input clock of pata_pdc2027x is sometimes detected
> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
> It seems sometimes the mdelay() function is not as precise as it
> used to be. Per Alan's advice, HT or power management might affect
> the precision of mdelay().
> 
> This patch calls gettimeofday() to mesure the time elapsed and
> calculate the PLL input clock accordingly.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> 
> Did more test. For mdelay(100) the usec_elapsed is usually 99287.
> However, sometimes the usec_elapsed is 118934, longer than expected.
> 
> Jun 26 12:12:29 p4ht-s kernel: [ 9156.490991] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
> Jun 26 12:12:29 p4ht-s kernel: [ 9156.610175] usec_elapsed[118934]
> Jun 26 12:12:29 p4ht-s kernel: [ 9156.610511] pata_pdc2027x 0000:02:05.0: PLL input clock 16817 kHz
> 
> After the patch, the PLL input clock detected looks more accurate.
> For your review, thanks.
> 
> diff -Nrup 00_libata-dev/drivers/ata/pata_pdc2027x.c 01_gettimeofday/drivers/ata/pata_pdc2027x.c
> --- 00_libata-dev/drivers/ata/pata_pdc2027x.c	2007-06-01 12:08:21.000000000 +0800
> +++ 01_gettimeofday/drivers/ata/pata_pdc2027x.c	2007-06-26 13:08:34.000000000 +0800
> @@ -689,10 +689,12 @@ static long pdc_detect_pll_input_clock(s
>  	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
>  	u32 scr;
>  	long start_count, end_count;
> -	long pll_clock;
> +	struct timeval start_time, end_time;
> +	long pll_clock, usec_elapsed;
>  
>  	/* Read current counter value */
>  	start_count = pdc_read_counter(host);
> +	do_gettimeofday(&start_time);
>  
>  	/* Start the test mode */
>  	scr = readl(mmio_base + PDC_SYS_CTL);
> @@ -705,6 +707,7 @@ static long pdc_detect_pll_input_clock(s
>  
>  	/* Read the counter values again */
>  	end_count = pdc_read_counter(host);
> +	do_gettimeofday(&end_time);
>  
>  	/* Stop the test mode */
>  	scr = readl(mmio_base + PDC_SYS_CTL);
> @@ -713,7 +716,11 @@ static long pdc_detect_pll_input_clock(s
>  	readl(mmio_base + PDC_SYS_CTL); /* flush */
>  
>  	/* calculate the input clock in Hz */
> -	pll_clock = (start_count - end_count) * 10;
> +	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
> +		(end_time.tv_usec - start_time.tv_usec);
> +
> +	pll_clock = (start_count - end_count) / 100 *
> +		(100000000 / usec_elapsed);
>  
>  	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
>  	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);

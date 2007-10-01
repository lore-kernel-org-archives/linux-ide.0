From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: Clean up DPLL stuff
Date: Mon, 01 Oct 2007 17:12:03 +0400
Message-ID: <4700F223.5040408@ru.mvista.com>
References: <20070926230424.23a302c8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:9861 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754818AbXJANMW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 09:12:22 -0400
In-Reply-To: <20070926230424.23a302c8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

> Nobody commented when I asked for review earlier so it must be ok  8)

    It's not that I've seen this before

 > so it must be ok  8)

    Not by me at least, so let me NAK it. 8-)

> Lets stick it in -mm to be sure

    Now let's unstick it. :-)

> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c linux-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c
> --- linux.vanilla-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c	2007-09-26 16:46:48.000000000 +0100
> +++ linux-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c	2007-09-18 16:44:32.000000000 +0100

    Wait, I thought you're patching pata_hpt3x2n!

> @@ -844,6 +844,46 @@
>  	/* Never went stable */
>  	return 0;
>  }
> +
> +static void *hpt_tune_function(struct pci_dev *dev, int dpll, int clock_slot)
> +{
> +	static const int MHz[4] = { 33, 40, 50, 66 };
> +	/*
> +	 *	For non UDMA133 capable devices we should
> +	 *	use a 50MHz DPLL by choice
> +	 */
> +	unsigned int f_low, f_high;
> +	int adjust;
> +
> +	f_low = (MHz[clock_slot] * 48) / MHz[dpll];
> +	f_high = f_low + 2;
> +	if (clock_slot > 1)
> +		f_high += 2;
> +	/* Select the DPLL clock. */
> +	pci_write_config_byte(dev, 0x5b, 0x21);
> +	pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);

    Could move the f_low/high writes to hpt37x_calibrate_dpll()...

> +	for(adjust = 0; adjust < 8; adjust++) {
> +		if (hpt37x_calibrate_dpll(dev))
> +			break;
> +		/* See if it'll settle at a fractionally different clock */
> +		if (adjust & 1)
> +			f_low -= adjust >> 1;
> +		else
> +			f_high += adjust >> 1;
> +		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
> +	}
> +	if (adjust == 8) {
> +		printk(KERN_WARNING "hpt37x: DPLL did not stabilize.\n");

    Deserves KERN_ERR. Wait, I remember to have changed it to KERN_ERR.

> +		return NULL;
> +	}
> +	printk(KERN_INFO "hpt37x: Bus clock %dMHz, using DPLL.\n", MHz[dpll]);

    That won't do -- it reintroduces the DPLL clock ISO bus clock reporting 
bug (that I've fixed just recently)!

> @@ -944,7 +984,7 @@
>  	u8 mcr1;
>  	u32 freq;
>  	int prefer_dpll = 1;
> -
> +	int hpt374alt = 0;
>  	unsigned long iobase = pci_resource_start(dev, 4);
>  
>  	const struct hpt_chip *chip_table;
> @@ -1046,16 +1086,28 @@
>  	if (chip_table == &hpt372a)
>  		outb(0x0e, iobase + 0x9c);
>  
> +	/*
> +	 * PLL must be done once
> +	 */
> +	 
> +	if (chip_table == &hpt374 && PCI_FUNC(dev->devfn) & 1) {
> +		/* The HPT374 secondary devfn is tuned to 50MHz when we find
> +		   the primary */

    Nah, the reason for that is completely different -- BIOS saves no clock 
data for function 1 but calibrates it for 50 MHz anyway, thus making the 
driver read already distorted f_CNT...
Not actually dangerous as the value yields 33 MHz PCI clock after clamping but 
WTF...

> +		port_info = *port;
> +		port_info.private_data = hpt37x_timings_50;
> +	}

    No, this does not seem correct -- the function 1 should be tuned (for the 
x86 case where there was no BIOS available to tune it beforehand). I don't see 
where the manual tells that the DPLL circuitry is shared. Contrarywise, I'm 
seeing it say on p. 3-22:

2. Each function has its own DPLL module, so you need set DPLL clock on every
    function

>  	/* Some devices do not let this value be accessed via PCI space
>  	   according to the old driver */
> -
>  	freq = inl(iobase + 0x90);
>  	if ((freq >> 12) != 0xABCDE) {
>  		int i;
>  		u8 sr;
>  		u32 total = 0;
> -
> +		
>  		printk(KERN_WARNING "pata_hpt37x: BIOS has not set timing clocks.\n");
> +		if (hpt374alt == 1)
> +			printk(KERN_ERR "pata_hpt37x: No saved frequency on primary function.\n");

    What's so erratic about this? And where hpt374alt is set to 1?

> +		private_data = hpt_tune_function(dev, dpll, clock_slot);
> +		/* For the HPT374 tune both channels together from fn 0 */
> +		if (chip_table == &hpt374 && !(PCI_FUNC(dev->devfn) & 1)) {
> +			struct pci_dev *pair = pci_get_slot(dev->bus, dev->devfn + 1);
> +			if (pair != NULL) {
> +				hpt_tune_function(pair, dpll, clock_slot);
> +				pci_dev_put(pair);
> +			}

    Ah, I see it now: you've decided to tune 2 functions of HPT374 at once...

>  		}
> -		if (dpll == 3)
> -			private_data = (void *)hpt37x_timings_66;
> -		else
> -			private_data = (void *)hpt37x_timings_50;
> -
> -		printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using %dMHz DPLL.\n",
> -		       MHz[clock_slot], MHz[dpll]);

    There was no need to undo that.

>  	} else {
>  		private_data = (void *)chip_table->clocks[clock_slot];
>  		/*

MBR, Sergei

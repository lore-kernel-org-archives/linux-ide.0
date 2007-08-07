From: Kristoffer Nyborg Gregertsen <gregerts@stud.ntnu.no>
Subject: Re: [PATCH 1/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 19:39:34 +0200
Message-ID: <200708071939.34266.gregerts@stud.ntnu.no>
References: <200708071126.08735.kngregertsen@norway.atmel.com> <200708071127.09751.kngregertsen@norway.atmel.com> <20070807165409.4c2a4451@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from merke.itea.ntnu.no ([129.241.7.61]:57810 "EHLO
	merke.itea.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275AbXHGSFz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 14:05:55 -0400
In-Reply-To: <20070807165409.4c2a4451@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>, linux-ide@vger.kernel.org, gregerts@stud.ntnu.no

On Tuesday 07 August 2007 17:54:09 Alan Cox wrote:
>  +static int pata_at32_get_pio_mask(void)
>
> > +{
> > +	switch (max_pio) {
> > +	case 0:
> > +		return 0x01;
> > +	case 1:
> > +		return 0x03;
> > +	case 2:
> > +		return 0x07;
> > +	case 3:
> > +		return 0x0f;
> > +	case 4:
> > +		return 0x1f;
> > +	default:
> > +		return 0x01;
>
> What is wrong with just using  (1 << max_pio) - 1 as the range is only
> 0-4 anyway.

Since max_pio is a module argument it may be invalid. Perhaps:

if (0 <= max_pio && max_pio <= 4)
	return (1 << max_pio) - 1;
else
	return 0x01;

Or is it common to trust the module arguments to be sane?

> > +static void pata_at32_data_xfer(struct ata_device *adev, unsigned char
> > *buf, +				unsigned int buflen, int write_data)
> > +{
> > +	struct at32_ide_info *info = adev->ap->host->private_data;
> > +
> > +	/* Set SMC to data transfer speed */
> > +	if (info->smc_pio_mode < 3)
> > +		smc_restore_registers(info->cs, &info->smc_16.reg);
> > +
> > +	/* Transfer data */
> > +	ata_data_xfer(adev, buf, buflen, write_data);
> > +
> > +	/* Set SMC back to register transfer speed */
> > +	if (info->smc_pio_mode < 3)
> > +		smc_restore_registers(info->cs, &info->smc_8.reg);
>
> Should be safe currently for IRQ driven behaviour, might be for polled but
> remember that without locking you could end up reading the status before
> you switch the clock back  so I'm not 100% sure.

I now see that things can get messed up. I can alter the hardware so that a 
seperate SMC memory space for data and register transfer can be used, each 
with their respective timing set at all times. This will cost one extra chip 
select pin and an AND port on the adaptor, but it might be worth it?

-- 
With kind regards

Kristoffer Nyborg Gregertsen

Student, Department of Engineering Cybernetics
Norwegian University of Science and Technology
Trondheim, Norway

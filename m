From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 16 Jan 2009 17:58:37 +0100
Message-ID: <200901161758.38037.bzolnier@gmail.com>
References: <200901141345.42583.stf_xl@wp.pl> <20090114131727.5b0e5193@lxorguk.ukuu.org.uk> <49708C55.1020204@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:42032 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbZAPQ73 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 11:59:29 -0500
Received: by bwz14 with SMTP id 14so5324011bwz.13
        for <linux-ide@vger.kernel.org>; Fri, 16 Jan 2009 08:59:27 -0800 (PST)
In-Reply-To: <49708C55.1020204@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, ddaney@caviumnetworks.com

Hi,

On Friday 16 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Alan Cox wrote:
> 
> >> +#ifdef AT91_GPIO_IRQ_HACK
> >> +#define NR_TRIES 10
> >> +	int ntries = 0;
> >> +	int pin_val1, pin_val2;	
> >> +	do {
> >> +		pin_val1 = at91_get_gpio_value(AT91_PIN_PB20);
> >> +		pin_val2 = at91_get_gpio_value(AT91_PIN_PB20);
> >> +	} while (pin_val1 != pin_val2 && ntries++ < NR_TRIES);
> >>     
> >
> > You really don't want to put special board specific code in generic
> > locations. In the libata case you don't need to and I think in the ide
> > case you can avoid it too by wrapping the IRQ handler.
> 
>    Unfortunately, it seems you can't wrap ide_intr(), at least with the 
> current code.

Well... there shouldn't be much problem with:

* adding ->irq_handler method to struct ide_port_info and struct ide_host

  [ which reminds me that struct ide_port_info would be better named struct
    ide_host_info and IIRC somebody has already noticed it in the past ;-) ]

* exporting ide_intr()

* adding ide_interrupt() wrapper around ide_intr() which will do sth like:

	if (host->irq_handler)
		return host->irq_handler()
	else
		return ide_intr()

  and then passing &ide_interrupt instead of &ide_intr to request_irq()

* implementing at91_irq_handler()

* Et Voila!

In the longer term it would also be useful for other purposes
(like adding ATA-like flash devices support to IDE).

> > Libata also supports polled mode.
> >   
> 
>    Yeah. Stanslaw, I'd (have to) advise going the libata way in this 
> case -- in case you want to avoid the additional trouble of porting this 
> broken-minded IRQ implementation to the IDE core... although the real 
> issue seems to olny be with the development board.

Enhancing pata_at32 seems to be also a good idea but at91_ide
looks almost ready for merge, is clean and relatively simple.

I think that the only things needing fixing before merge are:

- IRQ hack

- not using IDE_TIMINGS

and both should be easy to address IMHO.

> > Other comments:
> > 	- The old and new ATA layers both have timing tables and timing
> > functions so you don't need all the duplicated timing table logic.
> >   
> 
>    Stanislaw's patch is adding the DIOx- to address hold time (t9) to 
> the existing ones. While there's has been already a patch by David Daney 
> adding this timing to libata (however, the author have ditched this idea 
> finally), the table in ide-timings.c still misses it, as well as the PIO 
> mode 6 timings...

Indeed... should be easy and quick to fix though.

>    Hm, besides the address setup and active/recovery times there seem 
> wrong for the PIO mode 5: they should be 15 and 65/25, not 20 and 50/30. 
> Bart, are you reading this? :-)

Yeah.  Where's the patch? :-)

Thanks,
Bart

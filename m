From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Sun, 1 Feb 2009 18:13:17 +0100
Message-ID: <200902011813.18192.bzolnier@gmail.com>
References: <200901141345.42583.stf_xl@wp.pl> <200901161843.19487.bzolnier@gmail.com> <200901301005.44858.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f12.google.com ([209.85.218.12]:42252 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZBARYX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:24:23 -0500
Received: by bwz5 with SMTP id 5so869285bwz.13
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 09:24:20 -0800 (PST)
In-Reply-To: <200901301005.44858.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

On Friday 30 January 2009, Stanislaw Gruszka wrote:
> Czesc
> 
> On Friday 16 January 2009 18:43, Bartlomiej Zolnierkiewicz wrote:
> > > +static const struct ide_port_info at91_ide_port_info __initdata = {
> > > +	.port_ops = &at91_ide_port_ops,
> > > +	.tp_ops = &at91_ide_tp_ops,
> > > +	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE,
> > > +	.pio_mask = ATA_PIO6,
> > > +};
> >
> > AFAICS IDE_HFLAG_NO_IO_32BIT should also be set here,
> > you may also want to set IDE_HFLAG_UNMASK_IRQS while at it
> I have some doubts about things pointed out by Alan  - atomic access.  
> Due to flipping 8/16 bit in this driver, all functions accessing task file 
> and data register should do things atomically. If for example
> tp_ops->input_data() will be braked by interrupt and any other function
> accessing task file will be called very bad things can happen.

All taskfile / data access is atomic, the only exception is [Alt]Status
register read if shared IRQs are used (which doesn't seem to be the case
with AT91) or if the hardware is flaky and unexpected IRQs can happen...

If 8/16-bit flipping is really an issue then AT91 IRQ handler may need
to save info about current mode on entry, switch to 8-bit (if in 16-bit
mode), restore the saved mode on exit (if it was 16-bit mode).

> If I use IDE_HFLAG_UNMASK_IRQS IDE layer will assure atomic
> access to ATA registers ?

IDE_HFLAG_UNMASK_IRQS allows other IRQs to be serviced while IDE IRQ
is being serviced so really no problem here (unless some other drivers
also mess with 8/16-bit flipping but if so then the current code needs
fixing too).

Thanks,
Bart

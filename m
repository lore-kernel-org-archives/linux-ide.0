From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 30 Jan 2009 10:05:44 +0100
Message-ID: <200901301005.44858.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901161843.19487.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:56894 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbZA3I61 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 03:58:27 -0500
In-Reply-To: <200901161843.19487.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Czesc

On Friday 16 January 2009 18:43, Bartlomiej Zolnierkiewicz wrote:
> > +static const struct ide_port_info at91_ide_port_info __initdata = {
> > +	.port_ops = &at91_ide_port_ops,
> > +	.tp_ops = &at91_ide_tp_ops,
> > +	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE,
> > +	.pio_mask = ATA_PIO6,
> > +};
>
> AFAICS IDE_HFLAG_NO_IO_32BIT should also be set here,
> you may also want to set IDE_HFLAG_UNMASK_IRQS while at it
I have some doubts about things pointed out by Alan  - atomic access.  
Due to flipping 8/16 bit in this driver, all functions accessing task file 
and data register should do things atomically. If for example
tp_ops->input_data() will be braked by interrupt and any other function
accessing task file will be called very bad things can happen.
If I use IDE_HFLAG_UNMASK_IRQS IDE layer will assure atomic
access to ATA registers ?

Stanislaw Gruszka

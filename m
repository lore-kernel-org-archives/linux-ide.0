From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Wed, 22 Feb 2006 22:58:38 -0500
Message-ID: <43FD32EE.5080302@pobox.com>
References: <loom.20060222T182150-518@post.gmane.org> <43FD18F5.20002@gmail.com> <43FD2D9E.9020709@pobox.com> <43FD3181.5010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:49039 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750700AbWBWD6n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 22:58:43 -0500
In-Reply-To: <43FD3181.5010702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: =?UTF-8?B?Sm9uIEvDpXJlIEhlbGxhbg==?= <hellan@acm.org>, linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Tejun Heo wrote:
> We also need to delist some drives from m15w list according to SIMG's 
> blacklist. Is there any reason why sata_sil wants irq-pio desparately 
> compared to other drivers? Actually it seems that all sata_sil 

I presume the root cause is that SiI hardware is more like sata_vsc, 
hardware that _really_ wants to deliver an interrupt upon completion, 
even if interrupts are ostensibly disabled.

There are many reports in the field of a "lockup" (really screaming 
interrupts) that is solved by irq-pio or 'irqpoll' option.


> controllers seem to be capable of performing PIO using DMA which makes 
> PIO support unncessary.

This isn't supported because its a pain in the ass.  You must set up a 
new DMA transfer for each DRQ block in the PIO transfer.

If you want to write the code the support this... great!  That's 
definitely the best way to go long-term.

	Jeff



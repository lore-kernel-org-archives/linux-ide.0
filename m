From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_ninja32: setup changes
Date: Fri, 08 Feb 2008 18:36:14 +0300
Message-ID: <47AC76EE.9010804@ru.mvista.com>
References: <20080208152510.06d9af0a@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:59708 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755737AbYBHPfX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 10:35:23 -0500
In-Reply-To: <20080208152510.06d9af0a@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:

> Forcibly set more of the configuration at init time. This seems to fix at
> least one problem reported. We don't know what most of these bits do, but
> we do know what windows stuffs there.

> Signed-off-by: Alan Cox <alan@redhat.com>

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/pata_ninja32.c linux-2.6.24-mm1/drivers/ata/pata_ninja32.c
> --- linux.vanilla-2.6.24-mm1/drivers/ata/pata_ninja32.c	2008-02-06 14:14:39.000000000 +0000
> +++ linux-2.6.24-mm1/drivers/ata/pata_ninja32.c	2008-02-06 14:31:57.000000000 +0000
> @@ -17,6 +17,7 @@
>   *	Base + 0x00 IRQ Status
>   *	Base + 0x01 IRQ control
>   *	Base + 0x02 Chipset control
> + *	Base + 0x03 Unknown
>   *	Base + 0x04 VDMA and reset control + wait bits

    Why not:

+ *	Base + 0x05 Unknown

>   *	Base + 0x08 BMIMBA
>   *	Base + 0x0C DMA Length
> @@ -174,8 +175,12 @@
>  	ata_std_ports(&ap->ioaddr);
>  
>  	iowrite8(0x05, base + 0x01);	/* Enable interrupt lines */
> -	iowrite8(0xB3, base + 0x02);	/* Burst, ?? setup */
> -	iowrite8(0x00, base + 0x04);	/* WAIT0 ? */
> +	iowrite8(0xBE, base + 0x02);	/* Burst, ?? setup */
> +	iowrite8(0x01, base + 0x03);	/* Unknown */
> +	iowrite8(0x20, base + 0x04);	/* WAIT0 */
> +	iowrite8(0x8f, base + 0x05);	/* Unknown */
> +	iowrite8(0xa4, base + 0x1c);	/* Unknown */
> +	iowrite8(0x83, base + 0x1d);	/* BMDMA control: WAIT0 */
>  	/* FIXME: Should we disable them at remove ? */
>  	return ata_host_activate(host, dev->irq, ata_interrupt,
>  				 IRQF_SHARED, &ninja32_sht);

MBR, Sergei

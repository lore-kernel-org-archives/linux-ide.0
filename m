From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: clear bmdma status in ide_intr() (revised)
Date: Thu, 25 Jan 2007 18:17:22 +0300
Message-ID: <45B8CA02.4050701@ru.mvista.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com> <45B6D5A7.6080700@tw.ibm.com> <45B7596F.6080504@ru.mvista.com> <45B878F0.7060707@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1533 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965404AbXAYPR0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 10:17:26 -0500
In-Reply-To: <45B878F0.7060707@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

Albert Lee wrote:
> patch 2/2 (revised):
> - Do the dma status clearing in ide_intr() and add a new hwif->ide_dma_clear_irq such that LLDD can override it.
> - Fix drive->waiting_for_dma to work with CDB-intr devices.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> hwif->dma is not reliable: ide_intr() races with dma_start(). Sometimes we got hwif->dma == 0
> in ide_intr() even though it is actually a DMA interrupt. So, drive->waiting_for_dma is used instead.
> 
> Also revised per Sergei's comments and let ide_dma_clear_irq return "void".
> The "if (hwif->dma_status)" check in __ide_dma_clear_irq() is kept as is since I think
> it would be safer for the old ISA/VESA IDE devices that has no BMDMA registers.

    ISA/VESA drivers shouldn't have this method defined at all since they're 
PIO only. But well, it won't hurt...

> For your review, thanks.

> diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-cd.c 02_add_to_ide_intr/drivers/ide/ide-cd.c
> --- 01_remove_from_ide_cd/drivers/ide/ide-cd.c	2007-01-24 11:00:03.000000000 +0800
> +++ 02_add_to_ide_intr/drivers/ide/ide-cd.c	2007-01-25 16:52:20.000000000 +0800
> @@ -923,6 +923,10 @@ static ide_startstop_t cdrom_start_packe
>  		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
>   
>  	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
> +		/* waiting for CDB interrupt, not DMA yet. */
> +		if (info->dma)
> +			drive->waiting_for_dma = 0;
> +
>  		/* packet command */
>  		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
>  		return ide_started;
> @@ -965,6 +969,10 @@ static ide_startstop_t cdrom_transfer_pa
>  		/* Check for errors. */
>  		if (cdrom_decode_status(drive, DRQ_STAT, NULL))
>  			return ide_stopped;
> +
> +		/* Ok, next interrupt will be dma interrupt. */
> +		if (info->dma)
> +			drive->waiting_for_dma = 1;
>  	} else {
>  		/* Otherwise, we must wait for DRQ to get set. */
>  		if (ide_wait_stat(&startstop, drive, DRQ_STAT,

    Erm... shouldn't we set drive->waiting_for_dma in hwif->dma_start() then?
Why it's set in hwif->dma_setup() at all I wonder?

MBR, Sergei

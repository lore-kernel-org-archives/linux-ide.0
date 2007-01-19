From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix ATAPI DMA lost irq problem with CDB intr devices
Date: Fri, 19 Jan 2007 20:59:20 +0100
Message-ID: <45B12318.9000704@gmail.com>
References: <45AF57BE.7060505@tw.ibm.com> <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:42380 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932854AbXASTzW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jan 2007 14:55:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so538949uga
        for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 11:55:21 -0800 (PST)
In-Reply-To: <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertl@mail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>


Hi,

Albert Lee wrote:
> Problem: IDE ATAPI DMA lost irq with CDB intr devices on Intel ICHx
> machines.
> 
> This patch clears the INTR and ERROR bits of DMA status before starting
> BMDMA to fix the problem.

[PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
http://lkml.org/lkml/2006/12/4/201

The above patch was already merged so it seems that the list
of PCI IDs requiring ->atapi_irq_bogon needs to be expanded...

Adam, which ICH version is it?

> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> ATAPI DMA irq lost when testing Intel ICHx with CDB-intr CD-ROM drives:
> 
> Jan 18 18:08:48 p4ht-s kernel: ide-cd: cmd 0x28 timed out
> Jan 18 18:08:48 p4ht-s kernel: hdc: DMA interrupt recovery
> Jan 18 18:08:48 p4ht-s kernel: hdc: lost interrupt
> Jan 18 18:08:48 p4ht-s kernel: hdc: status timeout: status=0xd0 { Busy }
> Jan 18 18:08:48 p4ht-s kernel: ide: failed opcode was: unknown
> Jan 18 18:08:48 p4ht-s kernel: hdc: DMA disabled
> Jan 18 18:08:48 p4ht-s kernel: hdc: drive not ready for command
> Jan 18 18:08:48 p4ht-s kernel: hdc: ATAPI reset complete
> 
> The problem is reported by Adam Hawks.
> It seems the the INTR bit was set to 1 by the CDB-intr before the DMA is started.
> ICHx doesn't like it and causes the DMA irq lost later.
> 
> The patch is against 2.6.20-rc5. Tested ok on ICH4.

Does the problem also happen on ICH4?

> ====================================================================
> 
> --- ide-dma.ori/drivers/ide/ide-dma.c   2006-11-30 05:57:37.000000000 +0800
> +++ ide-dma/drivers/ide/ide-dma.c       2007-01-18 18:40:18.000000000 +0800
> @@ -591,6 +591,12 @@ void ide_dma_start(ide_drive_t *drive)
> {
>        ide_hwif_t *hwif        = HWIF(drive);
>        u8 dma_cmd              = hwif->INB(hwif->dma_command);
> +       u8 dma_stat             = hwif->INB(hwif->dma_status);
> +
> +       /* The intr bit of dma_status might has been set by the CDB interrupt.
> +        * Clear the INTR & ERROR bits here to prevent DMA irq lost later.
> +        */
> +       hwif->OUTB(dma_stat|6, hwif->dma_status);
> 
>        /* Note that this is done *after* the cmd has
>         * been issued to the drive, as per the BM-IDE spec.

Thanks,
Bart


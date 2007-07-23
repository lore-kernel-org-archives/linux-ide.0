From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide patches
Date: Mon, 23 Jul 2007 17:50:09 +0400
Message-ID: <46A4B211.7080800@ru.mvista.com>
References: <200707222019.03684.bzolnier@gmail.com>	 <1185148506.5439.80.camel@localhost.localdomain>	 <1185153674.5439.83.camel@localhost.localdomain>	 <1185155835.5439.91.camel@localhost.localdomain> <1185156084.5439.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:2170 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752570AbXGWNsK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 09:48:10 -0400
In-Reply-To: <1185156084.5439.93.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

> In the meantime, that patch applied on top of your latest series fixes
> the PIO setting in the driver to send the correct mode value in
> pmac_ide_set_pio_mode(). I still object to your patch serie at this
> point because hdparm -p N should not, imho, cause DMA to be disabled.

> I really believe that the kernel should keep track separately of PIO and
> DMA speeds.

    We do too. :-)

> Index: linux-work/drivers/ide/ppc/pmac.c
> ===================================================================
> --- linux-work.orig/drivers/ide/ppc/pmac.c	2007-07-23 10:21:07.000000000 +1000
> +++ linux-work/drivers/ide/ppc/pmac.c	2007-07-23 11:58:50.000000000 +1000
> @@ -535,7 +535,7 @@ pmac_outbsync(ide_drive_t *drive, u8 val
[...]
> @@ -1150,6 +1152,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
>  	hwif->drives[0].unmask = 1;
>  	hwif->drives[1].unmask = 1;
> +	hwif->drives[0].autotune = IDE_TUNE_AUTO;
> +	hwif->drives[1].autotune = IDE_TUNE_AUTO;

    Hm, indeed, most of the other drivers are just using 1.

>  	hwif->pio_mask = ATA_PIO4;
>  	hwif->set_pio_mode = pmac_ide_set_pio_mode;
>  	if (pmif->kind == controller_un_ata6
> @@ -1766,10 +1770,16 @@ pmac_ide_dma_test_irq (ide_drive_t *driv
>  
>  static void pmac_ide_dma_host_off(ide_drive_t *drive)
>  {
> +#ifdef IDE_PMAC_DEBUG
> +	printk(KERN_ERR "%s: dma_host_off()\n", drive->name);
> +#endif
>  }
>  
>  static void pmac_ide_dma_host_on(ide_drive_t *drive)
>  {
> +#ifdef IDE_PMAC_DEBUG
> +	printk(KERN_ERR "%s: dma_host_on()\n", drive->name);
> +#endif
>  }

    Gah! Why the debug messages might be using KERN_ERR?

MBR, Sergei

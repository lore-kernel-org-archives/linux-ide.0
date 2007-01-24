From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: clear bmdma status in ide_intr()
Date: Wed, 24 Jan 2007 16:04:47 +0300
Message-ID: <45B7596F.6080504@ru.mvista.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com> <45B6D5A7.6080700@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54711 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751410AbXAXNEz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 08:04:55 -0500
In-Reply-To: <45B6D5A7.6080700@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

Hello.

Albert Lee wrote:
> patch 2/2:
>   Do the dma status clearing in ide_intr() and add a new hwif->ide_dma_clear_irq such that LLDD could override it.

> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Tested ok on ICH4 and pdc20275. Not sure if this would have bad effect for other adapters.

> Patch against 2.6.20-rc5, for your review, thanks.

> diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-dma.c 02_add_to_ide_intr/drivers/ide/ide-dma.c
> --- 01_remove_from_ide_cd/drivers/ide/ide-dma.c	2006-11-30 05:57:37.000000000 +0800
> +++ 02_add_to_ide_intr/drivers/ide/ide-dma.c	2007-01-24 11:07:58.000000000 +0800
> @@ -650,6 +650,22 @@ static int __ide_dma_test_irq(ide_drive_
>  			drive->name, __FUNCTION__);
>  	return 0;
>  }
> +
> +/* returns 1 on error, 0 otherwise */

    Why? Do you check the result?

> +int __ide_dma_clear_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	u8 dma_stat;
> +
> +	/* clear the INTR & ERROR bits */
> +	if (hwif->dma_status) {

    hwif->dma_status should always be set, else ide-dma.c just won't work. The 
check seems superfluous.

> +		dma_stat = hwif->INB(hwif->dma_status);
> +		/* Should we force the bit as well ? */

    Good idea.

> +		hwif->OUTB(dma_stat, hwif->dma_status);

    I'm afraid this would break __ide_dma_end() function which tests the error 
conditions and returns failure if (dma_stat & 7) != 4...

> +	}
> +
> +	return 0;
> +}
>  #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
>  
>  int __ide_dma_bad_drive (ide_drive_t *drive)
> diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-io.c 02_add_to_ide_intr/drivers/ide/ide-io.c
> --- 01_remove_from_ide_cd/drivers/ide/ide-io.c	2006-11-30 05:57:37.000000000 +0800
> +++ 02_add_to_ide_intr/drivers/ide/ide-io.c	2007-01-24 11:21:41.000000000 +0800
> @@ -1644,6 +1644,18 @@ irqreturn_t ide_intr (int irq, void *dev
>  	}
>  	hwgroup->handler = NULL;
>  	del_timer(&hwgroup->timer);
> +
> +	/* Some controllers might set DMA INTR no matter DMA or PIO;
> +	 * bmdma status might need to be cleared even for
> +	 * PIO interrupts to prevent spurious irq or irq lost.
> +	 */

    Either "being lost" or "loss". Sorry for grammar nitpicking. :-)

> +	if (hwif->ide_dma_clear_irq && !(hwif->dma))
> +		/* ide_dma_end() needs bmdma status for error checking.
> +		 * So, skip clearing bmdma status here and leave it
> +		 * to ide_dma_end() if this is dma interrupt.
> +		 */
> +		hwif->ide_dma_clear_irq(drive);
> +
>  	spin_unlock(&ide_lock);

    Ah, you're only calling this when hwif->dma == 0... Well, that's probably 
fine. Although, once introduced, this method asks for more use...

>  	if (drive->unmask)

MBR, Sergei

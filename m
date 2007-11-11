From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cmd64x: don't clear the other channels interrupt
Date: Sun, 11 Nov 2007 22:52:58 +0100
Message-ID: <200711112252.58538.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200711091407.01369.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:14071 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbXKKVqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 16:46:02 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1274671fkz
        for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 13:46:00 -0800 (PST)
In-Reply-To: <200711091407.01369.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, marogge@onlinehome.de, milon@wq.cz

On Friday 09 November 2007, Sergei Shtylyov wrote:
> Make sure to not clear the other IDE channel's interrupt when clearing an IDE
> interrupt via the MRDMODE register.
> 
> Thanks to Bart for finding a coding mistake.

Could you resend with "Signed-off-by:" and "Tested-by:" tags?

[ A reference to the problematic commit and crediting Martin for
  patiently bisecting the issue would score an extra points. :) ]

> ---
> The patch is against the Linus tree.
> 
>  drivers/ide/pci/cmd64x.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/ide/pci/cmd64x.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/pci/cmd64x.c
> +++ linux-2.6/drivers/ide/pci/cmd64x.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/cmd64x.c		Version 1.50	May 10, 2007
> + * linux/drivers/ide/pci/cmd64x.c		Version 1.51	Nov 8, 2007
>   *
>   * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
>   *           Due to massive hardware bugs, UltraDMA is only supported
> @@ -339,7 +339,8 @@ static int cmd648_ide_dma_end (ide_drive
>  	u8  mrdmode		= inb(hwif->dma_master + 0x01);
>  
>  	/* clear the interrupt bit */
> -	outb(mrdmode | irq_mask, hwif->dma_master + 0x01);
> +	outb((mrdmode & ~(MRDMODE_INTR_CH0 | MRDMODE_INTR_CH1)) | irq_mask,
> +	     hwif->dma_master + 0x01);
>  
>  	return err;
>  }
> 
> 



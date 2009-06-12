From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/9] ide: move IRQ clearing from ack_intr() method to clear_irq() method
Date: Fri, 12 Jun 2009 18:18:52 +0200
Message-ID: <200906121818.52719.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102250.02835.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:55137 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759630AbZFLQRQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 12:17:16 -0400
Received: by mail-fx0-f216.google.com with SMTP id 12so735524fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 09:17:18 -0700 (PDT)
In-Reply-To: <200906102250.02835.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 10 June 2009 20:50:02 Sergei Shtylyov wrote:
> There are now two methods that clear the port interrupt: ack_intr() method,
> implemented only on M680x0 machines, that is called at the start of ide_intr(),
> and clear_irq() method, that is called somewhat later in this function.  In
> order to stop this duplication, delegate the task of clearing the interrupt
> to clear_irq() method, only leaving to ack_intr() the task of testing for the
> port interrupt.  This involves moving clear_irq() method call in ide_intr()
> closer to the beginning of the function and removing ack_intr() method call
> in ide_timer_expiry(), now becoming useless...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is atop of ide-2.6.git 'for-next' branch.
> 
>  drivers/ide/gayle.c  |   23 +++++++++++------------
>  drivers/ide/ide-io.c |   11 ++++-------
>  drivers/ide/macide.c |   18 ++++++++++++++----
>  3 files changed, 29 insertions(+), 23 deletions(-)
> 
> Index: ide-2.6/drivers/ide/gayle.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/gayle.c
> +++ ide-2.6/drivers/ide/gayle.c
> @@ -66,7 +66,7 @@ MODULE_PARM_DESC(doubler, "enable suppor
>       *  Check and acknowledge the interrupt status
>       */
>  
> -static int gayle_ack_intr_a4000(ide_hwif_t *hwif)
> +static int gayle_ack_intr(ide_hwif_t *hwif)
>  {
>      unsigned char ch;
>  
> @@ -76,16 +76,12 @@ static int gayle_ack_intr_a4000(ide_hwif
>      return 1;
>  }
>  
> -static int gayle_ack_intr_a1200(ide_hwif_t *hwif)
> +static void gayle_a1200_clear_irq(ide_drive_t *drive)
>  {
> -    unsigned char ch;
> +    ide_hwif_t *hwif = drive->hwif;
>  
> -    ch = z_readb(hwif->io_ports.irq_addr);
> -    if (!(ch & GAYLE_IRQ_IDE))
> -	return 0;
>      (void)z_readb(hwif->io_ports.status_addr);
>      z_writeb(0x7c, hwif->io_ports.irq_addr);
> -    return 1;
>  }

buddha.c needs a similar treatment

> --- ide-2.6.orig/drivers/ide/ide-io.c
> +++ ide-2.6/drivers/ide/ide-io.c

> @@ -791,6 +789,10 @@ irqreturn_t ide_intr (int irq, void *dev
>  		goto out;
>  
>  	handler = hwif->handler;
> +	drive	= hwif->cur_dev;
> +
> +	if (hwif->port_ops && hwif->port_ops->clear_irq)
> +		hwif->port_ops->clear_irq(drive);

We need to check for valid ->handler before using ->cur_dev
(it may contain a stale value otherwise).
 
Moreover I somehow miss the point of moving ->clear_irq call here
(it should be done after we know that it is really our IRQ).

>  	if (handler == NULL || hwif->polling) {
>  		/*
> @@ -821,8 +823,6 @@ irqreturn_t ide_intr (int irq, void *dev
>  		goto out;
>  	}
>  
> -	drive = hwif->cur_dev;
> -
>  	if (!drive_is_ready(drive))
>  		/*
>  		 * This happens regularly when we share a PCI IRQ with
> @@ -839,9 +839,6 @@ irqreturn_t ide_intr (int irq, void *dev
>  	del_timer(&hwif->timer);
>  	spin_unlock(&hwif->lock);
>  
> -	if (hwif->port_ops && hwif->port_ops->clear_irq)
> -		hwif->port_ops->clear_irq(drive);
> -
>  	if (drive->dev_flags & IDE_DFLAG_UNMASK)
>  		local_irq_enable_in_hardirq();
>  
> Index: ide-2.6/drivers/ide/macide.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/macide.c
> +++ ide-2.6/drivers/ide/macide.c
> @@ -55,13 +55,16 @@ volatile unsigned char *ide_ifr = (unsig
>  
>  int macide_ack_intr(ide_hwif_t* hwif)
>  {
> -	if (*ide_ifr & 0x20) {
> -		*ide_ifr &= ~0x20;
> +	if (*ide_ifr & 0x20)
>  		return 1;
> -	}
>  	return 0;
>  }
>  
> +static int macide_clear_irq(ide_drive_t *drive)
> +{
> +	*ide_ifr &= ~0x20;
> +}

s/int/void/

also please cc: m68k list on patches #3-5

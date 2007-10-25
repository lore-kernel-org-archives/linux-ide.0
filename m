From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: fix Kconfig IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE
Date: Fri, 26 Oct 2007 01:33:02 +0200
Message-ID: <200710260133.03792.bzolnier@gmail.com>
References: <573412.17797.qm@web52001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:1958 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758642AbXJYXdl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 19:33:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so631752nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 16:33:40 -0700 (PDT)
In-Reply-To: <573412.17797.qm@web52001.mail.re2.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
Cc: sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org


Hi,

On Monday 22 October 2007, Matti Linnanvuori wrote:
> From: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
> 
> Correct IDEPCI_SHARE_IRQ description to keeping interrupts enabled
> when calling the PCI IDE action handler. CONFIG_IDEPCI_SHARE_IRQ does not
> affect the setting of IRQF_SHARED for PCI chipsets in function init_irq, 
> file drivers/ide/ide-probe.c but only the setting of IRQF_DISABLED.
> Add IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE help text from hdparm
> manual page.
> 
> Signed-off-by: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
> ---
> 
> Changing mention of multi-mode to affecting only some systems. Improving text.
> 
> --- a/drivers/ide/Kconfig	2007-10-21 08:53:11.826349500 +0300
> +++ b/drivers/ide/Kconfig	2007-10-22 18:45:58.715425500 +0300
> @@ -154,7 +154,19 @@ config BLK_DEV_IDEDISK
>  config IDEDISK_MULTI_MODE
>  	bool "Use multi-mode by default"

Would be nice to update this to something more meaningful while at it,
i.e. "Use multiple-sector PIO mode by default"

>  	help
> -	  If you get this error, try to say Y here:
> +	  Multiple sector mode is a feature of most modern

This still doesn't emphasize the fact the this settings affects _only_
PIO transfers.  If DMA is used this setting should have no effect.

> +	  IDE drives, permitting the transfer of multiple sectors per I/O
> +	  interrupt, rather than the usual one sector per interrupt.
> +	  When this feature is enabled, it can reduce operating
> +	  system overhead for disk I/O by 30 - 50%. On some systems, it
> +	  also provides increased data throughput of anywhere from 5%
> +	  to 50%. Some drives, however (most notably the WD Caviar

The hdparm text help is years old, I'm don't think that the comment
about WD Caviar disks holds for the later models.

> +	  series), seem to run slower with multiple mode enabled. Some
> +	  drives claim to support multiple mode, but lose data at some

drives -> very old drives

> +	  settings. Under rare circumstances, such failures can result
> +	  in massive filesystem corruption.
> +
> +	  If you get the following error, try to say Y here:
>  
>  	  hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
>  	  hda: set_multmode: error=0x04 { DriveStatusError }
> @@ -367,11 +379,16 @@ config BLK_DEV_IDEPCI
>  	bool
>  
>  config IDEPCI_SHARE_IRQ
> -	bool "Sharing PCI IDE interrupts support"
> +	bool "Keeping interrupts enabled when calling the PCI IDE action handler"
>  	depends on BLK_DEV_IDEPCI
>  	help
> -	  Some ATA/IDE chipsets have hardware support which allows for
> -	  sharing a single IRQ with other cards. To enable support for
> +	  A setting of Y permits the driver to enable other interrupts
> +	  during processing of a disk interrupt, which greatly improves
> + 	  Linux's responsiveness and eliminates "serial port overrun"
> +	  and buffer errors. Use this feature with caution: some
> +	  drive/controller combinations do not tolerate the increased I/O
> +	  latencies possible when this feature is enabled, resulting in massive
> +	  filesystem corruption. To enable support for
>  	  this in the ATA/IDE driver, say Y here.
>  
>  	  It is safe to say Y to this question, in most cases.

CONFIG_IDEPCI_SHARE_IRQ has no real effect on IRQ unmasking because the first
thing that ide_intr() (IDE IRQ handler) does is calling spin_lock_irqsave()
(which disables local IRQs).

drivers/ide/ide-probe.c:

static int init_irq (ide_hwif_t *hwif)
...
#ifndef CONFIG_IDEPCI_SHARE_IRQ
			sa |= IRQF_DISABLED;
#endif /* CONFIG_IDEPCI_SHARE_IRQ */
...

kernel/irq/handle.c:

irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
...
	if (!(action->flags & IRQF_DISABLED))
		local_irq_enable_in_hardirq();

	do {
		ret = action->handler(irq, action->dev_id);
		if (ret == IRQ_HANDLED)
			status |= action->flags;
		retval |= ret;
		action = action->next;
	} while (action);
...

drivers/ide/ide-io.c:

irqreturn_t ide_intr (int irq, void *dev_id)
...
	spin_lock_irqsave(&ide_lock, flags);
...
	spin_unlock(&ide_lock);
...
	if (drive->unmask)
		local_irq_enable_in_hardirq();
...

Thanks for raising this question though, we see now that we may remove
IRQF_DISABLE flag completely from IRQ flags for IDE IRQ handler.

It is also a good time to kill IDEPCI_SHARE_IRQ config option
(fixing a bug alongside).

[ patches posted in separate mails ]

Coming back to this patch: please recast it dropping IDEPCI_SHARE_IRQ part.

Thanks,
Bart

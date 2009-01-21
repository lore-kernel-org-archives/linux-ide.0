From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 04/04] sata_mv: msi masking
Date: Tue, 20 Jan 2009 17:54:27 -0800
Message-ID: <da824cf30901201754x6ab25783ua3b6cfc30d4158df@mail.gmail.com>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca>
	 <49750774.1070005@rtr.ca> <497507BF.3090608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:55391 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbZAUByd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jan 2009 20:54:33 -0500
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id n0L1sUBB025701
	for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 01:54:30 GMT
Received: from qyk13 (qyk13.prod.google.com [10.241.83.141])
	by wpaz37.hot.corp.google.com with ESMTP id n0L1sSoU003572
	for <linux-ide@vger.kernel.org>; Tue, 20 Jan 2009 17:54:28 -0800
Received: by qyk13 with SMTP id 13so13834574qyk.1
        for <linux-ide@vger.kernel.org>; Tue, 20 Jan 2009 17:54:28 -0800 (PST)
In-Reply-To: <497507BF.3090608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Jan 19, 2009 at 3:07 PM, Mark Lord <liml@rtr.ca> wrote:
> Enable reliable use of Message Switched Interrupts (MSI) in sata_mv
> by masking further chip interrupts within the main interrupt handler.
> Based upon a suggestion by Grant Grundler.

This is a HW bug workaround so we don't end up with completions
pending but no interrupts pending.

>
> Signed-off-by: Mark Lord <mlord@pobox.com>

Please add:
Reviewed-by: Grant Grundler <grundler@google.com>


> --- old/drivers/ata/sata_mv.c   2009-01-19 17:18:31.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c 2009-01-19 17:12:51.000000000 -0500
> @@ -33,8 +33,6 @@
>  *
>  * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).
>  *
> - * --> Investigate problems with PCI Message Signalled Interrupts (MSI).
> - *
>  * --> Develop a low-power-consumption strategy, and implement it.
>  *
>  * --> [Experiment, low priority] Investigate interrupt coalescing.
> @@ -2199,9 +2197,15 @@
>        struct ata_host *host = dev_instance;
>        struct mv_host_priv *hpriv = host->private_data;
>        unsigned int handled = 0;
> +       int using_msi = hpriv->hp_flags & MV_HP_FLAG_MSI;
>        u32 main_irq_cause, pending_irqs;
>
>        spin_lock(&host->lock);
> +
> +       /* for MSI:  block new interrupts while in here */
> +       if (using_msi)
> +               writel(0, hpriv->main_irq_mask_addr);
> +
>        main_irq_cause = readl(hpriv->main_irq_cause_addr);
>        pending_irqs   = main_irq_cause & hpriv->main_irq_mask;
>        /*
> @@ -2215,6 +2219,11 @@
>                        handled = mv_host_intr(host, pending_irqs);
>        }
>        spin_unlock(&host->lock);
> +
> +       /* for MSI: unblock interupts; anything pending will hit us now */

Better comment would be:
    /* Unmasking any Cause bit which is set will generate an interrupt. */

And since we've masked all bits above, this effectively applies to all bits
in the mask. This is true for either type of interrupt (Line vs MSI).
We only require this for MSI though.

FYI (everyone else but Mark), MSI only brings two benefits to this driver:
1) ability to spread interrupt load across lots of CPUs if we have lots
    of controllers in a machine.
2) Get an exclusive IRQ (avoids spurious calls to IRQ handlers)

thanks,
grant

ps. Kudos to Mark for excellent work to date on this driver.
I'm impressed with how well it's working now compared
to the crap we had a year or two ago.

> +       if (using_msi)
> +               writel(hpriv->main_irq_mask, hpriv->main_irq_mask_addr);
> +
>        return IRQ_RETVAL(handled);
> }

From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 04/05] sata_mv: msi masking fix (v2)
Date: Wed, 21 Jan 2009 09:03:29 -0800
Message-ID: <da824cf30901210903t1276a237ob6501377696ad070@mail.gmail.com>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca>
	 <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:41152 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbZAURDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2009 12:03:33 -0500
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id n0LH3WR4003220
	for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 09:03:32 -0800
Received: from qyk14 (qyk14.prod.google.com [10.241.83.142])
	by wpaz9.hot.corp.google.com with ESMTP id n0LH3Hl7022664
	for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 09:03:29 -0800
Received: by qyk14 with SMTP id 14so5686362qyk.4
        for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 09:03:29 -0800 (PST)
In-Reply-To: <49773FD1.3040101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On Wed, Jan 21, 2009 at 7:31 AM, Mark Lord <liml@rtr.ca> wrote:
> Enable reliable use of Message-Signaled Interrupts (MSI) in sata_mv
> by masking further chip interrupts within the main interrupt handler.
>
> Based upon a suggestion by Grant Grundler.
> MSI is working reliably in all of my test systems here now.

Excellent.

> Signed-off-by: Mark Lord <mlord@pobox.com>

Reviewed-by: Grant Grundler <grundler@google.com>

thanks,
grant

> ---
>
> This replaces the originally posted [PATCH 05/04] version.
>
> --- old/drivers/ata/sata_mv.c   2009-01-21 10:16:59.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c 2009-01-21 10:22:28.000000000 -0500
> @@ -33,8 +33,6 @@
>  *
>  * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).
>  *
> - * --> Investigate problems with PCI Message Signalled Interrupts (MSI).
> - *
>  * --> Develop a low-power-consumption strategy, and implement it.
>  *
>  * --> [Experiment, low priority] Investigate interrupt coalescing.
> @@ -70,7 +68,7 @@
> #include <linux/libata.h>
>
> #define DRV_NAME        "sata_mv"
> -#define DRV_VERSION    "1.24"
> +#define DRV_VERSION    "1.25"
>
> enum {
>        /* BAR's are enumerated in terms of pci_resource_start() terms */
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
> +       /* for MSI: unmask; interrupt cause bits will retrigger now */
> +       if (using_msi)
> +               writel(hpriv->main_irq_mask, hpriv->main_irq_mask_addr);
> +
>        return IRQ_RETVAL(handled);
> }
>
> @@ -3414,9 +3423,9 @@
>        if (rc)
>                return rc;
>
> -       /* Enable interrupts */
> -       if (msi && pci_enable_msi(pdev))
> -               pci_intx(pdev, 1);
> +       /* Enable message-switched interrupts, if requested */
> +       if (msi && 0 == pci_enable_msi(pdev))
> +               hpriv->hp_flags |= MV_HP_FLAG_MSI;
>
>        mv_dump_pci_cfg(pdev, 0x68);
>        mv_print_info(host);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

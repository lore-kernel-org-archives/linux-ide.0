From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add MSI support to sata_vsc driver
Date: Thu, 17 Aug 2006 19:44:11 -0400
Message-ID: <44E4FF4B.6020407@garzik.org>
References: <87840E8EE8A8D240A13F8AA92CAB07D9024C14B3@azsmsx402>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59843 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964929AbWHQXoP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 19:44:15 -0400
In-Reply-To: <87840E8EE8A8D240A13F8AA92CAB07D9024C14B3@azsmsx402>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org

Wolstenholme, Daniel E wrote:
> Unfortunately, I'm stuck using Lookout for now. 

That's OK, this one needs another iteration anyway :)


> --------------
> diff -Naur linux-2.6.18-rc1-original/drivers/scsi/sata_vsc.c
> linux-2.6.18-rc1/drivers/scsi/sata_vsc.c
> --- linux-2.6.18-rc1-original/drivers/scsi/sata_vsc.c   2006-08-15
> 17:13:53.000000000 -0700
> +++ linux-2.6.18-rc1/drivers/scsi/sata_vsc.c    2006-08-17
> 14:29:27.000000000 -0700
> @@ -406,13 +406,17 @@
>          */
>         pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> 
> +       if (pci_enable_msi && pci_enable_msi(pdev) == 0)

pci_enable_msi is not a variable, don't test it.  Just call it.

The function will always exist, even if conditionally implemented as a 
macro in the no-op case.


> +               probe_ent->irq_flags &= ~IRQF_SHARED;

We're doing an assignment (as you see below, from the code you 
modified), and the entire struct is memset(3) to zero, so there's no 
need to clear this flag.  Just assign it, for the non-MSI case.


> +               probe_ent->irq_flags = IRQF_SHARED;
> +
>         probe_ent->sht = &vsc_sata_sht;
>         probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                                 ATA_FLAG_MMIO;
>         probe_ent->port_ops = &vsc_sata_ops;
>         probe_ent->n_ports = 4;
>         probe_ent->irq = pdev->irq;
> -       probe_ent->irq_flags = IRQF_SHARED;
>         probe_ent->mmio_base = mmio_base;

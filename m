From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] Add MSI support to sata_vsc driver
Date: Wed, 16 Aug 2006 21:07:38 -0700
Message-ID: <20060817040738.GA854817@sgi.com>
References: <87840E8EE8A8D240A13F8AA92CAB07D9024C14A6@azsmsx402>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:49598 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932270AbWHQEHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 00:07:41 -0400
Content-Disposition: inline
In-Reply-To: <87840E8EE8A8D240A13F8AA92CAB07D9024C14A6@azsmsx402>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 15, 2006 at 05:25:14PM -0700, Wolstenholme, Daniel E wrote:
> 
>    In the course of some work I'm doing with MSI interrupts, I had an
>    Intel GD81344 card I wanted to try out with MSI interrupts, and I
>    found that it does indeed support MSI.  Here's a patch to add support.

You sent the patch as html.  That's not going to work.  Even the text/plain
part of it is quoted/printable with lots of extra blank lines, etc.  If
you're using Outlook, the only way to send a patch is to first turn off
html and then send the patch as a text/plain attachment (as far as I know).

>    I implemented this rather simple patch using #ifdef CONFIG_PCI_MSI.  I
>    noticed some other drivers, such as sata_mv and LSI's fusion drivers,
>    use a kernel command-line parameter to enable MSI support.  I honestly
>    don't know the advantage to this; it seems to me to be easier if it's
>    enabled by default, as long as MSI support is selected in the kernel
>    configuration.  If not, someone please let me know.

It might be that some platforms that have MSI enabled won't support it
on certain machines where these chips are installed.  So it's probably
best to make it an option.  I'll defer to jgarzik on this, however.

jeremy

>    This patch is against 2.6.18-rc1.  There shouldn't be any problems
>    applying it to other 2.6.18 versions.
> 
> 
>    Dan
> 
> 
>    diff -Naur linux-2.6.18-rc1-original/drivers/scsi/sata_vsc.c
>    linux-2.6.18-rc1/drivers/scsi/sata_vsc.c
> 
>    --- linux-2.6.18-rc1-original/drivers/scsi/sata_vsc.c   2006-08-15
>    17:13:53.000000000 -0700
> 
>    +++ linux-2.6.18-rc1/drivers/scsi/sata_vsc.c    2006-08-15
>    16:02:26.000000000 -0700
> 
>    @@ -406,13 +406,23 @@
> 
>             */
> 
>            pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> 
> 
>    +#ifdef CONFIG_PCI_MSI
> 
>    +       if (pci_enable_msi(pdev) == 0) {
> 
>    +               probe_ent->irq_flags &= ~IRQF_SHARED;
> 
>    +       }
> 
>    +       else {
> 
>    +               probe_ent->irq_flags = IRQF_SHARED;
> 
>    +       }
> 
>    +#else
> 
>    +       probe_ent->irq_flags = IRQF_SHARED;
> 
>    +#endif
> 
>    +
> 
>            probe_ent->sht = &vsc_sata_sht;
> 
>            probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
> 
>                                    ATA_FLAG_MMIO;
> 
>            probe_ent->port_ops = &vsc_sata_ops;
> 
>            probe_ent->n_ports = 4;
> 
>            probe_ent->irq = pdev->irq;
> 
>    -       probe_ent->irq_flags = IRQF_SHARED;
> 
>            probe_ent->mmio_base = mmio_base;
> 
> 
>            /* We don't care much about the PIO/UDMA masks, but the core
>    won't like us

From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: sata_vsc.c cache line size question
Date: Wed, 17 Jan 2007 23:11:49 -0800
Message-ID: <20070118071149.GB72618@sgi.com>
References: <92952AEF1F064042B6EF2522E0EEF43703EE3171@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:36937 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751980AbXARHLv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Jan 2007 02:11:51 -0500
Content-Disposition: inline
In-Reply-To: <92952AEF1F064042B6EF2522E0EEF43703EE3171@EXNA.corp.stratus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dailey, Nate" <Nate.Dailey@stratus.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 15, 2007 at 11:26:59AM -0500, Dailey, Nate wrote:
> Here's a patch that does what you suggest.
> 
> Because the default cache line size on my system is 0x10, I tested the
> patch by checking against this value rather than 0... it worked as
> expected.
> 
> This patch is against 2.6.19.2 that I just downloaded from kernel.org. I
> actually tested on RHEL4 update 4, a 2.6.9 kernel, but I'll try building
> the 2.6.19.2 on my system to make sure it works in that version as well.
> 
> Nate

Hi Nate,

The patch looks fine, except that your mailer wrapped the lines.
Try sending it as a text attachment instead.

Thanks

jeremy

> 
> --- sata_vsc.c.orig     2007-01-15 11:06:17.000000000 -0500
> +++ sata_vsc.c  2007-01-15 11:10:29.000000000 -0500
> @@ -340,6 +340,7 @@ static int __devinit vsc_sata_init_one (
>         int pci_dev_busy = 0;
>         void __iomem *mmio_base;
>         int rc;
> +       u8 cls;
> 
>         if (!printed_version++)
>                 dev_printk(KERN_DEBUG, &pdev->dev, "version "
> DRV_VERSION "\n");
> @@ -389,9 +390,13 @@ static int __devinit vsc_sata_init_one (
>         base = (unsigned long) mmio_base;
> 
>         /*
> -        * Due to a bug in the chip, the default cache line size can't
> be used
> +        * Due to a bug in the chip, the default cache line size can't
> be
> +        * used (unless the default is non-zero).
>          */
> -       pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> +       pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
> +       if (cls == 0x00) {
> +               pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> +       }
> 
>         probe_ent->sht = &vsc_sata_sht;
>         probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |

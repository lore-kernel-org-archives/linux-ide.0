From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
Date: Mon, 7 Apr 2008 22:46:40 +0200
Message-ID: <200804072246.40223.bzolnier@gmail.com>
References: <200804072027.17520.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:52508 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbYDGUbS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 16:31:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so752663nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 13:31:15 -0700 (PDT)
In-Reply-To: <200804072027.17520.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Monday 07 April 2008, Sergei Shtylyov wrote:
> This function didn't actually check if a given BAR is in I/O space because of
> using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test the resource
> flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() check the
> results failing if necessary, and move the printk() call to the failure path.

This change is OK in itself but I worry that ide_pci_check_iomem() may now
return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted in MEM
resources always surviving ide_pci_check_iomem() calls before the fix) for
some host drivers (siimage, scc_pata...) resulting in failed initialization.

How's about removing this dead/broken function instead for now?

[ IIRC for managed PCI devices these checks are done by generic code so
  once IDE got converted to use it we will get them as an added bonus... ]

Thanks,
Bart

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is against today's Linus' tree...
> 
>  drivers/ide/setup-pci.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)
> 
> Index: linux-2.6/drivers/ide/setup-pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/setup-pci.c
> +++ linux-2.6/drivers/ide/setup-pci.c
> @@ -312,11 +312,12 @@ static int ide_pci_configure(struct pci_
>   *	@d: IDE port info
>   *	@bar: BAR number
>   *
> - *	Checks if a BAR is configured and points to MMIO space. If so
> - *	print an error and return an error code. Otherwise return 0
> + *	Checks if a BAR is configured and points to MMIO space. If so,
> + *	return an error code. Otherwise return 0
>   */
>  
> -static int ide_pci_check_iomem(struct pci_dev *dev, const struct ide_port_info *d, int bar)
> +static int ide_pci_check_iomem(struct pci_dev *dev, const struct ide_port_info *d,
> +			       int bar)
>  {
>  	ulong flags = pci_resource_flags(dev, bar);
>  	
> @@ -324,14 +325,11 @@ static int ide_pci_check_iomem(struct pc
>  	if (!flags || pci_resource_len(dev, bar) == 0)
>  		return 0;
>  
> -	/* I/O space */		
> -	if(flags & PCI_BASE_ADDRESS_IO_MASK)
> +	/* I/O space */
> +	if (flags & IORESOURCE_IO)
>  		return 0;
>  		
>  	/* Bad */
> -	printk(KERN_ERR "%s: IO baseregs (BIOS) are reported "
> -			"as MEM, report to "
> -			"<andre@linux-ide.org>.\n", d->name);
>  	return -EINVAL;
>  }
>  
> @@ -360,9 +358,12 @@ static ide_hwif_t *ide_hwif_configure(st
>  	struct hw_regs_s hw;
>  
>  	if ((d->host_flags & IDE_HFLAG_ISA_PORTS) == 0) {
> -		/*  Possibly we should fail if these checks report true */
> -		ide_pci_check_iomem(dev, d, 2*port);
> -		ide_pci_check_iomem(dev, d, 2*port+1);
> +		if (ide_pci_check_iomem(dev, d, 2 * port) ||
> +		    ide_pci_check_iomem(dev, d, 2 * port + 1)) {
> +			printk(KERN_ERR "%s: I/O baseregs (BIOS) are reported "
> +					"as MEM for port %d!\n", d->name, port);
> +			return NULL;
> +		}
>   
>  		ctl  = pci_resource_start(dev, 2*port+1);
>  		base = pci_resource_start(dev, 2*port);

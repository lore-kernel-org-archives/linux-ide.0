From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Tue, 5 Jun 2007 19:08:06 -0400
Message-ID: <20070605230806.GV31565@havoc.gtf.org>
References: <200706060104.18055.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:45268 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932707AbXFEXII (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jun 2007 19:08:08 -0400
Content-Disposition: inline
In-Reply-To: <200706060104.18055.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Wed, Jun 06, 2007 at 01:04:17AM +0200, Uwe Koziolek wrote:
> the PATA-port of SiS180 controller does not support a drive present status
> in the pci configspace like the other SiS PATA controllers, check skipped.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>
> 
> --- a/drivers/ata/pata_sis.c	2007-06-05 22:17:10.000000000 +0200
> +++ b/drivers/ata/pata_sis.c	2007-06-06 00:06:08.000000000 +0200
> @@ -130,6 +130,20 @@
>  
>  
>  /**
> + *	sis_enables_supported - Check if enable_bits are supported
> + *	@pdev: pci device
> + *
> + *	The combined PATA/SATA controller SiS180 does not support
> + *	the enable_bits in the PCI configspace
> + */
> +
> +static inline int sis_enables_supported(struct pci_dev *pdev)
> +{
> +	return ((pdev->device != 0x0180) && (pdev->device != 0x0181));
> +}
> +
> +
> +/**
>   *	sis_pre_reset		-	probe begin
>   *	@ap: ATA port
>   *	@deadline: deadline jiffies for the operation
> @@ -146,7 +160,8 @@
>  
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  
> -	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
> +	if (sis_enables_supported(pdev) && 
> +	    !pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
>  		return -ENOENT;

Should work, but please split up the operations like I've repeatedly
requested.

For the devices where enable_bits are not supported, you can use the
standard error handler.

Let me know if this needs further explanation.

	Jeff




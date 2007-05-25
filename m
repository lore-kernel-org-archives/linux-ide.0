From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Fri, 25 May 2007 04:23:31 -0400
Message-ID: <46569D03.7030503@garzik.org>
References: <200705250948.52588.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52770 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760856AbXEYIXf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 04:23:35 -0400
In-Reply-To: <200705250948.52588.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: htejun@gmail.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> --- a/drivers/ata/sata_sis.c	2007-05-22 11:05:38.000000000 +0200
> +++ b/drivers/ata/sata_sis.c	2007-05-23 00:24:28.000000000 +0200
> @@ -255,7 +255,7 @@
>  {
>  	static int printed_version;
>  	struct ata_port_info pi = sis_port_info;
> -	const struct ata_port_info *ppi[] = { &pi, NULL };
> +	const struct ata_port_info *ppi[] = { &pi, &pi };
>  	struct ata_host *host;
>  	u32 genctl, val;
>  	u8 pmr;

applied this part


> --- a/drivers/ata/pata_sis.c	2007-05-22 11:05:38.000000000 +0200
> +++ b/drivers/ata/pata_sis.c	2007-05-25 07:50:50.000000000 +0200
> @@ -146,7 +146,8 @@
>  
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  
> -	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
> +	if ((pdev->device != 0x0180) && (pdev->device != 0x0181) &&
> +	    !pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
>  		return -ENOENT;
>  
>  	return ata_std_prereset(ap, deadline);

I think you misunderstood what Alan and I were saying.

If you remove the enable-bits check, then logically, all the function 
does is call ata_std_prereset.  Thus, your error handler only needs to 
the standard function for 0x180 and 0x181, ata_std_prereset() rather 
than sis_pre_reset().

Further, once your ata_bmdma_drive_eh() has been reduced entirely to 
calling standard functions, you need not use sis_error_handler() at all, 
because _that_ has been reduced to ata_bmdma_error_handler().

As a result, the following line

	.error_handler		= ata_bmdma_error_handler,

is functionally equivalent to your patch, but without custom code to 
produce that effect.

	Jeff



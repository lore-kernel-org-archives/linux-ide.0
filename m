From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20] sata_vsc: use default cache line size if non-zero
Date: Thu, 15 Feb 2007 18:14:12 -0500
Message-ID: <45D4E944.2090500@garzik.org>
References: <92952AEF1F064042B6EF2522E0EEF43703EE31CC@EXNA.corp.stratus.com> <20070208085938.GA142057@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60407 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422664AbXBOXOS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:14:18 -0500
In-Reply-To: <20070208085938.GA142057@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

Jeremy Higdon wrote:
> On Wed, Feb 07, 2007 at 09:29:28AM -0500, Dailey, Nate wrote:
>> The attached patch modifies drivers/ata/sata_vsc.c to only set the cache
>> line size to 0x80 if the default value is zero. Apparently zero isn't
>> allowed due to a bug in the chip, but I've found performance is much
>> better with the (non-zero) default instead of 0x80.
>>
>> Signed-off-by: Nate Dailey <nate.dailey@stratus.com>
> Signed-off-by: Jeremy Higdon <jeremy@sgi.com>
> 
> Here is the attachment from Nate, inline.
> 
> Content-Description: sata_vsc_CLS.patch
> --- old/drivers/ata/sata_vsc.c	2007-02-04 13:44:54.000000000 -0500
> +++ new/drivers/ata/sata_vsc.c	2007-02-07 09:13:17.000000000 -0500
> @@ -345,6 +345,7 @@ static int __devinit vsc_sata_init_one (
>  	int pci_dev_busy = 0;
>  	void __iomem *mmio_base;
>  	int rc;
> +	u8 cls;
>  
>  	if (!printed_version++)
>  		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
> @@ -394,9 +395,13 @@ static int __devinit vsc_sata_init_one (
>  	base = (unsigned long) mmio_base;
>  
>  	/*
> -	 * Due to a bug in the chip, the default cache line size can't be used
> +	 * Due to a bug in the chip, the default cache line size can't be
> +	 * used (unless the default is non-zero).
>  	 */
> -	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> +	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
> +	if (cls == 0x00) {
> +		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> +	}

applied, after removing the superfluous braces :)



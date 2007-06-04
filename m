From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Mon, 04 Jun 2007 16:51:06 +0400
Message-ID: <46640ABA.7010308@ru.mvista.com>
References: <20601315171560711667@wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8363 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751119AbXFDMtf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jun 2007 08:49:35 -0400
In-Reply-To: <20601315171560711667@wsc.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Jiri Slaby wrote:

> diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
> index f2c5a14..0d51a11 100644
> --- a/drivers/ide/pci/generic.c
> +++ b/drivers/ide/pci/generic.c
> @@ -198,32 +198,41 @@ static ide_pci_device_t generic_chipsets[] __devinitdata = {
>  static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
> -	u16 command;
>  	int ret = -ENODEV;
>  
>  	/* Don't use the generic entry unless instructed to do so */
>  	if (id->driver_data == 0 && ide_generic_all == 0)
>  			goto out;
>  
> -	if (dev->vendor == PCI_VENDOR_ID_UMC &&
> -	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
> -	    (!(PCI_FUNC(dev->devfn) & 1)))
> -		goto out; /* UM8886A/BF pair */
> -
> -	if (dev->vendor == PCI_VENDOR_ID_OPTI &&
> -	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
> -	    (!(PCI_FUNC(dev->devfn) & 1)))
> -		goto out;
> -
> -	if (dev->vendor == PCI_VENDOR_ID_JMICRON) {
> -		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 && PCI_FUNC(dev->devfn) != 1)
> +	switch (dev->vendor) {
> +	case PCI_VENDOR_ID_UMC:
> +		if (dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
> +				!(PCI_FUNC(dev->devfn) & 1))
> +			goto out; /* UM8886A/BF pair */
> +		break;
> +	case PCI_VENDOR_ID_OPTI:
> +		if (dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
> +				!(PCI_FUNC(dev->devfn) & 1))
> +			goto out;
> +		break;
> +	case PCI_VENDOR_ID_JMICRON:
> +		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 &&
> +				PCI_FUNC(dev->devfn) != 1)
> +			goto out;
> +		break;
> +	case PCI_VENDOR_ID_NS:
> +		if (dev->device == PCI_DEVICE_ID_NS_87410 &&
> +				(dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
>  			goto out;
> +		break;
>  	}

   Could you intend the if() conditions carried to another line the way they 
were intended before?

MBR, Sergei

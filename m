From: Amit Gud <gud@eth.net>
Subject: Re: [PATCH 21/91] get rid of	pci_find_{device,subsys}drivers/ide/pci/hpt366.c
Date: Wed, 30 Mar 2005 15:58:58 +0530
Message-ID: <424A7F6A.1020005@eth.net>
References: <ITPXCHFE1b2X5YqE1L70000207f@itpxchfe1.enterprise.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay-bridge.veritas.com ([143.127.3.10]:58667 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261847AbVC3KXf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Mar 2005 05:23:35 -0500
In-Reply-To: <ITPXCHFE1b2X5YqE1L70000207f@itpxchfe1.enterprise.veritas.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Amit S. Gud" <gud@eth.net>, greg@kroah.com
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Amit S. Gud wrote:
> Replace pci_find_{device,subsys} with pci_get_{device,subsys}.
> 
> 
> Signed-off-by: Amit S. Gud <gud@eth.net>
> 
> ---
> --- orig-2.6.12-rc1/drivers/ide/pci/hpt366.c	2005-03-15 21:01:10.000000000 +0530
> +++ work-2.6.12-rc1/drivers/ide/pci/hpt366.c	2005-03-29 16:53:14.428577208 +0530
> @@ -1562,11 +1562,12 @@ static void __devinit init_dma_hpt366(id
>  static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
>  {
>  	struct pci_dev *findev = NULL;
> +	int ret;
>  
>  	if (PCI_FUNC(dev->devfn) & 1)
>  		return -ENODEV;
>  
> -	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
> +	while ((findev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
>  		if ((findev->vendor == dev->vendor) &&
>  		    (findev->device == dev->device) &&
>  		    ((findev->devfn - dev->devfn) == 1) &&
> @@ -1577,8 +1578,11 @@ static int __devinit init_setup_hpt374(s
>  				printk(KERN_WARNING "%s: pci-config space interrupt "
>  					"fixed.\n", d->name);
>  			}
> -			return ide_setup_pci_devices(dev, findev, d);
> +			ret = ide_setup_pci_devices(dev, findev, d);
> +			pci_dev_put(findev);
> +			return ret;
>  		}
> +		pci_dev_put(findev);
>  	}
>  	return ide_setup_pci_device(dev, d);
>  }
> @@ -1593,6 +1597,7 @@ static int __devinit init_setup_hpt366(s
>  	struct pci_dev *findev = NULL;
>  	u8 pin1 = 0, pin2 = 0;
>  	unsigned int class_rev;
> +	int ret;
>  	char *chipset_names[] = {"HPT366", "HPT366",  "HPT368",
>  				 "HPT370", "HPT370A", "HPT372",
>  				 "HPT372N" };
> @@ -1622,7 +1627,7 @@ static int __devinit init_setup_hpt366(s
>  	d->channels = 1;
>  
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin1);
> -	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
> +	while ((findev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
>  		if ((findev->vendor == dev->vendor) &&
>  		    (findev->device == dev->device) &&
>  		    ((findev->devfn - dev->devfn) == 1) &&
> @@ -1634,8 +1639,11 @@ static int __devinit init_setup_hpt366(s
>  					"pin1=%d pin2=%d\n", d->name,
>  					pin1, pin2);
>  			}
> -			return ide_setup_pci_devices(dev, findev, d);
> +			ret = ide_setup_pci_devices(dev, findev, d);
> +			pci_dev_put(findev);
> +			return ret;
>  		}
> +		pci_dev_put(findev);
>  	}
>  init_single:
>  	return ide_setup_pci_device(dev, d);
> 


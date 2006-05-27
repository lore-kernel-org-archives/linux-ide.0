From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] HPT3xx: switch to using pci_find_slot()
Date: Sun, 28 May 2006 00:53:38 +0159
Message-ID: <4478D889.506@gmail.com>
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:4730 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964997AbWE0Wxq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 May 2006 18:53:46 -0400
Received: by nf-out-0910.google.com with SMTP id l36so86378nfa
        for <linux-ide@vger.kernel.org>; Sat, 27 May 2006 15:53:44 -0700 (PDT)
In-Reply-To: <4478CD3D.6010409@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sergei Shtylyov napsal(a):
>    Switch to using pci_find_slot() to get to the function 1 of HPT36x/374
Better to use pci_get_slot()+pci_dev_put(), i. e. refcounting.
> chips -- there's no need for the driver itself to walk the list of the
> PCI devices, and it also forgets to check the bus number of the device
> found.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linus/drivers/ide/pci/hpt366.c
> ===================================================================
> --- linus.orig/drivers/ide/pci/hpt366.c
> +++ linus/drivers/ide/pci/hpt366.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/hpt366.c		Version 0.44	May 20, 2006
> + * linux/drivers/ide/pci/hpt366.c		Version 0.45	May 21, 2006
>   *
>   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
> @@ -79,6 +79,7 @@
>   * - prefix the driver startup messages with the real chip name
>   * - claim the extra 240 bytes of I/O space for all chips
>   * - optimize the rate masking/filtering and the drive list lookup code
> + * - use pci_find_slot() to get to the function 1 of HPT36x/374
We have git repos for logging changes, don't we?
>   *		<source@mvista.com>
>   *
>   */
> @@ -1412,24 +1413,20 @@ static void __devinit init_iops_hpt366(i
>  
>  static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
>  {
> -	struct pci_dev *findev = NULL;
> +	struct pci_dev *dev2;
>  
>  	if (PCI_FUNC(dev->devfn) & 1)
>  		return -ENODEV;
>  
> -	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
> -		if ((findev->vendor == dev->vendor) &&
> -		    (findev->device == dev->device) &&
> -		    ((findev->devfn - dev->devfn) == 1) &&
> -		    (PCI_FUNC(findev->devfn) & 1)) {
> -			if (findev->irq != dev->irq) {
> -				/* FIXME: we need a core pci_set_interrupt() */
> -				findev->irq = dev->irq;
> -				printk(KERN_WARNING "%s: pci-config space interrupt "
> -					"fixed.\n", d->name);
> -			}
> -			return ide_setup_pci_devices(dev, findev, d);
> +	dev2 = pci_find_slot(dev->bus->number, dev->devfn + 1);
> +	if (dev2 != NULL) {
> +		if (dev2->irq != dev->irq) {
> +			/* FIXME: we need a core pci_set_interrupt() */
> +			dev2->irq = dev->irq;
> +			printk(KERN_WARNING "%s: pci-config space interrupt "
> +			       "fixed.\n", d->name);
>  		}
> +		return ide_setup_pci_devices(dev, dev2, d);
>  	}
>  	return ide_setup_pci_device(dev, d);
>  }
> @@ -1487,8 +1484,8 @@ static int __devinit init_setup_hpt302(s
>  
>  static int __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
>  {
> -	struct pci_dev *findev = NULL;
> -	u8 rev = 0, pin1 = 0, pin2 = 0;
> +	struct pci_dev *dev2;
> +	u8 rev = 0;
>  	static char   *chipset_names[] = { "HPT366", "HPT366",  "HPT368",
>  					   "HPT370", "HPT370A", "HPT372",
>  					   "HPT372N" };
> @@ -1508,21 +1505,18 @@ static int __devinit init_setup_hpt366(s
>  
>  	d->channels = 1;
>  
> -	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin1);
> -	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
> -		if ((findev->vendor == dev->vendor) &&
> -		    (findev->device == dev->device) &&
> -		    ((findev->devfn - dev->devfn) == 1) &&
> -		    (PCI_FUNC(findev->devfn) & 1)) {
> -			pci_read_config_byte(findev, PCI_INTERRUPT_PIN, &pin2);
> -			if ((pin1 != pin2) && (dev->irq == findev->irq)) {
> -				d->bootable = ON_BOARD;
> -				printk("%s: onboard version of chipset, "
> -					"pin1=%d pin2=%d\n", d->name,
> -					pin1, pin2);
> -			}
> -			return ide_setup_pci_devices(dev, findev, d);
> +	dev2 = pci_find_slot(dev->bus->number, dev->devfn + 1);
> +	if (dev2 != NULL) {
> +	  	u8 pin1 = 0, pin2 = 0;
> +
> +		pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
> +		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
> +		if (pin1 != pin2 && dev->irq == dev2->irq) {
> +			d->bootable = ON_BOARD;
> +			printk("%s: onboard version of chipset, pin1=%d pin2=%d\n",
> +			       d->name, pin1, pin2);
>  		}
> +		return ide_setup_pci_devices(dev, dev2, d);
>  	}
>  init_single:
>  	return ide_setup_pci_device(dev, d);
> 
> 

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEeNiJMsxVwznUen4RAvL7AKCLth5crJcvUmMHSLEtX02VztoJUwCfZtNo
uOKYd32ClussVe5FyRtZ2TM=
=W479
-----END PGP SIGNATURE-----

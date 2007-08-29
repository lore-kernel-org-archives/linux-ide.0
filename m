From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH 1/10] ide: use pci_dev->revision
Date: Wed, 29 Aug 2007 14:39:07 -0700
Message-ID: <46D5E77B.5030800@intel.com>
References: <200708292316.38779.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61372 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbXH2VjK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Aug 2007 17:39:10 -0400
In-Reply-To: <200708292316.38779.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

Bartlomiej Zolnierkiewicz wrote:
> Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID so
> they were not converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65.


that's actually another effort that I'm working on atm. You can either hold off 
on your patch or we'll see how my patches bounce against yours ;)

Cheers,


Auke

> 
> Cc: Auke Kok <auke-jan.h.kok@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Quick grep over kernel tree finds out many other places using either
> pci_read_config_dword(dev, PCI_CLASS_REVISION, ...) & 0xff or simply
> pci_read_config_byte(dev, PCI_CLASS_REVISION, ...) and they all can be
> converted to using dev->revision.
> 
> Auke, a "PCI_CLASS_REVISION" follow-up to your previous patch would be great.
> :)
> 
>  drivers/ide/pci/pdc202xx_new.c |    6 +-----
>  drivers/ide/pci/sgiioc4.c      |    8 +++-----
>  drivers/ide/pci/siimage.c      |   19 +++++--------------
>  drivers/ide/setup-pci.c        |    6 ++----
>  4 files changed, 11 insertions(+), 28 deletions(-)
> 
> Index: b/drivers/ide/pci/pdc202xx_new.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_new.c
> +++ b/drivers/ide/pci/pdc202xx_new.c
> @@ -332,16 +332,12 @@ static long __devinit detect_pll_input_c
>  static void __devinit apple_kiwi_init(struct pci_dev *pdev)
>  {
>  	struct device_node *np = pci_device_to_OF_node(pdev);
> -	unsigned int class_rev = 0;
>  	u8 conf;
>  
>  	if (np == NULL || !of_device_is_compatible(np, "kiwi-root"))
>  		return;
>  
> -	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class_rev);
> -	class_rev &= 0xff;
> -
> -	if (class_rev >= 0x03) {
> +	if (pdev->revision >= 0x03) {
>  		/* Setup chip magic config stuff (from darwin) */
>  		pci_read_config_byte (pdev, 0x40, &conf);
>  		pci_write_config_byte(pdev, 0x40, (conf | 0x01));
> Index: b/drivers/ide/pci/sgiioc4.c
> ===================================================================
> --- a/drivers/ide/pci/sgiioc4.c
> +++ b/drivers/ide/pci/sgiioc4.c
> @@ -690,14 +690,12 @@ sgiioc4_ide_setup_pci_device(struct pci_
>  static unsigned int __devinit
>  pci_init_sgiioc4(struct pci_dev *dev)
>  {
> -	unsigned int class_rev;
>  	int ret;
>  
> -	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> -	class_rev &= 0xff;
>  	printk(KERN_INFO "%s: IDE controller at PCI slot %s, revision %d\n",
> -			 DRV_NAME, pci_name(dev), class_rev);
> -	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {
> +			 DRV_NAME, pci_name(dev), dev->revision);
> +
> +	if (dev->revision < IOC4_SUPPORTED_FIRMWARE_REV) {
>  		printk(KERN_ERR "Skipping %s IDE controller in slot %s: "
>  				"firmware is obsolete - please upgrade to "
>  				"revision46 or higher\n",
> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
> @@ -640,13 +640,9 @@ static unsigned int setup_mmio_siimage (
>  
>  static unsigned int __devinit init_chipset_siimage(struct pci_dev *dev, const char *name)
>  {
> -	u32 class_rev	= 0;
> -	u8 tmpbyte	= 0;
> -	u8 BA5_EN	= 0;
> -
> -        pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> -        class_rev &= 0xff;
> -	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);	
> +	u8 rev = dev->revision, tmpbyte = 0, BA5_EN = 0;
> +
> +	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, rev ? 1 : 255);
>  
>  	pci_read_config_byte(dev, 0x8A, &BA5_EN);
>  	if ((BA5_EN & 0x01) || (pci_resource_start(dev, 5))) {
> @@ -825,19 +821,14 @@ static void __devinit siimage_fixup(ide_
>  
>  static void __devinit init_iops_siimage(ide_hwif_t *hwif)
>  {
> -	struct pci_dev *dev	= hwif->pci_dev;
> -	u32 class_rev		= 0;
> -
> -	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> -	class_rev &= 0xff;
> -	
>  	hwif->hwif_data = NULL;
>  
>  	/* Pessimal until we finish probing */
>  	hwif->rqsize = 15;
>  
> -	if (pci_get_drvdata(dev) == NULL)
> +	if (pci_get_drvdata(hwif->pci_dev) == NULL)
>  		return;
> +
>  	init_mmio_iops_siimage(hwif);
>  }
>  
> Index: b/drivers/ide/setup-pci.c
> ===================================================================
> --- a/drivers/ide/setup-pci.c
> +++ b/drivers/ide/setup-pci.c
> @@ -478,7 +478,6 @@ static void ide_hwif_setup_dma(struct pc
>  static int ide_setup_pci_controller(struct pci_dev *dev, ide_pci_device_t *d, int noisy, int *config)
>  {
>  	int ret;
> -	u32 class_rev;
>  	u16 pcicmd;
>  
>  	if (noisy)
> @@ -501,10 +500,9 @@ static int ide_setup_pci_controller(stru
>  		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
>  	}
>  
> -	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> -	class_rev &= 0xff;
>  	if (noisy)
> -		printk(KERN_INFO "%s: chipset revision %d\n", d->name, class_rev);
> +		printk(KERN_INFO "%s: chipset revision %d\n",
> +				 d->name, dev->revision);
>  out:
>  	return ret;
>  }

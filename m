From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/9] libata: PCI device should be powered up before being
 accessed
Date: Fri, 01 Feb 2008 15:44:57 -0500
Message-ID: <47A384C9.10804@garzik.org>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853434040-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53758 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYBAUpF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:45:05 -0500
In-Reply-To: <12016853434040-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Tejun Heo wrote:
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 7e68edf..5ef6594 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -597,6 +597,11 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	const struct ata_port_info *ppi[] = { NULL, NULL };
>  	u8 tmp;
>  	struct pci_dev *isa_bridge;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
>  
>  	/*
>  	 * The chipset revision selects the driver operations and
> @@ -632,8 +637,15 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  #ifdef CONFIG_PM
>  static int ali_reinit_one(struct pci_dev *pdev)
>  {
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	int rc;
> +
> +	rc = ata_pci_device_do_resume(pdev);
> +	if (rc)
> +		return rc;
>  	ali_init_chipset(pdev);
> -	return ata_pci_device_resume(pdev);
> +	ata_host_resume(host);
> +	return 0;
>  }
>  #endif
>  
> diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
> index 761a666..567fe6b 100644
> --- a/drivers/ata/pata_amd.c
> +++ b/drivers/ata/pata_amd.c
> @@ -662,10 +662,15 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	static int printed_version;
>  	int type = id->driver_data;
>  	u8 fifo;
> +	int rc;
>  
>  	if (!printed_version++)
>  		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
>  
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
>  	pci_read_config_byte(pdev, 0x41, &fifo);
>  
>  	/* Check for AMD7409 without swdma errata and if found adjust type */
> @@ -709,6 +714,13 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  #ifdef CONFIG_PM
>  static int amd_reinit_one(struct pci_dev *pdev)
>  {
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	int rc;
> +
> +	rc = ata_pci_device_do_resume(pdev);
> +	if (rc)
> +		return rc;
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
>  		u8 fifo;
>  		pci_read_config_byte(pdev, 0x41, &fifo);
> @@ -721,7 +733,9 @@ static int amd_reinit_one(struct pci_dev *pdev)
>  		    pdev->device == PCI_DEVICE_ID_AMD_COBRA_7401)
>  		    	ata_pci_clear_simplex(pdev);
>  	}
> -	return ata_pci_device_resume(pdev);
> +
> +	ata_host_resume(host);
> +	return 0;
>  }
>  #endif
>  
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index d421831..2f81480 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -446,11 +446,16 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>  		.port_ops	= &artop6260_ops,
>  	};
>  	const struct ata_port_info *ppi[] = { NULL, NULL };
> +	int rc;
>  
>  	if (!printed_version++)
>  		dev_printk(KERN_DEBUG, &pdev->dev,
>  			   "version " DRV_VERSION "\n");
>  
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
>  	if (id->driver_data == 0) {	/* 6210 variant */
>  		ppi[0] = &info_6210;
>  		ppi[1] = &ata_dummy_port_info;

While _I_ do not object, I'm curious to see what Alan thinks about 
adding enable-device to all these drivers.  Seems like the right (and 
necessary) thing to do, from my perspective...

	Jeff



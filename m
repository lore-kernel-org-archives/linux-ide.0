From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: convert pata to new reset mechanism
Date: Sun, 12 Feb 2006 13:59:29 -0500
Message-ID: <43EF8591.7010604@pobox.com>
References: <20060212060637.GB20025@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22746 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750866AbWBLS7f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 13:59:35 -0500
In-Reply-To: <20060212060637.GB20025@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> [PATCH] ata_piix: convert pata to new reset mechanism
> 
> Convert ata_piix pata ->phy_reset to new reset mechanism.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> --
> 
> Jeff, this patch assumes that all-probe_reset-to-return-UNKNOWN[1] is
> applied.
> 
> [1] http://article.gmane.org/gmane.linux.ide/7967
> 
> 
>  ata_piix.c |   44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> Index: work1/drivers/scsi/ata_piix.c
> ===================================================================
> --- work1.orig/drivers/scsi/ata_piix.c	2006-02-12 14:26:03.000000000 +0900
> +++ work1/drivers/scsi/ata_piix.c	2006-02-12 14:35:06.000000000 +0900
> @@ -131,7 +131,7 @@ enum {
>  static int piix_init_one (struct pci_dev *pdev,
>  				    const struct pci_device_id *ent);
>  
> -static void piix_pata_phy_reset(struct ata_port *ap);
> +static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
>  static void piix_sata_phy_reset(struct ata_port *ap);
>  static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
>  static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
> @@ -208,7 +208,7 @@ static const struct ata_port_operations 
>  	.exec_command		= ata_exec_command,
>  	.dev_select		= ata_std_dev_select,
>  
> -	.phy_reset		= piix_pata_phy_reset,
> +	.probe_reset		= piix_pata_probe_reset,
>  
>  	.bmdma_setup		= ata_bmdma_setup,
>  	.bmdma_start		= ata_bmdma_start,
> @@ -259,8 +259,7 @@ static struct ata_port_info piix_port_in
>  	/* ich5_pata */
>  	{
>  		.sht		= &piix_sht,
> -		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
> -				  PIIX_FLAG_CHECKINTR,
> +		.host_flags	= ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
>  #if 0
>  		.mwdma_mask	= 0x06, /* mwdma1-2 */
> @@ -285,7 +284,7 @@ static struct ata_port_info piix_port_in
>  	/* piix4_pata */
>  	{
>  		.sht		= &piix_sht,
> -		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
> +		.host_flags	= ATA_FLAG_SLAVE_POSS,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
>  #if 0
>  		.mwdma_mask	= 0x06, /* mwdma1-2 */
> @@ -367,30 +366,43 @@ cbl40:
>  }
>  
>  /**
> - *	piix_pata_phy_reset - Probe specified port on PATA host controller
> - *	@ap: Port to probe
> + *	piix_pata_postreset - Postreset stuff on PATA host controller
> + *	@ap: Target port
> + *	@classes: Classes of attached devices
>   *
> - *	Probe PATA phy.
> + *	Postreset processing including cable detection.
>   *
>   *	LOCKING:
>   *	None (inherited from caller).
>   */
> +static void piix_pata_postreset(struct ata_port *ap, unsigned int *classes)
> +{
> +	piix_pata_cbl_detect(ap);
> +	ata_std_postreset(ap, classes);
> +}
>  
> -static void piix_pata_phy_reset(struct ata_port *ap)
> +/**
> + *	piix_pata_probe_reset - Perform reset on PATA port and classify
> + *	@ap: Port to reset
> + *	@classes: Resulting classes of attached devices
> + *
> + *	Reset PATA phy and classify attached devices.
> + *
> + *	LOCKING:
> + *	None (inherited from caller).
> + */
> +static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
>  
>  	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
> -		ata_port_disable(ap);
>  		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
> -		return;
> +		return 0;
>  	}
>  
> -	piix_pata_cbl_detect(ap);
> -
> -	ata_port_probe(ap);
> -
> -	ata_bus_reset(ap);
> +	return ata_drive_probe_reset(ap, ata_std_probeinit,
> +				     ata_std_softreset, NULL,
> +				     piix_pata_postreset, classes);

NAK, changes order of operations.  Cable detect moves from being one of 
the very first things to one of the very last things.

	Jeff




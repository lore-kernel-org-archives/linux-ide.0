From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/9] ata_piix: convert pata to new reset mechanism
Date: Sat, 11 Feb 2006 18:29:48 -0500
Message-ID: <43EE736C.4080204@pobox.com>
References: <11395835281330-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26321 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750836AbWBKX3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 18:29:52 -0500
In-Reply-To: <11395835281330-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert ata_piix pata ->phy_reset to new reset mechanism.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/ata_piix.c |   47 +++++++++++++++++++++++++++++++----------------
>  1 files changed, 31 insertions(+), 16 deletions(-)
> 
> aa17cffcebd940a844e0a8a5a99d2192699c9b4e
> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
> index 4933ba2..650c687 100644
> --- a/drivers/scsi/ata_piix.c
> +++ b/drivers/scsi/ata_piix.c
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
> @@ -367,30 +366,46 @@ cbl40:
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
> +	int i;
>  
>  	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
> -		ata_port_disable(ap);
> +		for (i = 0; i < ATA_MAX_DEVICES; i++)
> +			classes[i] = ATA_DEV_NONE;

ACK except for the above loop.  The above is really a regression, since 
its hand-coding something in a driver that libata should really be 
responsible for.

Whether you can ata_port_disable() or create a new function, the driver 
should be making a function call not hand-coding the loop.

Think about it conceptually:  the driver is really requesting that 
libata mark all devices on this port non-existent.  If you ever need to 
change the definition of non-existent (as this patch does, in fact), 
then its much easier to modify a function in libata once, rather than 
touch each driver as necessary.

	Jeff




From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] ahci: Add support for EEH error recovery
Date: Thu, 14 May 2015 13:13:40 -0400
Message-ID: <20150514171340.GL11388@htj.duckdns.org>
References: <1431622517-5851-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34265 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbbENRNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 13:13:44 -0400
Received: by qkgx75 with SMTP id x75so53738977qkg.1
        for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 10:13:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431622517-5851-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: wenxiong@linux.vnet.ibm.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, bjking1@us.ibm.com, wenxiong@us.ibm.com, Brian King <bjking@linux.vnet.ibm.com>

Hello, Wen.

On Thu, May 14, 2015 at 11:55:17AM -0500, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> 
> On the Power platform, the pci_error_handlers map to our EEH recovery.

Please spell out EEH on the first usage and hopefully explain briefly.
It's not a term that people are familiar with in general.

> In that case, without this patch, if we hit any sort of PCIe error, we
> won't be able to recover and we'll lose all access to the ahci disks.
> This could be the adapter trying to access an invalid DMA address due
> to a transient hardware issue, or it could be due to a driver bug giving
> the adapter an invalid address. It could also be other various PCIe

Is driver bug something to be recovered this way?  It's risking
further data corruption.  Panicking on detection sounds like a better
option for this sort of error.

> errors that cause our PCIe bridge chip to isolate the device and
> place it into the EEH "frozen" state. When this occurs, if the driver

What other conditions do this handle?  How often does this actually
get triggered and how successful are they at recovering from such
failures?

> associated with the hardware does not have these handlers registered,
> powerpc arch kernel code will hotplug remove the adapter, recover the
> adapter, then hotplug add it back. This works OK for some devices,
> but generally not so well for storage devices with mounted filesystems,
> which would tend to go readonly in this case.

I'm not quite sure.  The thing with hot unplug/plug is that all the
layers are notified that the operation has been interrupted.  If you
do online recovery, you have ensure that no data is lost or corrupt.
The error recovery must be interlocked with command execution and
other error handling operations.

> This patch adds the callback functions to support EEH(Extended Error
> Handling) error recovery in ahci driver. Also adds the code in
> ahci_error_handler to issue an MMIO load then check if it is in EEH.
> If it is in EEH, ahci_error_handler will wait until EEH recovery is completed.

Is this something arch-agnostic or specific to power?  I'm afraid I'd
need quite a bit more information to decide.

> +static const struct pci_error_handlers ahci_err_handler = {
> +	.error_detected = ahci_pci_error_detected,
> +	.slot_reset = ahci_pci_slot_reset,
> +};
>  
>  static struct pci_driver ahci_pci_driver = {
>  	.name			= DRV_NAME,
> @@ -530,6 +538,7 @@ static struct pci_driver ahci_pci_driver = {
>  	.suspend		= ahci_pci_device_suspend,
>  	.resume			= ahci_pci_device_resume,
>  #endif
> +	.err_handler		= &ahci_err_handler,
>  };

Prolly achi_pci_err_handler() is a better name?

> +static pci_ers_result_t ahci_pci_error_detected(struct pci_dev *pdev,
> +					       pci_channel_state_t state)
> +{
> +	struct ata_host *host = pci_get_drvdata(pdev);
> +	int i;
> +
> +	if (state == pci_channel_io_perm_failure)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	for (i = 0; i < host->n_ports; i++)
> +		scsi_block_requests(host->ports[i]->scsi_host);

This block further issuing of new commands does nothing to drain the
on-going commands or internal commands.  You need to invoke libata EH
and synchronize against it.

> +	return PCI_ERS_RESULT_NEED_RESET;
> +
> +}
> +
> +/**
> + * ahci_pci_slot_reset - Called when PCI slot has been reset.
> + * @pdev:	PCI device struct
> + *
> + * Description: This routine is called by the pci error recovery
> + * code after the PCI slot has been reset, just before we
> + * should resume normal operations.
> + */
> +static pci_ers_result_t ahci_pci_slot_reset(struct pci_dev *pdev)
> +{
> +	struct ata_host *host = pci_get_drvdata(pdev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int i, rc;
> +
> +	pci_restore_state(pdev);
> +
> +	pci_save_state(pdev);

What does the above do?

> +	rc = ahci_pci_reset_controller(host);
> +	if (rc)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	ahci_pci_init_controller(host);
> +
> +	for (i = 0; i < host->n_ports; i++)
> +		scsi_unblock_requests(host->ports[i]->scsi_host);
> +
> +	wake_up_all(&hpriv->eeh_wait_q);
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}

This doesn't seem to synchronize with the rest of libata at all.  You
really don't wanna be resetting and reinitializing the controller
while things are in flight.

>  static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
>  {
>  	int rc;
> @@ -1439,6 +1506,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
>  
> +	init_waitqueue_head(&hpriv->eeh_wait_q);
>  	/* must set flag prior to save config in order to take effect */
>  	if (ahci_broken_devslp(pdev))
>  		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
> @@ -1549,6 +1617,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pci_set_master(pdev);
>  
> +	pci_save_state(pdev);

Some comment please.

> +
>  	return ahci_host_activate(host, pdev->irq, &ahci_sht);
>  }
>  
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 71262e0..6bbf747 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -51,6 +51,8 @@
>  #define EM_MSG_LED_VALUE_OFF          0xfff80000
>  #define EM_MSG_LED_VALUE_ON           0x00010000
>  
> +#define AHCI_PCI_ERROR_RECOVERY_TIMEOUT	(120 * HZ)

Any specific reason for choosing this timeout?  Why is it even
necessary?

> @@ -1968,6 +1969,16 @@ static void ahci_thaw(struct ata_port *ap)
>  void ahci_error_handler(struct ata_port *ap)
>  {
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	u32 irq_stat;
> +
> +	irq_stat = readl(mmio + HOST_IRQ_STAT);
> +
> +	if (pci_channel_offline(pdev))
> +		wait_event_timeout(hpriv->eeh_wait_q,
> +				!pci_channel_offline(pdev),
> +				AHCI_PCI_ERROR_RECOVERY_TIMEOUT);

What if pci error happens here?

Too many holes both in implementation and documentation.  I think it'd
need significant amount of improvements to get included.

Thanks.

-- 
tejun

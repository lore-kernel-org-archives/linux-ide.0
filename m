From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Wed, 09 Aug 2006 01:11:42 -0400
Message-ID: <44D96E8E.9020801@pobox.com>
References: <1154919840689-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:18335 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964859AbWHIFLx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 01:11:53 -0400
In-Reply-To: <1154919840689-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement the following PCI init helpers for new LLD init model.
> 
> * ata_pci_host_set_init_native(): init ports for native PCI host_set
> * ata_pci_legacy_mask(): obtain legacy mask of ATA PCI device
> * ata_pci_set_dma_mask(): set DMA mask helper
> * ata_pci_acquire_resources(): acquire generic ATA PCI resources for host_set
> * ata_pci_request_irq(): prep host_set for IRQ and request IRQ.
> * ata_pci_release_resources(): release generic ATA PCI resources including IRQs
> * ata_pci_host_set_destroy(): release associated resources and destroy host_set
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-bmdma.c |  390 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-core.c  |    7 +
>  include/linux/libata.h      |   36 ++++
>  3 files changed, 431 insertions(+), 2 deletions(-)
> 
> 139908fea67d9fa2c835b1c92e76112ab45e295c
> diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
> index c4cd578..341d9b5 100644
> --- a/drivers/scsi/libata-bmdma.c
> +++ b/drivers/scsi/libata-bmdma.c
> @@ -797,6 +797,396 @@ void ata_bmdma_post_internal_cmd(struct 
>  }
>  
>  #ifdef CONFIG_PCI
> +static const unsigned long ata_legacy_addr_tbl[][2] = {
> +	{ ATA_PRIMARY_CMD, ATA_PRIMARY_CTL },
> +	{ ATA_SECONDARY_CMD, ATA_SECONDARY_CTL}
> +};
> +
> +static void ata_pci_port_init(struct ata_port *ap, unsigned long cmd_addr,
> +			      unsigned long ctl_addr, unsigned long bmdma_addr)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +
> +	ioaddr->cmd_addr = cmd_addr;
> +	ioaddr->altstatus_addr = ctl_addr;
> +	ioaddr->ctl_addr = ctl_addr;
> +
> +	if (bmdma_addr) {
> +		if (inb(bmdma_addr + 2) & 0x80)
> +			ap->host_set->flags |= ATA_HOST_SIMPLEX;
> +		ioaddr->bmdma_addr = bmdma_addr;
> +	}
> +	ata_std_ports(ioaddr);
> +}
> +
> +static void ata_pci_port_init_native(struct ata_port *ap, int port)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> +	unsigned long cmd_addr, ctl_addr, bmdma_addr;
> +
> +	cmd_addr = pci_resource_start(pdev, port * 2);
> +	ctl_addr = pci_resource_start(pdev, port * 2 + 1) | ATA_PCI_CTL_OFS;
> +	bmdma_addr = pci_resource_start(pdev, 4);
> +	if (bmdma_addr)
> +		bmdma_addr += port * 8;
> +
> +	ata_pci_port_init(ap, cmd_addr, ctl_addr, bmdma_addr);
> +}
> +
> +static void ata_pci_port_init_legacy(struct ata_port *ap, int port)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> +	unsigned long cmd_addr, ctl_addr, bmdma_addr;
> +
> +	cmd_addr = ata_legacy_addr_tbl[port][0];
> +	ctl_addr = ata_legacy_addr_tbl[port][1];
> +	bmdma_addr = pci_resource_start(pdev, 4);
> +	if (bmdma_addr)
> +		bmdma_addr += port * 8;
> +
> +	ata_pci_port_init(ap, cmd_addr, ctl_addr, bmdma_addr);
> +}
> +
> +/**
> + *	ata_pci_host_set_init_native - init host_set for native PCI ATA
> + *	@host_set: target ATA host_set
> + *
> + *	Initialize @host_set for native mode PCI ATA.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +void ata_pci_host_set_init_native(struct ata_host_set *host_set)
> +{
> +	ata_pci_port_init_native(host_set->ports[0], 0);
> +	if (host_set->n_ports > 1)
> +		ata_pci_port_init_native(host_set->ports[1], 1);
> +}
> +
> +/**
> + *	ata_pci_legacy_mask - obatin legacy mask from PCI IDE device
> + *	@pdev: target PCI device
> + *
> + *	Obtain legacy mask from @pdev.
> + *
> + *	LOCKING:
> + *	None.
> + *
> + *	RETURNS:
> + *	Obtained legacy mask.
> + */
> +unsigned int ata_pci_legacy_mask(struct pci_dev *pdev)
> +{
> +	unsigned int mask = 0;
> +	u8 tmp8;
> +
> +	if (pdev->class >> 8 != PCI_CLASS_STORAGE_IDE)
> +		return 0;
> +
> +	pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
> +
> +	if (!(tmp8 & (1 << 0)))
> +		mask |= ATA_PORT_PRIMARY;
> +
> +	if (!(tmp8 & (1 << 2)))
> +		mask |= ATA_PORT_SECONDARY;
> +
> +	return mask;
> +}
> +
> +static int ata_pci_acquire_legacy(int port, unsigned long *host_set_flags)
> +{
> +	unsigned long cmd_addr = ata_legacy_addr_tbl[port][0];
> +
> +	if (request_region(cmd_addr, 8, "libata") != NULL)
> +		*host_set_flags |= ATA_HOST_RES_LEGACY_PRI << port;
> +	else {
> +		struct resource *conflict, res;
> +
> +		res.start = cmd_addr;
> +		res.end = cmd_addr + 8 - 1;
> +		conflict = ____request_resource(&ioport_resource, &res);
> +
> +		if (strcmp(conflict->name, "libata")) {
> +			printk(KERN_WARNING "ata: 0x%0lX IDE port busy\n",
> +			       cmd_addr);
> +			*host_set_flags |= ATA_HOST_PCI_DEV_BUSY;
> +			return -EBUSY;
> +		}
> +		printk("ata: 0x%0lX IDE port preallocated\n", cmd_addr);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *	ata_pci_set_dma_mask - PCI DMA mask set helper
> + *	@pdev: target PCI device
> + *	@dma_mask: DMA mask
> + *	@p_reason: output arg for error message
> + *
> + *	Helper to set PCI DMA mask.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + */
> +int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
> +			 const char **p_reason)
> +{
> +	const char *reason;
> +	int rc = 0;
> +
> +	if (dma_mask == DMA_64BIT_MASK) {
> +		if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) == 0) {
> +			rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
> +			if (rc) {
> +				rc = pci_set_consistent_dma_mask(pdev,
> +							DMA_32BIT_MASK);
> +				if (rc) {
> +					reason = "64-bit DMA enable failed";
> +					goto err;
> +				}
> +			}
> +		} else {
> +			rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
> +			if (rc) {
> +				reason = "32-bit DMA enable failed";
> +				goto err;
> +			}
> +			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
> +			if (rc) {
> +				reason = "32-bit consistent DMA enable failed";
> +				goto err;
> +			}
> +		}
> +	} else if (dma_mask) {
> +		reason = "failed to set DMA mask";
> +		rc = pci_set_dma_mask(pdev, dma_mask);
> +		if (rc)
> +			goto err;
> +		rc = pci_set_consistent_dma_mask(pdev, dma_mask);
> +		if (rc)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> + err:
> +	if (p_reason)
> +		*p_reason = reason;
> +	return rc;
> +}
> +
> +/**
> + *	ata_pci_acquire_resources - acquire default PCI resources
> + *	@host_set: target ATA host_set to acquire PCI resources for
> + *	@dma_mask: DMA mask
> + *	@reason: output arg for error message
> + *
> + *	Acquire default ATA PCI resources.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + */
> +int ata_pci_acquire_resources(struct ata_host_set *host_set, u64 dma_mask,
> +			      const char **reason)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host_set->dev);
> +	int nr_dummy, i, rc;
> +
> +	/* acquire generic resources */
> +
> +	/* FIXME: Really for ATA it isn't safe because the device may
> +	 * be multi-purpose and we want to leave it alone if it was
> +	 * already enabled. Secondly for shared use as Arjan says we
> +	 * want refcounting
> +	 *
> +	 * Checking dev->is_enabled is insufficient as this is not set
> +	 * at boot for the primary video which is BIOS enabled
> +         */
> +	rc = pci_enable_device(pdev);
> +	if (rc) {
> +		*reason = "failed to enable PCI device";
> +		goto err;
> +	}
> +
> +	rc = pci_request_regions(pdev, DRV_NAME);
> +	if (rc) {
> +		host_set->flags |= ATA_HOST_PCI_DEV_BUSY;
> +		*reason = "failed to request PCI regions";
> +		goto err;
> +	}
> +
> +	host_set->flags |= ATA_HOST_PCI_RES_GEN;
> +
> +	/* set DMA mask */
> +	/* FIXME: If we get no DMA mask we should fall back to PIO */
> +	rc = ata_pci_set_dma_mask(pdev, dma_mask, reason);
> +	if (rc)
> +		goto err;
> +
> +	/* Acquire legacy resources.  For legacy ports, host_set must
> +	 * be popultaed with ports before calling this function.
> +	 */
> +	nr_dummy = 0;
> +	for (i = 0; i < 2; i++) {
> +		if (!(host_set->flags & (ATA_HOST_LEGACY_PRI << i)))
> +			continue;
> +		BUG_ON(i >= host_set->n_ports);
> +
> +		if (ata_pci_acquire_legacy(i, &host_set->flags)) {
> +			host_set->ports[i]->ops = &ata_dummy_port_ops;
> +			nr_dummy++;
> +		}
> +	}
> +
> +	if (nr_dummy && nr_dummy == host_set->n_ports) {
> +		*reason = "no available port";
> +		rc = -ENODEV;
> +		goto err;
> +	}
> +
> +	return 0;
> +
> + err:
> +	ata_pci_release_resources(host_set);
> +	return rc;
> +}
> +
> +/**
> + *	ata_pci_request_irq - request PCI irq for ATA host_set
> + *	@host_set: ATA host_set to request PCI irq for
> + *	@irq_handler: irq_handler
> + *	@flags: ATA_PCI_IRQ_* flags
> + *	@reason: output arg for error message
> + *
> + *	Request PCI irq for @host_set.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer.
> + *
> + *	RETURNS:
> + *	Return value of request_irq().
> + */
> +int ata_pci_request_irq(struct ata_host_set *host_set,
> +		irqreturn_t (*irq_handler)(int, void *, struct pt_regs *),
> +		unsigned int flags, const char **reason)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host_set->dev);
> +	unsigned int irq_flags = 0;
> +	int rc;
> +
> +	if (flags & ATA_PCI_IRQ_MSI) {
> +		flags &= ~ATA_PCI_IRQ_INTX;
> +
> +		if (pci_enable_msi(pdev) == 0)
> +			host_set->flags |= ATA_HOST_PCI_RES_MSI;
> +		else
> +			flags |= ATA_PCI_IRQ_INTX;
> +	}
> +
> +	if (flags & ATA_PCI_IRQ_INTX) {
> +		pci_intx(pdev, 1);
> +		host_set->flags |= ATA_HOST_PCI_RES_INTX;
> +	}
> +
> +	if (!(flags & ATA_PCI_IRQ_EXCL))
> +		irq_flags |= IRQF_SHARED;
> +
> +	rc = ata_host_set_request_irq(host_set, pdev->irq, irq_handler,
> +				      irq_flags, reason);
> +	if (rc == 0)
> +		host_set->flags |= ATA_HOST_PCI_RES_IRQ;
> +
> +	return rc;
> +}
> +
> +/**
> + *	ata_pci_release_resources - release all ATA PCI resources
> + *	@pdev: target ATA host_set
> + *
> + *	Release all ATA PCI resources.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +void ata_pci_release_resources(struct ata_host_set *host_set)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host_set->dev);
> +	int i;
> +
> +	/* stop all ports */
> +	ata_host_set_stop(host_set);
> +
> +	/* release IRQs */
> +	if (host_set->flags & ATA_HOST_PCI_RES_IRQ15) {
> +		free_irq(15, host_set);
> +		host_set->flags &= ~ATA_HOST_PCI_RES_IRQ15;
> +	}
> +
> +	if (host_set->flags & ATA_HOST_PCI_RES_IRQ14) {
> +		free_irq(14, host_set);
> +		host_set->flags &= ~ATA_HOST_PCI_RES_IRQ14;
> +	}
> +
> +	if (host_set->flags & ATA_HOST_PCI_RES_IRQ) {
> +		free_irq(pdev->irq, host_set);
> +		host_set->flags &= ~ATA_HOST_PCI_RES_IRQ;
> +	}
> +
> +	if (host_set->flags & ATA_HOST_PCI_RES_INTX) {
> +		pci_intx(pdev, 0);
> +		host_set->flags &= ~ATA_HOST_PCI_RES_INTX;
> +	}
> +
> +	if (host_set->flags & ATA_HOST_PCI_RES_MSI) {
> +		pci_disable_msi(pdev);
> +		host_set->flags &= ~ATA_HOST_PCI_RES_MSI;
> +	}

This is definitely the wrong direction.

We don't want to keep crowding knowledge of multiple bus technologies 
into the same function.

ata_pci_request_irq() and other code above follows the same theme... 
but its an unmaintainable direction.

This sort of stuff needs to be split up, not coalesced.

Another thing to think about:  IMO it makes sense to separate out the 
PCI IDE resource handling, because that set of technology is largely static.

Most newer controllers will only have a few resources, normally MMIO, 
and may even support MSI-X (multiple messages for different event types, 
rather than a single message for all events like MSI).

So, I'd like to see some of this inside libata-bmdma.c to keep the core 
free of such nastiness.

	Jeff



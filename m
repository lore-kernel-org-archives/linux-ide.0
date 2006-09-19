From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 7/20] libata: implement PCI ATA init helpers
Date: Tue, 19 Sep 2006 01:29:16 -0400
Message-ID: <450F802C.9040309@pobox.com>
References: <11559779711637-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:9631 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752070AbWISF3X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:29:23 -0400
In-Reply-To: <11559779711637-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
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

else return -EINVAL, I suppose


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
> + *	@host: target ATA host to acquire PCI resources for
> + *	@dma_mask: DMA mask
> + *	@p_reason: out arg for error message (can be NULL)
> + *
> + *	Acquire default ATA PCI resources.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + */
> +int ata_pci_acquire_resources(struct ata_host *host, u64 dma_mask,
> +			      const char **p_reason)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +	const char *reason;
> +	int rc;
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
> +		reason = "failed to enable PCI device";
> +		goto err;
> +	}
> +
> +	rc = pci_request_regions(pdev, DRV_NAME);
> +	if (rc) {
> +		host->flags |= ATA_HOST_DEV_BUSY;
> +		reason = "failed to request PCI regions";
> +		goto err;
> +	}
> +
> +	host->pci_flags |= ATA_PCI_RES_GEN;
> +
> +	/* set DMA mask */
> +	/* FIXME: If we get no DMA mask we should fall back to PIO */
> +	rc = ata_pci_set_dma_mask(pdev, dma_mask, &reason);
> +	if (rc)
> +		goto err;
> +
> +	return 0;
> +
> + err:
> +	ata_pci_release_resources(host);
> +	if (p_reason)
> +		*p_reason = reason;
> +	return rc;
> +}
> +
> +/**
> + *	ata_pci_release_resources - release default PCI resources
> + *	@host: target ATA host to release PCI resources for
> + *
> + *	Release default ATA PCI resources.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +void ata_pci_release_resources(struct ata_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +
> +	if (host->pci_flags & ATA_PCI_RES_GEN) {
> +		pci_release_regions(pdev);
> +
> +		if (!(host->flags & ATA_HOST_DEV_BUSY))
> +			pci_disable_device(pdev);
> +
> +		host->pci_flags &= ~ATA_PCI_RES_GEN;
> +	}
> +}
> +
> +/**
> + *	ata_pci_init_ports - initialize PCI ATA port addresses
> + *	@host: target ATA host
> + *
> + *	Initialize native ATA port TF addresses and PCI BMDMA
> + *	addresses for both legacy and native ports.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer.
> + */
> +void ata_pci_init_ports(struct ata_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +	int i;
> +
> +	/* initialize native TF and BMDMA */
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +		struct ata_ioports *ioaddr = &ap->ioaddr;
> +		unsigned long cmd_addr, ctl_addr, bmdma_addr;
> +
> +		cmd_addr = pci_resource_start(pdev, ap->port_no * 2);
> +		ctl_addr = pci_resource_start(pdev, ap->port_no * 2 + 1) |
> +			ATA_PCI_CTL_OFS;
> +		bmdma_addr = pci_resource_start(pdev, 4);
> +
> +		if (!((host->legacy_flags & ATA_LEGACY_MASK) & (1 << i))) {
> +			ioaddr->cmd_addr = cmd_addr;
> +			ioaddr->altstatus_addr = ctl_addr;
> +			ioaddr->ctl_addr = ctl_addr;
> +			ata_std_ports(ioaddr);
> +		}
> +
> +		if (bmdma_addr) {
> +			bmdma_addr += ap->port_no * 8;
> +			if (inb(bmdma_addr + 2) & 0x80)
> +				host->flags |= ATA_HOST_SIMPLEX;
> +			ioaddr->bmdma_addr = bmdma_addr;
> +		}
> +	}
> +}

I don't see where the legacy resource handling is?

For PCI devices in legacy, or mixed legacy+native mode, the above code 
should be calling into ata-legacy.c to reserve resources.


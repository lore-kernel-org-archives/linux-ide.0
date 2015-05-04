From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Mon, 4 May 2015 12:06:52 -0400
Message-ID: <20150504160652.GB1971@htj.duckdns.org>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35107 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbbEDQG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:06:57 -0400
Content-Disposition: inline
In-Reply-To: <1430725538-22162-1-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, Robert Richter <rrichter@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>

Hello, Robert. (cc'ing Alexander for ahci msi)

On Mon, May 04, 2015 at 09:45:37AM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch adds generic support for MSI-X interrupts to the SATA PCI
> driver. Only single interrupt support is implemented. Thus, per-port
> interrupts can not yet be enabled.
> 
> The driver now checks the device for the existence of MSI-X and tries
> to enable the interrupt. Otherwise, if a device is not MSI-X capable,
> the initialization is skipped and MSI or intx interrupts are
> configured.
> 
> This patch also enables AHCI for Cavium Thunder SoCs that uses MSI-X.

Please don't mix these two changes in the same patch.

> @@ -1202,11 +1207,41 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
>  {}
>  #endif
>  
> -static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> -				struct ahci_host_priv *hpriv)
> +static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
> +			  struct ahci_host_priv *hpriv)
> +{
> +	int rc, nvec;
> +	struct msix_entry entry = {};
> +
> +	/* check if msix is supported */
> +	nvec = pci_msix_vec_count(pdev);
> +	if (nvec <= 0)
> +		return 0;
> +
> +	/* per-port msix interrupts are not supported */
> +	if (n_ports > 1 && nvec >= n_ports)
> +		return -ENOSYS;

Hmm... can you please elaborate why the condition isn't nvec > 1?
Also, shouldn't we be printing a warning message here explaining why
probing is failing?

> +
> +	/* only enable the first entry (entry.entry = 0) */
> +	rc = pci_enable_msix_exact(pdev, &entry, 1);

So, enabling the first msix works if nvec > 1 && nvec < n_ports but
not if nvec >= n_ports?

> +	if (rc < 0)
> +		return rc;
> +
> +	return 1;
> +}
> +
> +static int __ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> +				  struct ahci_host_priv *hpriv)
>  {
>  	int rc, nvec;
>  
> +	nvec = ahci_init_msix(pdev, n_ports, hpriv);
> +	if (nvec > 0)
> +		return nvec;
> +
> +	if (nvec && nvec != -ENOSYS)
> +		dev_err(&pdev->dev, "failed to enable MSI-X: %d", nvec);
> +
>  	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
>  		goto intx;
>  
> @@ -1250,6 +1285,35 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
>  	return 0;
>  }
>  
> +static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
> +{
> +	struct msi_desc *desc;
> +
> +	list_for_each_entry(desc, &dev->msi_list, list) {
> +		if (desc->msi_attrib.entry_nr == entry)
> +			return desc;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> +				struct ahci_host_priv *hpriv)
> +{
> +	struct msi_desc *desc;
> +
> +	__ahci_init_interrupts(pdev, n_ports, hpriv);
> +
> +	if (!pdev->msix_enabled)
> +		return pdev->irq;
> +
> +	desc = msix_get_desc(pdev, 0);	/* first entry */
> +	if (!desc)
> +		return -ENODEV;
> +
> +	return desc->irq;
> +}

Can we please do this properly?  We should be able to move port priv
allocation to host allocaotion time and add and use pp->irq instead,
right?

Thanks.

-- 
tejun

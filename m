Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532429A5;
	Mon,  6 Jan 2025 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138351; cv=none; b=kXqwK4zON/doNsugPyng+Zn5ZuXBbIKGArZxPh8g4Qn/CfxXkYHr3zKBbiV1XX0zl2rqR16VDCRCEeDJFIAIm5RE1r96FWDobBfgLyzLovqS0k+AYqOoW4swuIRvA0RhslVkTUfaZb7YP2TdC6qZUIbgw85vi2ghg/cSsQAL9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138351; c=relaxed/simple;
	bh=dZYW+09VDsRY9zw6cB+RpJxNI8VanUKP+/ALjRAWzIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTkbmyrciTZ5z+F1PH4ezkU3ZVLpEVGLVw3yxXE+ax0NhnOLB9jOK9FrB+DxDMS0Nb9ezLVsVxBmVoA2uE47gBdRSLX+wA2ovhV/8H5tLSSFgSVoh6c5u+MKSCnOQmHvRkzf+MW70phfPvh4Oh/raXXAVrgyO01WrPTH+knLnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRmO5/YS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRmO5/YS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176F3C4CED2;
	Mon,  6 Jan 2025 04:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736138350;
	bh=dZYW+09VDsRY9zw6cB+RpJxNI8VanUKP+/ALjRAWzIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kRmO5/YSNs+f5xrtLf0qyoYlcHg2jDh33IK3BzVoo8u4mwkGLDvX9e0Bx7bEKW9Uk
	 iFD7VENnTufniongcSoXio1RzS498/XOSXZG2EfPe3nFgnhJ6qTpwKyFDs7Smz13W+
	 Bo5OtES2sCtyTiE/hMuxJ9sxhk/HsvewXw55FpA/Fw9QParewr8mRpisgGkNRPYgoI
	 q6y+Q6O6Hu9Rp6DHAudmAYJWv2Y0gJ5TdJFYTUIldCXRz4ZK1yXaae2cn3dOVLpG43
	 Yo+QkGsxMbUJMkhI+A3lE1CIIBCmRdlEuh4d1kndkTbwteyTtIq3PkzsL/MUUI+Nm6
	 zD/DTydho/hzA==
Message-ID: <54d03abd-d948-48f3-a0b4-5b61a10a3efc@kernel.org>
Date: Mon, 6 Jan 2025 13:38:25 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Replace deprecated PCI functions
To: Philipp Stanner <phasta@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <pstanner@redhat.com>
References: <20250102163531.63839-2-phasta@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250102163531.63839-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 1:35 AM, Philipp Stanner wrote:
> From: Philipp Stanner <pstanner@redhat.com>
> 
> struct ata_host.iomap has been created and administrated so far by
> pcim_iomap_table(), a problematic function that has been deprecated in
> commit e354bb84a4c1c ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()")
> 
> Ideally, drivers should not need a global table at all and should store
> ioremaped BARs in their respective structs separately. For ATA, however,
> it's far easier to deprecate pcim_iomap_table() by allocating
> struct ata_host.iomap statically as an array of iomem pointers. Since
> PCI_STD_NUM_BARS is currently defined to be 6, the memory overhead is
> irrelevant.
> 
> Make struct ata_host.iomap a static iomem pointer table.
> 
> Remove all calls to pcim_iomap_table() and pcim_iomap_regions(), and
> fill the aforementioned table directly through pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Overall, looks OK to me. Just a few nits below.

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 093b940bc953..8db14065a256 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1456,10 +1456,9 @@ static int piix_init_sidpr(struct ata_host *host)
>  	    pci_resource_len(pdev, PIIX_SIDPR_BAR) != PIIX_SIDPR_LEN)
>  		return 0;
>  
> -	if (pcim_iomap_regions(pdev, 1 << PIIX_SIDPR_BAR, DRV_NAME))
> -		return 0;
> -
> -	hpriv->sidpr = pcim_iomap_table(pdev)[PIIX_SIDPR_BAR];
> +	hpriv->sidpr = pcim_iomap_region(pdev, PIIX_SIDPR_BAR, DRV_NAME);
> +	if (IS_ERR(hpriv->sidpr))
> +		return PTR_ERR(hpriv->sidpr);

It looks like this hunk is completely independent of the libata-sff changes. So
it should probably go into its own patch.

> @@ -2148,59 +2218,31 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
>   */
>  int ata_pci_sff_init_host(struct ata_host *host)
>  {
> -	struct device *gdev = host->dev;
> -	struct pci_dev *pdev = to_pci_dev(gdev);
> -	unsigned int mask = 0;
> -	int i, rc;
> -
> -	/* request, iomap BARs and init port addresses accordingly */
> -	for (i = 0; i < 2; i++) {
> -		struct ata_port *ap = host->ports[i];
> -		int base = i * 2;
> -		void __iomem * const *iomap;
> +	int ret;
> +	unsigned short port_nr, operational_ports = 0;
> +	struct device *dev = host->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct ata_port *ap;
>  
> +	for (port_nr = 0; port_nr < 2; port_nr++) {
> +		ap = host->ports[port_nr];
>  		if (ata_port_is_dummy(ap))
>  			continue;
>  
> -		/* Discard disabled ports.  Some controllers show
> -		 * their unused channels this way.  Disabled ports are
> -		 * made dummy.
> -		 */
> -		if (!ata_resources_present(pdev, i)) {
> -			ap->ops = &ata_dummy_port_ops;
> -			continue;
> -		}
> -
> -		rc = pcim_iomap_regions(pdev, 0x3 << base,
> -					dev_driver_string(gdev));
> -		if (rc) {
> -			dev_warn(gdev,
> +		ret = ata_pci_sff_obtain_bars(pdev, host, ap, port_nr);
> +		if (ret > 0) {
> +			operational_ports += ret;
> +		} else if (ret < 0) {
> +			dev_warn(dev,
>  				 "failed to request/iomap BARs for port %d (errno=%d)\n",
> -				 i, rc);
> -			if (rc == -EBUSY)
> +				 port_nr, ret);
> +			if (ret == -EBUSY)
>  				pcim_pin_device(pdev);
> -			ap->ops = &ata_dummy_port_ops;

Why remove this ? This is wrong I think as ap->ops will not be set if
ata_pci_sff_obtain_bars() fails.

> -			continue;
>  		}
> -		host->iomap = iomap = pcim_iomap_table(pdev);
> -
> -		ap->ioaddr.cmd_addr = iomap[base];
> -		ap->ioaddr.altstatus_addr =
> -		ap->ioaddr.ctl_addr = (void __iomem *)
> -			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
> -		ata_sff_std_ports(&ap->ioaddr);
> -
> -		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
> -			(unsigned long long)pci_resource_start(pdev, base),
> -			(unsigned long long)pci_resource_start(pdev, base + 1));
> -
> -		mask |= 1 << i;
>  	}
>  
> -	if (!mask) {
> -		dev_err(gdev, "no available native port\n");
> +	if (!operational_ports)
>  		return -ENODEV;
> -	}
>  
>  	return 0;
>  }

[...]

> diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
> index d65c586b5ad0..2dd62317eb4f 100644
> --- a/drivers/ata/pata_hpt3x3.c
> +++ b/drivers/ata/pata_hpt3x3.c
> @@ -215,17 +215,18 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  
>  	/* Everything is relative to BAR4 if we set up this way */
> -	rc = pcim_iomap_regions(pdev, 1 << 4, DRV_NAME);
> +	base = pcim_iomap_region(pdev, 4, DRV_NAME);
> +	rc = PTR_ERR_OR_ZERO(base);
>  	if (rc == -EBUSY)
>  		pcim_pin_device(pdev);
>  	if (rc)
>  		return rc;
> -	host->iomap = pcim_iomap_table(pdev);
> +
>  	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
>  	if (rc)
>  		return rc;
>  
> -	base = host->iomap[4];	/* Bus mastering base */
> +	host->iomap[4] = base;	/* Bus mastering base */

Why move this assignment here ? Let's keep it where "host->iomap" was assigned
before the change.

>  
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
> diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
> index 76a91013d27d..d1edcd504044 100644
> --- a/drivers/ata/pata_ninja32.c
> +++ b/drivers/ata/pata_ninja32.c
> @@ -116,13 +116,14 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  	rc = pcim_enable_device(dev);
>  	if (rc)
>  		return rc;
> -	rc = pcim_iomap_regions(dev, 1 << 0, DRV_NAME);
> +
> +	base = pcim_iomap_region(dev, 0, DRV_NAME);
> +	rc = PTR_ERR_OR_ZERO(base);
>  	if (rc == -EBUSY)
>  		pcim_pin_device(dev);
>  	if (rc)
>  		return rc;
>  
> -	host->iomap = pcim_iomap_table(dev);

Same here. Replace this with "host->iomap[0] = base;".

>  	rc = dma_set_mask_and_coherent(&dev->dev, ATA_DMA_MASK);
>  	if (rc)
>  		return rc;
> @@ -130,9 +131,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	/* Set up the register mappings. We use the I/O mapping as only the
>  	   older chips also have MMIO on BAR 1 */
> -	base = host->iomap[0];
> -	if (!base)
> -		return -ENOMEM;
> +	host->iomap[0] = base;
>  	ap->ops = &ninja32_port_ops;
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS;
> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
> index 6820c5597b14..360b8d7e08bf 100644
> --- a/drivers/ata/pata_pdc2027x.c
> +++ b/drivers/ata/pata_pdc2027x.c
> @@ -702,17 +702,16 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
>  	if (rc)
>  		return rc;
>  
> -	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
> -	if (rc)
> -		return rc;
> -	host->iomap = pcim_iomap_table(pdev);
> +	mmio_base = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
> +	if (IS_ERR(mmio_base))
> +		return PTR_ERR(mmio_base);
> +

No need for this blank line.

> +	host->iomap[PDC_MMIO_BAR] = mmio_base;
>  
>  	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
>  	if (rc)
>  		return rc;
>  
> -	mmio_base = host->iomap[PDC_MMIO_BAR];
> -
>  	for (i = 0; i < 2; i++) {
>  		struct ata_port *ap = host->ports[i];
>  
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index abe64b5f83cf..8a17df73412e 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -360,15 +360,16 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	/* Try to acquire MMIO resources and fallback to PIO if
>  	 * that fails
>  	 */
> -	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
> -	if (rc)
> +	mmio_base = pcim_iomap_region(pdev, SIL680_MMIO_BAR, DRV_NAME);
> +	if (IS_ERR(mmio_base)) {
> +		rc = PTR_ERR(mmio_base);
>  		goto use_ioports;
> +	}
>  
>  	/* Allocate host and set it up */
>  	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
>  	if (!host)
>  		return -ENOMEM;
> -	host->iomap = pcim_iomap_table(pdev);
>  
>  	/* Setup DMA masks */
>  	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
> @@ -376,8 +377,8 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	/* Get MMIO base and initialize port addresses */
> -	mmio_base = host->iomap[SIL680_MMIO_BAR];
> +	/* Set MMIO base in table and initialize port addresses */
> +	host->iomap[SIL680_MMIO_BAR] = mmio_base;

Same. Keep this assignment where "host->iomap = ..." was. And I think the
comment here can now be reduced to "/* Initialize port addresses. */"

>  	host->ports[0]->ioaddr.bmdma_addr = mmio_base + 0x00;
>  	host->ports[0]->ioaddr.cmd_addr = mmio_base + 0x80;
>  	host->ports[0]->ioaddr.ctl_addr = mmio_base + 0x8a;

[...]

> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index 2df1a070b25a..0f98e784fbe7 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
> @@ -1163,12 +1163,12 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
>  	if (rc)
>  		return rc;
>  
> -	rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
> +	host_mmio = pcim_iomap_region(pdev, PDC_MMIO_BAR, DRV_NAME);
> +	rc = PTR_ERR_OR_ZERO(host_mmio);
>  	if (rc == -EBUSY)
>  		pcim_pin_device(pdev);
>  	if (rc)
>  		return rc;
> -	host_mmio = pcim_iomap_table(pdev)[PDC_MMIO_BAR];
>  
>  	/* determine port configuration and setup host */
>  	n_ports = 2;
> @@ -1193,7 +1193,7 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
>  		return -ENOMEM;
>  	spin_lock_init(&hpriv->hard_reset_lock);
>  	host->private_data = hpriv;
> -	host->iomap = pcim_iomap_table(pdev);
> +	host->iomap[PDC_MMIO_BAR] = host_mmio;

Maybe it is better to keep this together with the pcim_iomap_region() hunk above ?

> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 3a99f66198a9..9935eb61a694 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -751,18 +751,18 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> -	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
> +	mmio_base = pcim_iomap_region(pdev, SIL_MMIO_BAR, DRV_NAME);
> +	rc = PTR_ERR_OR_ZERO(mmio_base);
>  	if (rc == -EBUSY)
>  		pcim_pin_device(pdev);
>  	if (rc)
>  		return rc;
> -	host->iomap = pcim_iomap_table(pdev);
>  
>  	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
>  	if (rc)
>  		return rc;
>  
> -	mmio_base = host->iomap[SIL_MMIO_BAR];
> +	host->iomap[SIL_MMIO_BAR] = mmio_base;

Why move this assignment here ? Let's keep it where it was, before
dma_set_mask_and_coherent().



-- 
Damien Le Moal
Western Digital Research

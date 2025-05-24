Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5A23BE;
	Sat, 24 May 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748090190; cv=none; b=BzHg/Qemm/x+2NdI+2efPxvxcpMb/09iXTLh2BzxqDmIlCtVEeZR3in6AC7DjVFNG+b/uT5kiip8HCSz+uBO0nG3ZoLVSk6g/Lr11hxlAJcRA4FYXuW8cwroAmyFQgIEnPOwHbl0STn93djNF4ZF5C6gNgiRxkYpUiORd69qJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748090190; c=relaxed/simple;
	bh=/ShlOcbmdH3cPeRgc07WtfreI/Abuzcg8JCDKrm2CeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pde0cEmtQ9W/xqcMH7L8wzp+elVRJ3mm7ZRv+vsnxWpRUZ0poNx+w0RpWHk4gW79cPRN7NPCbKa1Q1BBpl0RDyMH+ufp1zWPHVcLG3UuAsA5xi8CTB88p0Ncntr1+LQhfRoD4oL/2WYA+MixZG6H+IOG9bg8br0n2SzpmWHlKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCK3v5Q5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCK3v5Q5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8880BC4CEE4;
	Sat, 24 May 2025 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748090189;
	bh=/ShlOcbmdH3cPeRgc07WtfreI/Abuzcg8JCDKrm2CeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NCK3v5Q5IKbcApfPyal+ZkTpvUjXGw6Cp1tikqwDCYGZNn5FLQYORFCbw75z6J0M8
	 /p439mQmqmtrtptPrs1VSpllRnG+9BWDnFx/9sFy5NixHLuTzvwl5F7OZfn53B6OKo
	 9cfKyuGH46j/0iGehqkyJkLOaqDvJb/qH/Co1iFZbFYiJjV24OOQt5yG6Lpdy/q0EK
	 SCqCcEx7ewTsDokdTChWQXULP+4sflN/2SFUETBIC55bc5gEi3Hnu/5OKx4Jcwwz4Y
	 aICTcmeAgddR5vcRBUzc19sbSgfwQcBgNqo/vBXRjPy5LuhopFugXZdrvQMhlzPp+T
	 cueAOyZYsn7Kw==
Message-ID: <7533f274-dcc9-42a5-9e5a-74019255fd3c@kernel.org>
Date: Sat, 24 May 2025 14:36:24 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ahci: enhance error handling in ahci_init_one
To: Alexander Roman <monderasdor@gmail.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <f2db43ab-97d0-4731-9b51-18876f342b42@kernel.org>
 <20250522102653.1169-1-monderasdor@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250522102653.1169-1-monderasdor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 12:26, Alexander Roman wrote:
> Add comprehensive error handling to ahci_init_one() to:
> 1. Prevent resource leaks during initialization failures
> 2. Ensure proper cleanup of allocated resources
> 3. Provide detailed error reporting for debugging
> 4. Maintain consistent error handling patterns
> 
> Key changes:
> - Initialize all pointers to NULL
> - Add centralized error handling via goto labels
> - Improve error messages with specific error codes
> - Remove duplicate Intel PCS quirk call
> - Adjust log levels (dev_err for fatal, dev_dbg for quirks)
> 
> Signed-off-by: Alexander Roman <monderasdor@gmail.com>

I received 2 x v3 patches with different commit messages and titles, but these 2
patches touch the same code.. Very confusing...
Which one is the "correct" patch you want us to consider ?

And please send patches to *all* maintainers of the subsystem.
You can check that with "scripts/get_maintainer.pl driver/ata"
(you are missing Niklas).

Note: it is too late to apply this patch anyway. If accepted, it will go in
during 6.16-rc1. So no rush to clean this up. Take your time and make a proper
patch please.


> ---
>  drivers/ata/ahci.c | 98 ++++++++++++++++++++++++++--------------------
>  1 file changed, 55 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index abc1234..def5678 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1611,7 +1611,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	struct ahci_host_priv *hpriv = NULL;
>  	struct ata_host *host = NULL;
>  	void __iomem *mmio = NULL;
> -	int n_ports, i, rc;
> +	int n_ports, i, rc = -ENOMEM;
>  	u32 tmp, cap, port_map;
>  	u32 saved_cap;
>  	struct device *dev = &pdev->dev;
> @@ -1619,60 +1619,72 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	VPRINTK("ahci_init_one enter\n");
>  
>  	rc = pcim_enable_device(pdev);
> -	if (rc)
> -		return rc;
> +	if (rc) {
> +		dev_err(dev, "failed to enable PCI device (err=%d)\n", rc);
> +		goto err_out;
> +	}
>  
>  	rc = pcim_iomap_regions(pdev, 1 << AHCI_PCI_BAR_STANDARD, DRV_NAME);
> -	if (rc)
> -		return rc;
> +	if (rc) {
> +		dev_err(dev, "failed to map PCI regions (err=%d)\n", rc);
> +		goto err_out;
> +	}
>  	mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR_STANDARD];
>  
>  	rc = pci_alloc_irq_vectors(pdev, 1, AHCI_MAX_PORTS, PCI_IRQ_ALL_TYPES);
> -	if (rc < 0)
> -		return rc;
> +	if (rc < 0) {
> +		dev_err(dev, "failed to allocate IRQ vectors (err=%d)\n", rc);
> +		goto err_out;
> +	}
>  
>  	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
> -	if (!hpriv)
> -		return -ENOMEM;
> +	if (!hpriv) {
> +		dev_err(dev, "failed to allocate host private data\n");
> +		goto err_out;
> +	}
>  
>  	hpriv->mmio = mmio;
>  	hpriv->flags = (unsigned long)ent->driver_data;
>  	hpriv->irq = pdev->irq;
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> -		ahci_intel_pcs_quirk(pdev, hpriv);
> +		rc = ahci_intel_pcs_quirk(pdev, hpriv);
> +		if (rc)
> +			dev_dbg(dev, "Intel PCS quirk failed (err=%d)\n", rc);
>  	}
>  
>  	ahci_get_port_map_mask(dev, hpriv);
>  
>  	rc = ahci_pci_save_initial_config(pdev, hpriv);
> -	if (rc)
> -		return rc;
> +	if (rc) {
> +		dev_err(dev, "failed to save initial config (err=%d)\n", rc);
> +		goto err_out;
> +	}
>  
>  	cap = hpriv->cap;
>  	saved_cap = cap;
>  	port_map = hpriv->port_map;
>  	n_ports = ahci_calc_n_ports(cap, port_map);
>  
>  	host = ata_host_alloc_pinfo(dev, ahci_port_info + ent->driver_data, n_ports);
> -	if (!host)
> -		return -ENOMEM;
> +	if (!host) {
> +		dev_err(dev, "failed to allocate ATA host\n");
> +		goto err_out;
> +	}
>  
>  	host->private_data = hpriv;
>  
>  	rc = ahci_configure_dma_masks(pdev, hpriv);
> -	if (rc)
> -		return rc;
> +	if (rc) {
> +		dev_err(dev, "failed to configure DMA masks (err=%d)\n", rc);
> +		goto err_host;
> +	}
>  
>  	ahci_pci_init_controller(host);
>  	rc = ahci_reset_controller(host);
> -	if (rc)
> -		return rc;
> -
> -	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> -		ahci_intel_pcs_quirk(pdev, hpriv);
> +	if (rc) {
> +		dev_err(dev, "failed to reset controller (err=%d)\n", rc);
> +		goto err_host;
>  	}
>  
>  	if (ahci_broken_system_poweroff(pdev)) {
> @@ -1685,20 +1697,20 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  
>  	if (is_mcp89_apple(pdev)) {
> -		ahci_mcp89_apple_enable(pdev);
> +		rc = ahci_mcp89_apple_enable(pdev);
> +		if (rc)
> +			dev_warn(dev, "Apple MCP89 enable failed (err=%d)\n", rc);
>  	}
>  
> -	acer_sa5_271_workaround(hpriv, pdev);
> -
>  	ahci_init_irq(pdev, n_ports, hpriv);
>  	ahci_pci_enable_interrupts(host);
>  
>  	ahci_pci_print_info(host);
>  
>  	rc = ata_host_activate(host, hpriv->irq, ahci_interrupt, IRQF_SHARED,
> -			       &ahci_sht);
> -	if (rc)
> -		return rc;
> -
> -	return 0;
> +			      &ahci_sht);
> +	if (rc) {
> +		dev_err(dev, "failed to activate ATA host (err=%d)\n", rc);
> +		goto err_host;
> +	}
>  }
> 


-- 
Damien Le Moal
Western Digital Research

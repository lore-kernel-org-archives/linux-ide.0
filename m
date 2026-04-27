Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420F3B6348
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292062; cv=none; b=Hjho2Dh7KnAOX5PZf8Fy1UDratuSWOVP6C7rHmCmb4B/bTwLJB9pB8Pp4++/WscZOHPKjy80Jte1R6PenNlICOYWvdHhqrNSF/QcAtxjvH5iGfPlhEHsHqFMSeEZj2yufFBgGRCy3OfUIUoJdg3VX0uKeFBkKOvvFx1IbCH50GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292062; c=relaxed/simple;
	bh=DY4KEJNZ+0pmsiXVAcMHRaYvbm7DX81+y4zKcnRGmEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSoi5VkuPHf2rIxFZN1Gr4EeLfym5fzfPRNl42s3iy1eqUtlwgFHoNjZ5zXfyA1viQo/dCkcP2EI1TlevZ1YCue/5y2UZDZszNIHK0ket2/AzgIxoiRHnWTs1fx0yT/zBgMn4C/CfZdh1MsHdCtV30x75zkRF+Hno+CK4ORIuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1zV+2Yp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1zV+2Yp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE63C19425;
	Mon, 27 Apr 2026 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777292062;
	bh=DY4KEJNZ+0pmsiXVAcMHRaYvbm7DX81+y4zKcnRGmEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1zV+2Ypy2dGtx+/OlfWe9QGXI0tZteDzqn1Vz30Ht39hcEGHbPElRHuethgbSjSh
	 0FCEWqOkuTIbUDdR0PgYUg0Hnj4Ejjdpy4vAWLqebMW6t4V3aMLbnUHFvzCKz44dbT
	 +HJeaaqs903N9IFjRyvlzapv62D5nOGii5Lv4etkXkWzR5oYaajnIYE6igBRxZvvBW
	 SAIQ9pjDTWQykyrZzcOZhFqiS6t+GIdMTr6u9CUFLD3nBs5uioqRdextQ4c0/b8Txb
	 GJYxmqJsuq4B1c7df4qptLJiu0knlOvCOs4uV/0rAUKbni2kfX3inGl1DKn5QFcI1t
	 U8mjm+iFY7SVw==
Date: Mon, 27 Apr 2026 14:14:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dayou5941@163.com
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, liyouhong@kylinos.cn
Subject: Re: [PATCH v4] ata: ahci: fail probe if BAR too small for claimed
 ports
Message-ID: <ae9TGoaQAi7dOVc0@ryzen>
References: <20260427060546.1407439-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427060546.1407439-1-dayou5941@163.com>

On Mon, Apr 27, 2026 at 02:05:46PM +0800, dayou5941@163.com wrote:
> From: Youhong Li <liyouhong@kylinos.cn>
> 
> When an AHCI controller is disabled in BIOS, its HOST_CAP register may
> contain invalid values (e.g., 0xFFFFFFFF) indicating an impossibly large
> number of ports. If CAP.NP claims more ports than can physically fit
> within the mapped BAR region, accessing port registers beyond the BAR
> boundary causes a kernel panic.
> 
> Add validation in ahci_init_one() to check that the BAR size is
> sufficient for the number of ports claimed in CAP.NP. The check
> calculates the required MMIO size as:
> 
>   required_size = 0x100 (global registers) + max_ports * 0x80
> 
> If required_size exceeds the actual BAR size, the probe fails with
> -ENODEV, preventing the panic and providing a clear error message.
> 
> This solution follows the suggestion by Damien Le Moal and Niklas Cassel
> to detect and reject obviously broken controller configurations early.
> 
> Reported-by: liyouhong <liyouhong@kylinos.cn>
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Complete rewrite based on community feedback
> - Move check from libahci.c to ahci.c
> - Fail probe early instead of attempting to work around invalid state
> - Implement BAR size validation as suggested
> 
> v3:
> - Fix patch format: add "---" separator and move changelog to correct location
> - Change dev_err to dev_warn as suggested
> 
> v4:
> - Break long lines as suggested by Damien
> - Keep complete changelog history
> 
> ---
>  drivers/ata/ahci.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1d73a53370cf..c04bee682605 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1888,6 +1888,25 @@ static ssize_t remapped_nvme_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(remapped_nvme);
>  
> +static int ahci_validate_bar_size(struct pci_dev *pdev, void __iomem *mmio)

static int ahci_validate_bar_size(struct pci_dev *pdev, int bar, struct ahci_host_priv *hpriv)


> +{
> +	u32 cap = readl(mmio + HOST_CAP);

readl(hpriv->mmio, HOST_CAP);


> +	unsigned int max_ports = ahci_nr_ports(cap);
> +	u32 last_port_end = 0x100 + (max_ports * 0x80);
> +	resource_size_t bar_size =
> +		pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);

pci_resource_len(pdev, bar);


> +
> +	if (last_port_end > bar_size) {
> +		dev_warn(&pdev->dev,
> +			 "BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",

"BAR%d too small for %u ports (last port ends at %#x, BAR %pa)\n", bar,


> +			 max_ports, last_port_end,
> +			 (unsigned long long)bar_size);

Print resource_size_t as %pa instead of casting to unsigned long long
and pass bar_size by reference (&bar_size):
https://docs.kernel.org/core-api/printk-formats.html#physical-address-types-phys-addr-t


> +		return -ENODEV;

return -EIO;


> +	}
> +
> +	return 0;
> +}
> +
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	unsigned int board_id = ent->driver_data;
> @@ -1988,6 +2007,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (!hpriv->mmio)
>  		return -ENOMEM;
>  
> +	rc = ahci_validate_bar_size(pdev, hpriv->mmio);

Please let this function be called with the arguments:

ahci_validate_bar_size(pdev, ahci_pci_bar, hpriv);

Such that it takes the same arguments as ahci_remap_check().


Kind regards,
Niklas


> +	if (rc)
> +		return rc;
> +
>  	/* detect remapped nvme devices */
>  	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
>  
> -- 
> 2.25.1
>

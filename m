Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C813DBA0
	for <linux-ide@vger.kernel.org>; Sun, 26 Apr 2026 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777247181; cv=none; b=V8X0shL7uLZA7g5WBF1nk7FepCZZ2yLEBb9Heyr5rQB7XDZh7scf5HefVQSi3/4Uv4jceG+v0QaUShurBIp+c+UUvfAbRt19CDQ3ur5GUMXv3B8ydKGRMPueLprrGQYwlahf/KqVyGVdM5A7rfXz5J0tSSVchwANYYmyNevXZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777247181; c=relaxed/simple;
	bh=E++IHz+Oen5Zvx8FkZOcAkMPCaLKOL0/h4P8XY+nw7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsmpUomtxS4OJW+CKjNMkGysVRiZrCQdP6cdRSIOch6rAMNVwboYHFRHHMQDi35/tUzkIpYbnNOMPS6tuWZY3ngjyTg/Q3+KDXiyr9aJrzmyS+CZ+HulJk5J1o7EhcuP6gRtXBFmqpPBUaRIRR4Ru/4LqFRiZsI1IMQ3zkdoaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB6dzE4J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB6dzE4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD65C2BCAF;
	Sun, 26 Apr 2026 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777247180;
	bh=E++IHz+Oen5Zvx8FkZOcAkMPCaLKOL0/h4P8XY+nw7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DB6dzE4JMiikMMdso+MHmvj4T90IbyeDOPGBoVXKQ0tmwNeX7w4AhON4heH2HQppb
	 nLBsseMQ40Mc3mL9BWcP9yngtgmiEYSHOabvBSHly1YC6yiBQ+/r2yZ9PWtvp9sMQ/
	 1N25i3zVMHh++v/k15TuPt6YQSSXZERM3qElhJ0dyS7/wR3u/WUpJxT62pwAQTt5GY
	 0PvlHmLhHr+nVP9oIOxlat5pAUnUtu8glzCXgF55PLxRquyC76PeOB0u8vLLvsyhbq
	 j4MUxVpQTtkXqy95DHRY91ZGHu7FRxLMxsLD7X52Ah0yDWPwS7jvjpTm8fJw9+0Yf1
	 4+m9oCM1QjZmA==
Message-ID: <75618383-ad2b-4b58-97d1-250be32a4bea@kernel.org>
Date: Mon, 27 Apr 2026 08:46:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: fail probe if BAR too small for claimed
 ports
To: dayou5941@163.com, linux-ide@vger.kernel.org
Cc: damien.lemoal@opensource.wdc.com, niklas.soderlund@corigine.com,
 liyouhong@kylinos.cn
References: <20260425065509.733544-1-dayou5941@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260425065509.733544-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 3:55 PM, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
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
> v2:
> - Complete rewrite based on community feedback
> - Move check from libahci.c to ahci.c
> - Fail probe early instead of attempting to work around invalid state
> - Implement BAR size validation as suggested
> 
> Reported-by: liyouhong <liyouhong@kylinos.cn>
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Suggested-by: Niklas Cassel <niklas.soderlund@corigine.com>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>

Your patch is not formatted correctly: the changelog should not be part of the
commit message but should come between the "---" separator after the tags and
the first "diff" line of the patch proper. The "---" separator is missing here
too. Did you generate this patch with "git format-patch" ?

> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1d73a53370cf..09026ea12cde 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1888,6 +1888,23 @@ static ssize_t remapped_nvme_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(remapped_nvme);
>  
> +static int ahci_validate_bar_size(struct pci_dev *pdev, void __iomem *mmio)
> +{
> +	u32 cap = readl(mmio + HOST_CAP);
> +	unsigned int max_ports = ahci_nr_ports(cap);
> +	u32 last_port_end = 0x100 + (max_ports * 0x80);
> +	resource_size_t bar_size = pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);
> +
> +	if (last_port_end > bar_size) {

It may be good to check also that max_ports is not zero here.

> +		dev_err(&pdev->dev,
> +			"AHCI: BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",
> +			max_ports, last_port_end, (unsigned long long)bar_size);

Please make this a warning (dev_warn()).

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	unsigned int board_id = ent->driver_data;
> @@ -1988,6 +2005,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (!hpriv->mmio)
>  		return -ENOMEM;
>  
> +	rc = ahci_validate_bar_size(pdev, hpriv->mmio);
> +	if (rc)
> +		return rc;
> +
>  	/* detect remapped nvme devices */
>  	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
>  


-- 
Damien Le Moal
Western Digital Research

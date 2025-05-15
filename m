Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15299299AAB
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313777; cv=none; b=hNOwGwDF3Tgl1R1z6cLL8bOnZhYv4l5EFPr4QbhHJJArJZeg8bPuF+D/pKZoXE9lk7yGG4Oask4liID2rT8RymDO/RaH7VNOPHwGOXs4dF9ODXgNbJjbK/rlvD4/ZTtTR5+NFl4HJ2Y1TGt+rgzp86ZchzdOcbCysfgZLnZbIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313777; c=relaxed/simple;
	bh=m+3N42XUCoK2XePX/f0fxxS9eQAlumMc42G6q8RW4cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqh4N1jfh86TZXTYv0D3YiKahvqg2iy5eokp/vyCYBHD5SQODWZ6yB6usYnJ1EYfsuDNZ1KZKleI01M/qAIFT9kCJGK7CZVGYmXot+dJyH26JOby7vnhFy6UAdEO+U6qo/ZagFsXOve5OBPOx7riLA1FEdsM56YSSUIqyX6hMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtViJkS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtViJkS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC6FC4CEF1;
	Thu, 15 May 2025 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313774;
	bh=m+3N42XUCoK2XePX/f0fxxS9eQAlumMc42G6q8RW4cE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VtViJkS9N9p6aM1kl6jj2Ls8nOF4K2bBeCyXObxpAr5JIaLYpo2W9Fi6SIe6BwxDb
	 nSDJoJi7/DXy49ABjfTi2hR80M286lPNgkUcCA3s3PEIDw2YY8LoYdyh8GEcqyHMiE
	 SCJBe7esywGMKlmJ4K39JNWfJmXdMFNEoqWEpojCbx7N7ymjvbQ+uByOGAYlQo8AgT
	 M1IC8KxKY1DwQEqm7yQXxmR/Yg1oeYW25MQx8Hb2kNGjrqNIU2Pkjq+U+Hiw1b0EjC
	 72SI8EB9sex4dHSZ9fc+ztx/e0lyUg4BSVEValwr53sQtfxsR25TSvDl9HWbaCnDFi
	 SFRJhKzke+oCQ==
Message-ID: <fd7cb42f-86d4-41cd-92dc-7912fc66b3e9@kernel.org>
Date: Thu, 15 May 2025 14:56:10 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-acpi: Do not assume 40 wire cable if no
 devices are enabled
To: Tasos Sahanidis <tasos@tasossah.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250514182939.151081-1-tasos@tasossah.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250514182939.151081-1-tasos@tasossah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 20:29, Tasos Sahanidis wrote:
> On at least an ASRock 990FX Extreme 4 with a VIA VT6330, the devices
> have not yet been enabled by the first time ata_acpi_cbl_80wire() is
> called. This means that the ata_for_each_dev loop is never entered,
> and a 40 wire cable is assumed.
> 
> The VIA controller on this board does not report the cable in the PCI
> config space, thus having to fall back to ACPI even though no SATA
> bridge is present.
> 
> The _GTM values are correctly reported by the firmware through ACPI,
> which has already set up faster transfer modes, but due to the above
> the controller is forced down to a maximum of UDMA/33.
> 
> Resolve this by returning EAGAIN in ata_acpi_cbl_80wire() if no devices
> have been detected and modify pata_via to handle this scenario.
> 
> First, an unknown cable is assumed which preserves the mode set by the
> firmware, and then on subsequent calls when the devices have been
> enabled, an 80 wire cable is correctly detected.
> 
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> ---
>  drivers/ata/libata-acpi.c | 11 ++++++++---
>  drivers/ata/pata_via.c    | 13 ++++++++++---
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index b7f0bf795521..c508a19c2495 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -523,6 +523,7 @@ EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
>  int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
>  {
>  	struct ata_device *dev;
> +	int ret = -EAGAIN;

See below, but adding:

	gtm = ata_acpi_init_gtm(ap);
	if (!gtm)
		return ATA_CBL_PATA40;

would be an additional nice cleanup.

>  
>  	ata_for_each_dev(dev, &ap->link, ENABLED) {
>  		unsigned int xfer_mask, udma_mask;
> @@ -530,11 +531,15 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
>  		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
>  		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
>  
> -		if (udma_mask & ~ATA_UDMA_MASK_40C)
> -			return 1;
> +		ret = 0;
> +
> +		if (udma_mask & ~ATA_UDMA_MASK_40C) {
> +			ret = 1;
> +			break;
> +		}
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
>  
> diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
> index 696b99720dcb..4d03b4a1ea4d 100644
> --- a/drivers/ata/pata_via.c
> +++ b/drivers/ata/pata_via.c
> @@ -182,6 +182,7 @@ static int via_cable_detect(struct ata_port *ap) {
>  	const struct via_isa_bridge *config = ap->host->private_data;
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	u32 ata66;
> +	const struct ata_acpi_gtm *gtm;
>  
>  	if (via_cable_override(pdev))
>  		return ATA_CBL_PATA40_SHORT;
> @@ -202,9 +203,15 @@ static int via_cable_detect(struct ata_port *ap) {
>  	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
>  		return ATA_CBL_PATA80;
>  	/* Check with ACPI so we can spot BIOS reported SATA bridges */
> -	if (ata_acpi_init_gtm(ap) &&
> -	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
> -		return ATA_CBL_PATA80;
> +	gtm = ata_acpi_init_gtm(ap);
> +	if (gtm) {
> +		int cbl = ata_acpi_cbl_80wire(ap, gtm);

While at it, maybe change ata_acpi_cbl_80wire() returns ATA_CBL_PATA_UNK,
ATA_UDMA_MASK_40C or ATA_CBL_PATA80, and rename that function to something like:

ata_acpi_cbl_pata_type()

The call to ata_acpi_init_gtm() can also go into that function, thus removing
the gtm argument.

With that, this big ugly hunk would become:

	return ata_acpi_cbl_pata_type(ap);

> +
> +		if (cbl < 0)
> +			return ATA_CBL_PATA_UNK;
> +		else if (cbl == 1)
> +			return ATA_CBL_PATA80;
> +	}
>  	return ATA_CBL_PATA40;
>  }
>  


-- 
Damien Le Moal
Western Digital Research

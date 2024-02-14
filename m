Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C777F
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869633; cv=none; b=HBvJ38oRZEGvMHG8AW6L/9bV538cqhnEUqdFwwzo6Sem2sIycHpNCE5AAN5QGtNJ9eyVrJ0LLL2b4Otvys1kajb5GmruViBEBskvDNqBIeXZauNTeW7xikMHP2oscuGkcy0LB451wPoeKL3SbQ1OCqG2F7hE0sa0HjbyzGyzOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869633; c=relaxed/simple;
	bh=EN1XvGAWPhOeHD4xsERndFfpJYGI2Paai+cL4XFd4AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpUHqvRcia986NrLahde9VIfH/qT93Rd3LLIkDkoTnIfETZAGkmJnQY/ky0YAf4SPXAmdZKWAMbfUyxp8d2xNCjYKWNjKLN1xzsM2tPe6jlW1PrpXNSDoCd37DgXFpx0OWc5F2gtWsW760IV1YBRweHocMZ5VAqKULb6XdKidY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtFl87LN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtFl87LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01706C433F1;
	Wed, 14 Feb 2024 00:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707869633;
	bh=EN1XvGAWPhOeHD4xsERndFfpJYGI2Paai+cL4XFd4AI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dtFl87LNq5kvAI9gziP0p0YPxZn6U7k69nQk4G/3bVVJEkZkbn6eTdcOM3vcni1Gg
	 lM1M17GwRI8GQ39/1JEqhSfzE8Vl7mq6eW6MhKr4LcRbgp/ken4Utsg7xeuCqRxi85
	 PbaDNuF3diIgdRK9WQh1jqLcahSsQhc7fEn4swZIexJlymAwxYkc7OhF2FHt6XWPDq
	 nrIxnbxiq3BhzvVyLfFJupNbi/1V/1eSE8Iu804P/lfmgvC0B6V236uSNo5z9Rw2/V
	 5jWlgSDU9IMJyP7bLRGL5lcdYd3128JdQJZpTpu351FThkhFET8IQjcO2GrvJ84o/9
	 0Fye5wc5Fxtpw==
Message-ID: <2deaf71c-2736-4b9d-9b4a-44f96af774ef@kernel.org>
Date: Wed, 14 Feb 2024 09:13:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ahci: clean up ahci_broken_devslp quirk
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
References: <20240213130733.819524-1-cassel@kernel.org>
 <20240213130733.819524-3-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240213130733.819524-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 22:07, Niklas Cassel wrote:
> Most quirks are applied using a specific board type board_ahci_no*
> (e.g. board_ahci_nomsi, board_ahci_noncq), which then sets a flag
> representing the specific quirk.
> 
> ahci_pci_tbl (which is the table of all supported PCI devices), then
> uses that board type for the PCI vendor and device IDs which need to
> be quirked.
> 
> The ahci_broken_devslp quirk is not implemented in this standard way.
> 
> Modify the ahci_broken_devslp quirk to be implemented like the other
> quirks. This way, we will not have the same PCI device and vendor ID
> scattered over ahci.c. It will simply be defined in a single location.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c28ad3f4b59e..1e1533d01803 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -51,6 +51,7 @@ enum board_ids {
>  	board_ahci_43bit_dma,
>  	board_ahci_ign_iferr,
>  	board_ahci_no_debounce_delay,
> +	board_ahci_no_devslp_pcs_quirk,
>  	board_ahci_nomsi,
>  	board_ahci_noncq,
>  	board_ahci_nosntf_pcs_quirk,
> @@ -151,6 +152,14 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> +	[board_ahci_no_devslp_pcs_quirk] = {
> +		AHCI_HFLAGS	(AHCI_HFLAG_NO_DEVSLP |
> +				 AHCI_HFLAG_INTEL_PCS_QUIRK),
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
>  	[board_ahci_nomsi] = {
>  		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>  		.flags		= AHCI_FLAG_COMMON,
> @@ -420,7 +429,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci_pcs_quirk }, /* Comet Lake-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci_pcs_quirk }, /* Comet Lake PCH-V RAID */
>  	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_no_devslp_pcs_quirk }, /* Bay Trail AHCI */

Same nit as the previous patch: let's name this board_ahci_pcs_quirk_no_devslp.

With that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

>  	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_pcs_quirk }, /* Cherry Tr. AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_pcs_quirk }, /* ApolloLake AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_pcs_quirk }, /* Ice Lake LP AHCI */
> @@ -1420,17 +1429,6 @@ static bool ahci_broken_online(struct pci_dev *pdev)
>  	return pdev->bus->number == (val >> 8) && pdev->devfn == (val & 0xff);
>  }
>  
> -static bool ahci_broken_devslp(struct pci_dev *pdev)
> -{
> -	/* device with broken DEVSLP but still showing SDS capability */
> -	static const struct pci_device_id ids[] = {
> -		{ PCI_VDEVICE(INTEL, 0x0f23)}, /* Valleyview SoC */
> -		{}
> -	};
> -
> -	return pci_match_id(ids, pdev);
> -}
> -
>  #ifdef CONFIG_ATA_ACPI
>  static void ahci_gtf_filter_workaround(struct ata_host *host)
>  {
> @@ -1823,10 +1821,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  				&dev_attr_remapped_nvme.attr,
>  				NULL);
>  
> -	/* must set flag prior to save config in order to take effect */
> -	if (ahci_broken_devslp(pdev))
> -		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
> -
>  #ifdef CONFIG_ARM64
>  	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
>  	    pdev->device == 0xa235 &&

-- 
Damien Le Moal
Western Digital Research


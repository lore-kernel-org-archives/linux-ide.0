Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6062AF06;
	Mon,  9 Sep 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867501; cv=none; b=bQLvhFwTAWu8FwxAW62uZWD0muU06FdggGIq7CoGD/3qTNMzJjDPqgHILHV0dXXoNsNqQdDF8Ze/LNEPgRkRlMfm41Y4nDMTcZdnSveJlulbYsZDIBXT+3DAeiqaWuzhFCBK0x/Oz/m+exWWu6V5x/v8RfNeLLiI82HS/b6ZeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867501; c=relaxed/simple;
	bh=hH4XLLH17eOVfK8CkcW92Eg0J7wEMDq68Etv805TWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3ZydNaLq2iNedzyD32CSPxmj9W01zOeVQVjqZ2pg/rTQSXnOgZvFdgFTC3OGyQ6WBdzWHOkUZcckMg3T6Q9nqgwkJKl2ou3Y2RXhAPueRmMp9CBru6PbTfaqfN+fwse0VggUTO1Bvl41DZ4fzBSK0a5VGpaTMaD6mtx7+Xk2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmG5r6ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmG5r6ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A739C4CEC5;
	Mon,  9 Sep 2024 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867500;
	bh=hH4XLLH17eOVfK8CkcW92Eg0J7wEMDq68Etv805TWfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmG5r6eizOzHl+Uj11VwQaIju/3C2DuvifKP3BTJveGB3asp5gUn5hPrSLORiaLLL
	 QWBEgE/I966kd6rEhCrQBHv9jRFS4TpjBVqLY7w7GG7pLhRW3j7thsYYi/++Ehpp6n
	 leg+bCbvI1h73xlDx9rmXmpABkGhOcBjGRXi/hRnnPBGqTU9ztywwQw+UfPFjMXI+F
	 PHcVWV6bkEr++VAiSqJUUw56wCXzOo6QpqBu5T08EZI9XrkKB8xNZ3qNRvHKGxvxIE
	 c7/I5SEWnkikJV/dAiM2R3GRhMNqESRCpaBsF93fqX7EfkZwTOFvOHU8z9RAXekIt5
	 HwMIAxZRrsVmQ==
Date: Mon, 9 Sep 2024 09:38:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ahci: Marvell controllers prefer DMA for ATAPI
Message-ID: <Zt6l6DVeDGzb5W7N@ryzen.lan>
References: <20240908094604.433035-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908094604.433035-1-chenhuacai@loongson.cn>

On Sun, Sep 08, 2024 at 05:46:04PM +0800, Huacai Chen wrote:
> We use Marvell CD/DVD controllers on many Loongson-based machines. We
> found its PIO doesn't work well, and on the opposite its DMA seems work
> very well. We don't know the detail of the controller, but we can set
> the ATA_FLAG_ATAPI_DMA and ATA_HORKAGE_ATAPI_MOD16_DMA flags on these
> controllers to prefer ATAPI DMA.
> 
> BTW, return -EOPNOTSUPP instead of 1 if ATAPI DMA is not supported in
> atapi_check_dma().
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/ata/ahci.c        | 3 +++
>  drivers/ata/libata-core.c | 6 +++++-
>  include/linux/libata.h    | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a05c17249448..b195e87e7109 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1939,6 +1939,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (hpriv->cap & HOST_CAP_PMP)
>  		pi.flags |= ATA_FLAG_PMP;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_MARVELL_EXT)
> +		pi.flags |= ATA_FLAG_ATAPI_DMA;
> +

Hello Huacai,

You are not providing a lot of information about:
1) The SATA controller.
2) The CD/DVD drive that you are using.


For 1), since you are patching ahci_init_one(), it appears to be a
AHCI controller from Marvell.

However, we do not write quirks that affect all PCI device IDs
for a specific vendor.

Please define a new board type in "enum board_ids" in ahci.c, e.g.
something like board_ahci_atapi_force_dma or board_ahci_atapi_prefer_dma,
and then add specific PCI vendor IDs and device IDs in ahci_pci_tbl that
should apply this quirk.


For 2), you are not giving us any information, so have you verified that
this problem happens with more than one specific CD/DVD drive model?

It would be interesting to know if the problem exists even if you
are using CD/DVD drives from different vendors.

If the problem is only for a specific drive model, then perhaps this
shouldn't be a controller quirk, but rather a device quirk?
Device specific quirks are defined in __ata_dev_quirks in libata-core.c.


Kind regards,
Niklas

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE3392823
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877224; cv=none; b=LloxRmLCvMTUadf/QD001NI815WF2LGje/BiUGQqGDmA9qPL0CIXTpGIsL229DO+MBhqQLnXxQF81VnKZlu/VOqoSg8jmPWE7sTM4LuoIPkGh68/FocebtOomP8WIDo6hcHognmJkEqAEM2NMRnRVLUEsC7rn/qOQJwExUxauuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877224; c=relaxed/simple;
	bh=DmbdB2wqOVRDSbSz6TDiPtjXIlTTjEGgYsHL3lXAZpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejv/99PZZiVpqFfuwYHvkH3+l1zaOlbs13swjvotWlAXPlYZW0NRdZsfF4+Pr4I9MdMV5/D+9wH80fK8ESKSK1bm0nNFXB8eyTzDSbYzxfDBu7DxqHjuhCPaDxP2MG8xVbCKYygabwksloNGWHfu5k6MTGiwrj6WoO2AIIbH2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2DDqCXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2DDqCXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCF1F000FF;
	Tue, 13 Oct 2026 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877223;
	bh=X3hKcq1ejXqXQqMPHR8Sj/wBTexkJzuBgWxbgdT7VB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2DDqCXC9pNf7ApzVf38F7SUyQyqh0vZnaZPMUkGRi8tuF82fhVHQ8wyAP6KvfXV0
	 5tVvzbOH59qQ7yaXUsCX+F45q3EyEOUEvHaKYJ3n3eCcwwqoZ8DyJ9SpEG8UaPQ/ui
	 kWjpvaY4JqMs21gzoSAS/UUTZM5FnVmOVs4ITovuadXNwaZC1vy6+yeWLnndIa+RVK
	 XSaYnF7kT7ZCzCDQWsSly1Kynf6aUnP4kGPRf09/kXiOJpJr7b+6XdQ1OefoP1CFyf
	 hN4P87DdHhePlq99J3qJSniyMJlf5tzw+a0vkIAGV7BLkx603jyDk4YCC0KWWeSMaT
	 uZe3x6UKusWtQ==
Date: Tue, 13 Oct 2026 09:40:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] ata: pata_atiixp allow maximum UDMA speed
Message-ID: <as3gY1yzelLuTB6K@ryzen>
References: <20261013043016.77075-1-jnyb.de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013043016.77075-1-jnyb.de@gmail.com>

On Tue, Oct 13, 2026 at 07:30:16AM +0300, Ioannis Barkas wrote:
> Enable UDMA 6 for compatible IDE hosts, tested on SB600 & SB700
> using ATA133 HDDs & SSDs. SSDs can exceed now 100MB/s

This commit log is a bit short. Please provide some more information.

You commit log mentions SB600 & SB700, but the code comment mentions
SB300.


> 
> Signed-off-by: Ioannis Barkas jnyb.de@gmail.com
> Signed-off-by: Nick Barkas nickbgrk@gmail.com

The email addresses in this patch, and in all your other patches,
are missing corrupt. The format is:

Signed-off-by: Firstname Lastname <email@address.com>

i.e. you are missing <> around the email address.


> ---
>  drivers/ata/pata_atiixp.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 4c612f9543..74ef9195bd 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -279,8 +279,26 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  		.udma_mask = ATA_UDMA5,
>  		.port_ops = &atiixp_port_ops
>  	};
> +	static const struct ata_port_info info_ata133 = {
> +		.flags = ATA_FLAG_SLAVE_POSS,
> +		.pio_mask = ATA_PIO4,
> +		.mwdma_mask = ATA_MWDMA12_ONLY,
> +		.udma_mask = ATA_UDMA6,
> +		.port_ops = &atiixp_port_ops
> +	};
>  	const struct ata_port_info *ppi[] = { &info, &info };
>  
> +	/* SB300 and newer: UDMA6 */
> +	switch (pdev->device) {
> +	case PCI_DEVICE_ID_ATI_IXP300_IDE:
> +	case PCI_DEVICE_ID_ATI_IXP400_IDE:
> +	case PCI_DEVICE_ID_ATI_IXP600_IDE:
> +	case PCI_DEVICE_ID_ATI_IXP700_IDE:
> +	case PCI_DEVICE_ID_AMD_HUDSON2_IDE:
> +		ppi[0] = ppi[1] = &info_ata133;
> +		break;
> +	}
> +
>  	/* SB600 doesn't have secondary port wired */
>  	if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
>  		ppi[1] = &ata_dummy_port_info;
> @@ -314,7 +332,7 @@ static struct pci_driver atiixp_pci_driver = {
>  module_pci_driver(atiixp_pci_driver);
>  
>  MODULE_AUTHOR("Alan Cox");
> -MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
> +MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400, AMD SB600/700 series and Hudson-2");

This is a separate logical change, please drop it.

As we can see from the context above:

/* SB600 doesn't have secondary port wired */

The driver already supports SB600 in PATA mode, even though it was not
explicitly mentioned in the module description.

I don't see why we would need to change it now.


Kind regards,
Niklas

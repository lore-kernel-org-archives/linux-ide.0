Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABF28BA8C
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142054; cv=none; b=sEjT/Fve8G1HrgyLOHpgPNvHo9GW8wbnf32HBDmJUy1BYpDcsX7EWIQABxsCWOMmUHMKhbrE+IlCn9kAGpculbmpiGfZLO4n3puPEFub6F0dPoF9TNcIBuOjBmqpJqD8xfFl6os58OvkVgKjxRKV7c0c1840ZWTTzzXJ2i4jjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142054; c=relaxed/simple;
	bh=pHpArF3/hTCePSZC0bHdWMXdwtuFUcKI52EuxNgMEzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y1oIxI0/INN77PLwVvWuSgVN7jIHCXo4ul24TSs5MV7dMzRKm+BRVvnFh/Izr1Rcg4qAWT8JuiSXlQ7q7FtgFdzVBjXiJHy7fhS9OkEhPRrGRFxOXr80Cr4FEgprUOud/3nqtp/6scbAruCFJCMYbMmUTCbILpr85xo7bpvBjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQKuQM5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQKuQM5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644DCC4CEE3;
	Tue, 17 Jun 2025 06:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750142053;
	bh=pHpArF3/hTCePSZC0bHdWMXdwtuFUcKI52EuxNgMEzk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lQKuQM5nsDlg5Iq4YRoX43pcDQlE82qSlj8USccwBng9EZp8WMkLOgEKyVJBpQy5t
	 Obd3nGGXdZ/aMiVfr06chiXx/Bzv1KbxxMOKaAd0/LRT0xG98/uh6eDdOnDCwv9NWR
	 9qpq651OwQoqtosWQU55nz8zPVUfJnPRRGCjZk5H/jAEKgj/vNUo9ghV0BcL1iFLaE
	 y6VLi18QGVeHCUffv2Truyj9u1tGE1dTt6r7XtkvMmn6sX6fEXeZC2rhsd+rN5b2GX
	 waYqkpavF/YFlexS9T5M0sp9SCMipA8jip5ujdoR6spvaMtY4eFolj+H6C+EF4EWkH
	 YM768pMjhNAHA==
Message-ID: <14325a6a-6f95-4767-bcbd-cb9b735e8b37@kernel.org>
Date: Tue, 17 Jun 2025 15:32:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Disallow LPM for Asus B550-F motherboard
To: Mikko Korhonen <mjkorhon@gmail.com>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
References: <20250617062055.784827-1-mjkorhon@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250617062055.784827-1-mjkorhon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 3:18 PM, Mikko Korhonen wrote:
> Asus ROG STRIX B550-F GAMING (WI-FI) motherboard has problems on some
> SATA ports with at least one hard drive model (WDC WD20EFAX-68FB5N0)
> when LPM is enabled. Disabling LPM solves the issue.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
> ---
> I think we might include the comment about the non working drive model, as
> we have tested only one model and in principle this could also be an
> interoperation issue. If one would need to enable LPM for the motherboard
> and happens to have a working hard drive model, he/she would know
> why we have made the patch in the first place.
> 
>  drivers/ata/ahci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c8ad8ace7496..ae8c4072a5a3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1454,6 +1454,22 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  			},
>  			/* 320 is broken, there is no known good version yet. */
>  		},
> +		{
> +			/*
> +			 * AMD 500 Series Chipset SATA Controller [1022:43eb]
> +			 * on this motherboard timouts on ports 5 and 6
> +			 * when LPM enabled at least with WDC WD20EFAX-68FB5N0
> +			 * hard drives.
> +			 */
> +			.matches = {
> +				DMI_MATCH(DMI_BOARD_VENDOR,
> +					"ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_BOARD_NAME,
> +					"ROG STRIX B550-F GAMING (WI-FI)"),
> +			},
> +			/* 3621 is broken, there is no known good version yet.
> +			 */

Please use the correct comment format:

			/*
			 * 3621 is broken and there is no known good version.
			 */

> +		},
>  		{ }	/* terminate list */
>  	};
>  	const struct dmi_system_id *dmi = dmi_first_match(sysids);


-- 
Damien Le Moal
Western Digital Research

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FD5672
	for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988739; cv=none; b=IcLoT5kRsbKFa57R1mdbIFXL9hYQaGvtLtxYxyT4zsXfcypl2ttMNj+r10uOr1njIb+KmAS++SgLCvyvkEKvLBykG9UwxIbMaa6dW1Z6K9CawhXr4CA3ifeK7E12Bqr8Fe0bsQLAaV8Y+IEwp746fJqhaLKkMR+7YqwNUOzd008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988739; c=relaxed/simple;
	bh=dsOuICXZxx/isAXSAC3b6KPEUlRIDfWCcr1uf+EbSv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdGNjk2sySGX+N2K6yAMiJLWPYd+hX9kuwRHp0QTpKoQfJiRtJQZ8SyoSHoqdhTu4XPpxKokaR/xULT9HhFQ2Fierjd3jGkuS9fBPQ9CgtPZha5xCcLgp1wT3AsB1x1KyXXzdhtllgy9qsz8CYuTuOESW4Q5cXBWuZxm8+ib0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeSIbSaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeSIbSaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE16C4CED2;
	Mon, 27 Jan 2025 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737988739;
	bh=dsOuICXZxx/isAXSAC3b6KPEUlRIDfWCcr1uf+EbSv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeSIbSaELSlcIkoByH+nCiO7940jbjXP26drS/pfgSIXO3qS4afN/tkxvUbJp9EkH
	 ISmjPEH6qFTbZFdg2vJG+TL031Hom7WROexfTUjH6O4rqkYw3K4qLD9nAy1kEZwKD6
	 wEmQPtLv9+kLNVmrv+HnriBAnzkRgRfs34aDnRhbIx00bnnBMC/JuKKpEV+e2hCYe0
	 NzZSawUIQPN+LalM48TS3ms98Xpo3JI3dBcLk3z8UYOlluHia7BWGi04uucrOsP+NJ
	 BZgy1uGmoX/nwITepT5H5J0/1kWqFcAf6YFS3M0aQqcQuc/UuC2pfkZ3CI/l7kuvXu
	 ho8S+Wlz8hDDQ==
Date: Mon, 27 Jan 2025 15:38:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] Disabling link power-management on Samsung SSD 870 QVO
 drives to make them work.
Message-ID: <Z5eaf3J3xqumKG7P@ryzen>
References: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>
 <Z45NEMKVAsxKvafa@ryzen>
 <ac64a484-022c-42a0-95bc-1520333b1536@debian.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac64a484-022c-42a0-95bc-1520333b1536@debian.org>

On Mon, Jan 20, 2025 at 04:08:16PM +0100, Daniel Baumann wrote:
> Hi Niklas,
> 
> On 1/20/25 14:18, Niklas Cassel wrote:
> >> I've added a new case for 870 QVO specifically as regular 870 don't have
> >> the issue.
> > 
> > This should have been in the commit message.
> 
> thanks for the pointer, I have now adjusted the commit message.
> 
> > Out of curiosity, did you test on regular 870, so you know they are not
> > broken as well?
> 
> we don't have many of non-QVO variants, but so far none of them has
> needed it. I've added that to the commit message as well.
> 
> > You probably also want to add:
> > Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> > Cc: stable@vger.kernel.org
> 
> added, thanks!
> 
> Updated patch attached.
> 
> Regards,
> Daniel

> From f2b44baf60d11882696a99445bf217d6ee409903 Mon Sep 17 00:00:00 2001
> From: Daniel Baumann <daniel@debian.org>
> Date: Sat, 18 Jan 2025 06:36:43 +0100
> Subject: [PATCH] ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO
>  drives
> 
> Disabling link power management on Samsung SSD 870 QVO drives
> to make them work again after the switch of the default LPM
> policy to low.
> 
> Testing so far has shown that regular Samsung SSD 870
> (the non QVO variants) do not need it and work fine with
> the default LPM policy.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Daniel Baumann <daniel@debian.org>
> ---
>  drivers/ata/libata-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c085dd81ebe7..63ec2f218431 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4143,6 +4143,10 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
>  						ATA_QUIRK_ZERO_AFTER_TRIM |
>  						ATA_QUIRK_NO_NCQ_ON_ATI },
> +	{ "Samsung SSD 870 QVO*",	NULL,	ATA_QUIRK_NO_NCQ_TRIM |
> +						ATA_QUIRK_ZERO_AFTER_TRIM |
> +						ATA_QUIRK_NO_NCQ_ON_ATI |
> +						ATA_QUIRK_NOLPM },
>  	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
>  						ATA_QUIRK_ZERO_AFTER_TRIM |
>  						ATA_QUIRK_NO_NCQ_ON_ATI },
> -- 
> 2.45.2
> 

Applied to libata/linux.git (for-6.14), thanks!


[1/1] ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives
      https://git.kernel.org/libata/linux/c/cc77e2ce

Kind regards,
Niklas

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE061B5EBC
	for <linux-ide@vger.kernel.org>; Mon, 20 Jan 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737379092; cv=none; b=BwrFkFKRBF2dSfzLkKdAfXZH1deO3DJ28KEnMChOFTVswXiaI+OnjmpnQ324kEP88j0RFCck+LN5NFfBDqSUu8d+N4X2tAQWDlgZjlZtCQsF/X7sdIsaf9pSFIk5sfiKnrs2fBZdGob7IlE47pEBsb+gF8aMQVCwELRApN1PrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737379092; c=relaxed/simple;
	bh=cST3t607mEhNnbLPWmb3RToZP1l4XnNPL4PNI2gnxcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImwVR2pFO2SvXRX/agbL8JZAKCNhhAffbZpIinDsi1DJ6ZGS9VCNwpaB5rEb1U6KqqgpCKo3S40khDpQD9LzRbaen812D4rUNgt5/gpAzpEyPxcXPMqZQsSbZkAb0T9cVazA2R/ddLO+ZkSStsY64L2jxHHGsB+bPA1evxHUGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv+yOsgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv+yOsgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB557C4CEDD;
	Mon, 20 Jan 2025 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737379091;
	bh=cST3t607mEhNnbLPWmb3RToZP1l4XnNPL4PNI2gnxcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv+yOsgLtWKhgLYeom8GImlexbtwkm2KWWNJOpLMRBO/TUzmN8sHQPRlU9K4EYAIC
	 D/4qKefWadmzgvGgZspIo5o5wTbqtw2frad7W/qkXykKETsrprDhpQiCHH3MFF/Ygw
	 VYUjtBATcMG4ddiWhzSb/Ya96EOTjwKKpKJR3FWlea1DugDpZ6LBxwgaXTyeuk0vvy
	 SDxP50Arc45NkXLqsfUP+Zqp/h+ziQtxjTiPBaRW4872xKGysISwZ/JwgnXR2kQrtU
	 P/xlmNGde2tzXdysSwCuma4698MVdw6ly1fqbbLTzyLlbV2RkUNeXsuX0ALpljFole
	 jppQIrmpGJupQ==
Date: Mon, 20 Jan 2025 14:18:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] Disabling link power-management on Samsung SSD 870 QVO
 drives to make them work.
Message-ID: <Z45NEMKVAsxKvafa@ryzen>
References: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>

Hello Daniel,

On Sat, Jan 18, 2025 at 06:52:30AM +0100, Daniel Baumann wrote:
> Hi,
> 
> since the kernel enabled LPM by default, Samsung 870 QVO SATA SSDs don't
> work anymore. Disabling LPM for them solves it, please consider applying
> the attached patch.
> 
> I've added a new case for 870 QVO specifically as regular 870 don't have
> the issue.

This should have been in the commit message.

Out of curiosity, did you test on regular 870, so you know they are not
broken as well?


> 
> [I'm not subscribed to the list, please CC on replies]
> 
> Regards,
> Daniel

> From 55e2cb12faa48cf429ad4a299ea4e4a3a9ba25f5 Mon Sep 17 00:00:00 2001
> From: Daniel Baumann <daniel@debian.org>
> Date: Sat, 18 Jan 2025 06:36:43 +0100
> Subject: [PATCH] Disabling link power-management on Samsung SSD 870 QVO drives
>  to make them work.

The subject should be something like:
ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives

> 
> Signed-off-by: Daniel Baumann <daniel@debian.org>

You probably also want to add:
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org

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


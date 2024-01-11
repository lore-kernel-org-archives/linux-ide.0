Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1C15484
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk35Lg8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EC0C433C7;
	Thu, 11 Jan 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704972086;
	bh=k2O7fKia8kB+O/LHBkA0GHJ3qvC7k0gbuB3QC2hLlE4=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=qk35Lg8qVvTtG9KAYSq1/PbKfF3/94rcAAPCC8qcBWJDK6vbXZzBlv+7Hh/akFK7l
	 txMss97Rs3+ZGilQhi3NZb8Obd972N6De77H/7mfPrJLd8ndLl4iIIXS+kwEktV5b5
	 oL+sJjBLvPJjU/NFktkFiDiYhu/wJjX4r1/+bOGThA6I4Rd98S4v1BxaTVqy9D6Mov
	 ZbEqDnLd+qhKxY2CecSxe0afkE11GFtNoYyTvty+V4BfdVke1SHXX8xFWksJ99nruW
	 8ghuEtbL7bUMozbmkjwS/bmkhFpP0ly9QVu9LtWIcFIfOBOtVXtDjxXZro2tuRLyHn
	 b8XiDVGebN/Mg==
Message-ID: <8ac10be3-a3aa-4886-850a-afa51d104410@kernel.org>
Date: Thu, 11 Jan 2024 20:21:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Do not try to set sleeping devices to
 standby
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20240111111512.1255875-1-dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240111111512.1255875-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 20:15, Damien Le Moal wrote:
> In ata ata_dev_power_set_standby(), check that the target device is not
> sleeping. If it is, there is no need to do anything.
> 
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Forgot to add Cc: stable. Resending.

> ---
>  drivers/ata/libata-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 09ed67772fae..d9f80f4f70f5 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2017,6 +2017,10 @@ void ata_dev_power_set_standby(struct ata_device *dev)
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
>  
> +	/* If the device is already sleeping, do nothing. */
> +	if (dev->flags & ATA_DFLAG_SLEEPING)
> +		return;
> +
>  	/*
>  	 * Some odd clown BIOSes issue spindown on power off (ACPI S4 or S5)
>  	 * causing some drives to spin up and down again. For these, do nothing

-- 
Damien Le Moal
Western Digital Research


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318418E06;
	Wed, 14 Feb 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908641; cv=none; b=III1kW87GhdP8HUdcsKvNaYsNzyYWzIot5gvOVCrD1bJxDYc/jrMV7oaEgl+khDiKyVZItHCBpO6aASBS9QaQ05KQon8Zwkttb4mfHMrPstatIbMtToKdZwsTRIsWW+/KuBklfvJkmPG0clbRSHKNHcKDjD9UFYui6LjjIXIf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908641; c=relaxed/simple;
	bh=LMpoYvwHyM10QN6tuSXIgHpEC1+hNiUOXILR2Ytr4Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqPwZfEpX3bmtGWoSFWqNLaoeE+4S20Jz51lCDTQjeRlBwloTfw+4lPZCVDH542jozvUqb4r7jNIZDuT2SnCVVfqg9jaWzluWpbiKwtPvtOEDa3giAQ2hpFFgZP4vIUWIfxe2DEbiS9yqmwI9I5/Jk7620TDyhtp3YsGx+f891Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUrTENT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUrTENT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD06C433C7;
	Wed, 14 Feb 2024 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707908640;
	bh=LMpoYvwHyM10QN6tuSXIgHpEC1+hNiUOXILR2Ytr4Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUrTENT9FjrVPm21G8EpI9ytRh9qHvdXcIy0HW7UPlpGcfRoSXn6T9jqFzmlv4RUO
	 og/d2TsR2v5yCLrOCch+nHFom2bD6SJCXSDt4bkhkGEd9JqUpNLaazP8JKD7dp5avD
	 i8h9/L7L3N4DszmwuEA7vecmt0rgt5+8au/hwzA9T86EMoDu/C9b5IlnKthf+2WRuA
	 p9qacaH7JsOODTfXojZcQHQBOrHcdP1dYXvKBYC1JByuqsW6EHf2SJP0khEKdMzHND
	 WVi5TTf0cUYztkIADuSSsxTtfRd9aS8rWDPF269L9UQz9kulJ1zaS5GGO8TNit0n5d
	 2TPak1VKHCfQQ==
Date: Wed, 14 Feb 2024 12:03:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Dieter Mummenschanz <dmummenschanz@web.de>,
	Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] ata: libata-core: Do not try to set sleeping devices
 to standby
Message-ID: <ZcyeG/H62aY8Nrku@x1-carbon>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <20240111115123.1258422-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111115123.1258422-2-dlemoal@kernel.org>

On Thu, Jan 11, 2024 at 08:51:22PM +0900, Damien Le Moal wrote:
> In ata ata_dev_power_set_standby(), check that the target device is not
> sleeping. If it is, there is no need to do anything.
> 
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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
> -- 
> 2.43.0
> 

Holding off [PATCH 2/2] until we get a better understanding of things,
thus for [PATCH 1/2] only:

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes

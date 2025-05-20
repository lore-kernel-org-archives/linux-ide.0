Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54C21C9EE
	for <linux-ide@vger.kernel.org>; Tue, 20 May 2025 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733436; cv=none; b=ifqXykuZj7owDL/BU17NRW4QDgETkZNT8vN+d3d98FeOvcLBbezqqpuEgGOu6szDsHMSgfKdeRgWhE2wYyc1hXpqwvogum29iLsEF5Yucp8VSNFvz7ZZNspc1YZ0piPp1nkC/r4SrL70V/9FiJWIkrdWF9Ht3uK4M2QFQRmxkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733436; c=relaxed/simple;
	bh=LdfXLFQdE0mpvPiFMJkiMSBC1Q/d7knv3M2L/3iw+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+BhmmsOZnhgwm2nHTNEl94OFQK7nQPbscZ5YjkGwc32mUAO9pWUFP+W/yIr87xBxSz8V2FTVNz3faxGjwT1T8X4WzagKh7P8gqrZ6sYbeKVgvHwGLgUMVeBBAcfpq2SVKblA5joISRgUDE/MYxTqfqNeqpr2cywpzE6hmuelwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pcfrg4eE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pcfrg4eE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB228C4CEE9;
	Tue, 20 May 2025 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733435;
	bh=LdfXLFQdE0mpvPiFMJkiMSBC1Q/d7knv3M2L/3iw+Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pcfrg4eEysj8BRMajMzfwPhBU8VFKhkUnV8PLBqlyt/D9Nkoqg8ZECzFFYFASTzIl
	 g+4RVIkidRsrQVYiV9Aa+B8xcFScDOqiNK1TjiRtfnuPX7ehgW+dKrEy/TSzFvHUZ7
	 Z6QuQGyz0UtoTqYDamcwlumqLRNcpfobDfJpycoqMBIDO+aaBzd88BqFTVqydShamV
	 dUtiW0NwMITMknTpWK4UxNyNM8n1EOgA1SMP3ys647tCfWpZ8V0ecXcFMhy+TgqBNS
	 trtruNnvlzzFw9IT2fexuBUtH6bASunn1hrFPmRvIiqGH+ZT8NyJ4iyz49dOQGfZyU
	 dyq09SCOpp0zg==
Message-ID: <5c94f5d7-95ee-4341-adbb-89d6bb48fa1e@kernel.org>
Date: Tue, 20 May 2025 11:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on
 VT6415/VT6330
To: Tasos Sahanidis <tasos@tasossah.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250519085508.1398701-1-tasos@tasossah.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250519085508.1398701-1-tasos@tasossah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/05/19 10:49, Tasos Sahanidis wrote:
> The controller has a hardware bug that can hard hang the system when
> doing ATAPI DMAs without any trace of what happened. Depending on the
> device attached, it can also prevent the system from booting.
> 
> In this case, the system hangs when reading the ATIP from optical media
> with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
> Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
> running at UDMA/33.
> 
> The issue can be reproduced by running the same command with a cygwin
> build of cdrecord on WinXP, although it requires more attempts to cause
> it. The hang in that case is also resolved by forcing PIO. It doesn't
> appear that VIA has produced any drivers for that OS, thus no known
> workaround exists.
> 
> HDDs attached to the controller do not suffer from any DMA issues.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916677
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>

Doesn't this need a Cc: stable tag ? I can add it when applying.


> ---
>  v1 -> v2: Wrap long line
> 
>  drivers/ata/pata_via.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
> index 696b99720dcb..d82728a01832 100644
> --- a/drivers/ata/pata_via.c
> +++ b/drivers/ata/pata_via.c
> @@ -368,7 +368,8 @@ static unsigned int via_mode_filter(struct ata_device *dev, unsigned int mask)
>  	}
>  
>  	if (dev->class == ATA_DEV_ATAPI &&
> -	    dmi_check_system(no_atapi_dma_dmi_table)) {
> +	    (dmi_check_system(no_atapi_dma_dmi_table) ||
> +	     config->id == PCI_DEVICE_ID_VIA_6415)) {
>  		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
>  		mask &= ATA_MASK_PIO;
>  	}


-- 
Damien Le Moal
Western Digital Research

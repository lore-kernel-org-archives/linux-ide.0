Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5582D739B;
	Sat,  5 Sep 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568903; cv=none; b=YcdjVIM3CVraS5RB2UQ2rYRTEqruRq35ALZojB8m/+YH4WwlvpI8w4crZfmD0ZFSrRaveLtDeUwsd7/IsOeexexiZsWUMHBEHLNh8fmBRR47I88GVRDGVi/Zphy9mcV2fGULT2ZyQ3yl3N6AdeNEMxFNU1TaY/pruYwQLT2QwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568903; c=relaxed/simple;
	bh=kr/PN2bFngzI+UgYAd12TCdMJRurp/prEWct9aeLNF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krg4mtEuhiAPEkQQsPniDiUzdD5/+jM4xCGOeXVsTj24nLubWtdhsStq+qIMMyBm/61qBUJMiDomLqSmBr4SWjQPoC1UJ8QftJDRvKhEfG1KeFXQ23qk3vT0tzQpOQDRIvDJX7QJdlYEvO6tI5rU1Ce38dnO4IE7Bvev0hdQ5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMe77plz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMe77plz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441371F00A3D;
	Sat,  5 Sep 2026 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788568901;
	bh=xwKo0yqZkaIgvgKghnaQ/y8MGLlhIK+s5NYoMb42MJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MMe77plzC/yqZKyPye8FOA7o3ykhflHLjZ5wKN5vLb2uNhgWHZEkG2AToSh59Fmhn
	 avQq54uj46cQkfp5CcPC2PaBwebaiTnLS517v7b6AHREN4cBUCZjD4oBe4ikWnMel9
	 t8bIVguhByD34H8MizoBCoPcqxLHrvJj9IfKQYOLspQbLLpX+LcI5IgcE5gJJHPWrx
	 odLC1NjV4U2BmnPml+tZ2tszny/CrwrszMAy6XBXW++9lbZYb3Sn6ArTjDtU3yzXF9
	 S85TXjEqXlIdpFTGHShLxiInXtx3O27c+EkUIQT4UYQA8IGq3+dYS/u8OdtfWyotvb
	 DRuBdiVDuanSQ==
Message-ID: <6e066029-94df-480e-95ea-3b27ae8387ad@kernel.org>
Date: Sat, 5 Sep 2026 09:41:39 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: fix repeated words in comments
To: Hemanth Selam <hemanth.selam@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260904123110.35532-1-hemanth.selam@gmail.com>
 <20260904123110.35532-3-hemanth.selam@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260904123110.35532-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 21:31, Hemanth Selam wrote:
> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/ata/libata-eh.c      | 2 +-
>  drivers/ata/sata_dwc_460ex.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c93c24b22d9c..630e6d44190b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -923,7 +923,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
>   *
>   *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
>   *	is non-zero and EH wasn't pending before.  Fast drain ensures
> - *	that EH kicks in in timely manner.
> + *	that EH kicks in timely manner.

Sashiko is correct here. This is the wrong fix. This should read:

"that EH kicks in in a timely manner."

In any case, this is all very minor and I prefer that we do not apply this patch
to avoid churn and backport issues and rather get these typos fixed when the
code around them changes.

>   *
>   *	LOCKING:
>   *	spin_lock_irqsave(host lock)
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891a..b0c069a02cc2 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1071,7 +1071,7 @@ static const struct scsi_host_template sata_dwc_sht = {
>  	/*
>  	 * test-only: Currently this driver doesn't handle NCQ
>  	 * correctly. We enable NCQ but set the queue depth to a
> -	 * max of 1. This will get fixed in in a future release.
> +	 * max of 1. This will get fixed in a future release.
>  	 */
>  	.sg_tablesize		= LIBATA_MAX_PRD,
>  	/* .can_queue		= ATA_MAX_QUEUE, */


-- 
Damien Le Moal
Western Digital Research

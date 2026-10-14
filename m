Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB44E8E06
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991284; cv=none; b=n11tINVbllOc8ZVH8UQSId1k4+QetGIlg1XUxlX+mykBwuIzmMcTsyd7zTWMhmFzSdAgAna5IxTbZGrTkCupRRALuRcxcdH6mt/oigjp6VVciCP2gr5kZZFOUN7cHFtNcm4NS7Y+5/I0vcz2DD1yrG7qZRohePVUKXXLJecoiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991284; c=relaxed/simple;
	bh=PNxLHjAXrCA7Lr/G9PfYpqDixBGccxfOlJaMtHtLK4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAXPEFmhWfFrlfkNpxwJ531Uz7/fk0bjIoAx6LmI6yjxOru7Bdeci8BGc3nZM2HqPZtiRMLQkbo6fp+9s4qDxx6FHvdjQhbsr+feHqN37yCfdpu5swIM/+HLSfXCaFweLLPnXzEJQ3CZ2q4vPzJX0NjFYDfh9xj2fpd8e/1CULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI+f7d8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI+f7d8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE471F000C4;
	Wed, 14 Oct 2026 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991283;
	bh=OsUjZjqQCe2Ep+FpcJRA6eUMQPzuSuvNGE3KiWaCHtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gI+f7d8IK34JNiptyFplM+uQmgkd3LfE+E7FP9rVU5Hrwcw+VytPpPR4KkQio4dpn
	 n91Xf++SS/87z2k3Ehtq9yuFwOhLaeaNaKEWR//E2Iz12H6OW5RgAzd99ttX5sa2MN
	 QCBtxDx5YBwbXqsAnc5E5XLn7aQKpzLYk1R+Roex3hk5MLvFqS4xqHume0Ytv2a6Zs
	 7j19cv0/okxUEeUpfKg9qtXp3PtCGPIxWITKmqbEiwDDKQAMsq4CygLjD7bDl2GPKL
	 UuAqe0SyPXbBZFlJlCAuITxy/XSgFiEL5GrFzCRTwRTEw2hkHL+pjGp57GYmMYBSw9
	 4G0BV7jlzn+7w==
Message-ID: <baa5c1a7-ce24-4dbc-aa6c-fd78995d789d@kernel.org>
Date: Wed, 14 Oct 2026 17:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: always apply all quirks matching for a
 device
To: linux-ide@vger.kernel.org
Cc: cassel@kernel.org
References: <20261014150340.2410073-1-dlemoal@kernel.org>
 <sashiko-outbox-171459@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <sashiko-outbox-171459@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/14 17:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ata: ata_dev_quirks() accumulation breaks specific quirk exclusions
> - [Medium] ata: ata_dev_print_quirks() inside loop suppresses subsequent match logs
> --
> 
> commit 8f4a558f46757e1ace36c8ad018b708424fefd18
> Author: Damien Le Moal <dlemoal@kernel.org>
> 
> ata: libata-core: always apply all quirks matching for a device
> 
> This commit changes ata_dev_quirks() to accumulate all matching quirks from
> the __ata_dev_quirks array rather than returning on the first match. This
> is intended to address issues where appended ATA_QUIRK_NO_FUA entries were
> ignored if earlier patterns also matched the drive.
> 
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
> 
> [ ... ]
> 
>> @@ -4521,16 +4522,18 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
>>  	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>>  	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
>>  
>> +	/* Get the quirks for all matching entries */
>>  	while (ad->model_num) {
>>  		if (glob_match(ad->model_num, model_num) &&
>>  		    (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
>>  			ata_dev_print_quirks(dev, model_num, model_rev,
>>  					     ad->quirks);
> 
> [Severity: Medium]
> Since ata_dev_print_quirks() sets ATA_EHI_DID_PRINT_QUIRKS on its first run
> and suppresses subsequent printing attempts, won't it fail to log the quirks
> from any second or subsequent matches?
> 
> Looking at ata_dev_print_quirks():
> 
>     if (!ata_dev_print_info(dev) || ehc->i.flags & ATA_EHI_DID_PRINT_QUIRKS)
>         return;
> 
>     ehc->i.flags |= ATA_EHI_DID_PRINT_QUIRKS;
> 
> Should the print function be called exactly once, outside the loop, passing
> the fully accumulated quirks mask instead of ad->quirks?
> 
>> -			return ad->quirks;
>> +			quirks |= ad->quirks;
> 
> [Severity: High]
> Does accumulating the quirks here break the ability for specific entries to
> shadow and exclude broader entries?
> 
> For example, earlier in the __ata_dev_quirks table, a specific entry is used
> to explicitly exclude a buggy drive:
> 
>     /*
>      * The intel 510 drive has buggy DRAT/RZAT. Explicitly exclude
>      * that model before whitelisting all other intel SSDs.
>      */
>     { "INTEL*SSDSC2MH*",        NULL,   0 },
> 
> If the loop continues, it will match the broader "INTEL*SSD*" pattern and
> apply the exact quirks the earlier specific entry was meant to avoid. Can
> this lead to functional regressions for devices that relied on earlier 
> entries to bypass buggy hardware features?


Hmmm... OK. I think Sashiko has a good point here. We cannot use my idea as that
works only for accumulating quirks, not for restricting them.
So I guess your patch is the better one.


-- 
Damien Le Moal
Western Digital Research

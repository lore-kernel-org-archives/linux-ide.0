Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC29298C1F
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312728; cv=none; b=qmXM9Zxcz73E8xkFJkXb+TfeA7UHqwSbHVo3Hi2zAgO9j4Xs4qVTtbgXPln0DmQXTnbKeZImuxoHAlbq+3Nqqo+rA/mefdpqn4wua31XB9+PK0e0JYWZp+HvpS2U3K4+cwVc/Wl6SNSjIFyb40wNA4GqG0jqawFoy3zzjrqxYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312728; c=relaxed/simple;
	bh=85ebDgfRdIuj2VTQNwe/o7n6zuKHRBPLpWpzFJ/cvT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzJqSf6O1sWbsYAD9VPw7ux9G8GfWYDHsppfffQOZpdyClquRF2zBmofFo4M1Kq6DtOXlOJVzLBj22Sawfat9fP+PC7q0gHCZ5UyxyvLTlIdorZDRkC2Ub3VuKvqxm8ZDGAhOu6BVXQvw00chb3+DdUIKvLB9hYpx9RoPRbDK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGaTZoNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGaTZoNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757CCC4CEF0;
	Thu, 15 May 2025 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312727;
	bh=85ebDgfRdIuj2VTQNwe/o7n6zuKHRBPLpWpzFJ/cvT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGaTZoNHr6e0ZM6s02uuVgIXwVCdTS3I94Rw5AR0xKGCeEWJdQFSkjl4GPxLvhxEJ
	 w5m+CASpGmlxjb0EBSCae0Utms6pwRLz/n1e3VRY+7e98d6CmgWRtVlNdv2X82ECiI
	 NTRQUMNaFWg7XO67UXYUszP529m8Y6MXeygxSBBde8N+xUtDA7nZM5gMQZIEN2OmDN
	 J7lv80+ujKUnDwp7qk6cMw09C3c5vns6XyNbUH3Tew4g1XJK9Yf17fYryrArWdkqci
	 CIJkxVV6fN0wKKDYnWeHT6SM8GvTZ6RBURvaciCUZwTu9a0IPLx9Tn2ll0s2pgtm2x
	 VlFoTt/qBmgJQ==
Message-ID: <093daf2d-c6f3-46ff-8336-50f015eb80a9@kernel.org>
Date: Thu, 15 May 2025 14:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ata: libata-eh: Add ata_eh_set_lpm() WARN_ON
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
References: <20250514172210.383801-9-cassel@kernel.org>
 <20250514172210.383801-11-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250514172210.383801-11-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 19:22, Niklas Cassel wrote:
> link->lpm_policy is initialized to ATA_LPM_UNKNOWN in ata_eh_reset().
> 
> ata_eh_set_lpm() is then only called if
> link->lpm_policy != ap->target_lpm_policy (after reset)
> 
> and then only if link->lpm_policy > ATA_LPM_MAX_POWER (before
> revalidation).
> 
> This means that ata_eh_set_lpm() is currently never called with
> policy == ATA_LPM_UNKNOWN.
> 
> Add a WARN_ON so that it is more obvious from reading the code that this
> function is never called with policy == ATA_LPM_UNKNOWN.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index edbc5d7572d1..d2ccdb9a2840 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3442,6 +3442,13 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
>  		return 0;
>  
> +	/*
> +	 * This function currently assumes that it will never be supplied policy
> +	 * ATA_LPM_UNKNOWN.
> +	 */
> +	if (WARN_ON(policy == ATA_LPM_UNKNOWN))

WARN_ON_ONCE() would be better here.

> +		return 0;
> +
>  	/*
>  	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
>  	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as


-- 
Damien Le Moal
Western Digital Research

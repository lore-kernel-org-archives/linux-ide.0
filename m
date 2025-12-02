Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0718BC3D
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642797; cv=none; b=IkJZtELxNjH0GBm7pYK+obM6tI1t4yHmYaBTt50wyxgVpg/IAPrEBDJfQfj35uQQlbAI0yUgaI3KQB3NN/kY4K6kZhWijNCV4gIpitNwIFHeFBdcRAO2cdKJDjMSMrDsprbcpaTHmhuSRGupJYHwo6iGNoi6pTE778i4bKHZe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642797; c=relaxed/simple;
	bh=RsMwrNy8Wm0cl7fZsRJnAu1DykqfOliIPjIpOjh1RN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJIS0hdZJ89KwM8ry63YSIf17s/dwB/AtZtegdzgiBCADj7JM7bD9bvhwSWqxztxsie1gS2YocHQcVVzM6VAXv4OUFcGkAYckdPU2DcmmBbFjRyGZOj098EK4c4YWeZtrPKuTzJuNvGsQ5KWQtmZlRBRSiFZISgKPORW4GyT0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmLyLWW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmLyLWW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A7AC4CEF1;
	Tue,  2 Dec 2025 02:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764642796;
	bh=RsMwrNy8Wm0cl7fZsRJnAu1DykqfOliIPjIpOjh1RN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZmLyLWW0LxhBBTSmvj4/LaiO+gTdPKqptIayOsa+QpPN6gfcEGeiz7oLQXgJ4iZhb
	 lI1OQV89fKAvcTPQDhFoT2DIEsfU9pkfUdaeo62TtTcff5ui1QnPaj08XaK309bNQ6
	 T53jsTDxur2Jn1uLhy5UVFDzYSHCuCAdDJBwfGlipFXiubpKOKVx7ybNJG8Wi2K/2W
	 73gMQg2wYjgOXquLVD+ggzwcPp/B0hvb2b8RQUgz7wQV6MeFUvv3zPJuT4OsGTSOdF
	 hZ3c3WrjAXXQQHeJgd1K8Dzr8LSJT5G36D0Z2qinqw/9Iuaqq4Wlkn1yImxafonlpK
	 zwwtgcfjlahZA==
Message-ID: <4d6063d0-5810-4449-a00d-bc397c2ead91@kernel.org>
Date: Tue, 2 Dec 2025 11:33:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] ata: libata: Add support to parse equal sign in
 libata.force
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-16-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-16-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> Currently, no libata.force parameter supports an arbitrary value.
> 
> All allowed values, e.g. udma/16, udma/25, udma/33, udma/44, udma/66,
> udma/100, udma/133 have hardcoded entries in the force_tbl table.
> 
> Add code to allow a libata.force param with the format
> libata.force=param=param_value, where param_value can be an arbitrary
> value.
> 
> This code will be used in a follow up commit.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

A couple of nits below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/libata-core.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 697188b990dd6..7f59eca2a65be 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6461,6 +6461,13 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
>  	{ "no" #name,	.quirk_on	= (flag) },	\
>  	{ #name,	.quirk_off	= (flag) }
>  
> +/*
> + * If the ata_force_param struct member 'name' ends with '=', then the value
> + * after the equal sign will be parsed as an u64, and will be saved in the
> + * ata_force_param struct member 'value'. This works because each libata.force
> + * entry (struct ata_force_ent) is separated by commas, so each entry represents
> + * a single quirk, and can thus only have a single value.

s/have/has

> + */
>  static const struct ata_force_param force_tbl[] __initconst = {
>  	force_cbl(40c,			ATA_CBL_PATA40),
>  	force_cbl(80c,			ATA_CBL_PATA80),
> @@ -6548,8 +6555,9 @@ static int __init ata_parse_force_one(char **cur,
>  				      const char **reason)
>  {
>  	char *start = *cur, *p = *cur;
> -	char *id, *val, *endp;
> +	char *id, *val, *endp, *equalsign, *char_after_equalsign;
>  	const struct ata_force_param *match_fp = NULL;
> +	u64 val_after_equalsign;
>  	int nr_matches = 0, i;
>  
>  	/* find where this param ends and update *cur */
> @@ -6592,10 +6600,36 @@ static int __init ata_parse_force_one(char **cur,
>  	}
>  
>   parse_val:
> -	/* parse val, allow shortcuts so that both 1.5 and 1.5Gbps work */
> +	equalsign = strchr(val, '=');
> +	if (equalsign) {
> +		char_after_equalsign = equalsign + 1;
> +		if (!strlen(char_after_equalsign) ||
> +		    kstrtoull(char_after_equalsign, 10, &val_after_equalsign)) {
> +			*reason = "invalid value after equal sign";
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* parse val */

	/* Parse the parameter value. */

>  	for (i = 0; i < ARRAY_SIZE(force_tbl); i++) {
>  		const struct ata_force_param *fp = &force_tbl[i];
>  
> +		/*
> +		 * If val contains equal sign, match has to be exact, i.e.
> +		 * shortcuts are not supported.
> +		 */
> +		if (equalsign &&
> +		    (strncasecmp(val, fp->name,
> +				 char_after_equalsign - val) == 0)) {
> +			force_ent->param = *fp;
> +			force_ent->param.value = val_after_equalsign;
> +			return 0;
> +		}
> +
> +		/*
> +		 * If val does not contain equal sign, allow shortcuts so that
> +		 * both 1.5 and 1.5Gbps work.
> +		 */
>  		if (strncasecmp(val, fp->name, strlen(val)))
>  			continue;
>  


-- 
Damien Le Moal
Western Digital Research

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6A3EB81E
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956655; cv=none; b=UPXaqPAH2r20wj8p6MJo4MuQJdQNhcnr4rDf3WR+alJ8hSgKNpY04l9pp8mFZB19P5CsTcKU5IcosNk5aAooK6iFlWopfgH3GBc78BaOTbe7WdogDx4YDxk46CyYEH18WqUYXKyR26uL2E+EIS2OgzQmsatwc9V+WFaIewVaUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956655; c=relaxed/simple;
	bh=gDRDsahclwcs5DnfhiWtsCpBaiLQc/LT90mG3cg+0u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kei5NUrBgAUbHPBPhMR52ak674Rl20Pu0X5LnTtRBKIl1gdmCqa2ELvNsIBK9eeqlVE6s9u44HV16pUl7QrDlyep43WUfcX/XrAAoVf13sG7SsyxEIeLIedBckHi4HIULvG/Oo6Tek3/QKwgMF27WLrPmqBpoeNoc+P3I4f9w7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNDMwmaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNDMwmaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139971F000FF;
	Wed, 14 Oct 2026 05:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791956653;
	bh=bKhl+eWIV1WD1LGKQ46fq2ZPjaJz0xT07fzAZhnuocw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YNDMwmawPgDET7uQJ1f0eaHAqZVdpnhGPJMIQxyHnCgl02+JYc29qTiGhn91eMbn3
	 gsxOZ1in8ds3wR+Y8UxKgqwMPIlMi00/Pdwd2zLbkUxA5dXmSrVtNjxd/g7M1nfBz0
	 shSYaWfhn0GyX6lDEQDUTl5AaUf3YhQZxiZ7mfdJGrNXMYd+yWC/HTNN4odl4W2D4m
	 pVPtd3H9Scyh4vZyQAFLQ2AfPRnd5A7lYH/PyhvgpIKGw/B/cEP4irI6GSaNPP2WhI
	 kI2z4iKjMCpPbjRvpkX6qI5H7zHmluUpKQOJU5RqmvK2A+J6MNg4BG/X4Uy4K0Ladr
	 fyJRig7aJh/0g==
Message-ID: <5b5faa39-1590-45b9-8a4a-ee328c53e826@kernel.org>
Date: Wed, 14 Oct 2026 07:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v3] ata: libata-core: Correct HPA horkage
To: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
Cc: IoannisBarkasjnyb.de@gmail.com, NickBarkasnickbgrk@gmail.com
References: <20261013201926.14456-1-jnyb.de@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261013201926.14456-1-jnyb.de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/13 22:19, Ioannis Barkas wrote:
> Code wrongly detects disks using 2 specific serial numbers
> Use their firmware to detect whole family of affected disks

s/firmware/firmware version ?

> 
> Fixes: 16c55b038033 (libata: implement BROKEN_HPA horkage and apply it to affected drives")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
> Signed-off-by: <Ioannis Barkas jnyb.de@gmail.com>
> Signed-off-by: <Nick Barkas nickbgrk@gmail.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d..b23e1c3e4c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  
>  	/* devices which puke on READ_NATIVE_MAX */
>  	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },
>  	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
>  
>  	/* this one allows HPA unlocking but fails IOs on the area */


-- 
Damien Le Moal
Western Digital Research

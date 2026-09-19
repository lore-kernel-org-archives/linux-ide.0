Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05628314D06
	for <linux-ide@vger.kernel.org>; Sat, 19 Sep 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838498; cv=none; b=toctmM2Uwg6NUY3sLiQwOF3MWsMBZ34mhtH7YCaTHFq0an/cFdZsB39rArpx2ckWTPhBZHfCeGCW+aIMzuP/d7IuoY/J/auB7nFX2e3c6V0mc1ZTy7GKmI564n89BaaEb9yy6Rsmkhq0ftBnWyZbFg2cZgUwzHb1Y2kPdGSg794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838498; c=relaxed/simple;
	bh=xvxxF47ICg63VNu3DVmOABXXnpysyrQcgc7hc9HE0Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kw4ajDT/HnM+B6+qnaWg0Y1Hfr0lF82A3cUpubFdbnrgqxhjTl9r2JyfDE4XgEIDtV4dxkpfcIdHYkkyREnGdsO6niTCBRnFKKK2Zvi3FJUgp1YgiV1kF61TOPxaMqPOA1SjD33AoS3l9VhOJ8slNr9PZmXJmNULJAvA7tIGJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4r4QIJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4r4QIJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89601F000FF;
	Sat, 19 Sep 2026 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789838496;
	bh=5Kinmz0WAk3dSRF2dIlQ+wvyb7msBfuqQeayX7fM9b0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T4r4QIJb7A8954FSOBKTqRVPJvRe/sGJUoJPY8ksgrLD9+ZE8Qq9JfqggE1IbIRKl
	 xT6N+fQFTtO0yPqzSf73mRhtkgbCdGkwzFaFuv0nT1Gnvt0T2CUGYkiL2ayNl2Z5fy
	 UoxB7MatkfFQttgXKj8KmSadiZ6QZVdxacfVpWM92l0WRJ94ynv1xkT16IDe5HmPir
	 GkAxKgqo4UyS75DNXo2yI4XpHvAAllS0GjKyv7fQH3Dbipt6Onsv8R+R7vpfYUrT9S
	 jRRsNwZVPp9mylwB1bBHtbHY+DgOCokhYBHhEVUQpszkrNjKxF9djQ1MqPSMc6pR/B
	 si/+nU8Ja1+aQ==
Message-ID: <20c5cd79-a9a8-4fc3-8a46-d1313a650397@kernel.org>
Date: Sat, 19 Sep 2026 12:21:35 -0500
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-core: Extend Samsung LPM quirk to AMD
 controllers
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20260918124030.1962773-4-cassel@kernel.org>
 <20260918124030.1962773-5-cassel@kernel.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260918124030.1962773-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/26 07:40, Niklas Cassel wrote:
> A Samsung SSD 870 QVO 8TB connected to an AMD 600 Series chipset SATA
> controller is reported to time out on STANDBY IMMEDIATE during system
> suspend with med_power_with_dipm enabled. The command completes when
> using max_performance instead.
> 
> The existing Samsung LPM quirk only matches ATI controllers, leaving
> AMD controllers unaffected. Rename it to
> ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD and extend the vendor check to AMD for
> the same Samsung SSD model patterns. Keep LPM behavior unchanged for
> other controller vendors, including Intel.
> 
> Leave ATA_QUIRK_NO_NCQ_ON_ATI restricted to ATI, since the reported AMD
> issue concerns LPM rather than NCQ.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221986
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/ata/libata-core.c | 15 ++++++++-------
>   include/linux/libata.h    |  4 ++--
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f482c0a6d7e9..92233fb25051 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2972,9 +2972,10 @@ static void ata_dev_config_lpm(struct ata_device *dev)
>   		    (dev->id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
>   			dev->quirks |= ATA_QUIRK_NOLPM;
>   
> -		/* ATI specific quirk */
> -		if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI) &&
> -		    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
> +		/* ATI and AMD specific quirk */
> +		if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD) &&
> +		    (ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI) ||
> +		     ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)))
>   			dev->quirks |= ATA_QUIRK_NOLPM;
>   	}
>   
> @@ -4136,7 +4137,7 @@ static const char * const ata_quirk_names[] = {
>   	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
>   	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
>   	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
> -	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
> +	[__ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD] = "nolpmonatiandamd",
>   	[__ATA_QUIRK_NO_ID_DEV_LOG]	= "noiddevlog",
>   	[__ATA_QUIRK_NO_LOG_DIR]	= "nologdir",
>   	[__ATA_QUIRK_NO_FUA]		= "nofua",
> @@ -4420,15 +4421,15 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>   	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
>   						ATA_QUIRK_ZERO_AFTER_TRIM |
>   						ATA_QUIRK_NO_NCQ_ON_ATI |
> -						ATA_QUIRK_NO_LPM_ON_ATI },
> +						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
>   	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
>   						ATA_QUIRK_ZERO_AFTER_TRIM |
>   						ATA_QUIRK_NO_NCQ_ON_ATI |
> -						ATA_QUIRK_NO_LPM_ON_ATI },
> +						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
>   	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
>   						ATA_QUIRK_ZERO_AFTER_TRIM |
>   						ATA_QUIRK_NO_NCQ_ON_ATI |
> -						ATA_QUIRK_NO_LPM_ON_ATI },
> +						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
>   	{ "FCCT*M500*",			NULL,	ATA_QUIRK_NO_NCQ_TRIM |
>   						ATA_QUIRK_ZERO_AFTER_TRIM },
>   
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 313e96173b19..48bde275968d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -76,7 +76,7 @@ enum ata_quirks {
>   	__ATA_QUIRK_MAX_SEC,		/* Limit max sectors */
>   	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
>   	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
> -	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
> +	__ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD, /* Disable LPM on ATI and AMD chipsets */
>   	__ATA_QUIRK_NO_ID_DEV_LOG,	/* Identify device log missing */
>   	__ATA_QUIRK_NO_LOG_DIR,		/* Do not read log directory */
>   	__ATA_QUIRK_NO_FUA,		/* Do not use FUA */
> @@ -115,7 +115,7 @@ enum {
>   	ATA_QUIRK_MAX_SEC		= BIT_ULL(__ATA_QUIRK_MAX_SEC),
>   	ATA_QUIRK_MAX_TRIM_128M		= BIT_ULL(__ATA_QUIRK_MAX_TRIM_128M),
>   	ATA_QUIRK_NO_NCQ_ON_ATI		= BIT_ULL(__ATA_QUIRK_NO_NCQ_ON_ATI),
> -	ATA_QUIRK_NO_LPM_ON_ATI		= BIT_ULL(__ATA_QUIRK_NO_LPM_ON_ATI),
> +	ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD	= BIT_ULL(__ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD),
>   	ATA_QUIRK_NO_ID_DEV_LOG		= BIT_ULL(__ATA_QUIRK_NO_ID_DEV_LOG),
>   	ATA_QUIRK_NO_LOG_DIR		= BIT_ULL(__ATA_QUIRK_NO_LOG_DIR),
>   	ATA_QUIRK_NO_FUA		= BIT_ULL(__ATA_QUIRK_NO_FUA),


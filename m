Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159E1531C1
	for <linux-ide@vger.kernel.org>; Tue, 25 Nov 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030289; cv=none; b=eJUYG9AdKRR/q9bvzf4g8rezx+Q9slZedb0a8ptXbgQUwXz4KaISD7CEitYjtdJMuGIwYwJCAt69nA0wB7POw4+k7RIaMs2aLWus2R8RjsgifNXP6kdhQhaMcoo6Nl58xBWHQT1fjZia1ms59rnlcrcUQH8WXqCIuWplJ1+8ODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030289; c=relaxed/simple;
	bh=XAvCVndyHLvDtwADmP5BRy0RUgYN2rh0pdO6K51b9Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HejPSX12Rm+LBWP6eV0kcJSMmynnbCSOEZMpU7vwfsnrMI7Bj6ADFloS5WAGWjrll8x1XDJ/NhULGCHi8EtpyqrI8fXkvvWNrnEABTKgq1nTcDEs8NfANweJUj2SE/Oy+K4FioDGNP+6kPD6xOaxhvATrqpverTSTWFHEQO2bNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQn8bmzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQn8bmzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E22C4CEF1;
	Tue, 25 Nov 2025 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764030288;
	bh=XAvCVndyHLvDtwADmP5BRy0RUgYN2rh0pdO6K51b9Uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IQn8bmzuX7hUa3UyYhwBFSR9R7SG7xVW5XSJKEbGKppcViMb/6wP6dwl/HaKw/zHD
	 I2KBlWlDUmibdMogiMxojJstROBAOz+WzCishxOxuBroB1LuJo1bkItX4DfK+nAkqW
	 OcaLXb/eyI4FhEh/6DNYIz5rKIaE33lhitvqjMfqN4dEqPlxU8rdZaQu6Ppa3ZbWZj
	 EJCVSNZ21zchJHWEHUGvfkEpTY17u4SyO93RYjhYeJnEhS8F3oyy4aKK2Npn35vTnP
	 okJIRlnj06Rhdor7JE02VaXhRYlkjbnZZTsPBvxL8ZU7CC6ECIkhyRiEXfJlnmGka5
	 zQzZpaKRB02jg==
Message-ID: <4a5fe360-6d26-4d06-9eca-d087966fee0a@kernel.org>
Date: Tue, 25 Nov 2025 09:20:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ata: libata-core: Quirk DELLBOSS VD MV.R00-0
 max_sectors
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com
References: <20251124134414.3057512-5-cassel@kernel.org>
 <20251124134414.3057512-7-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124134414.3057512-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 10:44 PM, Niklas Cassel wrote:
> DELLBOSS VD MV.R00-0 with FW rev MV.R00-0 times out when sending
> I/Os of size 4096 KiB.
> 
> Add a quirk so that the SATA controller is usable again.

Please name the quirk here and describe it.

> 
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 12 ++++++++++++
>  include/linux/ata.h       |  1 +
>  include/linux/libata.h    |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f48fb63d7e85..be320c3e0fef 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3146,6 +3146,10 @@ int ata_dev_configure(struct ata_device *dev)
>  		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
>  					 dev->max_sectors);
>  
> +	if (dev->quirks & ATA_QUIRK_MAX_SEC_8191)
> +		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_8191,
> +					 dev->max_sectors);
> +
>  	if (dev->quirks & ATA_QUIRK_MAX_SEC_LBA48)
>  		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
>  
> @@ -3998,6 +4002,7 @@ static const char * const ata_quirk_names[] = {
>  	[__ATA_QUIRK_NO_DMA_LOG]	= "nodmalog",
>  	[__ATA_QUIRK_NOTRIM]		= "notrim",
>  	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
> +	[__ATA_QUIRK_MAX_SEC_8191]	= "maxsec8191",

It would be a lot better  if we could have a definition for this a little more
generic, that is, add a value to a generic "maxsec" quirk. E.g.:
 	
	[__ATA_QUIRK_MAX_SEC_8191]	= { "maxsec", 8191 },

That would avoid the need for more of these if other drives have different
limits. We already have 2 maxsec limit, this is the 3rd one...

>  	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
>  	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
>  	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
> @@ -4104,6 +4109,12 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "LITEON CX1-JB*-HP",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
>  	{ "LITEON EP1-*",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
>  
> +	/*
> +	 * These devices time out with higher max sects.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=220693
> +	 */
> +	{ "DELLBOSS VD MV.R00-0", "MV.R00-0",	ATA_QUIRK_MAX_SEC_8191 },
> +
>  	/* Devices we expect to fail diagnostics */
>  
>  	/* Devices where NCQ should be avoided */
> @@ -6455,6 +6466,7 @@ static const struct ata_force_param force_tbl[] __initconst = {
>  
>  	force_quirk_on(max_sec_128,	ATA_QUIRK_MAX_SEC_128),
>  	force_quirk_on(max_sec_1024,	ATA_QUIRK_MAX_SEC_1024),
> +	force_quirk_on(max_sec_8191,	ATA_QUIRK_MAX_SEC_8191),
>  	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
>  
>  	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index c9013e472aa3..54b416e26995 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -29,6 +29,7 @@ enum {
>  	ATA_MAX_SECTORS_128	= 128,
>  	ATA_MAX_SECTORS		= 256,
>  	ATA_MAX_SECTORS_1024    = 1024,
> +	ATA_MAX_SECTORS_8191    = 8191,
>  	ATA_MAX_SECTORS_LBA48	= 65535,/* avoid count to be 0000h */
>  	ATA_MAX_SECTORS_TAPE	= 65535,
>  	ATA_MAX_TRIM_RNUM	= 64,	/* 512-byte payload / (6-byte LBA + 2-byte range per entry) */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 171268d65169..39534fafa36a 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -75,6 +75,7 @@ enum ata_quirks {
>  	__ATA_QUIRK_NO_DMA_LOG,		/* Do not use DMA for log read */
>  	__ATA_QUIRK_NOTRIM,		/* Do not use TRIM */
>  	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
> +	__ATA_QUIRK_MAX_SEC_8191,	/* Limit max sects to 8191 */
>  	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
>  	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
>  	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
> @@ -115,6 +116,7 @@ enum {
>  	ATA_QUIRK_NO_DMA_LOG		= (1U << __ATA_QUIRK_NO_DMA_LOG),
>  	ATA_QUIRK_NOTRIM		= (1U << __ATA_QUIRK_NOTRIM),
>  	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
> +	ATA_QUIRK_MAX_SEC_8191		= (1U << __ATA_QUIRK_MAX_SEC_8191),
>  	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
>  	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
>  	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),


-- 
Damien Le Moal
Western Digital Research

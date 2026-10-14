Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5953ED04
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988498; cv=none; b=cH26htAOI5gGxj2hvx1qW7IjBv61uMkTZ/JgaPSWV7sbHtK6h3C2Be1ztAS1BFUxWfnBMVuup5bdKGOc4DVOv4MkM3xZrXi2phAENXdOMDmxuVoe6USgEdgS5cQnlVeRDvub2ETN0pvmAL/jsbaMFa2/xFDhBN9o9C3PcItclG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988498; c=relaxed/simple;
	bh=8WEBQBEBaDTJkhAX6V6rkmsv++1UKcl8jFRUWn96oXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahSIHBbppiPSIaTSOQrUI7c4C9HfpST4ujT3M1MC3R3yA82Z5ixw0f+NKlhyuXLLCHzq+j1pe2jcj60a25yu+LWIPb0SOob7cUfFKc+GUlPcFXnVMffKRkj7SG2enA4ouTbXQx4eQDgGapew2bqwrwoZIwFOb5n0L+zq4lUufoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoxJLRK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoxJLRK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536D1F000C4;
	Wed, 14 Oct 2026 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988497;
	bh=yJrB+5JSqEqRwar8VDYTTfTYFhFOgB3hyj9MEof5Ge8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UoxJLRK9IbnO04QltXY3nEe92e18ZEu61dNQcYmzhyVhthvhq3BVRdr3XItlqE+n5
	 PqKoPg/NP8R2uqMBSzC7NwEbgqYALnOM8Z7P3xJ/vQKFAAyvBWG5IL2MxNTKDolNdq
	 NsQXOQ7Yxgs2SB5GNzuwdUrUhdQz8GY6Czc9KLDGFP8pXjJb/TGjoEoKnBv4b6FSHF
	 yNkTeRmlxo6Qokn8ueXVj2V5kl6UYHGZjqyTcU+PlgeyuYajZ+FHIx4y7Fs27v0hiZ
	 G+gtf8Jz7z55a0gUep66kLCIq78cc0UUSQ+eWIPq8a93fGSCb7iLvrwlG+P0lVnH3p
	 SbZTtXndILywA==
Message-ID: <9136433e-297d-47b1-b341-7ebc008f3e43@kernel.org>
Date: Wed, 14 Oct 2026 16:34:55 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Fix NO_FUA quirks shadowed by earlier
 quirk entries
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20261013193915.174460-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261013193915.174460-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/13 21:39, Niklas Cassel wrote:
> ata_dev_quirks() uses the first entry in __ata_dev_quirks[] that
> matches the device and ignores all later entries. Commit 38d431229bfb
> ("ata: libata: exclude FUA support for known buggy drives") appended
> three ATA_QUIRK_NO_FUA entries to the end of the table, with model
> patterns meant to cover whole product lines. Earlier entries already
> match some or all of these drives, so NO_FUA is not always applied:
> 
> - "INTEL*SSDSC2CT*" never takes effect. Every model it matches also
>   matches the earlier "INTEL*SSD*" entry, so these drives only get
>   ATA_QUIRK_ZERO_AFTER_TRIM.
> 
> - "WDC*WD2500J*" does not take effect for "WDC WD2500JD-*" drives,
>   which match the earlier ATA_QUIRK_WD_BROKEN_LPM entry.
> 
> - "OCZ-VERTEX*" does not take effect for "OCZ-VERTEX" drives with
>   firmware "1.30", which match the earlier ATA_QUIRK_BROKEN_HPA entry.
> 
> Move the Intel entry in front of "INTEL*SSD*" and keep
> ATA_QUIRK_ZERO_AFTER_TRIM in it, so these drives stay on the
> ZERO_AFTER_TRIM whitelist. Add ATA_QUIRK_NO_FUA to the WD2500JD and
> OCZ Vertex 1.30 entries. The quirks of all other drives are unchanged.
> 
> libata only uses FUA when it is enabled with libata.fua=1, so systems
> using the default setting are not affected.
> 
> Fixes: 38d431229bfb ("ata: libata: exclude FUA support for known buggy drives")
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Your solution works, but I think it is very fragile. We will most likely again
make the same mistake with the oredering. So what about something like this:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 92233fb25051..980a6a6256b1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4515,6 +4515,7 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
        unsigned char model_num[ATA_ID_PROD_LEN + 1];
        unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
        const struct ata_dev_quirks_entry *ad = __ata_dev_quirks;
+       u64 quirks = 0;

        /* dev->quirks is an u64. */
        BUILD_BUG_ON(__ATA_QUIRK_MAX > 64);
@@ -4527,11 +4528,11 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
                    (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
                        ata_dev_print_quirks(dev, model_num, model_rev,
                                             ad->quirks);
-                       return ad->quirks;
+                       quirks |= ad->quirks;
                }
                ad++;
        }
-       return 0;
+       return quirks;
 }

 static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)

With this, all quirks that apply to a device will apply, even if there are
multiple matching entries. That will solve the issue and make things a lot more
solid.

> ---
>  drivers/ata/libata-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 92233fb25051..cff4ededafad 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4323,7 +4323,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
>  
>  	/* this one allows HPA unlocking but fails IOs on the area */
> -	{ "OCZ-VERTEX",		    "1.30",	ATA_QUIRK_BROKEN_HPA },
> +	{ "OCZ-VERTEX",		    "1.30",	ATA_QUIRK_BROKEN_HPA |
> +						ATA_QUIRK_NO_FUA },
>  
>  	/* Devices which report 1 sector over size HPA */
>  	{ "ST340823A",		NULL,		ATA_QUIRK_HPA_SIZE },
> @@ -4459,6 +4460,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "Crucial*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
>  	{ "INTEL SSDSC2KG480G8", "XCV10120",	ATA_QUIRK_ZERO_AFTER_TRIM |
>  						ATA_QUIRK_MAX_SEC },
> +	{ "INTEL*SSDSC2CT*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM |
> +						ATA_QUIRK_NO_FUA },
>  	{ "INTEL*SSD*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
>  	{ "SSD*INTEL*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
>  	{ "Samsung*SSD*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
> @@ -4479,7 +4482,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "WDC WD1200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
>  	{ "WDC WD1600JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
>  	{ "WDC WD2000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
> -	{ "WDC WD2500JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
> +	{ "WDC WD2500JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM |
> +						ATA_QUIRK_NO_FUA },
>  	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
>  	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
>  
> @@ -4504,7 +4508,6 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "Maxtor",		"BANC1G10",	ATA_QUIRK_NO_FUA },
>  	{ "WDC*WD2500J*",	NULL,		ATA_QUIRK_NO_FUA },
>  	{ "OCZ-VERTEX*",	NULL,		ATA_QUIRK_NO_FUA },
> -	{ "INTEL*SSDSC2CT*",	NULL,		ATA_QUIRK_NO_FUA },
>  
>  	/* End Marker */
>  	{ }


-- 
Damien Le Moal
Western Digital Research

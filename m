Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40453876D5;
	Tue,  7 Jul 2026 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404149; cv=none; b=MCELlIN8wMo5IPRK29DvREWWolbolmocUC62i4o4bkAQRagn1JaiJMynWJYj2/YR/Pw7Q+05UNq/T4eYzjBFM0sSVisL21ECIc/hExJZfIif1jI3Vqxc7Kfvp9Ooje7cXKloqO4m6U2Cl5125k0Lmfos+MnWJVnyQPzgp3Nx4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404149; c=relaxed/simple;
	bh=oIpVHqEYBjqZbgr+9M8T7cUo03eXGme60pYBDdh8WYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF+cgFjkGgn8hOfmzg2vsAJMFn+PvDZGQCXGN2DNJ+WeTa3TQvQgb08ylGYhpVI+GU5nWmiGP0F2XLg22Lw7qDdd4jHc+RL1601Z96Yr+TpPZhYol578oR0E+u9jQk496/IzWCAp2FiaIT1GaPtNEmI/m7ZEazlCIekpi/X30io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We5ghjfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We5ghjfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180701F00A3A;
	Tue,  7 Jul 2026 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783404147;
	bh=3qo9g8aB1t6caiIpsMU73ixnKHUfAwHCUhDor7D+Z94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=We5ghjfFT5xCUyj7f10p74GK/nLDk9QmTc404yR5VBv6SKx5koGUaNGBqG6a1H3Gm
	 X7rqrU2U058tEBnQ4gCIcNuUBFqAVfQhuhM5ET1MdMEGXRGLeY0vUYA4QEaDyD2eI0
	 Yq8Bmf7WQThcgfQUSVYTp3p74lGoHtNk07poroylYFUSU3FOD+RI8vhsgUZLMmAlaQ
	 Dj/ER/p8NVH0IrTU4Row4MZnzty2xTrqXAs/+uwbnXaEn41AwB90APwWG7x7RwR9qg
	 bdudWumY8bG2JPg4TiKodIr8wPv0jT/yLeOgsX5DS5mvA4MJdlMsPIS3/e/m06/OLV
	 ZUlmsVG6hvZ1g==
Message-ID: <3fbfd30e-1555-4ce2-9cb5-72807c1a8b23@kernel.org>
Date: Tue, 7 Jul 2026 15:02:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-core: Skip HPA resize for locked
 drives
To: TJ Adams <tadamsjr@google.com>, Niklas Cassel <cassel@kernel.org>,
 Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Pylypiv <ipylypiv@google.com>,
 Salomon Dushimirimana <salomondush@google.com>
References: <akaHPScetfl1VbF8@ryzen>
 <20260706210054.1336654-1-tadamsjr@google.com>
 <20260706210054.1336654-2-tadamsjr@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260706210054.1336654-2-tadamsjr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 06:00, TJ Adams wrote:
> Skip HPA resize in ata_hpa_resize() if the drive is security locked.
> If the drive is locked, the command to read the native max address
> fails with -EACCES, which currently causes the sticky quirk
> ATA_QUIRK_BROKEN_HPA to be set on the device.
> 
> Setting this sticky quirk causes subsequent revalidations (after the
> drive is unlocked) to bypass HPA checks, preventing the unlocked drive
> from exposing its full native capacity without a reboot or device removal.
> 
> Signed-off-by: Terrence Adams <tadamsjr@google.com>

Doesn't this need the same fixes tag as patch 2 ?

> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index bdc88cf74709..3c06a15952f8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1338,7 +1338,7 @@ static int ata_hpa_resize(struct ata_device *dev)
>  	/* do we need to do it? */
>  	if ((dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC) ||
>  	    !ata_id_has_lba(dev->id) || !ata_id_hpa_enabled(dev->id) ||
> -	    (dev->quirks & ATA_QUIRK_BROKEN_HPA))
> +	    (dev->quirks & ATA_QUIRK_BROKEN_HPA) || ata_id_is_locked(dev->id))
>  		return 0;
>  
>  	/* read native max address */


-- 
Damien Le Moal
Western Digital Research

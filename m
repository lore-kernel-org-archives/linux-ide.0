Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6256FC5;
	Wed,  4 Mar 2026 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586240; cv=none; b=o/Vv5K5yBm/q5a+MzNO/jDkc5x0PVi+IZ/gmZejos7dBcTPHiY56cJ37uH09IwDv4kD6aZ7PzHJ34PpLaQpHu2Hi3FubfdccGrPzcCK43ro59czXWkq+5lJitsCFHeoyrw8GeGBs9AppuveeVW3hTa3BDslKXYWMdnQ6Oj16TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586240; c=relaxed/simple;
	bh=yXTpb+U5/jwSEf+FnuQgi0uBtQX9WiiNoK3uMPa7Bvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/Hwo5Hi9Bt/4GPZ0jORWkahFsZP2qUdbzECj91iah7I20+ydB2wbi2g24yfLt0A9MIXrhg5wp2yN+Ri6bohHqs0ZojLs64SkhGjQq5/mFygDmzmJ+KiHhisBPgeDbI0PrHO2nyyj2aFnfVGh587UKyO1NXS/DsbdIlIjnw5zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKQhTTS+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKQhTTS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C373AC116C6;
	Wed,  4 Mar 2026 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586240;
	bh=yXTpb+U5/jwSEf+FnuQgi0uBtQX9WiiNoK3uMPa7Bvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GKQhTTS+lXs4UuN8LxX19hUriV6DRaArmacrxEnCsrUrDczq0g2jNotr0DFB/w9dl
	 81jyb3nCyimYlsFtZKGn5fouIWC0pVV7+DNhqJikPGwRDfq7zcLjL/mCXoPKUkXiiO
	 NoTCT6J+/LzLzJU8c0dszTzaKZ04+7K+Z2zbi6uOnsnNkhgX4abzuaRYqajoqpfxvM
	 ucxXpvJUBBhbrJpa/aeDHJlSwgGoktW3WfPZZUNB17mfZWEI0wo6fLHne6ujOBwqwI
	 eo5zy0z/Jjo3qsAWXTitctJB+pIexw+ON2aZ4YJdlgsdbh1fbiYsy2lzrsFBc86TQz
	 jyKbYIUGG8log==
Message-ID: <bfd26e16-e5ba-4293-a37b-c21289de27eb@kernel.org>
Date: Wed, 4 Mar 2026 10:03:58 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
To: Pedro Falcato <pfalcato@suse.de>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303183337.1013474-1-pfalcato@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260303183337.1013474-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 03:33, Pedro Falcato wrote:
> Currently, whenever you boot with a QEMU drive over an AHCI interface,
> you get:
> [    1.632121] ata1.00: applying bridge limits
> 
> This happens due to the kernel not believing the given drive is SATA,
> since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
> a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.

It would be nice to fix that in QEMU.

> QEMU shares IDENTIFY data between PATA/SATA drives (and the corresponding
> emulation of IDE/AHCI) but does not, in any way, emulate any of these
> real hardware details. There is no PATA drive and no SATA cable.
> 
> As such, add a BRIDGE_OK quirk for QEMU HARDDISK. This results in the
> max_hw_sectors being limited solely by the controller interface's limits.
> Which, for AHCI controllers, takes it from 128KB to 32767KB.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> Note: This may be ok for stable, but I'll leave it up to you. There is
> obviously no Fixes: here that doesn't go back 20 years.
>  drivers/ata/libata-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d61846f03edc..70703432063a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	/* Devices that do not need bridging limits applied */
>  	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
>  	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
> +	{ "QEMU HARDDISK",		NULL,	ATA_QUIRK_BRIDGE_OK },

Until we spend the time to improve QEMU ATA emulation, I think this is OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

I think adding a Cc-stable here makes sense too. Niklas, can you do that when
applying ?

>  
>  	/* Devices which aren't very happy with higher link speeds */
>  	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },


-- 
Damien Le Moal
Western Digital Research

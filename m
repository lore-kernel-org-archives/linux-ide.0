Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427962DF142;
	Mon, 22 Jun 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128553; cv=none; b=dlyspAk/JKeVE64In0h6VAPTKldJThQfdUrjRZr7S3ykcWdXm3bHbhve5gZgXZnJ62bHjhhWhJYIHYgYGPdMgQmDyK/qE39GESVp/zU738lnysehLqIAHanjRR61olMApQJmPP7G24KjReK+dkGscRCiZDrce5IyvA1H8EJQF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128553; c=relaxed/simple;
	bh=M9+PAevxzZdNV2zr5DmvY4dNk7nOnSr6azQkrd8qbl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUszAFiHGPPJz99vsvgwBVOIVEIHBxoecljH3e3BRU++e0pXm4FyWF3rCiF2EZsKbddGfeYoFedL94FsUhDKfg2kcBrIbUHV6i2kuIaCJ2/MioKf4EeJ7H0S3RA0lSEXCa0T6eo3Pv5zOVeel1vIKRQ+xUE931beH3Ds/gRLdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlYwQvve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlYwQvve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B961F000E9;
	Mon, 22 Jun 2026 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782128551;
	bh=oEb0XbF6wz2MZmwHgaRHqYfw+eyt89us2adMVE93nr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KlYwQvve+fNdHilrUceEI7yzprLvPjtWlUxOq5Pzh6frZHoCkfqGXCcbduQqtCEDB
	 V7PIoBeTdsiZzvQ89gXqwuOd5ON+kw/e2sjBeINamrKRpM8gFOlG6b+W0WLWUOUAHm
	 UjhW9bP0dg8Q2DS0lhzxrWA21SDE7yKB5/78JjyEosxh7qAT8yZreYkt1iPtnp2yI8
	 fD8oa9bWRvcaD0llnChg8u5tLhil1k0/lh0pO/AYXPux1zxorEf2cZxHMKsTD8tK6y
	 uXkAQTG8EI35QvGWoWaCenPyXvnEN/IWCy0FCB3WK13vOrQUMpglKeEcrZIT3lHEHB
	 J+/1uL/9hJVhw==
Message-ID: <306825e1-ce7f-48b2-a643-ba18af05c51f@kernel.org>
Date: Mon, 22 Jun 2026 20:42:29 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: Bound the VPD B9h ranges to the
 response buffer
To: hexlabsecurity@proton.me, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
 <20260619-b4-disp-6200c44e-v1-2-4624a4707d9e@proton.me>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260619-b4-disp-6200c44e-v1-2-4624a4707d9e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/26 11:36, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> ata_scsiop_inq_b9() writes one 32-byte range descriptor per
> cpr_log->nr_cpr into the fixed 2048-byte ata_scsi_rbuf with no bound.
> The count originates from the device (concurrent positioning ranges log
> 0x47, up to 255), so an INQUIRY VPD page B9h to a drive whose log
> advertises more than 62 ranges overflows the static buffer by up to 6168
> bytes: a global out-of-bounds write into adjacent kernel data.
> 
> Emit only as many descriptors as the response buffer can hold and size
> the page length to match. The companion core fix bounds the stored count
> against the device log, but a large self-consistent log still yields
> nr_cpr up to 255, so the emitter needs its own bound.
> 
> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/ata/libata-scsi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d43207c6e467..d43306c5d375 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2355,18 +2355,24 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
>  {
>  	struct ata_cpr_log *cpr_log = dev->cpr_log;
>  	u8 *desc = &rbuf[64];
> -	int i;
> +	int i, nr_cpr;
>  
>  	if (!cpr_log) {
>  		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
>  		return 0;
>  	}
>  
> +	/*
> +	 * The page is built in the fixed-size ata_scsi_rbuf, so the number of
> +	 * range descriptors returned is bounded by that buffer's size.
> +	 */
> +	nr_cpr = min_t(int, cpr_log->nr_cpr, (ATA_SCSI_RBUF_SIZE - 64) / 32);
> +

I do not think this is the right place to fix this. Rather, we should define the
maximum number of ranges we can support given a 2K rbuf, that is, (2048 - 64) /
32 = 62, and check on probe that we are not actually exceeding that value when
scanning the disk. If we do, warn and ignore CPR.

62 ranges would mean 62 actuators... We are light years away from seeing drives
with that many actuators (we are lucky if we get 2, so...).

So I think we can drop this patch and simply reinforce the checks on the number
of cpr in patch 1. Or make this additional patch another fix if you prefer.
Either way is OK with me.

>  	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
>  	rbuf[1] = 0xb9;
> -	put_unaligned_be16(64 + (int)cpr_log->nr_cpr * 32 - 4, &rbuf[2]);
> +	put_unaligned_be16(64 + nr_cpr * 32 - 4, &rbuf[2]);
>  
> -	for (i = 0; i < cpr_log->nr_cpr; i++, desc += 32) {
> +	for (i = 0; i < nr_cpr; i++, desc += 32) {
>  		desc[0] = cpr_log->cpr[i].num;
>  		desc[1] = cpr_log->cpr[i].num_storage_elements;
>  		put_unaligned_be64(cpr_log->cpr[i].start_lba, &desc[8]);
> 


-- 
Damien Le Moal
Western Digital Research

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740A14E2F2;
	Tue, 23 Jun 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176744; cv=none; b=iyetfl3iIYljhXEYjRMZo8gxgarGkPZ8l0ncrrmEdRxvRwwyPEH40Hk/UsNwz2cA3ukTt4FWAgiEN0TCT9CqtzjEQeXcN24BMHNQrMIcMNVDiKLXEmvYr+YC685TGZuVeV8RVfbbzlkE5VfkxJDly+JpPMlV6pB7g6lM4WsK7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176744; c=relaxed/simple;
	bh=AtPnw00SmrkvZuEAVNLeoWYuPX38bbPpDqJgC3014Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HL+e3JropeeAWeROjopSctxY3qVxnwycPVu/ZBUfeG9lm0PSDRjyZ7rlmm+wv+tMroiUwp9ExCrvLM4AgRW8w9mQGmYlm2e6SirDpYVWFfk1f22KyCiF5tmHPdWuacWP6JWkIJhLgLXfqeeAULtt7T93wVzhYbOE+I1zXMArlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz5hHDTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz5hHDTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBE81F000E9;
	Tue, 23 Jun 2026 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782176742;
	bh=D+lvOeO1geMPIziPShS92aoEFFvift95QD7a7ij0aEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cz5hHDTyekR8ymGZxNwRBnNV7DkD727Vx4WieUtPUp98F3peDMMOS3AA8NZkpYJ4W
	 yXjEs0IaRKD69pPQm/dLsyEaYZmE78Rqrq4gxRNNBBEPiUIpmH3fknXiH8w+I8DDbw
	 q01706WGyOo7Qr9iORuVLqHWiFTWmUB0ZuuGfN1kf2jI1fOUD12QeB+kk60jXKeBxC
	 Yg/g5oZwHVYTFZdES80FmNTk6Cy8juf1+AHRbOKXO73sl1qShYGu2sp3dUlWQI4moc
	 TyiCvn0w/CzimTn3lE/8VPTgjU8uSAlLEB96yuENEMWT2c/0WJD/rWYtoSoDjtZWMu
	 jVs9ZWNBBTcFg==
Message-ID: <3c4c497a-54a1-410b-a950-b07ff4296355@kernel.org>
Date: Tue, 23 Jun 2026 10:05:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
To: hexlabsecurity@proton.me, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 03:38, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> ata_dev_config_cpr() takes the number of range descriptors from buf[0]
> of the concurrent positioning ranges log (up to 255), which the device
> reports independently of the log size in the GPL directory. The count is
> then walked at a fixed 32-byte stride in two places with no bound: the
> log read here, and the INQUIRY VPD page B9h emitter, which writes one
> descriptor per range into the fixed 2048-byte ata_scsi_rbuf. A device
> reporting a count larger than its own log overflows the read buffer (up
> to 7704 bytes past a 512-byte slab), and a count above 62 overflows the
> response buffer on the emit side.
> 
> Bound the count once, on probe, against both the log the device returned
> and the 62-descriptor capacity of the VPD B9h buffer; warn and ignore the
> log when it does not fit. Capping the stored count keeps the emitter in
> bounds with no separate change there.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
> Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v2: Per Damien Le Moal's review, reject an inconsistent count instead of
>     clamping it, and fold the emitter bound into this single probe-time
>     check: a count above 62 (the VPD B9h 2048-byte buffer capacity) or one
>     that does not fit the device's own log is rejected with a warning. That
>     makes the separate emitter patch unnecessary, so v1 2/2 is dropped.
>     v1 1/2: https://lore.kernel.org/all/20260619-b4-disp-6200c44e-v1-1-4624a4707d9e@proton.me/
>     v1 2/2: https://lore.kernel.org/all/20260619-b4-disp-6200c44e-v1-2-4624a4707d9e@proton.me/
> 
> A/B with a userspace AddressSanitizer mirror of both sinks (-m64 and -m32;
> the unbounded value is device log content, not bus state, so no hardware is
> needed):
> 
>   count  buf_len  with this patch
>   2      128      accepted (conforming drive)
>   62     2048     accepted (62 actuators, the documented maximum)
>   63     8704     rejected (exceeds the 62-descriptor VPD B9h buffer)
>   255    8704     rejected (self-consistent log, but the emit would overflow)
>   62     512      rejected (count does not fit the device's own log)
>   255    512      rejected
> 
> Without the patch the 512-byte rows fault on the log read and the >62 rows
> fault on the VPD B9h emit; with it every count the emitter can still receive
> fits the 2048-byte buffer. Reproducer available on request.
> ---
>  drivers/ata/libata-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3d0027ec33c2..017a16be158b 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2832,6 +2832,18 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>  	if (!nr_cpr)
>  		goto out;
>  
> +	/*
> +	 * The count is reported independently of the log size and is also
> +	 * emitted into the fixed 2048-byte VPD B9h buffer, which holds at most
> +	 * (2048 - 64) / 32 = 62 descriptors. Reject a count that exceeds that
> +	 * or does not fit the log the device returned.
> +	 */
> +	if (nr_cpr > 62 || buf_len < 64 + (size_t)nr_cpr * 32) {
> +		ata_dev_warn(dev,
> +			     "Invalid number of concurrent positioning ranges\n");
> +		goto out;
> +	}

Yes, this is much nicer. However, the hardcoded 62 is not great. If we ever
change the rbuf size, this will be wrong and we will have a hard time noticing
it. So let's do this properly and define something like:

#define ATA_DEV_MAX_CPR	((ATA_SCSI_RBUF_SIZE - 64) / 32)

in drivers/ata/libata.h
That requires moving the definition of ATA_SCSI_RBUF_SIZE for libata-scsi.c to
libata.h, which is fine.

Also, we may want to separate the checks to have a different warning:

	if (nr_cpr > ATA_DEV_MAX_CPR) {
		ata_dev_warn(dev,
			"Too many concurrent positioning ranges\n");
		goto out;
	}

	if (buf_len < 64 + (size_t)nr_cpr * 32) {
		ata_dev_warn(dev,
			"Invalid number of concurrent positioning ranges\n");
		goto out;
	}


> +
>  	cpr_log = kzalloc_flex(*cpr_log, cpr, nr_cpr);
>  	if (!cpr_log)
>  		goto out;
> 
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260622-b4-disp-5734c6f2-8f8c307f8bf1
> 
> Best regards,


-- 
Damien Le Moal
Western Digital Research

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCD158A1F;
	Mon, 16 Sep 2024 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505752; cv=none; b=BF/iiiRDGe972OeIsr29voJ/i1XvODFlQr/dFKahl7XLb92SLS5xyfQWL7lTF2OLUE0UxBvSLB2lO/zWczyXydE1mcb7qB4ZeGSCrrI3rwBxWzfSCR3lsGYG4oJN3eUmDQ66u1Hgk/58i+ifqMI28FXLZqSrK/l5XhnpOmsM08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505752; c=relaxed/simple;
	bh=RYpfdNmKaTeXJbERjP90RBtpFHg2AYlXmWBqtQKGlVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3kgtSfWASrjzbpPKbgwF00F0+z1HIVJjkBEhrUUuBY48oFhpoGtlQkJ4Hf8oQqjmth+JV203+c0S9qPymEO3UkZLGDye1zCHV2LvKLs81CoXhCyymuryLVdHXp6+neX12Ich7LDBT806xglSZieUdZ58FZh4pcCwkb/BZn3jVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwxhHVyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwxhHVyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A058BC4CEC4;
	Mon, 16 Sep 2024 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726505751;
	bh=RYpfdNmKaTeXJbERjP90RBtpFHg2AYlXmWBqtQKGlVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JwxhHVyx91Zp6uLhWlX7B4CpVwUAqb3iVL3N20Q5aH8g86CGt4rB6nkTwH24CyTvS
	 yzHJJiMUWCzAqPKOtAtQ1dHjakp1tSrzAGva81+1Oe8HpK1Yd37K/3Y9uchMPzSdDC
	 kTuAbdD77g+YZuffbbA4JE4z7ZTg8N1M6uE8FGpfAe9s/PKs5G+llAGYOISSayqBih
	 eAv7bpxR1RADxDydqDoTwjsh5AUi6GvpuiubrwMKGb2yxRMY9zw5sWG3UNG1SOkfEQ
	 jUSrKhU8na4qIkjgGR1QtQawzIFERBKI9c7hpBLbv783ZfB0+eYonLmFoiOxiSIbBO
	 hiDuYb/CCE8DA==
Message-ID: <94fa1f20-6bfa-4ae5-8f96-cf0d8ed9b3ac@kernel.org>
Date: Tue, 17 Sep 2024 01:55:27 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Fix the low data link negotiation
To: Guoliang Zhang <zhangguoliang@zspace.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240916074232.2584182-1-zhangguoliang@zspace.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240916074232.2584182-1-zhangguoliang@zspace.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/16 16:42, Guoliang Zhang wrote:
> large capacity hard drives, such as the 16TB Seagate hard drive in hotplug,
> have data link negotiations that only reach 3.0 Gbps.
> The reason for the issue is that after powering on, the hardware reset time
> of the hard drive is relatively long.
> In the driver, after the hardreset signal is sent, the waiting time for the
> first two tries is too short,
> causing the hardware reset to fall into a vicious cycle.
> 
> log is as follows:
> [ 959.461875] ata7: found unknown device (class 0)
> [ 963.686830] ata7: softreset failed (1st FIS failed)
> [ 969.442516] ata7: found unknown device (class 0)
> [ 973.686229] ata7: softreset failed (1st FIS failed)
> [ 979.426704] ata7: found unknown device (class 0)
> [1008.687432] ata7: softreset failed (1st FIS failed)

These messages are not normal and do not correspond to a drive that is slow to
spinup. These are generally indicative of bad communication with the device.
I ran into this the other day and solved the issue by using a better SATA cable...

If the drive is slow to spinup and takes time to start responding to commands,
you should see the message:

"link is slow to respond, please be patient "

which is issued by ata_wait_after_reset() -> ata_wait_ready(). The "1st FIS
failed" error indicates that the first H2D FIS sent to the device with the SRST
bit set does not give the correct answer, that is, the SRST bit is NOT set to
one in the Device Control register. Software reset should work always regardless
of the power state of the drive (spun down or not). So this error has nothing to
do with the timeout length, which is used for this first phase of the reset
sequence as a convenience but is really intended as a timeout value for waiting
for the link to become ready, which may take time if the device is spinning up.

> [1008.687447] ata7: limiting SATA link speed to 3.0 Gbps
> [1009.566733] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 320)

This is the result of the sofreset failing due to the "1st FIS failed" errors,
and NOT due to the fact that the drive is slow to spin up.

> [1009.567405] ata7.00: ATA-11: ST16000NT001-3LV101, EN01, max UDMA/133
> [10009.613694] ata7.00: 31251759104 sectors,
> multi 16: LBA48 NCQ (depth32), AA
> [10009.614223] ata7.00: Features: NCQ-sndrcv
> [10009.639149] ata7.00: configured for UDMA/133
> [10009.639366] scsi 6:0:0:0: Direct-Access  ATA ST16000NT001-3LVEN01
>  PQ: 0 ANSI: 5
> [10009.639779] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [10009.639989] sd 6:0:0:0: [sdc] 31251759104 512-byte logical blocks:
> (16.0 TB/14.6 TiB)
> [10009.639999] sd 6:0:0:0: [sdc] 4096-byte physical blocks
> [10009.640028] sd 6:0:0:0: [sdc] Write Protect is off
> [10009.640038] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [10009.640082] sd 6:0:0:0: [sdc] Write cache: enabled, read cache:enabled,
> doesn't support DPO or FUA
> [10009.717866]  sdc: sdc1 sdc2 sdc3 sdc4
> [10009.739038] sd 6:0:0:0: [sdc] Attached SCSI disk
> ========
> Logs after modify:
> [  661.023298] ata7: found unknown device (class 0)
> [  675.253714] ata7: softreset failed (1st FIS failed)
> [  680.996545] ata7: found unknown device (class 0)
> [  695.251101] ata7: softreset failed (1st FIS failed)

The errors are still here... So either you have a bad SATA cable, or the drive
reset sequence is not per specs. Changing the timeouts to a longer interval is
not removing these errors, so you are not actually fixing anything here.

Please check your cable. If that does nothing, I suggest contacting the drive
vendor about this.

I have plenty of drives that are slow to spin up and they do NOT generate that
FIS error.

> [  696.131404] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  696.132140] ata7.00: ATA-11: ST16000NT001-3LV101, EN01, max UDMA/133
> [  696.172742] ata7.00: 31251759104 sectors, multi 16: LBA48 NCQ (depth
> 32), AA
> [  696.173327] ata7.00: Features: NCQ-sndrcv
> [  696.198155] ata7.00: configured for UDMA/133
> 
> Signed-off-by: Guoliang Zhang <zhangguoliang@zspace.cn>
> ---
>  drivers/ata/libata-eh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..9e0f17e93e73 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -80,7 +80,7 @@ enum {
>   */
>  static const unsigned int ata_eh_reset_timeouts[] = {
>  	10000,	/* most drives spin up by 10sec */
> -	10000,	/* > 99% working drives spin up before 20sec */
> +	20000,	/* > 99% working drives spin up before 30sec */
>  	35000,	/* give > 30 secs of idleness for outlier devices */
>  	 5000,	/* and sweet one last chance */
>  	UINT_MAX, /* > 1 min has elapsed, give up */

-- 
Damien Le Moal
Western Digital Research


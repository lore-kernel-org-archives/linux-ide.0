Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74972D838E;
	Sun, 20 Sep 2026 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878738; cv=none; b=Jl9pYICopV9mmIO3R5Ukfn2dqZT9mtvftEli/dQGUezzDY0SF9Zv1RQ+ESTMx4wF21Cf4KDksZ5q2FxRodZa/urOTpt/9/OhhPAY/hucZHOfmxJ/GR0f5FJSfoqcJSLLXHUy5raMTTQr7i4ljJU621uLfkZsiBDsxKAYecc8kWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878738; c=relaxed/simple;
	bh=E1RASm9w8tOLrkqRRr7nXEskxGSCGoS68WOCE1NzR7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaBzyTcu6lYmDSUL7Ibh0ZeWzx9OyGG4fzBVMA74S+HFbQbee+Fd8tXGv15cDCjHKkKhpm2IjlrJB2ZtpeaWyI7Kt5UkajA1B4SziMbEzo28UUpfLenlbbiWX9Fylo41FJe2PT/pBE4GzjxVDiyReRcc+FUhahs0sgYubBA+mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhXLUwDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhXLUwDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1417A1F000FF;
	Sun, 20 Sep 2026 04:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789878736;
	bh=o2KCJrYmRm3NADoQED7XZPrawKQRuNurhTE+oIENGbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UhXLUwDWs6EZmNNBgTHgPr/Dxn301TOmHI9PQqJYDsVtqb0mkhI21Gbk/2vCuCh+U
	 EJSdQ7X++O3ems2eaPa4Dqn/Sr9+1RA/PeRQftgxk6cv/Rmis1uYLdIgZsGSsT81nu
	 VZ5tKNMSSagPsXIggT3eZrM2csLbZ8dYNtvTx1voogrS46xNjLEbo6otFv2NDj5hja
	 TMrvwT0a8K2DT0eqdUsEn/GBlikHeTzbD6lWqIKZEVgorDR+HgSH8R6vUYfuK6FfTb
	 VSqETcsHCjU5QUhGgdh9DB10u1T+2W83AFV3hMDxxK0mEz6nIveew55gkCosGd0AO5
	 ICRXyI7vwULmQ==
Message-ID: <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
Date: Sun, 20 Sep 2026 13:32:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: reject multi-sector taskfile commands
 when dev->multi_count is 0
To: Hui Peng <benquike@gmail.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260919222625.3797581-1-benquike@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260919222625.3797581-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/26 07:26, Hui Peng wrote:
> In ata_scsi_pass_thru() (drivers/ata/libata-scsi.c), issuing
> ATA_CMD_READ_MULTI / ATA_CMD_WRITE_MULTI / ATA_CMD_READ_MULTI_EXT /
> ATA_CMD_WRITE_MULTI_EXT / ATA_CMD_WRITE_MULTI_FUA_EXT via SG_IO when
> dev->multi_count == 0 sets qc->sect_size = 0 and triggers a divide-by-

Where do you see that?

> zero or WARN_ON in the ATA PIO/taskfile path. Reject ATA_PROT_PIO multi-
> sector commands with -EINVAL when dev->multi_count == 0.

That is not what your patch is doing.

> 
> Fixes: c6fd280766a0 ("Move libata to drivers/ata.")
> Assisted-by: LLM

See below, but you should tell your AI to read the ACS and SAT specs first. Or
better: check the specs *yourself* and analyze what is said before sending
patches that are not correct.

> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b3666519b648..c99f2845d09b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3507,6 +3507,11 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  	if (is_multi_taskfile(tf)) {
>  		unsigned int multi_count = 1 << (cdb[1] >> 5);
>  
> +		if (!dev->multi_count) {
> +			fp = (cdb[0] == ATA_16) ? 14 : 9;

ACS-3, which is the last ACS specification version without an obsolete
definition of multi-sector PIO read/wrtite states that:

If IDENTIFY DEVICE data word 59 bit 8 (see 7.12.7.21) is cleared to zero, and a
READ MULTIPLE EXT command is received by the device, and the device has not
returned command completion without an error for a SET MULTIPLE MODE command,
the device shall return command aborted.

The same statement is also present for WRITE MULTIPLE command.

Now referring to the SAT specifications, you can see that an ABRT (aborted
command) error should be reported as failed with the ABORTED COMMAND sense key
and NO ADDITIONAL SENSE INFORMATION additional sense code.
So here, the correct error to return is not invalid field.

> +			goto invalid_fld;
> +		}
> +
>  		/* compare the passed through multi_count
>  		 * with the cached multi_count of libata
>  		 */


-- 
Damien Le Moal
Western Digital Research

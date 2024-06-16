Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98E1C6A8;
	Sun, 16 Jun 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718579634; cv=none; b=c5vgg5rIb2DKBzsvgD3e0Stbcep4DAxm7DRSvUEAu5fSSUeKs7JiT0MzqsAaa29CjEOjwBbeH6VeKOhJ5WM2PRdn4fmpiDSN0CFZDY5izdX4p47xm7kKKX63IDvsRzuB3KjiXN+Otv/X6WMg8Q9IHHMl04DkkkSBuofF73w5az8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718579634; c=relaxed/simple;
	bh=ImeGSr5Au9G+JHm74kgUWkXXoP4SyiI8uTK738bqMVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtTDaBZECgxpMWl714GJ6+QH3MAK3N83Z+2DVMKnO3mDkSzTf0u0aMqPhs/m2p7pjbeQ0vV2O989Ndxb4M5siF0vmpxEETO08ZnOsvfCrDFpyORG07R8tXBTnycbB0WD8V8pGK8nTBEj8wSLpibVYCQsGP8uc43c1FdpxLxGWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhOzvRSW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhOzvRSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89683C2BBFC;
	Sun, 16 Jun 2024 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718579633;
	bh=ImeGSr5Au9G+JHm74kgUWkXXoP4SyiI8uTK738bqMVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EhOzvRSWdsxU9jiT7E4B9g/4xi8wO6V/agtahj3dBtMCsGraC+MqHJgOslW1y91HH
	 82ZAFifmSwnioy7LITS/M5klZv3QXbTpHj3JThxHBi1PoZUMCBHbfMnrMpWmmT36qy
	 fxsl/UlHUFn+zZ+dkxBBZCBaUJpBRa4U9mC8egzRm/U+b7d42mHyXCkDLgyHCOakWk
	 fSlu8W3E48A6OgzboP0/aatZzbcXntj0XnuxAq76nqvKNxmC/Hgu0V++6K76tNROii
	 hGZQENFTWqtOXYIDRTRgd3hvjfPEiPBlTB759nsGcoNhv4r4+aGCY2vESPUdDsjK98
	 3InzWJNoZArQw==
Message-ID: <2e89e829-9caa-470a-9ec8-5e8162fb5559@kernel.org>
Date: Mon, 17 Jun 2024 08:13:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240614191835.3056153-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/24 04:18, Igor Pylypiv wrote:
> scsi_queue_rq() memsets sense_buffer before a command is dispatched.
> 
> Libata is not memsetting sense_buffer before setting sense data that
> was obtained from a disk so there should be no reason to do a memset
> for ATA PASS-THROUGH / ATAPI.

This sentence is not very clear at all... I assume that the first part of the
sentence is for non passthrough commands. In this case, libata does not clear
the sense buffer because the scsi layer did that already, in scsi_queue_rq() as
noted above.

For passthrough commands, the same should be happening as well since passthrough
commands are also executed through blk_execute_rq() -> scsi_queue_rq(). So I do
not really understand (but I do agree that the memset() in libata seem useless).

> Memsetting the sense_buffer in ata_gen_passthru_sense() is erasing valid
> sense data that was previously obtained from a disk. A follow-up patch
> will modify ata_gen_passthru_sense() to stop generating sense data based
> on ATA status register bits if a valid sense data is already present.

This fix should come first in the series, since that commit will likely need to
go into current rc and cc-stable. And that will simplify this patch as well.

> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-eh.c   | 2 --
>  drivers/ata/libata-scsi.c | 4 ----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..b5e05efe73f6 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1479,8 +1479,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_taskfile tf;
>  
> -	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	/* initialize sense_buf with the error register,
>  	 * for the case where they are -not- overwritten
>  	 */
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index cdf29b178ddc..032cf11d0bcc 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -858,8 +858,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	unsigned char *desc = sb + 8;
>  	u8 sense_key, asc, ascq;
>  
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	/*
>  	 * Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
> @@ -953,8 +951,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  	u64 block;
>  	u8 sense_key, asc, ascq;
>  
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	if (ata_dev_disabled(dev)) {
>  		/* Device disabled after error recovery */
>  		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */

-- 
Damien Le Moal
Western Digital Research


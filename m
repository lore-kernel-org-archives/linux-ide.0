Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D218A6DF
	for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738131797; cv=none; b=kHeDfcqY35JnaVUKz4khhgsigJ6jA5sR+SHnpFkDiC27alL7WBH3yIiO5jHbVC3EC4e/hsbXjB5bnihWbrkAquzVOan6/5+4rotvamNoi6+tV2h8/kDfPHWPY7bN3gW/t4kE3INhxWSBo69Ioo4Eiv/JZVe957+cJUueaOku9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738131797; c=relaxed/simple;
	bh=BhxQMqcZedzjU2qtDipBBeXzDaNAedoASA3n2cnUgag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijh6eFCw5JPjmIidlSQdRVdOBhADR6qAMUnhkeC9qPYO+JOR3VgxSv9nLBBbHVScZQJmsadP/ZmsUemlZGvfEVRUWlDRNPXQh76aMqZKLtibS8JG0PsR1a5Ec0NbEzI2cYXAUcPzX7GAnCsVJcz3EXn5Rjhr8cIGT7D2Atu2tHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU0NmwSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU0NmwSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88311C4CED3;
	Wed, 29 Jan 2025 06:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738131796;
	bh=BhxQMqcZedzjU2qtDipBBeXzDaNAedoASA3n2cnUgag=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SU0NmwSzsBII0A0+Btzzrv4MVtcM7NA2eAdWOpHBHYDMR8cXuxSzv1aJ+AnDp/yJD
	 qURFf10QMNG8dgF7ztHwjktmOe+klJ0453fG63MERe8CUbNPdSJIklXocQhnBm37rz
	 5ybrC5oAoIupe+8gx9DTs0D/4tMf+9jNLhr+IAZMZvG++OaGIBbn/hLOtcuEsCTgtx
	 VVrrNSLJlRO7vfgAdh6YF251wM4qL4844ib1Qw90PjGmphJM0cixzTSgGG7LhXf1rJ
	 ag7BS6GVZSwD/gqL2aQM6rKAfLBasEnIRRE44/L958xJ0e8wbNWfPcjhjCtLQ9ueLe
	 vxHBHmKcDxXJQ==
Message-ID: <59b84a1d-2d76-4460-bfac-1c45c420124a@kernel.org>
Date: Wed, 29 Jan 2025 15:22:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems while retrieving SMART information via C602 SAS
 controller since 6.6.51
To: =?UTF-8?Q?Christian_K=C3=BChnke?= <christian@kuehnke.de>,
 linux-ide@vger.kernel.org
References: <1c79066a-9349-4f65-9ef2-dba4cf12361a@kuehnke.de>
 <f437dee3-4236-4146-bd91-abb6f611874f@kuehnke.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f437dee3-4236-4146-bd91-abb6f611874f@kuehnke.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/28/25 9:47 PM, Christian Kühnke wrote:
> I think, I found the root cause.

Please CC the maintainers if you want your email to not be lost in the noise of
the lists...

scripts/get_maintainers.pl drivers/ata

> 
> Kernel 6.12.11 and Kernel 6.13 do _not_ exhibit the problem and to my untrained
> eye, the affected layer has been reworked quite a bit in these versions.
> 
> After reviewing the mailing list archives and the kernel commit logs I suspect
> the following patch is missing from the kernel 6.6 stable series. It was
> developed by Igor together with the patches to libata-sata, but it did not make
> it into the 6.6 stable branch of offical kernel.
> 
> After applying this to 6.6.74, that version also works like a charm (without
> backing out the libata-sata patch).
> 
> From 18676c6aab0863618eb35443e7b8615eea3535a9 Mon Sep 17 00:00:00 2001
> From: Igor Pylypiv <ipylypiv@google.com>
> Date: Tue, 2 Jul 2024 02:47:34 +0000
> Subject: ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
> 
> ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
> to check if qc->result_tf contains valid data.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Link: https://lore.kernel.org/r/20240702024735.1152293-7-ipylypiv@google.com
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

So this needs to be sent to stable.

Please see: Documentation/process/stable-kernel-rules.rst

To get this patch added to 6.6, you fall into option (2):

Option 2
********

If the patch already has been merged to mainline, send an email to
stable@vger.kernel.org containing the subject of the patch, the commit ID,
why you think it should be applied, and what kernel versions you wish it to
be applied to.

> ---
>  drivers/ata/libata-core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> (limited to 'drivers/ata/libata-core.c')
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4f35aab81a0a38..45e3acb466c32a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4794,8 +4794,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
>  {
>      struct ata_port *ap = qc->ap;
>  
> +    /*
> +     * rtf may already be filled (e.g. for successful NCQ commands).
> +     * If that is the case, we have nothing to do.
> +     */
> +    if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> +        return;
> +
>      qc->result_tf.flags = qc->tf.flags;
>      ap->ops->qc_fill_rtf(qc);
> +    qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  }
>  
>  static void ata_verify_xfer(struct ata_queued_cmd *qc)


-- 
Damien Le Moal
Western Digital Research

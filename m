Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFF2D043
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScW/VNiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A3DC433C7;
	Fri,  5 Jan 2024 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704457762;
	bh=uZa4ht7q05AEdFwXoOxSfWehg+cy6+hrNP6+nY9S3pI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ScW/VNiXhubiRAydTc2mrJ5pGsGThpA3lyLkNuEa04DcNJ6HL5hA/iTT8qRujIxA2
	 RV6XFPpTHFYcZKmuzrvV6WaGcoe1H8OSKcGf9Qult2eXwk9BUr3/txiFg0bgkH6lfK
	 pQK3oVxrRI/lgedPwvF79VV9Kxm9Hfk2ECmxYRFENTstRqeDg41Vy61VhAfNNzqCTX
	 EFm9Lw3Vfzw40PhDd+iuLRIOYvGQ9UxWYvZBW7XQ6kj2YTf152K+LQuG47LCiSarnw
	 RXfPYKvEC8JYwz6HUqykhazP1Le/R/x+Yv7vQMAXi+1+BsgY5IBpGzzd9NNg/g2H4Z
	 bS/5o4JfB/sGw==
Message-ID: <96e45a4c-06b2-4610-abcd-153ef2a48c5e@kernel.org>
Date: Fri, 5 Jan 2024 21:29:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240104223940.339290-3-phill@thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 07:39, Phillip Susi wrote:
> When a disk is in SLEEP mode it can not respond to any
> commands.  Instead of waking up the sleeping disk, fake the
> commands.  The commands include:
> 
> CHECK POWER
> FLUSH CACHE
> SLEEP
> STANDBY IMMEDIATE
> IDENTIFY
> 
> If we konw the disk is sleeping, we don't need to wake it up
> to to find out if it is in standby, so just pretend it is in
> standby.  While alseep, there's no dirty pages in the cache,
> so there's no need to flush it.  There's no point in waking
> a disk from sleep just to put it back to sleep.  We also have
> a cache of the IDENTIFY information so just return that
> instead of waking the disk.

What ? If you wake up the drive, it will not be in standby... So I do not get
your point here. Can you clarify ? What is the problem you are trying to solve
here ? Is it related to system or runtime suspend/resume ?

And no, not a chance we fake commands like this.

> ---
>  drivers/ata/libata-core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1244da8f77e2..d9e889fa2881 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5045,6 +5045,22 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>  
>  	/* if device is sleeping, schedule reset and abort the link */
>  	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> +		if (unlikely(qc->tf.command == ATA_CMD_CHK_POWER ||
> +			     qc->tf.command == ATA_CMD_SLEEP ||
> +			     qc->tf.command == ATA_CMD_FLUSH ||
> +			     qc->tf.command == ATA_CMD_FLUSH_EXT ||
> +			     qc->tf.command == ATA_CMD_STANDBYNOW1 ||
> +			     (qc->tf.command == ATA_CMD_ID_ATA &&
> +			      !ata_tag_internal(qc->tag))))
> +		{
> +			/* fake reply to avoid waking drive */
> +			qc->flags |= ATA_QCFLAG_RTF_FILLED;
> +			qc->result_tf.nsect = 0;
> +			if (qc->tf.command == ATA_CMD_ID_ATA)
> +				sg_copy_from_buffer(qc->sg, 1, qc->dev->id, 2 * ATA_ID_WORDS);
> +			ata_qc_complete(qc);
> +			return;
> +		}
>  		link->eh_info.action |= ATA_EH_RESET;
>  		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
>  		ata_link_abort(link);

-- 
Damien Le Moal
Western Digital Research


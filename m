Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363123BD1D
	for <linux-ide@vger.kernel.org>; Wed, 31 Dec 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767181183; cv=none; b=dGDuFajLNRR2so3Ywgw5VZGUtcVFTJazcU3d3JKj3Ct1NyUlpYhkiqBUz9nmXsioqBffprHZuXRXp1qxUSmWo5BNkruDvCLU4QE4AjBTqpXDoRcVCOy5myRK6phSqmHbuG9urC1TLf59BwGCzsIHJq6Ugn9UXTv5Q75pToYwcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767181183; c=relaxed/simple;
	bh=GL6IJ4W0Q1deAWZ9TgXWet021svoP83GR8m3uNRUlBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNSISTPN7FJAvlIAFRSWrl2Q2nSRrMD1RAHyQdR3/KR7pelVQGdf+hLppedc1diCqiyQC/3ZMnpe/YUUXABTIp9+3lT02abDF6G9MwbieLIaKeKktJwLXLzq7p9I4L+KwJJQlidPLPMAOA9lb3NoUBoBsRN0XlFeu2uAZcB5X/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSAmPXaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSAmPXaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C1C113D0;
	Wed, 31 Dec 2025 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767181183;
	bh=GL6IJ4W0Q1deAWZ9TgXWet021svoP83GR8m3uNRUlBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSAmPXaE0fLA0gJ7TU09vDevvkjXygXKc8rIMzY0OPnslPb+KgDVOojsCnP4zmsMd
	 3SoPTw3EOfUW1ImvtjNmOrWuxOKpUSlJ00zJMCcjsCM8Dj8kynIMsOu0EgWSnaOqhw
	 v63Hf6/l0aWftYNNsLgyd27jp463EfFhJlJrXMBdV0tUg1oSMHHBcvicxFCBrRhLGW
	 jLDpK1kp5VdUEqH1FxUFd/w5M3RmiFlNbHL4no25v3SeY+JCr/vyIrdyRSQ7PfWvxi
	 rrhmbVZAipbCScyCb1FAW9bXIlxwAL4G7HYMgUcLu/YgjlgFAjYBlgj6cL8X+ORrOw
	 hMEt4fBZM0vtQ==
Date: Wed, 31 Dec 2025 12:39:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
Message-ID: <aVULegmRVY2O-TUC@ryzen>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220002140.148854-3-dlemoal@kernel.org>

On Sat, Dec 20, 2025 at 09:21:40AM +0900, Damien Le Moal wrote:
> @@ -1702,6 +1779,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	if (!ret)
>  		return 0;
>  
> +	/*
> +	 * We must defer this qc: if this is not an NCQ command, keep this qc
> +	 * as a deferred one and wait for all on-going NCQ commands to complete
> +	 * before issuing it with the deferred qc work.
> +	 */
> +	if (!ata_is_ncq(qc->tf.protocol)) {
> +		ap->deferred_qc = qc;
> +		return SCSI_MLQUEUE_DEVICE_BUSY;

Here you save the qc, and you return SCSI_MLQUEUE_DEVICE_BUSY;
SCSI_MLQUEUE_DEVICE_BUSY will cause the block layer to reinsert the request
in the queue, so you will get the same request sent to ata_scsi_translate()
again, even though you have save it. A little ugly IMO.

It seems like you are relying on the ata_scsi_qc_new() call will give you
the same *qc as the one you have stored...


> +	}
> +
> +	/* Use the SCSI layer to requeue and defer the command. */
>  	ata_qc_free(qc);
>  
>  	switch (ret) {
> @@ -1777,8 +1865,11 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  		goto done;
>  
>  	rc = ata_scsi_defer(ap, qc);
> -	if (rc)
> +	if (rc) {
> +		if (qc == ap->deferred_qc)
> +			return 0;

...and then you have this code here, to do nothing in that case.

But, are we guaranteed that we will always get the same qc?

Have you tried this both with and without mq-deadline?
And on both ahci and libsas HBAs?

Because AFAICT, for AHCI with mq-deadline, I don't think that rq->tag will
be kept, so you will probably get another *qc.

This is apparently because when using mq-deadline, q->elevator is non-NULL:
https://github.com/torvalds/linux/blob/v6.19-rc3/block/blk-mq.c#L742-L745

Thus RQF_SCHED_TAGS will be set.

When RQF_SCHED_TAGS is set, the rq->tag is not kept during requeue:
https://github.com/torvalds/linux/blob/v6.19-rc3/block/blk-mq.c#L427-L433

Perhaps it does work (only) for libsas HBAs though, because:
https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/ata/libata-scsi.c#L752-L762

in that case, it seems like the tag is taken from scsi_cmd->budget_token
rather than from rq->tag.


>  		return rc;
> +	}
>  
>  	ata_qc_issue(qc);
>  

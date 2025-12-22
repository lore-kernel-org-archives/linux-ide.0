Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29202877D8
	for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766438931; cv=none; b=t7uLlPaCWnEKkaM94Sl8FejD1tBka46BOMKnWouuYZOFPXGptb+P8UtXGFcwJr5d8W378YzIbixrVJaB6MdcnPPJ3/gy2h1hQ4iSEh1f1P16w8RY/dJ1vXNygHk6aPbupD77bXPb3ISugUVSkGhBFTn3yontKhHdioXg/lTXUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766438931; c=relaxed/simple;
	bh=PChPWexK8nNCoXbMZL6uPGqH+mvFQuoVNwHDPwLvUs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbTLMjyLpbhVxTNzRhqBOZH9XhNo1XQbBDCBsR6UelkoPqYvKldYpQxhpv4Mrcc3SXAzRoFarp3Ryy78b6A0p4t6fDzpWNp40EUOvUJuuJlb7VDCYWwK5OAkpVmn2ceafx9FivcY9thutxV2YE4lAShzqZkit0VYoEosO1F02wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wxQMgLYz; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wxQMgLYz"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d06cfa93so565775ad.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2025 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766438928; x=1767043728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CW9J4J++0QrB7/ZGWU1NJug68Jgz7io3UYU36tJ6aic=;
        b=wxQMgLYzXoM/AAXzi0qLq3KR2vXnkifUV+TGCPXD4WtraLIsfvRst6HdBoQ8fcYxLo
         KO39SWGWVmKBD74NuTVWNpsIabt9FpFFmRtUcV4ek4hQyjJgPZ4ndmcGX3xvHTA+dIdh
         ySJyS4maOHFicBnnKcyX4MiBKPzXnwnEIAcYAuD6jVFpgiRy7ZuMgOWi/VIyPNbnWvhi
         pdMXnc8f5VekoWIgiZalmvNHQXK9XJIIGc7iYkvnEoIoaIZBLkALIRskro1Vt3WNkKJ8
         79DIzsZv4O8BULIx7YDy7butXRNSV+ue0S8phWaxW3h5VLwtzE965OdXNCGXbR9XRuRG
         8maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766438928; x=1767043728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW9J4J++0QrB7/ZGWU1NJug68Jgz7io3UYU36tJ6aic=;
        b=TVqUHgO3980C7iX0GQK9BXp6exhtGSHbTi1PX2aoU8gAQEBsdbNsV4hXbawnh4du2d
         rQMlCWeeXFwHrCTaV6e2fLnhf6+6HKZgBDZ7Rse3M/h5tYmQzhQedCssaJ3Io4MVxb47
         yH+rI+y/VhxiiZ44iDTh1+Gm8LBJs6rzp6vqObqWy2wXFW3tAGT+DZuQUrYM1ENRLTxU
         lOj5yt5Hc/BuU+kZhs3A5/yfpsbns80xntE1gYPwSQQjRNP4U8lkqvZxuef2nMj972LO
         5dCgVgL2FswtBbFk61ODDFbDc0uhsFMZDFuSQnHmT0AY5DE18PPSrUjoENmWd+8chDCV
         7kQg==
X-Gm-Message-State: AOJu0YyQr2A15ABDC+SqVXSP8dXnA3dbpV7LbusRrakDgzSOI2IExzXE
	Sijlw8FEmRAWkXLvKYZrofOgK3ocQwBA+Xa4AyOtYK4y2FORTcI8OHsQitp47O8wSA==
X-Gm-Gg: AY/fxX5TOSh3gLh0kfklldD7Y3rhxRJLUdpL13suoqykH11hLL3lkWp15L32GM25Q6/
	FQjGAuo6fcTHBvxvTPl56S2nJMNMyPY6Ca1ipEVC59Lx4yECdze4I6ySkIuIGQGt8mfSLud0Qs0
	6+UhPuNOA/O777lcYLZbsfoXqCy0eFvNGbQhnckM9nvKKrFftI1yCKXTW19gvFrOxiKqTwxwS9A
	m/n74UQw9Ai66sJLBHMYGAkpVvz7KgP1DaWvUy0va1TXj5pupt/2oCxtUEGTEuPS9XUeP2ykGPq
	IfZbGbZ49aFRq7IKut/WmrLF1MPJIp4y4W6QG3Xeg4nJZQDelPLcmGLSNk2HuTlXPtdkOYgVro4
	9Xos+IueDx2LhWtJwaj+J/pRQIAY6giJSNMJ99nhdunVWA6M0sFGtIlS2xVksy45sg4XIO8QMQ6
	aIBdxbgeOLczi6nLeebasnZrlQ6KFxhRPyzRiAAPPTI9xrjTUuB9zT
X-Google-Smtp-Source: AGHT+IFve3CNcNHbsFxkSV/eH+z+xqXW2U3g2JQs0kf9nWTdkqxlIfGYd0K1SKxgxBJ2unc6Xn538A==
X-Received: by 2002:a17:903:380f:b0:290:cd63:e922 with SMTP id d9443c01a7336-2a3142c95c9mr4626835ad.15.1766438927430;
        Mon, 22 Dec 2025 13:28:47 -0800 (PST)
Received: from google.com (157.132.203.35.bc.googleusercontent.com. [35.203.132.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm82892105ad.13.2025.12.22.13.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 13:28:46 -0800 (PST)
Date: Mon, 22 Dec 2025 13:28:41 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
Message-ID: <aUm4CdHWRcNmCQ3X@google.com>
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
> When a non-NCQ passthrough command is issued while NCQ commands are
> being executed, ata_scsi_defer() indicates to ata_scsi_translate() that
> ata_qc_issue() should not be called for the passthrough command, and
> instead returns SCSI_MLQUEUE_XXX_BUSY to defer the command execution.
> This command deferring is correct and as mandated by the ACS
> specifications since NCQ and non-NCQ commands cannot be mixed.
> 
> However, in the case of a host adapter using multiple submission queues,
> when the target device is under a constant load of NCQ read or write
> commands, there are no guarantees that requeueing the non-NCQ command
> will lead to it not being deferred again repeatedly, since other
> submission queues can constantly issue NCQ commands from different CPUs
> ahead of the non-NCQ command. This can lead to very long delays for the
> execution of non-NCQ passthrough commands, and even complete starvation
> in the worst case scenario.
> 
> Since the block layer and the SCSI layer do not distinguish between
> queuable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT
> implementation must ensure forward progress for non-NCQ commands in the
> presence of NCQ command traffic. This is similar to what SAS HBAs with a
> hardware/firmware based implementation do.
> 
> Implement such forward progress guarantee by limiting requeueing of
> non-NCQ commands: when a non-NCQ command is received and NCQ commands
> are in-flight, do not force a requeue of the non-NCQ command by
> returning SCSI_MLQUEUE_XXX_BUSY in ata_scsi_translate() and instead
> hold on to the qc using the new deferred_qc field of struct ata_port.
> 
> This deferred qc will be issued using the work item deferred_qc_work
> running the function ata_scsi_deferred_qc_work() once all in-flight
> commands complete, which is checked with the port qc_defer() callback
> indicating that no further delay is necessary. This check is done using
> the helper function ata_scsi_schedule_deferred_qc() which is called from
> ata_scsi_qc_complete(). This thus excludes this mechanism from all
> internal non-NCQ commands issued by ATA EH.
> 
> When a port deferred_qc is non NULL, that is, the port has a command
> waiting for the device queue to drain, the issuing of all incoming
> commands (both NCQ and non-NCQ) is deferred using the regular busy
> mechanism. This simplifies the code and also avoids potential denial of
> service problems if a user issues too many non-NCQ passthrough commands.
> 
> Finally, whenever ata EH is scheduled, regardless of the reason, a
> deferred qc is always requeued so that it can be retried once EH
> completes. This is done by calling the function
> ata_scsi_requeue_deferred_qc() from ata_eh_set_pending(). This avoids
> the need for any special processing for the deferred qc in case of NCQ
> error, link or device reset, or device timeout.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Reported-by: Igor Pylypiv <ipylypiv@google.com>

Tested-by: Igor Pylypiv <ipylypiv@google.com>

Thanks again for fixing this issue, Damien!

> Fixes: 42f22fe36d51 ("scsi: pm8001: Expose hardware queues for pm80xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c |  1 +
>  drivers/ata/libata-eh.c   |  6 +++
>  drivers/ata/libata-scsi.c | 93 ++++++++++++++++++++++++++++++++++++++-
>  drivers/ata/libata.h      |  2 +
>  include/linux/libata.h    |  3 ++
>  5 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0b24bd169d61..121f35115d33 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5558,6 +5558,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	mutex_init(&ap->scsi_scan_mutex);
>  	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
>  	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
> +	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
>  	INIT_LIST_HEAD(&ap->eh_done_q);
>  	init_waitqueue_head(&ap->eh_wait_q);
>  	init_completion(&ap->park_req_pending);
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2586e77ebf45..b90b17f680f8 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -917,6 +917,12 @@ static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
>  
>  	ap->pflags |= ATA_PFLAG_EH_PENDING;
>  
> +	/*
> +	 * If we have a deferred qc, requeue it so that it is retried once EH
> +	 * completes.
> +	 */
> +	ata_scsi_requeue_deferred_qc(ap);
> +
>  	if (!fastdrain)
>  		return;
>  
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8e04fc173ea3..e39837846566 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1658,8 +1658,73 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
>  	done(cmd);
>  }
>  
> +void ata_scsi_deferred_qc_work(struct work_struct *work)
> +{
> +	struct ata_port *ap =
> +		container_of(work, struct ata_port, deferred_qc_work);
> +	struct ata_queued_cmd *qc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +
> +	/*
> +	 * If we still have a deferred qc and we are not in EH, issue it. In
> +	 * such case, we should not need any more deferring the qc, so warn if
> +	 * qc_defer() says otherwise.
> +	 */
> +	qc = ap->deferred_qc;
> +	if (qc && !ata_port_eh_scheduled(ap)) {
> +		WARN_ON_ONCE(ap->ops->qc_defer(qc));
> +		ap->deferred_qc = NULL;
> +		ata_qc_issue(qc);
> +	}
> +
> +	spin_unlock_irqrestore(ap->lock, flags);
> +}
> +
> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc = ap->deferred_qc;
> +	struct scsi_cmnd *scmd;
> +
> +	/*
> +	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
> +	 * do not try to be smart about what to do with this deferred command
> +	 * and simply retry it by completing it with DID_SOFT_ERROR.
> +	 */
> +	if (!qc)
> +		return;
> +
> +	scmd = qc->scsicmd;
> +	ap->deferred_qc = NULL;
> +	ata_qc_free(qc);
> +	scmd->result = (DID_SOFT_ERROR << 16);
> +	scsi_done(scmd);
> +}
> +
> +static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc = ap->deferred_qc;
> +
> +	/*
> +	 * If we have a deferred qc, then qc_defer() is defined and we can use
> +	 * this callback to determine if this qc is good to go, unless EH has
> +	 * been scheduled.
> +	 */
> +	if (!qc)
> +		return;
> +
> +	if (ata_port_eh_scheduled(ap)) {
> +		ata_scsi_requeue_deferred_qc(ap);
> +		return;
> +	}
> +	if (!ap->ops->qc_defer(qc))
> +		queue_work(system_highpri_wq, &ap->deferred_qc_work);

Do we need to call cancel_work_sync(&ap->deferred_qc_work) in ata_port_detach()?

> +}
> +
>  static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
> +	struct ata_port *ap = qc->ap;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	u8 *cdb = cmd->cmnd;
>  	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> @@ -1689,12 +1754,24 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  	}
>  
>  	ata_qc_done(qc);
> +
> +	ata_scsi_schedule_deferred_qc(ap);
>  }
>  
>  static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>  {
>  	int ret;
>  
> +	/*
> +	 * If we already have a deferred qc, then rely on the SCSI layer to
> +	 * requeue and defer all incoming commands until the deferred qc is
> +	 * processed, once all on-going commands are completed.
> +	 */
> +	if (ap->deferred_qc) {
> +		ata_qc_free(qc);
> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> +	}
> +
>  	if (!ap->ops->qc_defer)
>  		return 0;
>  
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
>  		return rc;
> +	}
>  
>  	ata_qc_issue(qc);
>  
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 0e7ecac73680..60a675df61dc 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -165,6 +165,8 @@ void ata_scsi_sdev_config(struct scsi_device *sdev);
>  int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
>  		struct ata_device *dev);
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
> +void ata_scsi_deferred_qc_work(struct work_struct *work);
> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
>  
>  /* libata-eh.c */
>  extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 39534fafa36a..c5b27d97dfaf 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -903,6 +903,9 @@ struct ata_port {
>  	u64			qc_active;
>  	int			nr_active_links; /* #links with active qcs */
>  
> +	struct work_struct	deferred_qc_work;
> +	struct ata_queued_cmd	*deferred_qc;
> +
>  	struct ata_link		link;		/* host default link */
>  	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
>  
> -- 
> 2.52.0
> 

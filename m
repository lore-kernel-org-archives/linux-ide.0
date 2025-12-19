Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F3C148
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102913; cv=none; b=TLmbBUIaQLvFhCBu3aMLrDQbgwfzivOCLCe2RQlde40nC80F+14AKtn8MK1Bg3gJmOv1g2lHCiOi9PBaEl0SJ9VyG3Neb3EvkUb6FVD8YHDXboTP7TBLjA9rjzNaOfCPJ62vLTbLgS1eRuuKZnLyIHUopyGie9egZlJvzVOnbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102913; c=relaxed/simple;
	bh=sj/9+TTFVczBApmw+1W3gzqM2cNlnc09vvhNbpxia1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRW3mEj+kjJ8rBzEBfIk+NSHAskyRas+HesgU/3Rr68ZjOeoDDkAJPuedBi1jO9jleXI7Ffof8hJ14zck6fI+BQeS8l2lhUDLLM6iNTMeyH7OU1tUuOgrY6YsQ1F4CuOAMQX9anae1cKC2PWuALsnSrAqn8PChG5OrkPaFkdHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upXlJx57; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upXlJx57"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29f02651fccso75155ad.0
        for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2025 16:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766102911; x=1766707711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KY77qFjyB1sVN6U3Qy47u5kQWGMY40d8gEfhKie3+Dg=;
        b=upXlJx57+u0sP6eRaL5sbXjJ/vYaoZyFrK9W0e6gteNAnrIXBKB2s2Ucslc2/Aa5cK
         MSm34mAO+G1bivJHHwafLQ27Q88lPEzs1/XME6lxZBiaKzxpkttt6iWDJUV+6FRUHW6y
         Wh5eXcpmi1utE+ZvsSKj5rdu1T9VY08Pqsn2RR9wmXl0TN8uJI/8mjvRXYNmOMhmW/MW
         +6EX9j78sDHrAdU9wMADmNT1HHRhPtSGO7ayCQKG+88mLbOi4Ks5TYj9RorE0IAQvi8b
         XBpY697lfI6G49GrLq9zyNC0Oub2YSWbg0GdQoxyNxwcfTnzXfJm844Qb5hxGfvZmQmi
         jSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102911; x=1766707711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY77qFjyB1sVN6U3Qy47u5kQWGMY40d8gEfhKie3+Dg=;
        b=ixo1HdcIZlbiNGKCHC9TInXuRXbi71PcWAYp6cwD5dWaf5FqBoWWLNgVbzSiOHd6Nk
         2Lu+/3eVEVGGM3p0hlZEnUO8FmMAKFrVJXPT2/28pO5887VuzOOIMAfN0aBXdvC/lgtC
         MMOg2PniRUbbhPB3QbIH9vDZzqwAh42RXrZC6F0wRZMqcDKMqkYPvLx4kwQylgFAJjJs
         ArkNFZGvi3MTyyT+ixpwZVh8nL2hCvVSB6fi3knL2ayi5j3ttYeY2D6Oqjt4k4SOQzLV
         tK2VmP4Hi8DI+bMMuofOhyKhIadx+dcpVuzxvm8GOyeg8qEF5WU5BH2OWPO7f4n9iDOX
         a6OA==
X-Gm-Message-State: AOJu0YyUuvW7VQxBoBZQXP1PgDVV3aNK4dfn0JHDBOhKagzJCPYE97zG
	ZOI5BhP0v6yNVabZ3aW8kCtek2uxFLcQMSwyBNUyAT0Ml9269+64rL5lRn4nGvDSHw==
X-Gm-Gg: AY/fxX41yT3ReD3rJv9xUQzokx2+IGY/T125YPkangubcFsQBFGbin94lAHqnyo8TvD
	nyRmcd+CxxhbvtBoYnKkDPkS00k2qSk4uaYfZeBRlRrc2Nwe0ZSaqJjWLwdJJkuD/hzrKpE/Wxw
	3CYzu3AMR5KfKKNAV+wIfR9Kp1cPZg//z++fv1wFUmXMEKKrD8poIKBNOuyLNw8+ORkQbLqhnLb
	rHJeGzhEXlmw/xwYJaCF/56h+uazHXl+sjmIi+BGb/33x+43axkE4HIXEnGflOf5J9IMuuXByFO
	n8kUDkE1Wl2/Ck39EzS0a2yiQA5AvQyIA6pdGK5fVALWPC/E8rs/bhzL/VqB+CBskqMrQyfZd8j
	v4+9CSOooEvwnaTsKs4B888lHwfDUyzeukCYi0AHMZ60bsJKLJR0o8IiZ5YPR7SR0faLr8c4yJY
	7GLhEnb4VVSYcj5cPXypX+sMW1TaEHvSQpUfT5FCnquBUYaFOLGyXW
X-Google-Smtp-Source: AGHT+IEijI5R72jMLZJVrjYZ4vZX8bzNIRH18hwTFRy9k0vec+OR5QAugQ48iTPs9rRZ09FwU49RtA==
X-Received: by 2002:a17:902:fc4f:b0:29e:27f4:bac0 with SMTP id d9443c01a7336-2a2f5aa0d97mr197905ad.16.1766102910675;
        Thu, 18 Dec 2025 16:08:30 -0800 (PST)
Received: from google.com (157.132.203.35.bc.googleusercontent.com. [35.203.132.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm3746635ad.25.2025.12.18.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:08:28 -0800 (PST)
Date: Thu, 18 Dec 2025 16:08:24 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Xingui Yang <yangxingui@huawei.com>
Subject: Re: [PATCH 2/2] ata: libata-scsi: avoid passthrough command
 starvation
Message-ID: <aUSXeEoBg1cYYdtK@google.com>
References: <20251217231712.490765-1-dlemoal@kernel.org>
 <20251217231712.490765-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217231712.490765-3-dlemoal@kernel.org>

On Thu, Dec 18, 2025 at 08:17:12AM +0900, Damien Le Moal wrote:
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

Thank you very much for fixing this, Damien! I'll run some tests and add
my Tested-by if everything looks good.

> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
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
> index 42d103542525..c5ebd2bab356 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1658,8 +1658,75 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
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
> +	 * If we still have a deferred QC and we are not in EH, issue it. In
> +	 * such case, we should not need any more deferring the QC, so warn if
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
> +
> +	lockdep_assert_held(ap->lock);
> +
> +	/*
> +	 * If we have a differed QC when a reset occurs or NCQ commands fail, do
> +	 * not try to be smart about what to do with this deferred command and
> +	 * simply retry it by completing it with DID_SOFT_ERROR.
> +	 */
> +	if (qc) {
> +		struct scsi_cmnd *scmd = qc->scsicmd;
> +
> +		ap->deferred_qc = NULL;
> +		ata_qc_free(qc);
> +		scmd->result = (DID_SOFT_ERROR << 16);
> +		scsi_done(scmd);
> +	}
> +}
> +
> +static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc = ap->deferred_qc;
> +
> +	lockdep_assert_held(ap->lock);
> +
> +	/*
> +	 * If we have a differed QC, then qc_defer() is defined and we can use
> +	 * this callback to determine if this QC is good to go, unless EH has
> +	 * been scheduled.
> +	 */
> +	if (qc) {
> +		if (ata_port_eh_scheduled(ap)) {
> +			ata_scsi_requeue_deferred_qc(ap);
> +			return;
> +		}
> +		if (!ap->ops->qc_defer(qc))
> +			queue_work(system_highpri_wq, &ap->deferred_qc_work);
> +	}
> +}
> +
>  static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
> +	struct ata_port *ap = qc->ap;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	u8 *cdb = cmd->cmnd;
>  	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> @@ -1689,12 +1756,22 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
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
> +	 * If we already have a deferred QC, then rely on the SCSI layer to
> +	 * defer and requeue all incoming commands until the deferred QC is
> +	 * processed, once all on-going commands are completed.
> +	 */
> +	if (ap->deferred_qc)
> +		return SCSI_MLQUEUE_DEVICE_BUSY;

Should we free qc here? ata_scsi_translate() does not free qc if
ata_scsi_defer() returns a non-zero value.

> +
>  	if (!ap->ops->qc_defer)
>  		return 0;
>  
> @@ -1702,6 +1779,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	if (!ret)
>  		return 0;
>  
> +	/*
> +	 * We must defer this QC: if this is not an NCQ command, keep this QC as
> +	 * a deferred one and wait for all on-going NCQ commands to complete
> +	 * before issuing it with the deferred QC work.
> +	 */
> +	if (!ata_is_ncq(qc->tf.protocol)) {
> +		ap->deferred_qc = qc;
> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> +	}
> +
> +	/* Use the SCSI layer to defer and requeue the command. */
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

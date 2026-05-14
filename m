Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B78357D03;
	Thu, 14 May 2026 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756944; cv=none; b=VvYpkXqtzyi0Mplwy/Y+kDhyWfi4gr/5UPCV8ZjGVp3VmEkLP2W4PNped6+GofwasYcy8evw6At03CQfphmidubztl0ZpRUmMfN8mSyBpnap5ZOFHHI25NK29NiFU6L/Lmn/EgCL+Nnn87ljYjcUaa/OFj3zao7cUKBQz+bVl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756944; c=relaxed/simple;
	bh=Q17owuwcb5oic1hGE9fU0C/o2hgW0cGiph2+aUZl7kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK6PoVSzLI19JxwnxdedcxDCbs/DI/7LMKPUvKxvPJcs6XqrodbxAsAjmUXjR0ul/OoffGgtAueNbf8Tou1l9dwD3hzwxsFOhh0hTe2RxoMBU4XN2K6SjpigCMIwN+8JcA3uLJ6MqAqstcAow2HPVM1sAIOMbsApIOW82TWgUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9Ba38PX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9Ba38PX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D7FC2BCB3;
	Thu, 14 May 2026 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778756943;
	bh=Q17owuwcb5oic1hGE9fU0C/o2hgW0cGiph2+aUZl7kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9Ba38PX8bWY4b4lwMDjmbzc3es1XySsLv95sxiJ3CnmEby2MFt7qtP5x6+86R2Ja
	 v1jWYlxRJ29bEHvdBCcEPG9acuAj4xmzWbqmRsXFhd6whnekMwk26p0DczUgRCisnD
	 x2kf5RFwvORbPzxtg3iKt5ZaiRSQa6D9pkf8oP0TgOpvfT5Avsu+WxYEA+TpKQbvdW
	 aGb8CglsA3MWrgi18STRBSSQ/gei4bDrAJmczhl28Ypus4DnzadC3Cw+ALJrv398Ji
	 UNGwwZvkZWhbphMh9uqAgDnksvDAHFod/mGt7LG1XT69vIgwtJqVz6R1z/9GD7qSsd
	 hxSP6BnavFjcA==
Date: Thu, 14 May 2026 13:08:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ata: libata-scsi: do not needlessly defer
 commands when using PMP with FBS
Message-ID: <agWtS_We9Ljnq2TY@fedora>
References: <20260513151359.1075403-10-cassel@kernel.org>
 <20260514100530.A6A2FC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514100530.A6A2FC2BCC7@smtp.kernel.org>

On Thu, May 14, 2026 at 10:05:29AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Hardware exclusivity violation and race condition due to removed port-wide barrier.
> - [High] Cross-link command starvation due to per-link deferred_qc wakeups.
> --
> 
> commit ec58a121e5df098567314ab23ec810f87424e7ab
> Author: Niklas Cassel <cassel@kernel.org>
> 
> ata: libata-scsi: do not needlessly defer commands when using PMP with FBS
> 
> This patch moves deferred_qc from struct ata_port to struct ata_link.
> This allows mixing non-NCQ and NCQ commands on the same port across
> different links when using Port Multipliers that support FIS-Based Switching.
> 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 02f2d7416c839..bd09d48d718da 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> [ ... ]
> > @@ -1676,10 +1677,10 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
> >  	 * such case, we should not need any more deferring the qc, so warn if
> >  	 * qc_defer() says otherwise.
> >  	 */
> > -	qc = ap->deferred_qc;
> > +	qc = link->deferred_qc;
> >  	if (qc && !ata_port_eh_scheduled(ap)) {
> >  		WARN_ON_ONCE(ap->ops->qc_defer(qc));
> > -		ap->deferred_qc = NULL;
> > +		link->deferred_qc = NULL;
> >  		ata_qc_issue(qc);
> >  	}
> 
> Could this lead to a hardware exclusivity violation?
> 
> Before this patch, ap->deferred_qc acted as a port-wide barrier. Now that
> it's scoped to the link, it allows other links to issue commands while one
> link has a deferred command pending.
> 
> If Link A defers a non-NCQ command, its workqueue gets scheduled. In the
> window before the workqueue executes, Link B can receive and issue a command
> since linkB->deferred_qc is NULL.
> 
> When Link A's workqueue runs, it evaluates the WARN_ON_ONCE above. Because
> Link B is now active, qc_defer() would correctly flag a conflict and return
> non-zero. However, the WARN_ON_ONCE does not abort execution, so the code
> proceeds to unconditionally call ata_qc_issue(qc). This would issue Link A's
> non-NCQ command while Link B's command is already active.

Thank you Sashiko, but being able to issue commands to multiple links at
the same time is the whole point of this series.

With PMP FBS, it is allowed to mix NCQ and non-NCQ to *different drives*.

Mixing NCQ and non-NCQ commands to the *the same drive* will still not
be allowed.

So this change in behavior is very much intended.


> 
> [ ... ]
> > @@ -1759,11 +1765,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  
> >  	ata_scsi_qc_done(qc, false, 0);
> >  
> > -	ata_scsi_schedule_deferred_qc(ap);
> > +	ata_scsi_schedule_deferred_qc(link);
> >  }
> 
> Can this cause cross-link command starvation for deferred commands?
> 
> In ata_scsi_qc_issue(), if a CBS PMP link is blocked because another link
> holds exclusive port access, it explicitly stores the command in
> linkA->deferred_qc. When the active link (Link B) completes its commands,
> ata_scsi_qc_complete() now only evaluates the completing link (Link B).
> 
> Since Link A's deferred_qc is completely ignored during Link B's completion,
> and Link A has no active commands to trigger its own completion, will its
> deferred command be permanently stranded, eventually causing a SCSI timeout?

This review comment is correct, but this was because of a mistake in
V4 which accidentally did "goto defer_qc" instead of "goto free_qc".

This is fixed in V5. In V5 PMP CBS will never make use of the deferred QC
issuing via workqueue feature, so this review command can be disregarded.


Kind regards,
Niklas

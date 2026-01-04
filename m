Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35464224FA
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767546990; cv=none; b=XDykv8qVcZYYaMISCCLo+BLT4EGgxqoSIzlK5NziqcV3wjESAOjpwLzV/J0wlBL00RWb218Xt9MFsT+onL+ahdZLQ/qxT0IXfPJZIGCTGzTbbEHh4OXmB0EuXYKWrd/sufIMmZzonZMhjtwgjJfFtF/cv4FRfmPEH+bGzsEEBJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767546990; c=relaxed/simple;
	bh=Oe4qcgoG7XI3D2/AETycYRtZhz+CihEJrhPt2GADN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzg/aYfPiJVqVtRA3TMJN13tbdKGZztM3haZmqYgpwQ0ITupPSpp4P7dJ9HktzvHEbEHJ85RsUUo1YLhCwKl7+zfXBbmX08IcS1phGXc92FaXqz4ROnU1vM7R9KcKTjZ2ahenP6axnNAXtjspmtmje2eSCvUr6FRpVH8yMW6X+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9Ry0kJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9Ry0kJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE35C4CEF7;
	Sun,  4 Jan 2026 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767546989;
	bh=Oe4qcgoG7XI3D2/AETycYRtZhz+CihEJrhPt2GADN9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9Ry0kJ6UkgX92y6OholSin40JQhH0immeK5teMpXFnJguPTqOwa0/ttQbQvyx3mS
	 gvj/M9aEBYILzidcq6ifok1t347ZBpaJghYBrgTdP2hBzorYMbL3CjRCpL+Oz+Q4ME
	 g1eVoqV7tFIhcOV43apb2gttVn8IDGyp0PIZ0sEZK5y4kTKmfvVxWNHnsuZ41Lqild
	 7Hi4gGbK3SM0wWZZZiN416BFFH+EiJlvJmCLX+XV4jNRrCCBlff4xRJPebQgJwBYJB
	 toomMbmSsqKnn6BbogZxDwiaqCckfjA+Bdtx6iERA0TSblT35RDREliC+khH5l7AUf
	 B+wBJFWrUA1MQ==
Date: Sun, 4 Jan 2026 18:16:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v5 2/2] ata: libata-scsi: avoid Non-NCQ command starvation
Message-ID: <aVqgafdgx3qtfcHx@fedora>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
 <20260104082203.1212962-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104082203.1212962-3-dlemoal@kernel.org>

On Sun, Jan 04, 2026 at 05:22:03PM +0900, Damien Le Moal wrote:
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

Since ap->deferred_qc needs to be checked while holding the spinlock,
in order to synchronize with ata_scsi_deferred_qc_work(), please add a
lockdep_assert_held(ap->lock) here.

Yes, I know that you had multiple lockdep_assert_held() in V2.

But I think that a single lockdep_assert_held() in either 
ata_scsi_requeue_deferred_qc() or ata_scsi_qc_complete() is warranted
(and yes, it is a no-op on production systems (where lockdep is disabled)).

Other than that, looks good to me, no need for a resend, you canfixup when
applying:

Reviewed-by: Niklas Cassel <cassel@kernel.org>


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

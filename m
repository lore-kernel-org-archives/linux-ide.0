Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAF38B127
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753131; cv=none; b=g+/ag0qInrIJjgxnVFgxvrecmzaKTIFxI7QNKbN1wFn7j8Vf3uwHNjQGvQ0wKXcgwq4hq0c1nmZcU/MaYFQZrfE4SkRrtdzv8NkQRK592nxNR52v5A7mprDVzuS1gLU8j5KV9yZNMoNItx//B0uPdHRKSMxgL3QP2W3bJ5fVacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753131; c=relaxed/simple;
	bh=LrIMPsnmArNULOxU9hBKriVwgH4MVLt5HqZ6DVdR9I4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLX3DXEubscscE3saRQiZ0nP3voEWj/Fi299X1cOpydxgc72KAaKs4vUPuy2bJmWaSDE+UDuIturKF7vDhkkdkhyWVDlBPNFowi8t3NAwitPv8Kzr6sdYmDIqP1sKB7TLrrwqmMxCfjwAcwusz7VB86LBgWe0eAo+dZr3MMtFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW7imEVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW7imEVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A2FC2BCC7;
	Thu, 14 May 2026 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778753130;
	bh=LrIMPsnmArNULOxU9hBKriVwgH4MVLt5HqZ6DVdR9I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PW7imEVlEAQRo4Pwwjhu6vXsNrD20n6wgwIII3CEZzzZMpPCl6JqlAdMA0vvnISRz
	 UYg9443e30e6MRuxUceTvo3xMHM3EeDdic3U2gyNPiaKQWXur9iD1dBIK69sxvrngs
	 3yB8YJUWS3flIYLZK/jpFTGefN+3wpUlvNCBV9xiH3RHrHGLYSZ+wia5kvPvH0lcEk
	 w5DMDSw0iIMQZ3bekZC6T5b9sUrM2MaxrhPN4XtAerG/fOQR9EY6bOY+z3jK09OB0k
	 geR8nZHU2vqkoUwtdn3tNUl2H5Z5Thar7WOmGZxtxleqXNFI1y7tyChtkTvxSeIKgB
	 dnbBxzfpXs9Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] ata: libata-scsi: do not needlessly defer
 commands when using PMP with FBS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260513151359.1075403-10-cassel@kernel.org>
References: <20260513151359.1075403-10-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 10:05:29 +0000
Message-Id: <20260514100530.A6A2FC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Hardware exclusivity violation and race condition due to remov=
ed port-wide barrier.
- [High] Cross-link command starvation due to per-link deferred_qc wakeups.
--

commit ec58a121e5df098567314ab23ec810f87424e7ab
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-scsi: do not needlessly defer commands when using PMP with FBS

This patch moves deferred_qc from struct ata_port to struct ata_link.
This allows mixing non-NCQ and NCQ commands on the same port across
different links when using Port Multipliers that support FIS-Based Switchin=
g.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 02f2d7416c839..bd09d48d718da 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[ ... ]
> @@ -1676,10 +1677,10 @@ void ata_scsi_deferred_qc_work(struct work_struct=
 *work)
>  	 * such case, we should not need any more deferring the qc, so warn if
>  	 * qc_defer() says otherwise.
>  	 */
> -	qc =3D ap->deferred_qc;
> +	qc =3D link->deferred_qc;
>  	if (qc && !ata_port_eh_scheduled(ap)) {
>  		WARN_ON_ONCE(ap->ops->qc_defer(qc));
> -		ap->deferred_qc =3D NULL;
> +		link->deferred_qc =3D NULL;
>  		ata_qc_issue(qc);
>  	}

Could this lead to a hardware exclusivity violation?

Before this patch, ap->deferred_qc acted as a port-wide barrier. Now that
it's scoped to the link, it allows other links to issue commands while one
link has a deferred command pending.

If Link A defers a non-NCQ command, its workqueue gets scheduled. In the
window before the workqueue executes, Link B can receive and issue a command
since linkB->deferred_qc is NULL.

When Link A's workqueue runs, it evaluates the WARN_ON_ONCE above. Because
Link B is now active, qc_defer() would correctly flag a conflict and return
non-zero. However, the WARN_ON_ONCE does not abort execution, so the code
proceeds to unconditionally call ata_qc_issue(qc). This would issue Link A's
non-NCQ command while Link B's command is already active.

[ ... ]
> @@ -1759,11 +1765,12 @@ static void ata_scsi_qc_complete(struct ata_queue=
d_cmd *qc)
> =20
>  	ata_scsi_qc_done(qc, false, 0);
> =20
> -	ata_scsi_schedule_deferred_qc(ap);
> +	ata_scsi_schedule_deferred_qc(link);
>  }

Can this cause cross-link command starvation for deferred commands?

In ata_scsi_qc_issue(), if a CBS PMP link is blocked because another link
holds exclusive port access, it explicitly stores the command in
linkA->deferred_qc. When the active link (Link B) completes its commands,
ata_scsi_qc_complete() now only evaluates the completing link (Link B).

Since Link A's deferred_qc is completely ignored during Link B's completion,
and Link A has no active commands to trigger its own completion, will its
deferred command be permanently stranded, eventually causing a SCSI timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513151359.1075=
403-6-cassel@kernel.org?part=3D4

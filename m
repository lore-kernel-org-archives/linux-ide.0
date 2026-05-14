Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FA2D876B
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728063; cv=none; b=LQS4mhdgHn1GaLDA/dIL0IKoHOe9vOgTHn+ZEZIGu1XnnKYg04naGTpTmuxPj9WS2uesZJWS14TmP41/23gCdaQhK5Ash6GFTfAEQFPwa/jWkBrNi9r8oUfOkH2NNAVI262CyUQVpgoFNXTrUKB4a2UEsJSSXk7Zmw9pbjV6NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728063; c=relaxed/simple;
	bh=I0JvjWT/7QWe1iJ0XDcVaIpmMM3oedClYCdv6rtwIfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OGT/jpbPOcAC1+/NqMyCf69+LSlsaKdbco++eybZK7eIJynlir193kqTlBzSGAv9ZzYnW7WAb86PWmSiG/gOLmSsULNBSYbftjDwfx+d4G9Z4mde7n4q66Dt/21H1X1QvwnrbllJym1m1PjQB4Y0Rkcy6h80VzOHvjIp6kjup6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9YbbZCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9YbbZCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643ADC19425;
	Thu, 14 May 2026 03:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778728062;
	bh=I0JvjWT/7QWe1iJ0XDcVaIpmMM3oedClYCdv6rtwIfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q9YbbZCztDLOF4YBcYTPnowkdEG9HrwiBxr9Z5jJpSMmxkGhcWY+tT78t1EYrEYlw
	 LDgB7UeqhS6DJTGifXg6k+j11hTtaMAoHXe2qCoAZ0Esa/h9SIuXgpkHFRP+slXuz7
	 I0xB608Q6nyXQmT2zdGzckw1BZkewCHNJFUtXFZ1x2EuM4bQmPXSljVCWA3CuoccfB
	 /LY+ocgpGXcQ3Crbc/FwLRe9ZxwPPdDmIpxsMHNC1npXkGU/uRJKDpiLEfAXsr/hvW
	 TWGfR6iy1M/0WweiItR98K9bbFqhvqAeu+RdMZJuzvP3BXLZ1p9FEXbCHz3HOuZPrw
	 99pn9HbOO1WlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-eh: queue hotplug work on the
 system_dfl_long_wq workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260513081001.714630-2-cassel@kernel.org>
References: <20260513081001.714630-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:07:41 +0000
Message-Id: <20260514030742.643ADC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch fails its stated goal of unifying workqueues, leaving a =
Use-After-Free concurrency vulnerability intact due to broken workqueue non=
-reentrancy.
--

commit 30d96f652048a28eb19aca7f2ef201c2aea08917
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-eh: queue hotplug work on the system_dfl_long_wq workqueue

This commit changes ata_scsi_port_error_handler() to queue hotplug_task
on system_dfl_long_wq, attempting to unify the workqueue usage with
ata_scsi_scan_host().

>     ata_scsi_scan_host() queues the ap->hotplug_task work on the unbound
>     system_dfl_long_wq workqueue.

Is this description of ata_scsi_scan_host() accurate?

Looking at ata_scsi_scan_host(), it queues the work on system_long_wq, not
the unbound system_dfl_long_wq.

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 9a4b67b90b17b..6cb79a09423dd 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -819,7 +819,7 @@ void ata_scsi_port_error_handler(struct Scsi_Host *ho=
st, struct ata_port *ap)
>  		ap->pflags &=3D ~ATA_PFLAG_LOADING;
>  	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
>  		!(ap->flags & ATA_FLAG_SAS_HOST))
> -		schedule_delayed_work(&ap->hotplug_task, 0);
> +		queue_delayed_work(system_dfl_long_wq, &ap->hotplug_task, 0);

Could this still leave the port vulnerable to a use-after-free regression
during teardown?

Since ata_scsi_scan_host() uses system_long_wq and this now uses
system_dfl_long_wq, the same work can still be queued on two different
workqueues, bypassing the workqueue non-reentrancy checks.

If the work was last queued to system_dfl_long_wq, would a call to
cancel_delayed_work_sync(&ap->hotplug_task) during ata_port_detach() only
flush that pool and return immediately, missing an instance still executing
on system_long_wq?

Should this be changed to use system_long_wq to match ata_scsi_scan_host()
and ensure the synchronization actually waits for all work to complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513081001.7146=
30-2-cassel@kernel.org?part=3D1

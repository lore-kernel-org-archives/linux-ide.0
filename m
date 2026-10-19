Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A14C8466
	for <linux-ide@vger.kernel.org>; Mon, 19 Oct 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420968; cv=none; b=MvC/ORvMWfQHH1m6RToUKRjS5xYkiDegSHOZGSkqGso4IpE7WnWezycYVWHfQrCa4OSpQJHez2Rw+eeC6uOzZZg9CPWLyA/UbFnY4Uj9L8ILPzwOMgERmPgK5srDhAgytBLqEyrULvVOlOEpVK4kh4RrF/KdRfYmbuLoBUdIaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420968; c=relaxed/simple;
	bh=mZ7643x/Z4PI4ESeigEe1MHez8qCrT/HOVPKxLMKkr4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hhPBeWlvaTZ/V30NCt30jXeRBOfiRFE8wLvhYkSDCK86EmAuKOiVS/QJCTUpWSVxqC4IV8ZS3n8p6r7jcxcXGDraGRjzzPL8FloXqBHyvo9UAz170JgqAMrj8yEyREZgfSqS9otpp3cgLV+27jBRJXkyFmzboSjGZVrLAgNo0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2oeuo42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2oeuo42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26ED1F000C4;
	Mon, 19 Oct 2026 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420967;
	bh=eByBzMu2ecb99t4vJpINwU41NVCzvfw/b/0GO+fnzZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O2oeuo420HdHPL11D0YAlfeWdVpcajSm8QIo4LUAH1m2Uyz5Abxf6Dg+m/+ikHcHd
	 v1kTdGmtIpIlEX0qgNNF8Pb04hOIAT2HemFiE3t5NXNS2orduyY1o0YShlK6cqyW9c
	 +YSjFWsLOBlpR+/ivMJBki4iDniDe/gmbazo6QobL6rBeK1bG1t4jxbHaclLSEOhfw
	 NHncvbF3pkImlCEh5yQ9xktqrFinXFeRx1zU3zT6Nznd4GBOu9ilBoH+N07k6Ua8DY
	 woBiwRz9TpiqTcC6P/xJGCPRl38f/VdyullyOdM8bVcx1H7v4AbVYFUctRuRbObMcQ
	 qLo8WB265PCiw==
Message-ID: <sashiko-outbox-177477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] ata: libata-sff: don't busy-wait for
 PIO data-in command completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261019135441.1420968-182-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-182-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:42:45 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ata: libata-sff: race between ata_sff_hsm_move() and ata_sff_flush=
_pio_task()
--

commit ffe3d0726a492588a046ac4c8f5eafd55e0c371b
Author: Richard Weinberger <richard@nod.at>

ata: libata-sff: don't busy-wait for PIO data-in command completion

This commit bounds the inline busy-wait for PIO data-in completion in
ata_sff_hsm_move() to ~100us. If the device remains busy after draining the
final data block, it sets ATA_TFLAG_POLLING and queues ata_sff_pio_task() to
poll for completion in process context.

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 1e2a2c33cdc80..416e1239ed56d 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1114,8 +1114,14 @@ int ata_sff_hsm_move(struct ata_port *ap, struct a=
ta_queued_cmd *qc,
> =20
>  			if (ap->hsm_task_state =3D=3D HSM_ST_LAST &&
>  			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
> -				/* all data read */
> -				status =3D ata_wait_idle(ap);
> +				status =3D ata_sff_busy_wait(ap,
> +						ATA_BUSY | ATA_DRQ, 10);
> +				if (status !=3D 0xff &&
> +				    (status & (ATA_BUSY | ATA_DRQ))) {
> +					qc->tf.flags |=3D ATA_TFLAG_POLLING;
> +					ata_sff_queue_pio_task(link, 0);
> +					return 0;
> +				}
>  				goto fsm_start;
>  			}
>  		}

[Severity: High]
Can queuing ap->sff_pio_task from the interrupt handler here race with
ata_sff_flush_pio_task() during timeout recovery and trigger a BUG_ON()?

Previously, ap->sff_pio_task was only initially queued at command issue time
and re-queued by ata_sff_pio_task() itself, so cancel_delayed_work_sync() in
ata_sff_flush_pio_task() guaranteed the work item would not be re-armed
before ap->hsm_task_state was reset to HSM_ST_IDLE:

drivers/ata/libata-sff.c:ata_sff_flush_pio_task() {
	...
	cancel_delayed_work_sync(&ap->sff_pio_task);

	spin_lock_irq(ap->lock);
	ap->hsm_task_state =3D HSM_ST_IDLE;
	spin_unlock_irq(ap->lock);

	ap->sff_pio_task_link =3D NULL;
}

When an interrupt-driven PIO data-in command times out (via
ata_scsi_cmd_error_handler() -> ata_sff_flush_pio_task() or
ata_exec_internal_sg() -> ata_sff_flush_pio_task()), ap->sff_pio_task is not
yet pending, so cancel_delayed_work_sync() returns immediately.

If the final data block interrupt arrives on another CPU before
ata_sff_flush_pio_task() acquires ap->lock:

CPU0                                  CPU1 (IRQ)
ata_sff_flush_pio_task()
  cancel_delayed_work_sync()
                                      __ata_sff_port_intr()
                                        ata_sff_hsm_move()
                                          ata_pio_sectors(qc)
                                          qc->tf.flags |=3D ATA_TFLAG_POLLI=
NG;
                                          ata_sff_queue_pio_task(link, 0);
  spin_lock_irq(ap->lock);
  ap->hsm_task_state =3D HSM_ST_IDLE;
  spin_unlock_irq(ap->lock);
  ap->sff_pio_task_link =3D NULL;

When ata_sff_pio_task() then executes on ata_sff_wq, wouldn't it hit
BUG_ON(ap->sff_pio_task_link =3D=3D NULL), or enter fsm_start with
ap->hsm_task_state =3D=3D HSM_ST_IDLE while error handling is active?

[ ... ]

>
endasi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-182-sashal@kernel.org?part=3D1

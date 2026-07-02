Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE61F4176
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951370; cv=none; b=W3T4Jqnzh7L+MgTNPwRijke5wiqdgaRycqT/e6mY2QQ+Nr7yTGBG9AidjpPGieP6YiYp/tmxkUymeIQqdyfSAl5RX8Nphq/DY+GS7WdjLAVCJBcFYHx24awS+J7p4Mk6k1XXA3Kms2tVHG2mjv+06yR6zgWeu93QFu9N+es/k7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951370; c=relaxed/simple;
	bh=iYYsGyBKOkQl9GXbsm24JLfaoSZRpUUTHCDZ0nlgKsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jHmoi8RuEcEzB/CZLv2vdJqhst7jCnrOPp6v0AXWd6drwFGkq5+8QFlhAyxTQsk49uQwp1BC4+cbCuxfbt385Vp/cdfmHYj2/gOtGpkHmNoTHKl74+RcAFRlKeYsnTcAO2F2f7dgE0t/sJF0X1L8h5ka8AZ3v5pTCVnVG3lBtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vuayuhy1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuayuhy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E49E1F000E9;
	Thu,  2 Jul 2026 00:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951369;
	bh=tg3PpbDN3tqWlSfpqMa+UbLqizw383kksF0fF6MAiCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vuayuhy1o7mczSJCPDgZ5kUM5/XH3QPaCxQjTvxQ0Ts1jCisTo1kseN1Rmu/jbJGt
	 9/PIm7eoKmMRvXxrg6NjlK/oktkrGOjRmqAclBSAE5zaZfE+vsP3Bt0eNaUZNP84/a
	 1kzZawET9f6wlKNdkEFWpHVhGU6JXWCDwf2XM7l5xEZauD4jEwOMQHYyJ6fXkWq6iv
	 xj7OMhjHuznY4NxJPC5e8XG2OlrjP4e7CvVpwLflsaUJ2K1uA9O6cYek8rK3siyF0y
	 m9VDa+F2lBM2vY6/vETBz8osP9i7IjWfW4Wd4k9hRGv+xgdH+Z1Pt2RA75BwhhzVv+
	 YtpkqbSBl6yjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 5/8] ata: sata_dwc_460ex: fix data race on
 hsdev->sactive_issued in interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702000350.68331-6-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
 <20260702000350.68331-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 00:16:08 +0000
Message-Id: <20260702001609.4E49E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The NCQ tag completion logic contains an infinite loop due to =
a left shift instead of a right shift, which will cause a hard CPU hang ins=
ide a spinlock-protected hardirq context.
- [High] Unconditionally zeroing `hsdev->sactive_issued` on every interrupt=
 destroys persistent NCQ state, breaking NCQ completion tracking.
- [High] The `clear_interrupt_bit()` function ignores the `bit` argument an=
d inadvertently clears all pending hardware interrupts.
--

commit 2746dc992432ebc7a9253d28cee91b6dd821a51d
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in interrupt ha=
ndler
   =20
hsdev->sactive_issued is written locklessly in sata_dwc_isr() before
acquiring host->lock, while sata_dwc_qc_complete() performs a
read-modify-write on the same field under the lock.  This creates a
data race that can corrupt NCQ tag tracking state.
   =20
Move the zero assignment inside the critical section so all accesses
to sactive_issued are serialized by host->lock.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..9a4fb911d3215 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -470,9 +470,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_in=
stance)
>  	int handled, port =3D 0;
>  	uint intpr, sactive, sactive2, tag_mask;
>  	struct sata_dwc_device_port *hsdevp;
> -	hsdev->sactive_issued =3D 0;
> =20
>  	spin_lock_irqsave(&host->lock, flags);
> +	hsdev->sactive_issued =3D 0;

[Severity: High]
This is a pre-existing issue, but does unconditionally zeroing
hsdev->sactive_issued on every entry into sata_dwc_isr() destroy persistent
NCQ state?

It looks like this breaks NCQ completion tracking by erasing tags set during
SATA_DWC_INTPR_NEWFP handling.

Would this force a fallback to a non-standard NCQ completion path that hand=
les
commands individually?

> =20
>  	/* Read the interrupt register */
>  	intpr =3D sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);

[Severity: Critical]
This is a pre-existing issue, but does the NCQ tag completion logic contain=
 an
infinite loop when processing completions?

Inside the NCQ completion block of sata_dwc_isr():

        while (!(tag_mask & 0x00000001)) {
                tag++;
                tag_mask <<=3D 1;
        }

Because tag_mask is left-shifted, bit 0 will remain 0 and tag_mask eventual=
ly
evaluates to 0. At that point, !(0 & 1) is always true.

Would this cause the loop to spin forever inside a spinlock-protected hardi=
rq
context?

[Severity: High]
This isn't a bug introduced by this patch, but does the clear_interrupt_bit=
()
function ignore the bit argument and inadvertently clear all pending hardwa=
re
interrupts?

drivers/ata/sata_dwc_460ex.c:clear_interrupt_bit()
        sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
                        sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));

Since it reads the intpr register and writes the exact read value back,
assuming a standard Write-1-to-Clear (W1C) register model, would this clear
all pending interrupts?

Could hardware interrupts that occur simultaneously with NEWFP interrupts be
permanently lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702000350.6833=
1-6-rosenp@gmail.com?part=3D1

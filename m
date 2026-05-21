Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F153FB05D
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388839; cv=none; b=pMjeEN1y2WmiZz93f/gHsdt41B9ol1ux7US0Qd81Y8A/BU2hE0EvgCgwr+V0Esyqtm9hLLziUl6uZJX/vnd4UhB4CH71uc0ZoqDlMvZLTU34o3d8HE/yvjlgx7wSp3v9qfZEaTH0Y8YOMK2WOyyPNOts/7z7aidcI+IZRdaWuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388839; c=relaxed/simple;
	bh=LJBI0Bp0Vc81I/hGRFSjcfjzuHWNGzOaSN0pkQzumjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jm2VkV0fzvG/YM2am/oXv+dbwJP+U33yy+Q8wvAxIHRqvAQWz8wML39EYm+Wpd7UFs15EiIjpD/EvDsfT7xWpGDjdKTth6oFx5imetw6KFrgMo6NlDev5eywosjpKNHuEtrJQU0oB9Frnu3+u2mhMaIppWZ4ZZCSqMqmit0qV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmYPs92o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmYPs92o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD131F000E9;
	Thu, 21 May 2026 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779388836;
	bh=VPsy/1J26ODqcBFyxACJbA1LdmMKRpAJA+mCmcBUqH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UmYPs92oqsyKtI8RgfElknQaEtjiQvOlgcl1y8YCkFOpjyb+yUrnl/5NYVaSuXmGP
	 AbF8rpNdi/WLPzZGUHM46WIDxYBTR0qbdc/TwIYnpoU8K1tv5QCnNRWs4iU3+DGDF9
	 j+u6Sj2SuAZ79KykCILC5H0u9xUXkp3SOa8+bgVkojc5T6yqStYyHw9jk+kqwRETPq
	 wGUQCBFfBOgtVqfoYwCDmX1CWcIxR6kiEidEl7SwOWfX6CxOQfQChfwOnR8KrHz7ue
	 iw1mHV5jFRnMMgRTj62Biv6UN0OVa0H0j84xHPYmhVtRyIjcNaWtrHhIfnjuPYMKdB
	 cA1DCnjIlCPfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] ata: libata: Pass the ATA port argument directly
 to ata_qc_complete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260521173347.2079560-5-bvanassche@acm.org>
References: <20260521173347.2079560-5-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:40:35 +0000
Message-Id: <20260521184035.DAD131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The kernel-doc comment for ata_qc_complete() is missing the new '@a=
p' parameter.

Pre-existing issues:
- [High] In `sata_fsl_host_intr`, a spurious interrupt will prematurely com=
plete an active internal command.
--

commit 0bfdcf1e846fdd4f2753f05417c311388a3aa360
Author: Bart Van Assche <bvanassche@acm.org>
ata: libata: Pass the ATA port argument directly to ata_qc_complete()

This commit prepares for adding lock context annotations by passing the ATA
port argument directly to ata_qc_complete(). No functional changes were mad=
e.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5caae9a2aca39..307ab48fe04c2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5024,9 +5024,8 @@ static void ata_verify_xfer(struct ata_queued_cmd *=
qc)
>   *	LOCKING:
>   *	spin_lock_irqsave(host lock)
>   */
> -void ata_qc_complete(struct ata_queued_cmd *qc)
> +void ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
>  {

[Severity: Low]
Is the kernel-doc block missing the new @ap parameter? Since this is an
exported symbol, omitting the new parameter might trigger kernel-doc
warnings during documentation builds.

> -	struct ata_port *ap =3D qc->ap;
>  	struct ata_device *dev =3D qc->dev;
>  	struct ata_eh_info *ehi =3D &dev->link->eh_info;

[ ... ]

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index be829fcc584de..ce6f50b8e38c1 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1264,7 +1264,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  			 ioread32(hcr_base + CC));
> =20
>  		if (qc) {
> -			ata_qc_complete(qc);
> +			ata_qc_complete(ap, qc);
>  		}

[Severity: High]
This is a pre-existing issue, but does this code prematurely complete an
active internal command on a spurious interrupt?

When an internal command is active, ap->qc_active has bit 32 set
(ATA_TAG_INTERNAL). The done_mask is a 32-bit value read from the CC
register, so it cannot have bit 32 set. Consequently,
done_mask & ap->qc_active always evaluates to 0.

The driver then falls back to the else if block this hunk modifies, which
blindly assumes the internal command completed without verifying that the
completion bit in CC is actually set. If a non-error or spurious interrupt
arrives while an internal command is in flight, it appears the driver
will incorrectly complete the command before the hardware finishes processi=
ng
it.

>  	} else {
>  		/* Spurious Interrupt!! */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521173347.2079=
560-1-bvanassche@acm.org?part=3D4

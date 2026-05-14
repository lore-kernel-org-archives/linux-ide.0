Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7D3F4117
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739594; cv=none; b=k4oEeAteGle64oECiWzetGovl03FmGDSNW35yZn4zZKtK6r7L3MWj/OCZ27AJsPayMGkOvhDAX0LNtPugSBQCZxGJeDX6hmp1Q9vrbVC7XL1Iu4Ev2tMexQUATjecwr3A+wqlsrMxVGeiGqyAeR2CpHRj98WclwzX0OGAWObzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739594; c=relaxed/simple;
	bh=nkFO3WIv2UqmRo/AjVYG9W8DdQwnD7LmemTBWxFJt2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfpPGNUGoir4HzlkCZmfd1vCUgT7t9QOwBVticwX4yxa7d9NW4n3uGNbbteqPmZCOygG21Pjc6Ul1R2c2ak2HJ0Sz34Zy+m3mBS3ZqW9Anp23jPMRG/5dpksTLNPpWR3r994CmMHY7iclGU4V3uJxeV44IeKUIm2dZJh8u/ppBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CubIuQIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CubIuQIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEA2C2BCB7;
	Thu, 14 May 2026 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778739593;
	bh=nkFO3WIv2UqmRo/AjVYG9W8DdQwnD7LmemTBWxFJt2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CubIuQIws8wlLA0ec9JpNc0NAnj39GXhz0s7ZWgI9dsnFLMSc2/1E+Ejop6MdAagF
	 9ahhNtXdq/mJ2dqAoEIwI7Mi8T8fpYQBR6utyzd0UwsvjyoWSsieSi3hI089HLTznY
	 x+zvG6DoGazX+O6l9o/1t500FPpf++rUDQ1oupk4zsPGVa/Y/MF6jzha7DvIYukdEU
	 6q5pYiJNRPer75hAjFwV3JHrq6HHt6mbxQndGtU4hDPTjq4+yKlYK3M7ZOAbQUiEk+
	 7kAM9/LcmSvzjTFFfmd/o+ltn30Otse0AX6u448J9ims3i/M4nNspw8bWBA3QVeNCb
	 rzgBETrEQ+b0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] ata: libata-scsi: do not use the deferred QC
 feature on PMPs with CBS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260513151359.1075403-9-cassel@kernel.org>
References: <20260513151359.1075403-9-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 06:19:52 +0000
Message-Id: <20260514061953.7DEA2C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `ATA_DEFER_LINK_EXCL` case incorrectly uses `goto defer_qc;` i=
nstead of `goto free_qc;`, causing the command to still be stored in the in=
compatible deferred workqueue.
--

commit ea0512ae247e5510bc9041eabca7f2d8e0abcc9e
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS

This commit introduces the ATA_DEFER_LINK_EXCL return value to prevent
commands from being deferred via the workqueue when using Port Multipliers
(PMPs) with Command-Based Switching (CBS). It modifies
sata_pmp_qc_defer_cmd_switch() and sil24_qc_defer() to return this new
value, and updates ata_scsi_qc_issue() to handle it without storing the
command in the deferred_qc workqueue.

[ ... ]

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 22642a0e6b843..02f2d7416c839 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1787,6 +1787,14 @@ static int ata_scsi_qc_issue(struct ata_port *ap, =
struct ata_queued_cmd *qc)
>  	case ATA_DEFER_LINK:
>  		ret =3D SCSI_MLQUEUE_DEVICE_BUSY;
>  		goto defer_qc;
> +	case ATA_DEFER_LINK_EXCL:
> +		/*
> +		 * Drivers making use of ap->excl_link cannot store the QC in
> +		 * ap->deferred_qc, because the ap->excl_link handling is
> +		 * incompatible with the ap->deferred_qc workqueue handling.
> +		 */
> +		ret =3D SCSI_MLQUEUE_DEVICE_BUSY;
> +		goto defer_qc;

Does this still store the command in the incompatible deferred workqueue?

If this jumps to defer_qc, a non-NCQ command will fall into this block in
ata_scsi_qc_issue():

defer_qc:
        if (!ata_is_ncq(qc->tf.protocol)) {
                ap->deferred_qc =3D qc;
                return 0;
        }

Should this case use goto free_qc instead to force a requeue without caching
the command in ap->deferred_qc and losing the SCSI_MLQUEUE_DEVICE_BUSY retu=
rn
value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513151359.1075=
403-6-cassel@kernel.org?part=3D3

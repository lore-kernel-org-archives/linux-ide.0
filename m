Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C962D29C8
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718989; cv=none; b=JW2G/ziQJSKZUIP395VIcobbD/TbBDYiLCFQ4svyapu5n6jC8xyIJvWtzPdnjmksp2A0v4uJ4pATNBv4pGsIBdCt9zoql2dDrlvVGg8zT2G/KT1Iu1fVpvzBqQKF3TIuAUS7jZNqwSLhQJ9duL+L4728FskW87IVywNPExHOctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718989; c=relaxed/simple;
	bh=JVFVN0S04GdX3I2uCPXrMwoH2JJ/RmeIBcufMKKDBY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTxkTYIgmRPL7rGB/zUYwtap+gxr8FNKXhol6cd5Ol8RSKu1hidDAu/MWbos98wHsAeVIY28ydFMMF2vUHqQ65glq73khmg6glpKEqVWKmAFO6DkWVJME9i88RtXEhuPZ1+3VVQ6c9z8aEeh2MbbkXvS1pYBNnSP7h6vU28keg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcdP738N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcdP738N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89577C19425;
	Thu, 14 May 2026 00:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718988;
	bh=JVFVN0S04GdX3I2uCPXrMwoH2JJ/RmeIBcufMKKDBY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hcdP738NfuXF8wKEFFwjhyH6ur+gMERDUKqVNCMIQWTM+FwXyIoJKdtkvRmQJxa1L
	 hUdXEG7yvQ00oyPv2xPec2IUkFTe8Urs4aegysrJP7tvAVoXQyNeHhaHR8RpWV/CCj
	 Rhvxr2qw1pA3eE8ogUxhZmprNYhrqlXIc5r4e25OkzjxhHuPMqvVZPJNJHYvyf6OUJ
	 lPJQoewZgYjmtFmBsWT8MHXiCE198WQRNb+xa+9FTS/PnfDQbkVRgHeQ4rKHAx9fF+
	 Ye1Oc0vfJA+D14JHka/UcjTUqk9NsgKMJa8Qu9QVBMXxw+7q0cUBa5lvs6qK25ZayZ
	 PX8zCCtYKqu9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] ata: libata-scsi: convert dev->sdev to per-LUN
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260512202728.299414-3-philpem@philpem.me.uk>
References: <20260512202728.299414-3-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:36:28 +0000
Message-Id: <20260514003628.89577C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Out-of-bounds array write in `ata_scsi_dev_config()` and `ata_=
scsi_sdev_destroy()` via unvalidated `sdev->lun` index.
- [High] Semantic error in `atapi_qc_complete()` clears `locked` flag for L=
UN 0 on failures originating from other LUNs.
- [High] TOCTOU race condition in `ata_port_detach()` leading to NULL point=
er dereference or Use-After-Free.
--

commit 1302443818a8bc8d7f9a9c01d075139291e28886
Author: Phil Pemberton <philpem@philpem.me.uk>
Subject: ata: libata-scsi: convert dev->sdev to per-LUN array

This commit converts the single dev->sdev pointer into an array to support
multi-LUN ATAPI devices. It replaces hardcoded single-LUN logic with loops
over valid LUN slots and adds helpers to safely access the per-LUN SCSI
devices.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4408b1fb48c77..1cb159d9dbc75 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[ ... ]
> @@ -6275,11 +6276,15 @@ static void ata_port_detach(struct ata_port *ap)
>  	/* Remove scsi devices */
>  	ata_for_each_link(link, ap, HOST_FIRST) {
>  		ata_for_each_dev(dev, link, ALL) {
> -			if (dev->sdev) {
> +			int lun;
> +
> +			for (lun =3D dev->nr_luns - 1; lun >=3D 0; lun--) {
> +				if (!dev->sdev[lun])
> +					continue;
>  				spin_unlock_irqrestore(ap->lock, flags);
> -				scsi_remove_device(dev->sdev);
> +				scsi_remove_device(dev->sdev[lun]);

Can this cause a NULL pointer dereference or use-after-free?

The argument dev->sdev[lun] is evaluated after the lock is released. If a
concurrent sysfs device removal invokes ata_scsi_sdev_destroy(), it will
acquire the lock and set dev->sdev[lun] =3D NULL.

When the original thread resumes, it might pass NULL to scsi_remove_device(=
),
which unconditionally dereferences sdev->host. Even if it reads a non-NULL
pointer, no reference is held via scsi_device_get(), so the device could be
freed concurrently.

Should the pointer be cached and refcounted under the lock, similarly to how
it is done in ata_scsi_remove_dev()?

>  				spin_lock_irqsave(ap->lock, flags);
> -				dev->sdev =3D NULL;
> +				dev->sdev[lun] =3D NULL;
>  			}
>  		}
>  	}
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 32c6a0e497cf9..7c3d31dc49a17 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[ ... ]
> @@ -1131,7 +1131,7 @@ int ata_scsi_dev_config(struct scsi_device *sdev, s=
truct queue_limits *lim,
>  	if (dev->flags & ATA_DFLAG_TRUSTED)
>  		sdev->security_supported =3D 1;
> =20
> -	dev->sdev =3D sdev;
> +	dev->sdev[sdev->lun] =3D sdev;

Could this cause an out-of-bounds write?

The dev->sdev array has a fixed size of ATAPI_MAX_LUN (8), so valid indices
are 0 to 7. The SCSI layer's shost->max_lun is 8, and scsi_report_lun_scan()
checks if (lun > sdev->host->max_lun), which allows lun =3D=3D 8.

If an ATAPI device returns LUN 8, could dev->sdev[8] =3D sdev overwrite
dev->nr_luns, leading to further stack buffer overflows during teardown pat=
hs
that use dev->nr_luns?

>  	return 0;
>  }
> =20
[ ... ]
> @@ -1220,11 +1220,12 @@ void ata_scsi_sdev_destroy(struct scsi_device *sd=
ev)
> =20
>  	spin_lock_irqsave(ap->lock, flags);
>  	dev =3D __ata_scsi_find_dev(ap, sdev);
> -	if (dev && dev->sdev) {
> -		/* SCSI device already in CANCEL state, no need to offline it */
> -		dev->sdev =3D NULL;
> -		dev->flags |=3D ATA_DFLAG_DETACH;
> -		ata_port_schedule_eh(ap);
> +	if (dev && dev->sdev[sdev->lun] =3D=3D sdev) {

Could this also cause an out-of-bounds access if sdev->lun is 8?

> +		dev->sdev[sdev->lun] =3D NULL;
> +		if (sdev->lun =3D=3D 0) {
> +			dev->flags |=3D ATA_DFLAG_DETACH;
> +			ata_port_schedule_eh(ap);
> +		}
>  	}
>  	spin_unlock_irqrestore(ap->lock, flags);
> =20
[ ... ]
> @@ -2911,10 +2912,15 @@ static void atapi_qc_complete(struct ata_queued_c=
md *qc)
>  		 * avoid this infinite loop.
>  		 *
>  		 * This may happen before SCSI scan is complete.  Make
> -		 * sure qc->dev->sdev isn't NULL before dereferencing.
> +		 * sure the LUN-0 sdev isn't NULL before dereferencing.
>  		 */
> -		if (qc->cdb[0] =3D=3D ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
> -			qc->dev->sdev->locked =3D 0;
> +		if (qc->cdb[0] =3D=3D ALLOW_MEDIUM_REMOVAL) {
> +			struct scsi_device *sdev =3D
> +				ata_dev_scsi_device(qc->dev, 0);
> +
> +			if (sdev)
> +				sdev->locked =3D 0;
> +		}

Does this clear the locked flag for LUN 0 even if the failed command was
issued to a different LUN?

If the command was issued to LUN 1, its locked flag would remain set, which
could cause an infinite retry loop in SCSI EH for multi-LUN devices.

Should this use qc->scsicmd->device->locked =3D 0 instead to clear the flag=
 on
the actual target device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512202728.2994=
14-1-philpem@philpem.me.uk?part=3D2

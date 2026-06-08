Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557330C157
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956758; cv=none; b=Q2gcfthOZpeVMB30dmeOUq+00+BtnaEoOIkRJ2KOxUBxFbc/2I4QUPfp+fPocCxe0+c76mlXh7dDfl7BMzEq7/7nsPMbgfLTH8TcrNzlIGqH8oY1ussmmU/ZViUNq4Ns+K26TvfTHNm40fqB722dasbAnU+dWJw4xD8Cq6BX11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956758; c=relaxed/simple;
	bh=Wys2jnDbCwu46Plk/qzt4xqrTwceSxdeKu5IZF+xvaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cnx2Jjw43gYZ12opyRAw9dMZ5hbNUO/+ACOXzSpct/LFsLfwI9S8l+xAlixAm0QU4ASVsEbCZffvnCM2qYWFzZsNGIckcA2iGQYIHh+4HUrHgMcJ37IU+Dnl9kQrJ4PYxrSI7LhNOvUemHmJjV7YGs/kg2Z69NA6NGhKgOjX8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J50etvsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J50etvsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8472B1F00893;
	Mon,  8 Jun 2026 22:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780956756;
	bh=Ad/plau8wEEmGHmFeSmNn/x6fQkvKegP5Uf2GoG/+bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J50etvskUtqyHz0EthoNGOmXDNxONTGR1aRQmxvG3FwCRH5nBpVeWUfmNehtIrqw6
	 fOeGw1cJbyquuMUcHgRVzQHz1Q9umxPrc6VBaIVSxxMrQNg/I74vOpmuImfCPibgXS
	 8qJbZ8KD7+04EhTTz8/trQ2zYqqXjEZ9YK82lEHYr8yciftXSA4bcnFrWQNuqY31nv
	 9j94Zc42ORTXE1xbFX5hPRvBXva+OukwHyYB3HNhoUumKMFk9ebj+nfO9SviOyFgto
	 T9aZDYqtwIqn8PC3LyZnMhoXr/I8UVmwbMFeJvBpzDADdWClZYO7pzaSNYmHAkbT+r
	 YcQP+wrE2nt6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] ata: libata-scsi: convert dev->sdev to per-LUN
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260608213443.2296614-3-philpem@philpem.me.uk>
References: <20260608213443.2296614-3-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:12:36 +0000
Message-Id: <20260608221236.8472B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Hardcoding LUN 0 in `atapi_qc_complete()` after a failed `ALLOW_ME=
DIUM_REMOVAL` command re-introduces an infinite SCSI EH loop for higher LUN=
s.
- [High] The `ATA_DFLAG_RESUMING` flag is permanently leaked if `scsi_resca=
n_device()` fails, blocking future power management operations.
- [High] `ata_scsi_sdev_destroy()` triggers a full ATA device detach simply=
 when LUN 0 is destroyed, abruptly severing all other active LUNs.

Pre-existing issues:
- [High] In `ata_port_detach()`, `dev->sdev[lun]` is not cleared before cal=
ling `scsi_remove_device()`, leaving a window for Use-After-Free by lockles=
s readers.
--

commit 21e5b1c2633a42382bfa70b2a8ecf4892badd416
Author: Phil Pemberton <philpem@philpem.me.uk>
Subject: ata: libata-scsi: convert dev->sdev to per-LUN array

This commit replaces the single scsi_device pointer in ata_device with an
array to support multi-LUN ATAPI devices. It also adds a dev->nr_luns field
and an ata_dev_scsi_device() helper to manage the per-LUN access.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
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
>  				spin_lock_irqsave(ap->lock, flags);
> -				dev->sdev =3D NULL;
> +				dev->sdev[lun] =3D NULL;
>  			}
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does this leave a window for a
use-after-free? By dropping the lock and calling scsi_remove_device() while
the pointer is still accessible in the array slot, concurrent lockless
readers might access the scsi_device during or after its destruction.
Would it be safer to snapshot the pointer and clear the slot under the lock
before calling scsi_remove_device(), similar to how it is handled in
ata_scsi_remove_dev()?

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
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
> +		dev->sdev[sdev->lun] =3D NULL;
> +		if (sdev->lun =3D=3D 0) {
> +			dev->flags |=3D ATA_DFLAG_DETACH;
> +			ata_port_schedule_eh(ap);
> +		}
>  	}
>  	spin_unlock_irqrestore(ap->lock, flags);

[Severity: High]
Could this abruptly detach the physical device while other LUNs are still
active? If a user manually removes LUN 0 via sysfs while LUN 1 is still
running, the sdev->lun =3D=3D 0 condition evaluates to true, triggering a
full ATA device teardown. Should the detach sequence instead be deferred
until all active LUN slots in the device array have been cleared?

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

[Severity: High]
Does hardcoding LUN 0 here re-introduce an infinite SCSI EH loop for higher
LUNs? If an ALLOW_MEDIUM_REMOVAL command fails on a LUN > 0, this code
clears the locked flag on LUN 0 instead of the target device. This leaves
the higher LUN's locked flag set, which causes SCSI EH to retry the lock
indefinitely. Should this use the actual device that the command targeted?

[ ... ]
> @@ -5007,37 +5010,39 @@ void ata_scsi_dev_rescan(struct work_struct *work)
[ ... ]
> -			spin_unlock_irqrestore(ap->lock, flags);
> -			if (do_resume) {
> -				ret =3D scsi_resume_device(sdev);
> -				if (ret =3D=3D -EWOULDBLOCK) {
> -					scsi_device_put(sdev);
> -					goto unlock_scan;
> +			for (lun =3D 0; lun < dev->nr_luns; lun++) {
> +				struct scsi_device *sdev =3D dev->sdev[lun];
> +
> +				if (!sdev)
> +					continue;
> +				if (scsi_device_get(sdev))
> +					continue;
> +
> +				spin_unlock_irqrestore(ap->lock, flags);
> +				if (do_resume) {
> +					ret =3D scsi_resume_device(sdev);
> +					if (ret =3D=3D -EWOULDBLOCK) {
> +						scsi_device_put(sdev);
> +						goto unlock_scan;
> +					}
>  				}
> -				dev->flags &=3D ~ATA_DFLAG_RESUMING;
> +				ret =3D scsi_rescan_device(sdev);
> +				scsi_device_put(sdev);
> +				spin_lock_irqsave(ap->lock, flags);
> +
> +				if (ret)
> +					goto unlock_ap;
>  			}
> -			ret =3D scsi_rescan_device(sdev);
> -			scsi_device_put(sdev);
> -			spin_lock_irqsave(ap->lock, flags);
> =20
> -			if (ret)
> -				goto unlock_ap;
> +			if (do_resume)
> +				dev->flags &=3D ~ATA_DFLAG_RESUMING;
>  		}
>  	}

[Severity: High]
Can the ATA_DFLAG_RESUMING flag be permanently leaked here?
If scsi_rescan_device() returns an error for any LUN, the code breaks out
early using goto unlock_ap. This skips the block at the bottom that clears
the ATA_DFLAG_RESUMING flag, leaving the device stuck in a resuming state
and potentially blocking future power management operations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608213443.2296=
614-1-philpem@philpem.me.uk?part=3D2

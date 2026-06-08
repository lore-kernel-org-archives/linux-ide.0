Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084128B4E2
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957047; cv=none; b=Cu2BQX73tYdiTmz8ehgokXrfLCiQaR/1A23XuHBswBdMAriPxOHREkktX3VleXZ+GJo9fudOH3RDMIKRWXKEPKonEJVwRAf/YniDAHIUxCKLMn+He0gwH0NgmHs92QI5PzWJyP0Dlgzx+Ol4rm78y8/qjvnDo4PcAGUrH/27pHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957047; c=relaxed/simple;
	bh=UZiOQTdjouwAZpJ5Y1GgSTwWRA56cRnLbRj4+kSJ/C0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YpQEhy/i9c3zq5YMm7v53vVaY1j6/2aBILsYN6kVznBj9xsdkYDcp5SGkJnVFQ8ph1kNzZEgDPmkzfFMuFgtoqYlJs5lq7TpdpskPv1etUOf7BxetVbl1ABm+yFm5R3LHAUp/y0BadbijPnzJvsiUDS75mhtZdnBdCddTVN4lJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ievUYzbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ievUYzbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734D71F00893;
	Mon,  8 Jun 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780957045;
	bh=3SLmuuAyjMsfJJboBxItsZTbcePzNE5UfrbiuFSjUhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ievUYzbcAIfG/awCP8Y2uS76KfcjpW5p2bZqruiuDD361myqywKnYz42n2Oufa+oz
	 2ALZdWSdd0urdCVu4MtyKP/Dfcp1w7L8bW61GwNBLSJ4uEuk5XyRfneKtNvDFnZSLj
	 M6GU1ROXdKDwwgSOMGyc8xTe09FIn47a6n635nWlMvIvTgN6mHH8eLBDkmv+9btxp0
	 jmUmE2zivp/Gh70YCwto4/fpn0b0VxHkUldECG4ils+LvpDsFzXLIfCjELH8cDMnpD
	 HDOhZyENCRMsFfwp8jDXM0OTJAMzpIg7daISqZLmL98eVYXkRS241wJpwzlyzxrKi4
	 w1Mr0vGYDofMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] ata: libata-scsi: probe additional LUNs for
 multi-LUN ATAPI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260608213443.2296614-6-philpem@philpem.me.uk>
References: <20260608213443.2296614-6-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:17:25 +0000
Message-Id: <20260608221725.734D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Moving `ata_scsi_assign_ofnode()` after `scsi_device_put()` in=
troduces a TOCTOU race leading to a NULL pointer dereference or Use-After-F=
ree.
- [High] Hot-unplugging a multi-LUN ATAPI device fails to detach and free L=
UNs > 0, resulting in memory leaks and zombie SCSI devices.
--

commit 6a6b71770a262841f2823d6eb0dbe90bb0dcb456
Author: Phil Pemberton <philpem@philpem.me.uk>
ata: libata-scsi: probe additional LUNs for multi-LUN ATAPI devices

After LUN 0 is added for an ATAPI device, this commit checks the BLIST_FORC=
ELUN
flag. If set, it bumps the LUN count to the host's maximum and triggers a
sequential SCSI scan for that target. Non-responding LUNs are silently skip=
ped.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 2d714efc855f0..a6f5557014c70 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[ ... ]
> @@ -4745,12 +4746,30 @@ void ata_scsi_scan_host(struct ata_port *ap, int =
sync)
>  			sdev =3D __scsi_add_device(ap->scsi_host, channel, id, 0,
>  						 NULL);
>  			if (!IS_ERR(sdev)) {
> -				dev->sdev[0] =3D sdev;
> -				ata_scsi_assign_ofnode(dev, ap);
> +				/*
> +				 * For multi-LUN ATAPI (BLIST_FORCELUN), bump
> +				 * dev->nr_luns to the host max so the LUN
> +				 * routing in atapi_xlat() accepts the probe
> +				 * INQUIRYs to LUN > 0, then trigger the
> +				 * sequential scan.  pdt_1f_for_no_lun, set
> +				 * during LUN 0 configure, ensures
> +				 * non-responding LUNs are silently skipped;
> +				 * dev->sdev[] is populated by
> +				 * ata_scsi_dev_config() during the scan.
> +				 */
> +				if (dev->class =3D=3D ATA_DEV_ATAPI &&
> +				    sdev->sdev_bflags & BLIST_FORCELUN) {
> +					dev->nr_luns =3D ap->scsi_host->max_lun;

[Severity: High]
Does bumping dev->nr_luns here cause a memory leak during a device
hot-unplug or fatal error reset?

During those events, the libata error handler synchronously calls
ata_eh_detach_dev() followed by ata_dev_init(), which unconditionally resets
dev->nr_luns =3D 1 without clearing the dev->sdev[] array.

When the asynchronous SCSI hotplug task later calls ata_scsi_remove_dev(),
it bounds its cleanup loop using the newly reset count:

for (lun =3D dev->nr_luns - 1; lun >=3D 0; lun--) { ... }

Since dev->nr_luns was reset to 1, any active SCSI devices populated in
dev->sdev[1..7] appear to be skipped. Could this permanently leak the
scsi_device structures and leave unresponsive zombie block devices exposed
to userspace?

> +					scsi_scan_target(
> +						&ap->scsi_host->shost_gendev,
> +						channel, id, SCAN_WILD_CARD,
> +						SCSI_SCAN_RESCAN);
> +				}
>  				scsi_device_put(sdev);
> -			} else {
> -				dev->sdev[0] =3D NULL;
>  			}
> +
> +			if (dev->sdev[0])
> +				ata_scsi_assign_ofnode(dev, ap);

[Severity: Critical]
Is there a race condition here between dropping the local reference and
checking dev->sdev[0]?

By calling scsi_device_put(sdev) before checking dev->sdev[0] and executing
ata_scsi_assign_ofnode(dev, ap), the object's lifetime relies solely on sys=
fs
since shost->scan_mutex is not held here.

If a concurrent device removal happens (such as userspace writing to the
delete attribute), the concurrent path executes:

sdev_store_delete()
  scsi_remove_device()
    ata_scsi_sdev_destroy()

This path sets dev->sdev[0] =3D NULL and drops the sysfs reference.

If this concurrent sysfs removal happens exactly between the unprotected
if (dev->sdev[0]) check and its use inside ata_scsi_assign_ofnode(), could
it result in a NULL pointer dereference, or a Use-After-Free if the object
is freed before accessing sdev->sdev_gendev.of_node?

>  		}
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608213443.2296=
614-1-philpem@philpem.me.uk?part=3D5

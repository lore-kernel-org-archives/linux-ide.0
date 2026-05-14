Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AE78F4A
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726036; cv=none; b=mM74ZhN3sIRq3mWDtqX19kKvWoC0e6VbH4nMnXs9UoPeg1lttbLFXX955kTYqO0tVblue2tu/0MndUiXl99Os+85NLLBGgVWKTDNRx44NTnY1Y4z6ghOkl9VBTTfeVnxk/d66UrdHvjOh24DS4cdwLt5I/gkkp6WXu2nAs1ug1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726036; c=relaxed/simple;
	bh=WY2Qufn2mP9g8gTZU/PRb8frtQas8wk/jq8m0vYZ9Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XjzH/Yh3fWhYViW/sBUd3ZaisEXjtrHlpQhXxQSWvwq14dHGGWJ5aUcFaKsJaam1v5NmxUg62XOYTNvnKSaUCJAF8137KlD4n32XH/si8zsZ/RO6FZZOW579r+Yx2YqxGO+Q4pOguRXXyAaO3feC+yg0TVA5ZkIVFlGkdVaKmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+VBI9nW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+VBI9nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E36C19425;
	Thu, 14 May 2026 02:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778726035;
	bh=WY2Qufn2mP9g8gTZU/PRb8frtQas8wk/jq8m0vYZ9Ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q+VBI9nWt0l6ncZ5D0xm4HoHsE7ANLE6R4Jn1KQ9HibilO9eoUs3W4JAHP9vmDtEF
	 Nea3ZKzrRnq3Bnop25byjvtKq3GV1lftA1XROeR8wDlhNz6PY3zeJa0NZIqvTnYK/W
	 wwNSKS1vL1jYosGAZtJDHhMUijpH2hx/JY7UxnDN9o6K8YYMMuuMdmTESKekT7tTUp
	 KBk2FWfTH3GdZ8boGNq2PIeFkBYAe+w1+2uN6PmIprfPMOeWb9veepGllmxwLlvjjY
	 avDVZohXAxP74MPKC/v8fXoLlYYi3yQeJN1BZ1BMq5GxVTvePowqkTWgO3qQUD1Vkw
	 HUz43Pc6Q/rUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] ata: libata-scsi: probe additional LUNs for
 multi-LUN ATAPI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260512202728.299414-6-philpem@philpem.me.uk>
References: <20260512202728.299414-6-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:33:54 +0000
Message-Id: <20260514023355.57E36C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving scsi_device_put(sdev) before ata_scsi_assign_ofnode(dev, ap=
) introduces a TOCTOU race condition that can result in a Use-After-Free or=
 NULL pointer dereference.
--

commit cc077598d05a5231fc7b5c24f7dca060535cfe72
Author: Phil Pemberton <philpem@philpem.me.uk>

ata: libata-scsi: probe additional LUNs for multi-LUN ATAPI devices

This commit updates libata-scsi to check the BLIST_FORCELUN flag after LUN 0
is added for an ATAPI device. If set, it temporarily bumps dev->nr_luns to
the host's max_lun and triggers a sequential SCSI scan to probe additional
LUNs.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c

[ ... ]

> @@ -4745,12 +4746,30 @@ void ata_scsi_scan_host(struct ata_port *ap, int =
sync)
>  			sdev =3D __scsi_add_device(ap->scsi_host, channel, id, 0,
>  						 NULL);
>  			if (!IS_ERR(sdev)) {

[ ... ]

> +				if (dev->class =3D=3D ATA_DEV_ATAPI &&
> +				    sdev->sdev_bflags & BLIST_FORCELUN) {
> +					dev->nr_luns =3D ap->scsi_host->max_lun;
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

Can this sequence cause a use-after-free or a NULL pointer dereference?

By moving ata_scsi_assign_ofnode() outside of the !IS_ERR(sdev) block and
after scsi_device_put(), the local reference to sdev is dropped before it
is accessed.

Because ata_scsi_scan_host() does not hold shost->scan_mutex, a concurrent
device removal via sysfs could execute as soon as the local reference is
dropped.

If scsi_remove_device() asynchronously clears dev->sdev[0] and frees the
sdev structure:

CPU1
ata_scsi_scan_host()
    scsi_device_put(sdev);

CPU2
scsi_remove_device()
    dev->sdev[0] =3D NULL;
    // sdev is freed

CPU1
    if (dev->sdev[0])
        ata_scsi_assign_ofnode(dev, ap);

Could CPU1 evaluate the if statement before the pointer is cleared, but
execute ata_scsi_assign_ofnode() after it is freed, resulting in a write
to freed memory?=20

Alternatively, if it reads dev->sdev[0] after the pointer is cleared,
could this result in a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512202728.2994=
14-1-philpem@philpem.me.uk?part=3D5

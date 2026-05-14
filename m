Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3E30BBBC
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722005; cv=none; b=CTjGWYvduRUxeTmswsnkERYSg5miHmwZ7XVctTO4VMOXdc/G0Smtdv8m9Ij8siUNhIABed6Atp0B818eAEmvzJtEuBT6Qo5uc6KZt3l4W+9bBySTD5TeCQJwUAmr3iLKcXC5A8bX/m6IPkC+LBEgjYkw8FXSIKwv8uVtKKtjrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722005; c=relaxed/simple;
	bh=nKKRWVNkVvn/U+utxWKV6TMZto8qsu7+n02kL8wyKts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJHu10c2OjXOkvm7Sqly0H5fSsDY5/RVN2LLvNt9RCHi2m2bQCb5nonQuhIoGrKCm4V2lGy6oBBiLkOcuFRbMONv0C/AiB9pXqDbcBpc/f4yoYdc/vve0mYufiN3VqQLIotfIt5eLr+uRw4V8XzMJTY9HgpsRFSnZOUhBSLLlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXKkiz/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXKkiz/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6FC19425;
	Thu, 14 May 2026 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722004;
	bh=nKKRWVNkVvn/U+utxWKV6TMZto8qsu7+n02kL8wyKts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NXKkiz/+ao2zppobJD6giRYm6s2OVM2hLoogZOcmIsm0dKaB9egUdIfzoi+2CLSEa
	 C2ZMDsvKfJFxzK6wuj3UuJQepSd8snptQwQvroTD03DvPMRxEC054VSFHH81L7FTd+
	 uWPswPXMVbYrvZqK9fG0cPxfmVgP9K3AjiU1u4Aio7FuumSjQVjGelwv19dDJo/h/8
	 Ql78uGzye1kqTiglHp8oOjAQ3auP9iTgmRR64VEpmUKZU2q97+SsecEhrVLFTCC0qT
	 F5vzhADHhB16Ahw4PwjTY8BTkzp0b6cdQoFYMXGb0gits/A+NR0oQgWgcJJsYkr3Ei
	 Au219T8pclmKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] scsi: add BLIST_NO_LUN_1F blacklist flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260512202728.299414-5-philpem@philpem.me.uk>
References: <20260512202728.299414-5-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:26:44 +0000
Message-Id: <20260514012644.80F6FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BLIST_NO_LUN_1F flag fails to suppress the spurious 'No Devi=
ce' entry for an unpopulated LUN 0, violating the primary goal of the commi=
t.
--

commit 3370505ee70b7e5a5de5aa8aad7a378c9144aa38
Author: Phil Pemberton <philpem@philpem.me.uk>

scsi: add BLIST_NO_LUN_1F blacklist flag

Some multi-LUN devices respond to INQUIRY on unpopulated LUNs with
PQ=3D0 / PDT=3D0x1f instead of the standard PQ=3D3. The SCSI scan layer
normally adds such devices, producing spurious No Device entries.

This commit adds a BLIST_NO_LUN_1F flag to scsi_devinfo. It sets the
target flag pdt_1f_for_no_lun during scsi_add_lun() to suppress these
spurious entries.

> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index ef22a4228b855..bfbbf9be05d21 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1069,6 +1069,8 @@ static int scsi_add_lun(struct scsi_device *sdev, u=
nsigned char *inq_result,
>  	transport_configure_device(&sdev->sdev_gendev);
> =20
>  	sdev->sdev_bflags =3D *bflags;
> +	if (sdev->sdev_bflags & BLIST_NO_LUN_1F)
> +		sdev->sdev_target->pdt_1f_for_no_lun =3D 1;

Could this cause a regression by failing to suppress the spurious No Device
entry for an unpopulated LUN 0?

In scsi_probe_and_add_lun(), the check to skip unpopulated LUNs occurs
before scsi_add_lun() is called:

drivers/scsi/scsi_scan.c:scsi_probe_and_add_lun() {
    ...
	if (((result[0] >> 5) =3D=3D 1 || starget->pdt_1f_for_no_lun) &&
	    (result[0] & 0x1f) =3D=3D 0x1f &&
	    !scsi_is_wlun(lun)) {
		SCSI_LOG_SCAN_BUS(3, sdev_printk(KERN_INFO, sdev,
					"scsi scan: peripheral device type"
					" of 31, no device added\n"));
		res =3D SCSI_SCAN_TARGET_PRESENT;
		goto out_free_result;
	}

	res =3D scsi_add_lun(sdev, result, &bflags, shost->async_scan);
    ...
}

If LUN 0 is unpopulated, scsi_probe_and_add_lun() will evaluate this skip
condition while starget->pdt_1f_for_no_lun is still 0.

The skip condition will evaluate to false, and scsi_add_lun() will be
invoked. This erroneously adds LUN 0 as a spurious No Device entry.

Should starget->pdt_1f_for_no_lun be updated directly from the local bflags
inside scsi_probe_and_add_lun() before the skip condition is evaluated?

> =20
>  	if (scsi_device_is_pseudo_dev(sdev))
>  		return SCSI_SCAN_LUN_PRESENT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512202728.2994=
14-1-philpem@philpem.me.uk?part=3D4

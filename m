Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811F30E0FB
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956604; cv=none; b=JXki9rf8tkWGdE/zVBRmSm9HYpHCT79vhqvli81Do8VWz6k91AJ6gAcZ+Jt9lLEfnV5f1dtWswrPtRHYme14EMQKqtoRVlzhqsnwfAnOxiXO9rzW/XK9qtgxswRXlM8p9z+4/MDw9nEsXsBDaIthoaAUbzOZQH0HUYmi9rmtl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956604; c=relaxed/simple;
	bh=sC9RVZERONyGrpPlbeupzUdRrJhWj2VHV49ddD4MUKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c6bR021JbUykvY6hmXUHpNfn4JZm0UDnl5O1QP55HhFr0bZ8wUOaQIfxdvAMXEdMVve3rmSVc/JUKxHChL9ozHULhQGrZ+FV6zqA/g7xATHWfq/jOmQybR1MckbUuYkqwaMOLOrVUIytrdrvvnlxiB05q5n31TPWKDC3Vof1yXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9NUzXLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9NUzXLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECFE1F00893;
	Mon,  8 Jun 2026 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780956603;
	bh=T/9sE18/vr4th8xaQMw/XteIjDgTKlWS8V6a9iUnHBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9NUzXLBXPzaOEFiMluwdKOIu40+KwA9RuzywTHk5oSnVz8hxYdIeQreTWeAXkBwA
	 V26Njj6PLyBFFddisnA4OxUiAvtRhaOjUN3puiMXNdFp6c77KWvADhlNzCwRDJMbJI
	 AAAAAW881G44WhrsVBFRPl72an1HqM6ritR5Cl6oRrEb1wkY+eGZ6v/Pjav2xtl9Fs
	 aHUJTRqgNrct2qLjH+amcIPtrQx+xrXaznJgcE0/QZFQFQBuCGfn7/yFqejnHRvRA7
	 WBztKXDgVIwxAUyc7lycCBaVgxX4UFqg2+6bFLNDk9BXBwcyn6jMzIzY8K8+gG6c2K
	 x5v/CsPQgxJDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] scsi: add BLIST_NO_LUN_1F blacklist flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260608213443.2296614-5-philpem@philpem.me.uk>
References: <20260608213443.2296614-5-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:10:02 +0000
Message-Id: <20260608221003.1ECFE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The BLIST_NO_LUN_1F flag fails to suppress the initial unpopulat=
ed LUN (usually LUN 0) from being added as a spurious 'No Device' entry.

Pre-existing issues:
- [High] Concurrent read-modify-write on `struct scsi_target` bitfields cau=
ses data races and lost updates.
--

commit 10038c8d1287bfd2d8ba061ac2b0a14d56b4076e
Author: Phil Pemberton <philpem@philpem.me.uk>
scsi: add BLIST_NO_LUN_1F blacklist flag

This commit introduces the BLIST_NO_LUN_1F blacklist flag to suppress spuri=
ous
"No Device" entries on certain multi-LUN devices. It modifies scsi_add_lun()
to set the pdt_1f_for_no_lun flag during LUN scan based on the new blacklist
flag.

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

[Severity: Medium]
Will this actually suppress the spurious entry for the first scanned LUN
(typically LUN 0)?

Looking at scsi_probe_and_add_lun(), the suppression check evaluates
starget->pdt_1f_for_no_lun before scsi_add_lun() is called:

scsi_probe_and_add_lun() {
    ...
    if (((result[0] >> 5) =3D=3D 1 || starget->pdt_1f_for_no_lun) &&
        ...
        /* skip LUN */
        return SCSI_SCAN_TARGET_PRESENT;
    ...
    scsi_add_lun(...);
}

If LUN 0 is unpopulated, does it bypass the suppression check since the flag
is only set here in scsi_add_lun() afterward?

[Severity: High]
This is a pre-existing issue, but does adding another non-atomic bitfield
modification here expand a race window?

The fields pdt_1f_for_no_lun, single_lun, and expecting_lun_change are
adjacent bitfields in struct scsi_target that share the same memory word.
Modifying a bitfield performs a non-atomic read-modify-write.

Since scsi_add_lun() modifies pdt_1f_for_no_lun and single_lun from process
context (e.g., during a rescan), and an I/O completion on an already-active
LUN encountering a Unit Attention might call scsi_report_lun_change() which
modifies expecting_lun_change from softirq context, can this concurrent
read-modify-write cause updates to be lost?

If expecting_lun_change is lost, does it result in failing commands with
spurious I/O errors instead of retrying them?

If single_lun is lost, could it allow concurrent I/O to devices that do not
support it, potentially causing device hangs or data corruption?

> =20
>  	if (scsi_device_is_pseudo_dev(sdev))
>  		return SCSI_SCAN_LUN_PRESENT;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608213443.2296=
614-1-philpem@philpem.me.uk?part=3D4

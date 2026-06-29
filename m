Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244529D281
	for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756315; cv=none; b=Lf4bmNwUnv0XCqwrtPxe6DZqfYA4b8iMnf26WYIM91/XZa+4rFgGs7lv+50+BMtyEdp6Bux0d9VdulRYXcZYl9o3WiU61tSmMiRzqMq5ZGfYb5gaLI4q2S/JMFmW2yrGio730a1SpEUCJp7OsjwxFK+4h6oNuM/p6z6tjU6oT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756315; c=relaxed/simple;
	bh=nUzrz8yEebiDKQKlyMsPst83OZ5AnmtJxX1ZjJ29T+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SaTn8jdobHjXRDusssfYaqgrWNbC6AaMgVtPEGM6cAYI4NGF3pQIujUtKQeJgrZt7Vf0NKrdXrArMt5HRXVjsWUOyMOIqETCSHPxDsgUIaSX4hkFaoivCeuSF47NmZ3BeZVzQRLrKr1jH6XsniqtVkI2yblodoc2Jrs1mDsctkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoHQKcgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoHQKcgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DCB1F00A3A;
	Mon, 29 Jun 2026 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782756314;
	bh=m8Ca4JARtEIuUuRlGjjuGZuSqmrlOmFPp96+FZ7BboI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoHQKcgTHM1RMGGB/PBR0t/OmRqOt+Xus5JZbdbxG6Hl+iJ+4BSVdOmZEUsD34r/8
	 IIFBTNmFtT3hrOCU87BasEf2uZriL8lOEoFDPwWQwODQyPDGjii2td6OYTk8vGR/aj
	 jvBRw0HAv8YOCWhsDL1PlxVH9V5+II9Bt8tKXErN65HCJ/DFLaVuYkmygjobpLKojz
	 NR6rc/ShKZSWDXKslqdRWoiivlO4W30ID7iNWxNRvHViyyY5YKFRveoiV3CxAmgqNy
	 Z0SrfCvnIMwhH8bbykDGedmdQ3ATkc2iQdhSArYQ378Hy6ZrC31FGCwwXH9wVU124S
	 Ihi6cT+EJnx+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-scsi: limit simulated SCSI command copy to
 response length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karuna Ramkumar" <rkaruna@google.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260629175024.2187500-1-rkaruna@google.com>
References: <20260629175024.2187500-1-rkaruna@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 18:05:13 +0000
Message-Id: <20260629180513.C8DCB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A malicious or misconfigured ATA device can trigger an out-of-=
bounds heap read in ata_dev_config_cpr() and a massive global buffer overfl=
ow in ata_scsiop_inq_b9() by reporting a large nr_cpr value. The newly adde=
d defensive check in ata_scsi_rbuf_fill() executes after the overflow has a=
lready occurred.
- [Critical] ata_format_dsm_trim_descr() overflows the static ata_scsi_rbuf=
 for devices with large sector sizes.
--

commit 8b4a8e5bfe8806f87d80466e94aa7a4684517178
Author: Karuna Ramkumar <rkaruna@google.com>

ata: libata-scsi: limit simulated SCSI command copy to response length

The function ata_scsi_rbuf_fill() is used to copy the response of
emulated SCSI commands from ata_scsi_rbuf to the SCSI command's
scatterlist.

[ ... ]

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a6..0ddec111a78c4 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1933,8 +1933,10 @@ static void ata_scsi_rbuf_fill(struct ata_device *=
dev, struct scsi_cmnd *cmd,
>  	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
>  	len =3D actor(dev, cmd, ata_scsi_rbuf);
>  	if (len) {
> +		if (WARN_ON(len > ATA_SCSI_RBUF_SIZE))
> +			len =3D ATA_SCSI_RBUF_SIZE;

[Severity: Critical]
This is a pre-existing issue, but does the overflow already occur before th=
is
check is reached?

The actor function writes directly into the static ata_scsi_rbuf array.
For example, in ata_scsiop_inq_b9():

    for (i =3D 0; i < cpr_log->nr_cpr; i++, desc +=3D 32) {
        ...
        put_unaligned_be64(cpr_log->cpr[i].num_lbas, &desc[16]);
    }

If a device reports a large nr_cpr value (up to 255), this loop could write
up to 8224 bytes into the 2048-byte ata_scsi_rbuf array during the actor()
call, before the defensive WARN_ON() check has a chance to execute.

Additionally, could ata_dev_config_cpr() perform an out-of-bounds heap read
when reading this large nr_cpr value?

    cpr_log->nr_cpr =3D nr_cpr;
    desc =3D &buf[64];
    for (i =3D 0; i < nr_cpr; i++, desc +=3D 32) {
        cpr_log->cpr[i].num =3D desc[0];
        ...

If nr_cpr exceeds the allocated buffer space based on buf_len, this loop
appears to read past the end of the allocation.


[Severity: Critical]
This is also a pre-existing issue, but does ata_format_dsm_trim_descr()
overflow this same static buffer for devices with large sector sizes?

When a filesystem discard is issued to a device with a 4K logical sector si=
ze,
ata_scsi_write_same_xlat() calculates trmax as 512:

    size_t len =3D sdp->sector_size;
    ...
    const u32 trmax =3D len >> 3;

In ata_format_dsm_trim_descr():

    if (len > ATA_SCSI_RBUF_SIZE)
        len =3D ATA_SCSI_RBUF_SIZE;
    ...
    memset(buf, 0, len);
    while (i < trmax) {
        ...
        buf[i++] =3D __cpu_to_le64(entry);

While the memset() length is properly capped to 2048 bytes, the while loop
continues up to trmax. For a trmax of 512, this writes 512 8-byte entries
(4096 bytes) into the 2048-byte ata_scsi_rbuf array.

>  		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
> -				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
> +				    ata_scsi_rbuf, len);
>  		cmd->result =3D SAM_STAT_GOOD;
>  		if (scsi_bufflen(cmd) > len)
>  			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629175024.2187=
500-1-rkaruna@google.com?part=3D1

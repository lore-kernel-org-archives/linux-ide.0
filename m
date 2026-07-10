Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81238AC99
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712623; cv=none; b=PkLF7VuwCMdaFolw/39suWAkGIpQ9SkUJTBOc2Ne3yFXmz5mRAkF1WdKv7tYfEv+U3pH++82oQaou1cmVhK35Mwvkc31R1ZoGUM9pERHpZTUNcaW6KedNKH1Z8u+Vv2nPUWNhBHxaIOKbhkuyEonFTrL1jM3pIIUpYwPbEmmheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712623; c=relaxed/simple;
	bh=hX5iTyZ8ei20bjK8tVlMKCZfDP1kt/oY45Ldt2Mq2G4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a0b7wzKUbG9uuOEORUv/+x1yucSdIm+kTGpEnqT9GtTApir1lD1kXiZTxkmzFujo5m5/+kBu//9HHu77LM91lu8QLnf7QOW4mY9/mkBDwTXpK2TFqTcdK6mgx6pQ2ltseXJKO3BHfc+KchOJA99/XnW/kW+XzXEXs5SPe6LrVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Cb1/Zn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Cb1/Zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0161F000E9;
	Fri, 10 Jul 2026 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712620;
	bh=Jin7nD1c2tg5tmlEthSMBT4p8+7CXz0vhDpqEWm4lgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6Cb1/ZnQOX8aWoyx8htLhB44qhLyMUVSb39/Jp08np92LHVOakRbVIfFdWH/w6wu
	 iahaaHY9TcHQtgxAxjTkTwRnWZWgGbLgeTfjWPr3UfAWiTJyzKcq/vfesV2M7MjBSL
	 QRqF9pQeM02atjbg7r1GSHqPThMnQrBpTzmJAhmUrOtwIwUrzS1t++IUD3Mjr5E4ue
	 LDOjuR7mtBZ/KSxiZwUENe+lLEfqOVb6Tx07beIdOFuMwG5ZH8MuP+6K+25r8trX14
	 Tg27geXoxbnZEKhc+1wm6SiHC9H0eblkN0bLGAE/QTvL32Se5H3FiNPMdKUu00vg6C
	 3IP6J6m00GNaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-scsi: add out-of-bounds checks in
 ata_scsiop_inq_b9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karuna Ramkumar" <rkaruna@google.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260710193235.334782-1-rkaruna@google.com>
References: <20260710193235.334782-1-rkaruna@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 19:43:39 +0000
Message-Id: <20260710194339.AE0161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added bounds check to prevent `page_len > ATA_SCSI_RBUF_S=
IZE` is mathematically dead code.
--

--- Patch [1]: [PATCH] ata: libata-scsi: add out-of-bounds checks in ata_sc=
siop_inq_b9 ---
commit bacad4b494e8c54b7f847f50ed2b764d2bdf3fde
Author: Karuna Ramkumar <rkaruna@google.com>
ata: libata-scsi: add out-of-bounds checks in ata_scsiop_inq_b9

This commit adds a bounds check to ata_scsiop_inq_b9() to ensure the
calculated page length does not exceed the SCSI request buffer size. If the
calculated size is larger, the command is aborted to prevent a buffer
overflow.

Link: https://lore.kernel.org/all/0E78BE5F-B4EE-460A-A6D5-F0CE47BFC7DF@kern=
el.org/

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[ ... ]
> @@ -2361,15 +2361,22 @@ static unsigned int ata_scsiop_inq_b9(struct ata_=
device *dev,
[ ... ]
>  	if (!cpr_log) {
>  		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
>  		return 0;
>  	}
> =20
> +	page_len =3D 64 + (int)cpr_log->nr_cpr * 32;
> +	if (page_len > ATA_SCSI_RBUF_SIZE) {
> +		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
> +		return 0;
> +	}

[Severity: Low]
Is this bounds check reachable during normal operation?

Looking at how cpr_log is populated in ata_read_cpr_log(), nr_cpr is
already explicitly validated against ATA_DEV_MAX_CPR. Since ATA_DEV_MAX_CPR
is mathematically derived from ATA_SCSI_RBUF_SIZE, a device reporting a
value exceeding this limit has its log discarded, leaving dev->cpr_log as
NULL.

Because ata_scsiop_inq_b9() immediately returns if cpr_log is NULL right
above this snippet, it seems page_len can never evaluate to a value greater
than ATA_SCSI_RBUF_SIZE. Does this make the new check mathematically dead
code under real inputs?

> +
>  	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
>  	rbuf[1] =3D 0xb9;
> -	put_unaligned_be16(64 + (int)cpr_log->nr_cpr * 32 - 4, &rbuf[2]);
> +	put_unaligned_be16(page_len - 4, &rbuf[2]);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710193235.3347=
82-1-rkaruna@google.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FB313E21
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154018; cv=none; b=DZAWuqHXk9+2kk9n2sXeBEy/EtW5xwd6JSprcF4Bp+64MCQG0EYpeopUcrJedRF+M/hwT8cMSZYujPaHwAmAAOIxXfeat7hF+K0eufBHNogJSg4INeVZ0T24bHFszAd8FpRGUcDO2jNhpGGVRfyvDfnjfsF7kIrALvUBxy8dK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154018; c=relaxed/simple;
	bh=P7S9fBbNQ8Vtj5Qv0ZvQKBOpFcnvuqojGl6TH3tjOj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVXeWc8a2WZJXyvfnQAgjY5xxylXuh2eOrvv5n1ot05+h4WRSO5p3yk9f5xvNrVjXH5pqUa7XYbk90RgI8JdyoxrAEBXdGd7mZ//SFQxIigO7tOL6dGQB4FprPrhCPjiBmQBNTj9UejiOVm7Sgz1DS/s0bCxuR4IEPwR/9bIs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd7DpdQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd7DpdQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C851F00A3A;
	Mon, 22 Jun 2026 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782154017;
	bh=Hp+ZSwkeM+bKMp1xZ5iIh7IUTWgou478zl7nf8uSPpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cd7DpdQLnJwFIVdxzGna4rLim4rwOpYsAjX1ZaNMkRmqi+96RxCgGNqFOkWBOGKNh
	 7KErkirxz+32lO3cJephXZGgpAvf5PluXJDnDw/HB5Xw+iwk+M88JPkVzS5JtLa/EC
	 li08DU5KOYrnlzR9Xu8206b+1kimQl024cXLdcA6p5V0B9SEKUbBwYhUktP3EV9nkL
	 GcaDA2FSkugzwq0aZTjSRc4cYRbo7a50gKz9dUbdqFh3LaiDb2MXx7gq8hx1HqI/+f
	 Prp2lzNtub8sACb6XjQStUaZ0E1r1XUxlYIm7hgo0DfB8OktKEJ/10q6CuOwcimOeG
	 6xCJ+d0zTmqXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me>
References: <20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 18:46:56 +0000
Message-Id: <20260622184657.27C851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch strictly rejects the entire Concurrent Positioning Ran=
ges (CPR) log if the range count exceeds 62 or the returned log size, perma=
nently disabling the feature for otherwise compliant devices.
--

commit fb7353b474c07b1173b746d017d47feac25f57b1
Author: Bryam Vargas <hexlabsecurity@proton.me>

ata: libata-core: Reject an invalid concurrent positioning ranges count

This commit adds bounds checking for the concurrent positioning ranges (CPR)
log count. It rejects the log if the count exceeds 62 (the maximum capacity
of the VPD B9h buffer) or if the count exceeds the returned log size.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3d0027ec33c2a..017a16be158b6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2832,6 +2832,18 @@ static void ata_dev_config_cpr(struct ata_device *=
dev)
>  	if (!nr_cpr)
>  		goto out;
> =20
> +	/*
> +	 * The count is reported independently of the log size and is also
> +	 * emitted into the fixed 2048-byte VPD B9h buffer, which holds at most
> +	 * (2048 - 64) / 32 =3D 62 descriptors. Reject a count that exceeds that
> +	 * or does not fit the log the device returned.
> +	 */
> +	if (nr_cpr > 62 || buf_len < 64 + (size_t)nr_cpr * 32) {
> +		ata_dev_warn(dev,
> +			     "Invalid number of concurrent positioning ranges\n");
> +		goto out;
> +	}

[Severity: Medium]
Does this code completely disable the CPR feature for spec-compliant devices
that report more than 62 ranges?

The ATA specification allows up to 255 concurrent positioning ranges, and t=
he
62-descriptor limit seems to be an internal Linux SCSI translation limit ba=
sed
on the fixed 2048-byte ata_scsi_rbuf size. By jumping to out, we discard the
log entirely rather than capping it to fit internal limits.

Also, the commit message states "Capping the stored count keeps the emitter=
 in
bounds", but the code appears to reject the log outright instead of capping
the count. Could we instead dynamically cap nr_cpr to 62 here, so that devi=
ces
with more ranges still get partial functionality rather than having the fea=
ture
disabled entirely?

> +
>  	cpr_log =3D kzalloc_flex(*cpr_log, cpr, nr_cpr);
>  	if (!cpr_log)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-b4-disp-57=
34c6f2-v2-1-53083c2df3c6@proton.me?part=3D1

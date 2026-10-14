Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD496501F4E
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983552; cv=none; b=XS/bjDzADzRR+a+kQu9zw+4gOMVUZEr12C0xtYwxehCgoQnIX8DWMkxveLdPk5Am1B8fxMLf6Faq4s7ecwcWgGhzzOA/jBS53GSqBFuFeLJxc5Lan1nB3od+CgR/o6PC9t0ZhBZ4VYLjHQqCVoWOQHxqqkw7oOqoHQ0FbR2z42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983552; c=relaxed/simple;
	bh=S7OzfuqePZCvxr9NLqubz4IlfE7riL/GnJNSXEn/gJk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nYr2Eb1RzkWwmlmwl9huYhlP6CUFH6IZXQ3h0oCELt4Trh0MHYB4c1v45x7OL77Cv4CUi47govZ79t8VxjsCg4erWDQXCEvwXHHszaniYuf6eV5Btb8KSrl33Th76JjJ42XTt7PPZ7R+tBQtOp0bXZEYplSw7GALGdyw+lDYxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqUzljrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqUzljrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D752F1F000FF;
	Wed, 14 Oct 2026 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983546;
	bh=xyVrhHCMl29UrW4mRCdPTEv9Nf/8lxy4BxUZWOBf63M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqUzljrtHNhU4v9Sr/hEzhxC4N/Xf7USzpmDyV08tKTESXJDJuYOoineu4J/shv8Z
	 jRK5qMjrrZFvS3zQjbqhfrmhmpRb/H6C1uMZ5Br+y4jXepumkVpXjO+hngX9kIu9i3
	 OkuFL7HbdDXY1LduMeawg8iTJyJE4X6ReP+P0D6XYc5uX/AHwEAijr3e+GBP6B+JRO
	 V89k3dMUijSz8bM5gYQyuMLG342UzRNdczl9fKTjqOr1feS1C8/l8ame7kX6leVUfd
	 nx2mQNPyIwGAnCSHEW6TDD9u/FpA1iuPR/am0ojAhsRmpdi13CVJpckoOLN2R9gv/r
	 ma6QWwgIZv+xQ==
Message-ID: <sashiko-outbox-171321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-core: Ignore forced transfer modes the host
 does not support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rand Deeb" <rand.sec96@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261014125916.1975-1-rand.sec96@gmail.com>
References: <20261014125916.1975-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:12:25 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ata: libata-core: early return bypasses valid fallback force con=
figs
--

commit b2b8699db9f1c2c52ee37c5d556e07a3dde1ab2e
Author: Rand Deeb <rand.sec96@gmail.com>

ata: libata-core: Ignore forced transfer modes the host does not support

This commit adds a check to ignore forced transfer modes that the host
controller does not support. This prevents out-of-bounds reads in driver
timing tables when an unsupported mode is forced.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 92233fb25051a..324aaa81c8a30 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -458,6 +459,17 @@ static void ata_force_xfermask(struct ata_device *de=
v)
> =20
>  		ata_unpack_xfermask(fe->param.xfer_mask,
>  				    &pio_mask, &mwdma_mask, &udma_mask);
> +
> +		/* Never force a transfer mode the host does not support */
> +		if ((pio_mask & ~ap->pio_mask) ||
> +		    (mwdma_mask & ~ap->mwdma_mask) ||
> +		    (udma_mask & ~ap->udma_mask)) {
> +			ata_dev_warn(dev,
> +				     "FORCE: %s not supported by the host, ignored\n",
> +				     fe->param.name);
> +			return;

[Severity: Medium]
When a specific override is rejected by this new host capability check in
ata_force_xfermask(), does using return prematurely abort the loop?

The libata.force parameter allows stacking multiple hierarchical overrides
(e.g., libata.force=3Dpio4,1.0:pio5), which are evaluated backwards so the
most specific match wins.

By returning instead of using continue, the code appears to silently bypass
earlier valid fallback overrides like the port-wide pio4 in the example abo=
ve.

This would cause the device to fall back to its auto-negotiated mask instead
of the valid user-specified fallback, which might cause issues if the user
was relying on the fallback constraint to disable broken DMA.

> +		}
> +
>  		if (udma_mask)
>  			dev->udma_mask =3D udma_mask;
>  		else if (mwdma_mask) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014125916.1975=
-1-rand.sec96@gmail.com?part=3D1

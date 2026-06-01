Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274E1A6839
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341416; cv=none; b=UPbyvGl3IQuAtXiKuBfikU6LFzDiNOQtTaYoYMc2QAhHp0WVRrS3Ql7a6eO3YFnDiTc9BJ59xRaZYl+UYl57nNS+4qJmPeIWq61Dl9gvZWVFIVhrmtLtSA3rDOVK4/xGSUPcca5neudq++KfAdHjpeJle90/oYh4nWtoPftd5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341416; c=relaxed/simple;
	bh=M1LVx4KIYNVxqSFnkQc3aME/D6tpzP4b7DT3+5oabOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSaGW0vl2a3tcNnsrz5ata35Q0SBXqoYL21gTBNZdOZLX4m08dqlFIellxg0oVQffPVAckih6yyoNrls8iPJ2RG3cuaXwKYOhUxFqmxryUmLO5xsfRGD0V6G31oEzAJvVE/rZmGRxVDekdYu0cfl+vb6J0IEEQWoDhIoaS+XNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnjCmstJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnjCmstJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4B91F00893;
	Mon,  1 Jun 2026 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341415;
	bh=gMpHSVNH/3XXVeGPZSsZwxYQdcFPwzrPjtpIXQwnPJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PnjCmstJY9Wu41cTFDLEG8IN4DyehprfyGgIy2yJVB97Uo3LUySxBTUJAax0lAGxj
	 s4V033MTfkO/bLOxtF6tKKy/AgECSA/NgQIaosN8ulzmclXkn5RkUwf7uyei53kcI/
	 UqUktMYDlf/r9FPrCfYeyAEYr5ZXO9tBk0Ifp2TLxojijELdKaGtoAKRR4stt+o0Uj
	 o1cwhfzQNOelF6Mu+Fbxf55Zr2W6GqLHxOTra7p5HOkOp+YfufnIDF5zfMHKll5/o/
	 b4DDRgUMuIlf7LriKzAM9DCk0KZFTa3A+idJaArGUwxOyi4tWax2ss4QbPEzxEWm7y
	 BA72Z44lBXXVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_ep93xx: fix endianness bug in trailing byte
 transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260601190921.20167-1-rosenp@gmail.com>
References: <20260601190921.20167-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 19:16:54 +0000
Message-Id: <20260601191655.3E4B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `ep93xx_pata_data_xfer()` function destroys the `words` loop c=
ounter, returning an incorrect byte count that breaks ATAPI PIO transfers.
--

commit c92ab9f0ecc44ddedc25d0e57302962565e67769
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: fix endianness bug in trailing byte transfer

This commit fixes an endianness bug in ep93xx_pata_data_xfer() where a trai=
ling
odd byte was being truncated and incorrectly byte-swapped on big-endian
systems. It removes the cpu_to_le16/le16_to_cpu wrappers and uses the raw
read/write values directly.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -495,19 +495,12 @@ static unsigned int ep93xx_pata_data_xfer(struct at=
a_queued_cmd *qc,
> =20
>  	/* Transfer trailing 1 byte, if any. */
>  	if (unlikely(buflen & 0x01)) {

[ ... ]

>  		if (rw =3D=3D READ) {
> -			*pad =3D cpu_to_le16(
> -				ep93xx_pata_read_data(
> -					drv_data, IDECTRL_ADDR_DATA));
> -			*buf =3D pad[0];
> +			*buf =3D ep93xx_pata_read_data(drv_data, IDECTRL_ADDR_DATA);
>  		} else {
> -			pad[0] =3D *buf;
> -			ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad),
> -					  IDECTRL_ADDR_DATA);
> +			ep93xx_pata_write_data(drv_data, *buf, IDECTRL_ADDR_DATA);
>  		}
>  		words++;

[Severity: High]
This is a pre-existing issue, but does this function return an incorrect by=
te
count that breaks ATAPI PIO transfers?

Earlier in ep93xx_pata_data_xfer(), there is a loop that destroys the words
counter:

        unsigned int words =3D buflen >> 1;
        while (words--)
            /* transfer 2 bytes */

Because of the post-decrement, the words counter underflows to UINT_MAX when
the loop terminates. If there is an odd trailing byte, words++ wraps it back
to 0, and the function returns 0 since the end of the function is:

        return words << 1;

If there is no trailing byte, the function returns UINT_MAX << 1, which is
0xFFFFFFFE.

Returning 0 for an odd-length transfer causes callers like
__atapi_pio_bytes() to not decrement their remaining bytes counter while
still advancing the scatter-gather list, resulting in unexpected or too
much trailing data errors.

Returning 0xFFFFFFFE causes __atapi_pio_bytes() to subtract that huge amount
in a single iteration, instantly dropping the remaining transfer count to z=
ero
even if the DRQ block spanned multiple scatter-gather entries.

Could this be fixed by saving the original buffer length and returning that
instead of relying on the mutated words counter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601190921.2016=
7-1-rosenp@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60251308F32
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834538; cv=none; b=iRYxjVhcyERNBhl8ymbf8efC6vMefTnHpTPvKY6RTS/n3h8ksrIcx2qfSj8QVHHq2fO9Eo3/0AFhUgBnlMJlJVJQtwrWHWJi+Sw59+nBqUxrBBKe8L+TG8sHE1g/p2bI74onYze7D9c9bJUnbRsRFi8QKO2g8Lf7zrGVTXd23T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834538; c=relaxed/simple;
	bh=X/IeehER49R19c5zM8MK9HzujYRXX8/ANMvUaZxZvfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtQvewxv3cRX8DiWOZm/G2fpvO+kqaP6RnZHpemCwEfK/j/pVyfv7CQkGZ3+iRP4uHiMw0gmPS1RzfzBmmMf7qD/cIoklJ141g9cxRi4E0GYQXNWJqSBUd8VY1s7DEx9dfRPThFrkXr/na0BhXtu0g7ETBzN0Y8FV1V9fp2T4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B71/3q+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B71/3q+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FAC1F000E9;
	Thu, 23 Jul 2026 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784834537;
	bh=QIuuO8psmDZE+MFXMxCxS/XHjkNhsggVulwzgAfpfCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B71/3q+gRSxB4PxtPWKFtJU90wFMjf3q41d0b+kBGxujb/xhTaW4kypMd57Lm9Gdi
	 hY86s8iEzPEUIc2F5R+1u67i9D3iTt3nDNJbYaTRpATFBzQHqKf88Dqqudd7ruJkoM
	 N+nLoW/f06KpMUFiJArUG+dpaVFf3D9xSK9yrFgsZ8ADLRRIqLnqgeQkIerf5VJuj8
	 vcdSrIhISIpRRxQgySO6O4oeyHJjUEUzclmTik8rhO9MRSP8nYCAiJI6nMBMTGPVz+
	 c0NcFTwzfkNAIewOwW2DX2bMPEdPm6KFKlMjVRejsn6hAyRd1z7AgNtkhDpBtNb9rw
	 95HQnDAjV0rDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: pata_ep93xx: fix endianness bug in trailing byte
 transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260723191302.139580-1-rosenp@gmail.com>
References: <20260723191302.139580-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:22:16 +0000
Message-Id: <20260723192216.B2FAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `ep93xx_pata_data_xfer` function calculates an incorrect consu=
med byte count due to the `words` loop counter underflowing, returning eith=
er `0xFFFFFFFE` or `0`.
--

--- Patch [1]: [PATCHv2] ata: pata_ep93xx: fix endianness bug in trailing b=
yte transfer ---
commit 6f058310f6ea9721e68fb8c4613fa6b146f2e1f7
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: fix endianness bug in trailing byte transfer

This commit fixes an endianness issue in the trailing odd byte transfer
logic by removing the pad array and directly reading/writing the u8
value without wrappers.

Closes: https://lore.kernel.org/oe-kbuild-all/202607231521.gvhnJpOG-lkp@int=
el.com/

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 42a24dc51d26b..647977ed607c8 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -499,19 +499,12 @@ static unsigned int ep93xx_pata_data_xfer(struct at=
a_queued_cmd *qc,
> =20
>  	/* Transfer trailing 1 byte, if any. */
>  	if (unlikely(buflen & 0x01)) {
> -		unsigned char pad[2] =3D { };
> -
>  		buf +=3D buflen - 1;
> =20
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
>  	}

[Severity: High]
This is a pre-existing issue, but does this function calculate the correct
consumed byte count?

When ep93xx_pata_data_xfer() executes the earlier transfer loop, the words
variable unconditionally decrements until it underflows:

drivers/ata/pata_ep93xx.c:ep93xx_pata_data_xfer() {
    ...
    unsigned int words =3D buflen >> 1;

    /* Transfer multiple of 2 bytes */
    while (words--)
        if (rw =3D=3D READ)
            ...
}

After the loop, words underflows to UINT_MAX.

For odd-length transfers, the trailing byte block quoted above executes
words++, which increments UINT_MAX to 0. The function then returns words <<=
 1,
which results in returning 0.

If 0 is returned, could this cause an infinite loop in __atapi_pio_bytes()?=
 A
returned consumed value of 0 means qc->curbytes does not advance, which mig=
ht
cause the transfer loop to stall indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723191302.1395=
80-1-rosenp@gmail.com?part=3D1

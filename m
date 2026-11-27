Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804057;
	b=CraTZoBEyOFcJqzNaZHny+uEJyIljZypxOQfWHZOixH1Aul8hI+9As0qfHciX+rUTxi2
	 Pvb7H5FIJrpeCJLlvQYaavHIUpDVwpE5blzrTItBxcPwXNvdZYV4Rmq+tqskC+vvQKE7A
	 uf6pxP+tRtPhxi0pUOFBJnM/y4zeAJ4w4IuCLL/klkMrfz3K1nC1RTWuzpdZ1kvFCD0rV
	 1i7zLYF5q37WEaBex9PgIQdkwc5MjsGW+wrSMckjFGf7uxZ7xurrxrUSZlOCbqLL/ehBB
	 khrNkNvyiEyzsW1AV1m8R9BbZNGg/QajQ2ppD2LyUsY5ICyWBC6sTlPg0srzTOuNSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MpMHMeKfSUpVVudVmacRjQ35EknUsnhxffZAqo0Szqw=;
	b=QMervb15PnU3c4bGlqc9P9RMXnTJdpb2UupuRz6L0pXJTxZtoYJ4HWJH0oio+1/XzStZ
	 AwJnYNt3C/gAyi46BUvdyiKa4tdgOh5hcBvnP5sKfxmj6QNPWQxHnNWGjOTPMmZ8VsyvQ
	 vKg+zRRxf+prFSwBqAh8iEYaBmBbLbICBVCcdWFPcC3TdT9K9aaEl8W0kHUdJ5Q1jWGjz
	 +cli3N0fn/z3QeDSytDY+mXc2YzmzRiDbEbOD05Xf11nXgoR3SNn0bw2cSPj+qbGfM6LE
	 f6hQr1LpQQaoFO0JaAQL5wfhdawt+uJNpQXYDut7zAy9upNW2yCVB6f3Kt/gvs4gdlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wn0NhjJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41397606A31C
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wn0NhjJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB541F0089A;
	Fri, 27 Nov 2026 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804056;
	bh=MpMHMeKfSUpVVudVmacRjQ35EknUsnhxffZAqo0Szqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wn0NhjJzNrwn7NymX8ic7vHsAJrvuJxHC6lPPGXQyvqY3p6n51Gg/HC2qYXgurL7L
	 YR9ouSUHjnwEwmTxkx6pq2OBUr1GDQboMVld84MlAT71RYOSVl/TP4nGEq2Pca7YEi
	 MJFHBszJJhP6zbYVkloUqLEk1AfyYgcb1RM8SCHy6si5ZJBNauPgbD63wXQCb58BA2
	 f8i/GQmpAe3i6XL1YMQ00sJl+8hhrAc5xUSn+4TtZFtaVgW+yWeAgPGNSfNvsSfIRx
	 El7ImBKsNbS1s2f5oCTaabI0O5Cs1XHeQ0c+SqoYNrM4d75OjMd4dcsJ+HaejmqjdN
	 wRv15iM3iWPAw==
Message-ID: <sashiko-outbox-238078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] ata: sata_dwc_460ex: add missing newlines to
 error messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Novak" <artem122novak@gmail.com>, linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261127181619.183139-4-artem122novak@gmail.com>
References: <20261127181619.183139-1-artem122novak@gmail.com>
 <20261127181619.183139-4-artem122novak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:27:36 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ata: sata_dwc_460ex: missing newline in sata_dwc_error_intr()
  dev_err()
--

commit ab933557af07fdf91678a715e8ab4e273eba8aa2
Author: Artem Novak <artem122novak@gmail.com>

ata: sata_dwc_460ex: add missing newlines to error messages

This commit adds missing trailing newlines to dev_err() messages in
sata_dwc_460ex.c.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4ab378d2c26f7..df711a802c53e 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -497,7 +497,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_in=
stance)
> =20
>  		qc =3D ata_qc_from_tag(ap, tag);
>  		if (unlikely(!qc)) {
> -			dev_err(ap->dev, "failed to get qc");
> +			dev_err(ap->dev, "failed to get qc\n");
>  			handled =3D 1;
>  			goto DONE;
>  		}

[Severity: Low]
Should the dev_err() format string in sata_dwc_error_intr() also be
terminated with a newline so that subsequent kernel log messages are not
concatenated onto the same line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127181619.1831=
39-1-artem122novak@gmail.com?part=3D3

Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DD386453
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278152; cv=none; b=RRLdzWCrb0Mu7CZv57RxAfjQ6GaFAiKaFgPSfv6P4spDx0S4x6hcIBVdK1zjfNOsHjNYu3hPt3cbz39U0WPZGkOc14PzkiysdNAt1DVoZ6HxC0q/sE5YD8RCdxPt3rBdkQf9Ec/cbc2CTFu/P4COHSZOvTAqjXQF3fBwhqhPH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278152; c=relaxed/simple;
	bh=PnuPJ6H577ryB0Er9Px/nidVF5deLxNwv6GP7VCuWnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVXRfuTySFxLgBASars3nxPsOt+K8c0i5zTjTnuP0/LU4xbX+BsqZreuawxkNMcfqyqPgP3w6Jcis+CrPN7LohJDdaGKtjHbTbqOxiWqdAcZFmIL0dHY1Me63Tmm3pryC5fJBJ2p9rhQr70prpqc1LfKAn4dziyW6FBh8MoRglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adaJ6J7M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adaJ6J7M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so691561f8f.1
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781278147; x=1781882947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck+lvb4zAWTYh0Xw/V/ySRqsR//4Q4SowgTY8rwTbuU=;
        b=adaJ6J7MCqPuCdgWYzBKf/siJVfIsjBTnGIy0G5BJhqrL7LyT5l5Cp08XsBjk4tYII
         sqj+COwKSPBbvL8tn9Op2g4CAiInxaMkSYKXOHA6qctrq9+s4sCADR+kNRu4ZpDlnYXc
         1jz1scJCxxktnmGobg5Ue3WHqFV7+wvP8cU0T/goMA2QxjhXcHr8VN/fom+9GYBAEn3W
         WeTXLbKmgOZoazy8RfakeaJKiqVuMx1sIDx8d2L5GXSmbg/Cb07/ZN1GL23JAjFuk9Zc
         z0sq8FSEv3nf5QlKmu9s0eNP0o/77CRy0PF2X7X3mAGITt9kKn8vjvWwbHWCB9awkE7j
         KDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278147; x=1781882947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ck+lvb4zAWTYh0Xw/V/ySRqsR//4Q4SowgTY8rwTbuU=;
        b=tO3CZ0LLT+6DQzhJsmnC9Walg0BgiHcCVhx1idyndVniLzVaXCHC5jZDhggBzzSE9n
         a6lOYRciaZ69jRSrmjguGcP2Q87U6kc4vKkr7PKM0bBTcOP8vZkLIF+3voGX+kC7OLcA
         p6vhpnRdqSGDHdmoU+JKXJHFfgsABcytuo8la2Q31Dy0HOihUeCSzy24Kl1nkWf4Adqz
         0t+hNlZ0QMBC9UriQwBS5wbUU4pzom09jnQqhNhpejP9Q4NgVXDUhp+IkytsKJMzeEfc
         DfiNTeBLI1aY9tXLbOh0Lp5zb82Br458+LNwLFhLY43Xs/9kciJXZmmuMo/pJaIRJIfs
         MtYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dRtQxK91T5znYypyyGJQtRlOehWCFFqm8iDThLDCc/GY5gE5i/g4yiyPZvF2EHv9o14jrKN8SaOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyP7ozio5y0oz75Je56rWrhLAayv5Gj8jQ1jvG4Qt1aK6aV9H
	xRvP8YtWx9cot0+nNMhDyVrNU5TvSVFxpwTSH7agK77zV/qnnghzM5Gg
X-Gm-Gg: Acq92OEo3Lfe4Zb4Y7NV7/RmJzEcKT5zsC1URZFeojM3i6tzqS4HeqHyI9xYzNwxokK
	9V+21q1c/+5Et/fc6B0E1V2t4p00Lt6gNw7KLba0Na+6isHq3Ep/0vt8MrhOT5KRY0wKIupqwB5
	9WSABQSUOk2BF4nGcu5kLOb8Aqybb78CXm2J5gHRC4/JbFRBcnlsCeOAPwZcLOAJa4MxF9+3Yk3
	1yvzG5OCCC3lg0y8bw7XwboNPlpMCuzdZgyraJva167kYCPj6WvQrhbpi5/UUPZ6tlrQ20My/G0
	Ky3ySpgQUsW9hG3IKjRA1cmm4F8GS5e6anbm3+nKrRmyh/e1giR3OLo+Xej5D+6YWPl1/LffHSg
	tgSyl3msopyF/nNiZLW3EJ6NkxjuZ5GJ0vYFsGuugxuCxSMf0YawSaooBLx1kAZO306GzBJnH4R
	ialt+YCNcjZQbd80OCaUjXzGLR1txe0YmfvoG9h+7p31ERXksM47tYsLbFAwqJ
X-Received: by 2002:a5d:59ac:0:b0:460:2ee5:67b8 with SMTP id ffacd0b85a97d-4606dba8bafmr4827548f8f.36.1781278146644;
        Fri, 12 Jun 2026 08:29:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f23fsm6751764f8f.9.2026.06.12.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:29:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:29:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ata: Use named initializers for pci_device_id
 arrays
Message-ID: <20260612162904.396dbc1f@pumpkin>
In-Reply-To: <616e527a0c6cd367f3301438501d8345b0675df1.1781252168.git.ukleinek@kernel.org>
References: <cover.1781252167.git.ukleinek@kernel.org>
	<616e527a0c6cd367f3301438501d8345b0675df1.1781252168.git.ukleinek@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jun 2026 10:21:48 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.

I think I'd try to keep each entry on one line for readability.
Either by just letting the line be long or using a #define for the initiali=
ser.

...
> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> index 3999305b5356..402d3304b94b 100644
> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -91,9 +91,11 @@ static const struct ata_port_info acard_ahci_port_info=
[] =3D {
>  };
> =20
>  static const struct pci_device_id acard_ahci_pci_tbl[] =3D {
> -	/* ACard */
> -	{ PCI_VDEVICE(ARTOP, 0x000d), board_acard_ahci }, /* ATP8620 */
> -
> +	{
> +		/* ACard ATP8620 */
> +		PCI_VDEVICE(ARTOP, 0x000d),
> +		.driver_data =3D board_acard_ahci,
> +	},
>  	{ }    /* terminate list */
>  };


Why not extend PCI_VDEVICE so you can pass it the .driver data
(and other named initializers), something like:

#define PCI_VDEVICE(vend, dev, ...) \
	.vendor =3D PCI_VENDOR_ID_##vend, .device =3D (dev), \
	.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID, 0, 0 \
	__VA_OPT__(, .driver_data =3D __VA_ARGS__)

The change to all the files is then just to move the )
(and the old versions will still compile).
You can also do:
	PCI_VDEVICE(XXX, 0xx, board_xxx, .override_only =3D 1)

At which point you can move the {} inside - but that is a breaking change.

Note that sparse won't grok __VA_OPT__() so will need an alternate definiti=
on.

-- David



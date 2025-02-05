Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D017083A;
	Wed,  5 Feb 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778633; cv=none; b=PvAzlbbA3fBYWjpHbcfUtqyaXaB0+4FcP4PZKtaImnhPPA8MKjYaZwyzKvzWSd1ybK+BlsQ7i3B+VTLcit+3LsbN0mC2TqjTsBPGnz7+3/BKVUf5G7V9N7zB0kC23MV6WTUQwT9It3lEr62ddYPoeUG9/YdzLpKSr9QBq0Spt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778633; c=relaxed/simple;
	bh=04qJ44E+WKTfOObDH1SURly/YlWo6PracBKyAh9xp2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nj9YFwqu4YT+3TIV4aTQIvG4nL8N6E7nmypnZNyutLC3FFgx64lnS10rVvUE0nSCFEioEiIKWmlslPWnb4UuNoayXPUjoGo899ClcTwheWO8hnQ1GXyG2/33ipgnH03qDYH5SEhYDewGQrYO5V9qBFjku1mqD91UmDXmsuFi5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlmUcaTj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlmUcaTj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43618283dedso466705e9.3;
        Wed, 05 Feb 2025 10:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738778629; x=1739383429; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqnA75NtgKIwe5IrDIJEaQ7EQltoDIFrSNIy4uQJbKw=;
        b=ZlmUcaTjfjwiC1wPstds+lg7pUuWzaxDclrguzr+ToVL5hZwWLqjMlCyS6NGib33Lo
         /qvBQ2ysPXpnaxUjmd6GWa0rq9vk5nim11eDPH9XbR1T/wIt3IXcDJAvIoQLsvrZO0/0
         m9HAoqEGf9gFBoYM3XrN2q215Djf4bHD1g4DNv6dklngqlxwK0E/pBYtLldgOzpvJlJm
         hVPQDxarteeM7e4JXrIzXsf5j5LCWwuKWzSReaFVyd8d7K+ovj3UqxD5utEk/onoWBl8
         rGnuZf2rDHPUtjjEhLBdFPE92ThmjuKC9XAo7ouiDGUrjc7TexMPSHhWdXjp2c/f+pS8
         mK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778629; x=1739383429;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqnA75NtgKIwe5IrDIJEaQ7EQltoDIFrSNIy4uQJbKw=;
        b=Qp/y64FmJkP78nd2sEZ3Mko0cAbuGpGuFEYRtxgh+LGhXECiHjk/PMEPSlwYomAj9d
         2EVWGiHAJPEmA5SIg6sAB4MANCwS5Ny/PcAUeoh3cTeJPrUVz8+Yq5sCbIYN0fNHA0n8
         ItwZlA9nAxaUo2cbWthy1czIaWm7+yejQ2/P1e5MntQ6QkH4MRoj8zpp6vsUO2zQ8ykW
         s32rt5mLze1eWkI7BGtPN4vsunXuHHz8GUtD+yPuHzIhBoSKgW1Hf2YQcsZ8C8S80p6V
         88eyRf8zLMUsWzPzQdrlmAQi9kEirET5te6cG6I+kP54nh/RBxen7EPDBfPjvwCUvfyW
         4X1A==
X-Forwarded-Encrypted: i=1; AJvYcCUnbraW4HUDzGH0u7ZslXstqCAwocgOrZxIDCoXI7eDTNzxZo9DeKnKPgm02spnOCTmkd0XTVkP6Cc=@vger.kernel.org, AJvYcCUx4j6Jv5NeZmes9KsnIV8cOo4ijoWIEwM1YJUPmdzizLiM6rXCil5cdZaABbhxpQAEBNLDZoIEBjy6eFh3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22ZDofCSvMkdyCxq7ej/yDGff0d8Zzx/7omxaOKQG9oaZ+vb/
	Q6csay7GgALOaQENTn55A1FI7pT/UDgrcGCq91Y9oDSu0fX6Hn68
X-Gm-Gg: ASbGncvqsBcJ138ciOrXDmC0lxdRS1Cs7Ihqpc2dRpn3T5bc+mKjxJGaWpPcumM3aec
	BxxBcVta+BsaQcQUf7jGXYP6RAddOnGMvac7vpvp5eV6uAqg91DkLE9+1ihIHqkSVy2OrquxHtD
	6uW+Y2UvwZnetRsFamaOlM+jb3/nArbcx0KS0aqS9mA7FlX0gqLWfuqe7dZ7G5dJ7p4fC9pA65B
	WQ0os9abJ9UUBWnieEmkTp4TrnvEh9Qqstn005K6oDWF18XfHB8aJ8uQAHxpeb0yfpk+RE0tyMB
	Gh8Ab6tuxOhx/V5b3m1GLbiXEIBYhBoDcrcH/qNMwJdLUsEDznj4/DATWBlgWw==
X-Google-Smtp-Source: AGHT+IEheNsRSHUWuzlNyK8boLS7j93RQIefLWBb0ea9mzvCgFE9iYJOQySEEeBH1tlzjsI+PVnmpQ==
X-Received: by 2002:a05:600c:4754:b0:435:1a2:2633 with SMTP id 5b1f17b1804b1-4390d43da3fmr34821435e9.15.1738778629000;
        Wed, 05 Feb 2025 10:03:49 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:2ca8:ba92:a6ab:f4bf? ([2a02:168:6806:0:2ca8:ba92:a6ab:f4bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4438sm29337625e9.25.2025.02.05.10.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:03:48 -0800 (PST)
Message-ID: <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Josua Mayer <josua@solid-run.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>, Mikhail Anikin	
 <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 05 Feb 2025 19:03:47 +0100
In-Reply-To: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
References: 
	<20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-01 at 13:13 +0100, Josua Mayer wrote:
> So far ahci_platform relied on number of child nodes in firmware to
> allocate arrays and expected port numbers to start from 0 without holes.
> This number of ports is then set in private structure for use when
> configuring phys and regulators.
>=20
> Some platforms may not use every port of an ahci controller.
> E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
> to the following errors during boot:
> [=C2=A0=C2=A0=C2=A0 1.719476] ahci f2540000.sata: invalid port number 1
> [=C2=A0=C2=A0=C2=A0 1.724562] ahci f2540000.sata: No port enabled
>=20
> Update all accessesors of ahci_host_priv phys and target_pwrs arrays to
> support holes. Access is gated by hpriv->mask_port_map which has a bit
> set for each enabled port.
>=20
> Update ahci_platform_get_resources to ignore holes in the port numbers
> and enable ports defined in firmware by their reg property only.
>=20
> When firmware does not define children it is assumed that there is
> exactly one port, using index 0.
>=20

[...]

> @@ -625,6 +651,8 @@ struct ahci_host_priv *ahci_platform_get_resources(st=
ruct platform_device *pdev,
> =C2=A0		 * If no sub-node was found, keep this for device tree
> =C2=A0		 * compatibility
> =C2=A0		 */
> +		hpriv->mask_port_map |=3D BIT(0);
> +
> =C2=A0		rc =3D ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
> =C2=A0		if (rc)
> =C2=A0			goto err_out;
>=20

This very last hunk (when firmware does not define children...) causes some=
 change in behaviour on my Turris Omnia
(Armada 385):

6.13.0 bootlog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Feb 05 18:30:45 xxxx kernel: ahci-mvebu f10a8000.sata: AHCI vers 0001.0000,=
 32 command slots, 6 Gbps, platform mode
Feb 05 18:30:45 xxxx kernel: ahci-mvebu f10a8000.sata: 2/2 ports implemente=
d (port mask 0x3)
Feb 05 18:30:45 xxxx kernel: ahci-mvebu f10a8000.sata: flags: 64bit ncq snt=
f led only pmp fbs pio slum part sxs=20
Feb 05 18:30:45 xxxx kernel: scsi host0: ahci-mvebu
Feb 05 18:30:45 xxxx kernel: scsi host1: ahci-mvebu
Feb 05 18:30:45 xxxx kernel: ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0=
xf10a9fff] port 0x100 irq 40 lpm-pol 0
Feb 05 18:30:45 xxxx kernel: ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0=
xf10a9fff] port 0x180 irq 40 lpm-pol 0

Previously, both detected ports were automatically used, and no warning was=
 emitted.
(hpriv->mask_port_map was 0x0)


6.14.0-rc1 bootlog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: masking port_map 0x3=
 -> 0x1
Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: AHCI vers 0001.0000,=
 32 command slots, 6 Gbps, platform mode
Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: 1/2 ports implemente=
d (port mask 0x1)
Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: flags: 64bit ncq snt=
f led only pmp fbs pio slum part sxs=20
Feb 05 18:36:40 xxxx kernel: scsi host0: ahci-mvebu
Feb 05 18:36:40 xxxx kernel: scsi host1: ahci-mvebu
Feb 05 18:36:40 xxxx kernel: ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0=
xf10a9fff] port 0x100 irq 40 lpm-pol 0
Feb 05 18:36:40 xxxx kernel: ata2: DUMMY

Now, hpriv->mask_port_map is forced to 0x1, resulting in a kernel warning, =
and no more ata2 available.
In my particular case it is not a big deal, since nothing is connected to t=
he 2nd port, and I can live with this obscure warning.

But that might not be the case for everybody?

Regards, Klaus

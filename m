Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AA3BAD93
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268356; cv=none; b=pa1RR6ONLJHq7xGERt9zQVSGwq5J8OHipsEUG5KTSGEIICG9aDJGZZKA9sqjDOUYpEaFQzGNV6SCQ6QsYYnS5DrYp5wG2qherUt2cdrtFldANOyYcarURqCwDObtdxwf+QqIshM+PlYjCLUN+0ZiH+ITJWJFyJR7MMMw1pWxpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268356; c=relaxed/simple;
	bh=fE8djFS2MpLptbCdfvOG7cV+KrkPKvXeDfCrGMnjEO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIzgZUHH4cgqEgMEEmR7TOx/IX/2iQSDujAxkw9J9iQifBTegCtTWCS3m4IdRZ2L/hGyK3Z/iQdjqozApWjHnfpUkMChXajewFTlpa8tNLXTApfuReAiFvhUmGtHK1lDnrDHCTqe8VDQaIKTz+xWpWRG6p8NYrJZVoS4UnBcndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TicXe0oE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TicXe0oE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so43293045e9.2
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2026 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779268352; x=1779873152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv2vsftvjAxiOjlegrZ40pqute/SFTSBsTUXAXDUDj4=;
        b=TicXe0oELinzln2INfHsoewvnFAYWys6j8pkYMZi3owjomevbCC7BjTGTOEpPuhcyi
         Ot4afXwnU1lEm96SkfrCdiWYlM7E2Nxco5id25qFKuwZcgVWtNIuh1pU/5SAnToUgmJW
         70RkJ0gaP4R+WrVCwRoBWjkm155DEezmBty4mDm1j4CcXHnZBAuGT12rqn6S8J6Cwywc
         Ljtky3TW2V5klE55heEeH++eB9cnIFj2u9Gwi2WRZ7qUvgY+BbWZU7yjhENvwm7SwwV9
         ev0ybOe9zjUBtXP6r1B/vFZzlmm7UELbi09W2D0JbrukqNK5i3DqOZFj6lGCurxaflNe
         UmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268352; x=1779873152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv2vsftvjAxiOjlegrZ40pqute/SFTSBsTUXAXDUDj4=;
        b=FeAFzJGYMayTvKalq4qgatqmshnGWyh5ms7cCH4VXomBeavGdJ9KyPEERsJjogrnXN
         v9wMurs0YqXK4MtNFXWarglxUGBbseBEs8kfpEFulqXAaNATkH72JAlYEoFA7xTWnGn2
         GYq9VznMlTwooEf8ItEcBg54exNM/DCqnu00r7Z/mNmq86hXaMUx8AYhR8u0GdRa5eIJ
         cq0BRvL4m78T+1aQ3tdKi14FKiYLlUWS5bz7UdPea0PPhGxUU82pc1RKudXjiF30Qv79
         qWMl/vmi5HVc6JFACkzINXYMuV8qXIVLJQBPt84VNuAOCW8yW0O3MxXNGnIdd1PolkFC
         wFtA==
X-Forwarded-Encrypted: i=1; AFNElJ8KVMPiaK8ssrjoOCZfBdGpRMBQLMsObYKJsv3v582rad4FJmCkkEjjjOEtGqhS1R/DKMpC3/zDgcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHaMegJaRqEZ5oKns5nI1zZJYUy367DT/4VoNCL9aho+OelJs
	7DHtemcb5/1NmcolI+73YMfSwf7pnDXo9Y4IdTcuLpxVE1dg09VJ13WkHfBB5rrS6GI2X5sBzb2
	jHliwRnxYJg==
X-Gm-Gg: Acq92OG0PoFJQQEbzSQomCxajlHkBs8wMNvFW42jXYqozqIceDIXaUb2EVv6vPM5MU9
	k9AtmmS0V/Sws40kWNEJlBo45ZjnS48u+7l3hb5TgA6l1yaqva2YWlYnfY1B8YKQyHwVgNv/GEU
	EZSwDRVwOfkhWGw7Qxdzn5Y88fPclKOewWzoyhBow0LBCTlD48+d3oD2RXgHt5h4n9tQ5MnwelT
	xyMiA6j802jaB/l9CIb2fDy0mRWrl8gsxdh/e+Sqa5Qa8ezCTrwDxQ5bOp9UuVTK5B2je+wxX87
	ZImsJOwBMptMemE2tJnWUCvhbB0/68YXeVuuQSq1Q6JZMPOaQRWUbyT1jM/gISTja6M+l607Qv0
	HGM3CprXm06ZQq4igt1nM4mnygaJ98mejHmKMXX8W/6ZW7g1IzwXH24nscXUG9EeArxYbIs+apm
	FBWFv5R/hklxNK0kG2+vxG0pNiWHTZf+VduPG/Vwkm9AnBSBKe58quOv3+AfmSTM9OJ0XvhJsv6
	/77s/2Z3XpiAsk=
X-Received: by 2002:a05:600c:8b0d:b0:48f:e230:2a26 with SMTP id 5b1f17b1804b1-48fe6631679mr367283935e9.33.1779268352240;
        Wed, 20 May 2026 02:12:32 -0700 (PDT)
Received: from localhost (p200300f65f47db04a02ef40d8e5825ac.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a02e:f40d:8e58:25ac])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe537ccf5sm375529645e9.14.2026.05.20.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:12:31 -0700 (PDT)
Date: Wed, 20 May 2026 11:12:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] ata: Consistently define pci_device_ids using named
 initializers
Message-ID: <ag16iA6JLwGGLR8_@monoceros>
References: <20260430170612.510869-2-u.kleine-koenig@baylibre.com>
 <b06a2fec-441f-4be2-aae6-3796c1e45cfc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqcdgilotkws2btq"
Content-Disposition: inline
In-Reply-To: <b06a2fec-441f-4be2-aae6-3796c1e45cfc@kernel.org>


--qqcdgilotkws2btq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ata: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

On Mon, May 04, 2026 at 10:09:53AM +0200, Damien Le Moal wrote:
> On 4/30/26 19:06, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > ... and PCI device helpers.
> >=20
> > The .driver_data member in the various struct pci_device_id arrays were
> > initialized mostly by list expressions. This isn't easily readable if
> > you're not into PCI. Using named initializers is more explicit and thus
> > easier to parse.
> >=20
> > Also use PCI_DEVICE to conveniently assign .vendor, .device, .subvendor
> > and .subdevice where appropriate.
> >=20
> > The secret plan is to make struct pci_device_id::driver_data an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/)
> > and that requires named initializers. But it's also a nice cleanup on
> > its own.
> >=20
> > This change doesn't introduce changes to the compiled pci_device_id
> > arrays. Tested on x86 and arm64.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> This looks like a nice cleanup to me. A couple of nits below.
> With that, feel free to add:
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>=20
> [...]
>=20
> > diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> > index 495fa096dd65..fac1266f7fa6 100644
> > --- a/drivers/ata/ata_piix.c
> > +++ b/drivers/ata/ata_piix.c
> > @@ -154,184 +154,186 @@ static unsigned int in_module_init =3D 1;
> > =20
> >  static const struct pci_device_id piix_pci_tbl[] =3D {
> >  	/* Intel PIIX3 for the 430HX etc */
> > -	{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },
> > +	{ PCI_DEVICE(0x8086, 0x7010), .driver_data =3D piix_pata_mwdma },
>=20
> Please split the line before the .driver_data like for all the other chan=
ges.
> That will make things consistent...

I would go for

	{
		PCI_DEVICE(0x8086, 0x7010),
		.driver_data =3D piix_pata_mwdma,
	}, {
		...

then. Or would you prefer something more compact like:

	{ PCI_DEVICE(0x8086, 0x7010),
	  .driver_data =3D piix_pata_mwdma },

?

Best regards
Uwe

--qqcdgilotkws2btq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoNevsACgkQj4D7WH0S
/k6P8ggAnMje7ucT7yKoD+v2hsALg25MvZd/o0LGk7p+YLqalw9jqCEtIGHlCpck
gHjjPFV/IOGAwwX8RdEan1zIT/OReeVV75MikUF6OO+CEpkQFtTRlCcvi7d48CXK
HJlW+1g+L770G2bUMjDrRD/nbDjYQDMX9RGEJsYykuxjx6dNkOZvjBmZu6Iazpql
cS47i5ySvm1TYXPs6BumrgAdsIBLmlN2TzArebKPfk1vRovWQVoUPCa4/3Fj7Zul
bo/OBleCQLAhOycu6pTE1PQye54KXx3h9+K20owFID3PJZLIA2JdTWY/f6wRJ2ZA
v1MmCU6jEl8x5oM0GLij2HrUHgTSaQ==
=btUf
-----END PGP SIGNATURE-----

--qqcdgilotkws2btq--

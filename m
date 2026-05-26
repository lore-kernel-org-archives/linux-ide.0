Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38533C5DCD
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813501; cv=none; b=I/7tsYIl64F7KBSc4MOsgwc3VAOxY4a6DLyB1qoxMtylQwXlaR8rvs5S9uHYS09R5B78ToiLHfwVJIe0N3jqrAe+L12Q3yZKH6+HsRkb6ga/cS7gs4YP7o0dcN7M77g8TPVOY8opgBMWiXaN9X+reyW29pvOQZAYISYSUsI0+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813501; c=relaxed/simple;
	bh=4V0/hRzQM3QPZtd9ciEuGpakZz9BDAJEY1Xq/95IEYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP/aL+E9JpF7xMq2OWVWnOWzYgVVSePWr9nbkfZMjvk0EbDHKlEWG+kTv0FvS6gfX2z4VVT7TkggaWqgywPLOEUVu38MD2Yr54iuGTZRJqPLMtplviiHqQ8xcOXrBKGdr2VyvhRtVHZJsl+e6UN1PFYZ5gpDidXRS0ZglkyxHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mk0Bwf5h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mk0Bwf5h"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so44911265e9.3
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779813497; x=1780418297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+neT3f/iOdkns4E+8cxUHIEwouFFRC5e7pB2NZRvaQM=;
        b=mk0Bwf5hXpVXtR8qKrq4eVR8YRH8uAgW243P9LPUcvYHlW/W3CenauBquVI1o3J3Gz
         ykz9ET95iEHsRPV830hnFjr+E9v6rT8uhO0Iv8U2EVfdIiTHUUuKMxFybKQ5FuNj38bd
         fdstOAocTCEVIJp/li2MjrH1TtrNYnTy9LFZwGX72Coi2ym25O4/5jgSbT/7y8xXzHEk
         Fc/IBf27hQDsuVeDJJOKWgwtUeRO5mJq0jJAVfLR97P3J7upjpS4Qdi3HsJ8sYyNyP/o
         LOkZcOScYuknd4QAmTD+rRr6zgy3tK7XkOL9daYc9jJ12Qq/UI632ZbmKMp5vbeHF0ud
         rzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813497; x=1780418297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+neT3f/iOdkns4E+8cxUHIEwouFFRC5e7pB2NZRvaQM=;
        b=O9D93/VlugYD2evQLPnWe813m0f9b3biHP0Rlayxv3u6i29ZXOmFISp9CBtZ5na12K
         UqrvnZKzbGh1mqmvwj201Vw7Sh+axDrrvuobSL6cdMW3lK5lcBYZ1vSerdNzG7shmUj9
         O0LtplXajNKa12bXLEYzYCOVVXx+1wedooRv+DySJ13Kk2c3XMfh0Ih8FaSpFlNBNssK
         kRxq35CX13/zEg85/jicMJjNWniGq42HfazoH+ZPEhj3LSbnJ18KfT8MPAStC/ICtURB
         pSTMqUy8oqOecWERp3NnZNjOpVA0UCc4ULlgcHPEC4Jd8AwuOBdNnkwybYWw3m661y5L
         tcpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qvw2m5tAuw7mLNgJ5cyqp4iFIPcDbZ988ZMd9dCy5QMwPbv8mCxBziJAz4KHufuwEeoRpVPgb0/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAYT0FBssy/i+WHlQEtNZAqcjasZ4gWAiWm7+OGNeec2M7/Gb
	XJFLK0Q1oeNmFulaP/JAQgaO35IEW8x/zdSwkYKKZiVnFc5YmZ1YCKNqia0A78r/Tw8=
X-Gm-Gg: Acq92OExkFqcxhNp4Tm4oBt17jMjQttSPnwDHu/8bOd2cZ347UfUWqcuhFT6TaYvKSd
	w42xVgOcbNwSLR0VKAVfZXbKohxkcA09X2k6NaWDydb2iSb5rsAe4IVLabHmdTCUiwCSWj4MFh5
	qqnuDV2Siy5uVB0/BKXkMXsDKRZwv0dn8zq9LkH5EcAnwWK0QNRBkz8hToKjUUFskC+iy2Sa4Ey
	fL20QXsxgJZowXsWPoHBEZTIu0jz8AvxjUULgeZkZcaSw1c4J2nI8SvWDbljs84I+Gs+Ml3IV8F
	AtVpA3YQKSgP+rbPsqnqICqRoyF/pQPZcsHr20K0D1vOHGjaNydhKepUsFBG3LIuIaGC3OjIn/a
	ABd5GSriE0MgVhDTKZo1VSKBnyi3h874v8unappZmknFzxp75G7BfWmNmDLMploR/Gowsjb44gr
	S3eYhbvFaC6rdCte9ELJ+QW/+j4Hp7Y9buo7Jv+UJsyDiUsJ8NMspHLrzeKU3Q/QckSAitTTL58
	Y3NjWZdyPSAB+c=
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-490424b25abmr314126765e9.11.1779813497306;
        Tue, 26 May 2026 09:38:17 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6d493dfsm37901229f8f.23.2026.05.26.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:38:16 -0700 (PDT)
Date: Tue, 26 May 2026 18:38:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
Message-ID: <ahXMGtBv_pQXM7YS@monoceros>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26ssrqftvvoyehs2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>


--26ssrqftvvoyehs2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
MIME-Version: 1.0

On Tue, May 26, 2026 at 05:01:48PM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> > this series is about improving the handling of pointers in struct
> > zorro_device_id's driver_data.
> >
> > While it's ok on all current Linux platforms to store a pointer in an
> > unsigned long variable, it involves casting that loses type information.
> > This can be nicely seen in patch #7 where after profiting from patch #6
> > the compiler notices a missing const.
> >
> > Preparing for that change, all zorro_device_ids are converted to use
> > named initializers, which is also a nice cleanup that could stand for
> > itself, as it improves readability for humans. (That is necessary
> > because an anonymous union can be initialized by name, but not using a
> > list initializer.)
> >
> > My motivation for this series is the CHERI hardware extension. With that
> > pointers are bigger than longs and thus you cannot store pointers in
> > zorro_device_id::driver_data. So this series is also about getting
> > support for CHERI into the mainline, but I hope the clean up effects
> > mentioned above are justification enough to accept this series.
>=20
> Thanks for your series!
>=20
> > The dependencies in this series are as follows:
> >
> >  - Patch #5 depends on #1, #2
>=20
> s/5/6/?
>=20
> >  - Patches #7 and #8 depend on patch #6.
> >
> > So if the ata maintainers agreed to merge their patch #1 via scsi, and
> > Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
>=20
> s/5/6/?

Yes, indeed. And I tried so hard to get all the numbers right :-\

Best regards
Uwe

--26ssrqftvvoyehs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoVzHQACgkQj4D7WH0S
/k4BXggAoAuTCgxPow5/rQYRxSTj+kNc4XmxhIlX39wkjq4KJoBOkfK1zOhQISV1
4HHCqWa9m9dov4bu6Kg8LwbKa2UChzh7HIDanvg0FuTjuR2DvZAqQ1h3KlZHQj4H
Dh1fxxwA9H2mAUN8tHgeBxUVZ6qajflOjKFHpsQbdgTyoj2LkR1szY77e5P4QdmS
0UJbs5rWuTPA+ErMqqdl4SkAygYx8SEw84ch7byHO4yx9rpUCp8zJk95dKJCgAir
L38wVLJUZNR7sQVkPKakWtv34niUdKWjqIXa8yB4GHOQFX65uFKEzrvodPCyE2J/
vgh7fbUvdt3OqTL+DpSduQS2l1F1qA==
=W3Nr
-----END PGP SIGNATURE-----

--26ssrqftvvoyehs2--

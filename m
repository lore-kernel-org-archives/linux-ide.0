Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35075399D02
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350258; cv=none; b=tmc9t9dTiMLjevAGmBO4bb37bmg1WxV3/9kSHfEQ60WRGEQidXbjs5sYK7Fk0USLabDhtCY3AGV/5YZ6+l42Feb5ouGJusYfxXIkBzoN8aIss2a+g5J3nrAjcC3ySzITXRsFUqcKUBr3U5w7YB+WRgQ+6OmyZBAZJv9gMqpSyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350258; c=relaxed/simple;
	bh=01uWqmyLFzd8H4CBvINTSYaToSHFeAsBFz1Y1xtMczw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGIBFy921w408M3LPPvQ+K//FY53Ts0utEcgoEBttzXh9Vzm9avGlRbexuYXval2t+QYwKUsn8LeQMcQiXyMD+yLRQ0pXCKpZrHkpfH/4Qfj0aYYmvq9Q9hlbJnOgf6OCoeGqR3Z9deNUQngCM6bkrmOPp2eFL48uUgUQU6gb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQOH2x0O; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQOH2x0O"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so541768f8f.1
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350253; x=1779955053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZORxaPdJSDOgk8ANxzTl375l5CvuQSqBLkQk79bozY=;
        b=OQOH2x0OZmEHxHHry4BcFu9isGLq7beTOFb9yC45lwiqzRwafosbDvCQccvcpI4Hxe
         eNbwvw1744HGpcNiJAsDBkrw0MOq6sGds1NNjqKKdU7XNpyaBOBKjmtpsUX6V4wjZR5k
         Q6cOhRbs/2kg7mNG7JGrw5Mv0KyRQWrK0BBill59rSboOl2hNYGNkFbj5C1VgnaY/O71
         6h9qm+zQaGuSOpXX61yXVpOm24hFxKD7lHIZx8i8qrG4CTHkTNB6DjkIkfahhE9yQYdC
         fT/M6Md7fplyvntgzvkItb2GO0f2QUjGrMGYcskzmZdYFpJSrhLb7NDmnIMIqlEa7t0y
         k+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350253; x=1779955053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZORxaPdJSDOgk8ANxzTl375l5CvuQSqBLkQk79bozY=;
        b=U9X3dkMK3rTt0fTjmEHdsWjcu1oc1ZJ36upqDt97TDPC7aSEI+jWDMFvC8op2V+3ET
         SLa+D2dv5feZicMSNAG2oczmwCet24tvPNRvk6KCAvNt/Kw4jBgcICQP7TNoPqvwMvrK
         LjMTDLBiZ0d9Uurfn4R56Cxrgl97I461zOxOyE4oY90Cvj1p2Zy7zHKnT6mX8L7vEyWb
         liLJjqfOz4BMsPXZyr+ke7d34kHWf8j+2Fnu5d2jTM2fKr2mdQYeJwQSzL1PbZMPouvm
         3NizMg6O5cj7r52xi6A6z2vJg6rDBNPDfC7hqjGokh5ru9v9Ts5UMN9ruuJTXpFIU96v
         UlVg==
X-Forwarded-Encrypted: i=1; AFNElJ//APzrL+J5Z58+XKc1RD764mMCtPozrod8h5YMoylbp9AN3egkU4ZZ7stBlqqusklSlI/MiBhc0wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnbhjjBxIeaXHikCRX4RO86HQ6LWa4lP0ztNejzZXiej1gYoe
	w3q55mampnGxs5xIlBq6qEFule3o8pg9c0WIj+tkMRaihwvJ9hC6ljYc
X-Gm-Gg: Acq92OHyUwTygNwnK0rNRIka3Ho3+/Fj/eo1yR+u7gNk9bQ0JKHt2j7Hjoq5tmuCguj
	EMjH372u+XsuwnGR0Cf7v7J+yebdV2JEsqtJCEdjziSihBHMN+PGvqisQIs8NsVYG+eMoO7yT0u
	U1jwJ7Ibnlh+1joxbcMsCveQzuioFyslKCKMMtEaL2c7Y+H05KGkA0gWSttSnFeucDttBHlOtJC
	TWg3q9po+B+Lb6mUEfu2+RTYiaCoLzdjfBGINJAh3hO6U3opFT9ristn2Zp10KBItLSN5tEcxIy
	OzPOH/uAAoTHAFkKudmROeq3/G92jMTQYNXX0kF0TlqdjSdiG3wjJjQYckk+lswci9YHob7QYxg
	34qppqdTftdzeyEhTZ70LybvSiwgBZ/S6Uo0etNesqTbXQFnWoGGRJN98dNQ/XRCJxHPZHNsuxK
	3bJZElzI9YB7qKasV5nvo80G7IH8f9+PmPJC+kaA/sp6JujXACNbhN++Fgmk/MZcCgP9yPtZgGK
	/HY9G0hWyH0Gw==
X-Received: by 2002:a05:6000:2583:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-45ea4141e17mr2803411f8f.38.1779350252817;
        Thu, 21 May 2026 00:57:32 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7dd50asm821152f8f.15.2026.05.21.00.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:57:30 -0700 (PDT)
Date: Thu, 21 May 2026 09:57:28 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 4/9] media: vde: Explicitly specify PMC instance to use
Message-ID: <ag66qZ6rLOeUTWV7@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-4-a6de5da7216b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufnilbb7pbo55sdz"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-4-a6de5da7216b@nvidia.com>


--ufnilbb7pbo55sdz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/9] media: vde: Explicitly specify PMC instance to use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:55PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/media/platform/nvidia/tegra-vde/vde.c | 15 +++++++++++----
>  drivers/media/platform/nvidia/tegra-vde/vde.h |  1 +
>  2 files changed, 12 insertions(+), 4 deletions(-)

Hi Mauro,

would you mind providing an Acked-by on this so I can take it through
the Tegra tree? That'd make the dependency handling a bit simpler.

Thanks,
Thierry

--ufnilbb7pbo55sdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOuugACgkQ3SOs138+
s6FbKQ//aRQbgwr4ztzl8XykZ3VwYpBsUA5hzUjDURQkJFNdwnkt6k1kBPuF6tMI
joUObtuboDDZBD6T1W1CWvCKqzBPwDlmD5hdckRGlbau3ug5Z4HYFpTEoO2VPhr8
kW6mO+oE+5Jq2I4kEfCg9WfotOOP15ehuSzn2JRbKZDLC9l8/Fyo/7nglXyjmoJk
qgD47vfx8/zgrE/Fv9M+eGdeJzh0XxvRrqWYxe6wJqlFCETYNH38hb+CBfIWa8HR
Tzoa0rmTS4YRP2+p6yeckAN5IWgSx7ZTbCMLLoJfyjEbCUf9Y3ymi7DNWHey2gi1
SY1ue+l/i2UNavChYqtuBV9YOfSyM0PWRQja4YeSMSIK1M7mLfta20LOo37A112O
BN5tR5zmtwiKW5ZnAReOMcWJFLobWu9+ZlbkiyQ4yiONh1truDHgwBOssPfCK+/Y
ejeJGgdzWnlgonVwEp80tLQsNZN4Nccrmnn5JPaH1maEC+eJBtP1Y6V+io/28QFP
YE+W8gXUwm2BK81TcpIw6qswfWiBu8WdGeCx9j5X+mbo/jNWboIo2l0AQxtbCyGm
LiYJV+w1iEWO3WWQKymgmwRdhT/QfeS4VcUikTrZG/NrcIEpVwuVk4syKobUx9Cx
DuSlIPt97hHCjwAaF6HZwg809a+jTrqXPBq4VlYvkjefZNJAiMA=
=2vYi
-----END PGP SIGNATURE-----

--ufnilbb7pbo55sdz--

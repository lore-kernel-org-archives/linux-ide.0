Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3A3C5DB8
	for <linux-ide@vger.kernel.org>; Fri, 22 May 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444939; cv=none; b=TguSo+t4u+7Bzhmb7MJBeAQ2/B0S3T8BLMm70+x1vKi9IVvuBAMhwOlGFjB3w0u056e/1uPJQBZpsT6AHKlQKI+lsC01ZyHbelb96IbHsxotwgFCiFT7Oc7/uSsVIltg+3+YQAB5CoOJUIdZbb61f5pKy+tYUyJsyIUspzsz6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444939; c=relaxed/simple;
	bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSpWA7eRhfCmE22rSEaoY/eflx5GySjiq5BvnirI/sfl2aRy6330eYXPx4TUOpRnHb40G68ednOwhmHUTCB13O2Ze9FqG9dXC14ElZmo5b5RwzNUt/NOM4NiotHu9mUJRkXHHh/1GtO4wWS35J19Kquf4LEnVWJVK2myYzN6nQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3xQEC3n; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3xQEC3n"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48fde648a71so49804105e9.0
        for <linux-ide@vger.kernel.org>; Fri, 22 May 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444936; x=1780049736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
        b=T3xQEC3nEmnuLNZ3gZBTSC6yv6J03YL5MQt5irY5+v0SH1VGr2ThripFTNPGJzedAy
         1NBFLUpwv/1+E5Er5joEdIxPy32+FRJHLV5Sa27SYP3SzRSDbQcj0XQzOxfQACrQqL5O
         9B0NVhsHm2ZWwdr2mgqHeHKPxK9sSEphmgbk43ut5rXFH4bPIuqWsGm2UaddkUVcHpxO
         sB9CchfsQaVOCQzcTWgOexjNztzauzE5fj+CjuW9PgT3QedCCzSCy7aXY+V+PnSAG7Qw
         YKrrI8mT+KjHtdr0lP2oZklUNhqKn8WudBpWzJUBepA9VX0wjBrT+Fk9qblPZhIpkF6y
         KMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444936; x=1780049736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
        b=TI3YbmMY9xsSje9j4TdyPHs6CDJ3tLQW/58R7yM/yua6OgOasKV273cmVBx25NWPfc
         CheixQU+7ud+bgnnsLaxsGi+uL0hFPSijvpvUxZy2vwBRLQhXG5pDCliwphNGPDNsVT+
         WeoEuFSYZM+lQx8XW2w+PIY6G6HWD5yLCj9FXpkRdF3MEZPpx1WqEaOazkcZnN2AIbrP
         VDI0nyFJlxmHlHRhPzCe411vHd5fcwyzD/yKYtpFY0o4vFipJHwmLTnsY08Ydg1HiuK9
         K08Yf5zzm89n0TcuPOlNlyz+92/KPcfWUv2dXgGWFXFUC+UcPDir6/Pli1/DH6AI9B3v
         YXxA==
X-Forwarded-Encrypted: i=1; AFNElJ/TReC7/9YekSfDKnI1JnDXB3XwgJw865eJKREQ2Pvxs/5tCGKka38H64+Utw0KXhn2UUZtZ/eiP4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xOyIWY9JpWq72L08VrHADa2cubA6AzgIBegBSFqgRLl2KJVT
	HfBIskPPrdEyRwH/ZKniU43tYJzL86HQFThJ4DjjHlyWEQQrQnFF/Pnd
X-Gm-Gg: Acq92OF5j5HiGHQcUi+rZi8saZw56sD64ZznA5awyaWHYpKJlcHcmR3kCD9EqZv+mBS
	aoi2+3TGdzey3DgoxIs8y9m6mpLuVpSKaSeAo7UaB9HyyqbKV214itZhT5hnSHYDUysJxMzbR+u
	iY5+6I99sEjyQsSUmbRM+FBTuKK6yjDSa1PAh4TYs1YaO4xdfwdsU9kT/kgc6AITpge4o81DItL
	rkyhysG03ak/YmOpYSn3a+NhjMy1Hyf95C+TyN53n2txmQw4OhEo56eB5R6geWGSDNHK4cPeiiS
	EBJshOlAhJGEZHobtbRa67r0Hwy2b4Go916fGDGnPXxUrXEYjXIeWpS2NINCtFRVq9M09YMHYo6
	9aKwDPNRKHcKF415NoFp2oVi90G9w5TD4iANxJpznzo4gLr957CZXz7AlVx4P2ETACfKkxj/mIi
	x93veaB9ZTTdl4hzC+cWOBQum7E/s2zXpeYxoHE4VxGjTpbHuWDjZlKms6A9gs3+Qv9i3DgJI+w
	0LHIOLHCLhdSu1Gd/oHfLWe
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490426b0c92mr24655565e9.16.1779444935807;
        Fri, 22 May 2026 03:15:35 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527dbf3sm30624875e9.6.2026.05.22.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:15:29 -0700 (PDT)
Date: Fri, 22 May 2026 12:15:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
Message-ID: <ahAst802sjuJr7-l@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
 <ag67dmFtSDBC6aPK@orome>
 <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtz3f4pwlb7uchwq"
Content-Disposition: inline
In-Reply-To: <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>


--qtz3f4pwlb7uchwq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
MIME-Version: 1.0

On Thu, May 21, 2026 at 04:04:28PM +0200, Danilo Krummrich wrote:
> On 5/21/26 10:00 AM, Thierry Reding wrote:
> > would any of you mind giving an Acked-by so I can pick this up into the
> > Tegra tree with the rest of the series?
> Sorry, I thought I already replied to this.
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks!

Thierry

--qtz3f4pwlb7uchwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQLL0ACgkQ3SOs138+
s6G6mg//ZTSVOV0O5XnlSqUo1fdyiV44Qxo3ysbWUv2+O3w+r5WwMjgdyUM9yAbS
cdsRz3LHOAYcXBxYZhtdkLh5KhhvjdkUk4e1fdo/5QSGjRPARHPS3bQAZbnpZy46
tWvdiKwj2fM2rZ5JQHvYEjGCSQ9hGa/9Ri3OnGti51rcUbCJhJS/J1KgyJ/UOmyn
ZKLr/2FfTbmC8w0Ukki+CV3d4JV/pxY1UNjyt7x568o6JlebDPK6M7PKMI/IM6GW
fHt0U+f335ljan2LD8HZfSia4sa2nZJnbJDtIEj1ov6suhrowY9Mne4JQTEwjuLX
db6abSI9ox3O3vkx7Zd1G795TZUWTXKlw2SHr5vMyOBXhJHtipm7y0bAwj4ZJiAp
5ghmBQzl9HdBVy8x8x8SjmVCygxrt2rOVocYDG1/Uc5DSZWa8aa3VQJMK6WZy9gB
9G47X1VZPs9B/KeqE5TWRwB05OHuLeCIVQz8Nd06DjN0IEUStecgDWXm0bs4UNWZ
zMwz/HPgK4zp59HRlVqgoYRNrIRXCd5wmz5t+JdqDwbytna2YVTV7u/3FOGgn/rD
HgxwYqtJsO3KosQ3UN/HKPoEk67noCBWMrSzZbwFhw/DziZwEn4mr+slHKizUvrF
40Ir94vEC6DhMDCNJClxmU6S9zhRoKUOqW3FLyPgC1Ghfp5RQrQ=
=MZIt
-----END PGP SIGNATURE-----

--qtz3f4pwlb7uchwq--

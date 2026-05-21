Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9411385D9A
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350356; cv=none; b=UVvrWMucTM01ulK415raBlCYHqeDcXYTs0rFZdJbhITTR7N+9v1eChlNmkUVQ7dko/SFcbHz6WxOz7fA3XeNdXmABG4JUJlS/D3QE4zV3DcNKXLBvNCWYLbujGqtjOek67kd+FxRWUlkmvuuEoaVCGlr8n09lwKfvSg/OnFVC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350356; c=relaxed/simple;
	bh=/1x4coy+EhRxr4G74Byh3jOJGsE6QncBFV+p/Hi25m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXIXQA3/ZP9cA/oQAYe5gH129q0rw876uudJNrBwB0z5KqCPI3ayaaaP/yJvMTg97+0F3dKFDlMPFcqKnuTa0OwMjOnnwJxgduY3rRa92N+xlw9uObsggUfHBN0sb1nMHmkbs2nDgpGtWRr4BRD30+MyU2d56DeDM1xPvk3TnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCpNOv5A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCpNOv5A"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso76341585e9.1
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350352; x=1779955152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfHyghQkuGkWqA8eUzVzPKJ2kyI5blFU5Z3V4gExrrw=;
        b=tCpNOv5A8HdCnQTC2YO6ZmPUIap2OWuVg6KtEdVlpXcpKiO/YpeIEsNE09QOC0vPcp
         mbkj5o0ucQMdZBIgSSBrhyC/5QY7B47hG7LDVU9TFDXSzpHKknB4pvMZaTz13AtS7g8D
         BDej5suWOmQEY1V2jTm/nLuzsxDmemRcGY3F3BsoCEQm3TZqKL7//xBS/cYch4hNkR+L
         s3pr2Vw+4nE0uzPECzfz3ZBPiU7WNMyEj6Xu711+lGijH909MMqqhvwK7DJhjsS/BZfo
         9CNxpVPVl792FLvzHh6sTfal8LBre/LuucO8+uBxwPHGogDvoGMGQWWey9guSQZqvaI8
         OArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350352; x=1779955152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfHyghQkuGkWqA8eUzVzPKJ2kyI5blFU5Z3V4gExrrw=;
        b=ZN6sc0LeERzL6AvqojRFBP8/UqhaHbZcI62ltnyp3HskEo5wTl4lfOf7sUmqwm7hZo
         S+Z4P3y3pHatvOD8EQAqXtThPNQIwRHVpjvzvwd/et/fBEeg+tkm3EqZuVnZzjnfUWr9
         8+uhw5JfUHw4LluWa0qBUHcdlbaasYCqhI62ZBvmCvo8IJHzsMGb2RCt/miZdBQSkdeC
         a8Reh0nyGZHV7vbWssTXMQDxJ6Bqz0VJx358pKTo/heMUemPkpZbE04VLbJH8qKyISYn
         tKGq7dHGZvqYm/ksc1OxDdK4fRNuqFDqVAR/j8g+pivMGjUfr9c6jWK8LyTtWkbjWvji
         iZjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EC5DwU5Gl5krUSfwG1MZUPCXuXP32AC8Ok5jfUGRD+NDPnAUHyQJmrxhRMJ0qfUvlOOEsm7uRdWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyePpUk2+cOgEX+ywT4WZfLALdhNGTjr16mAsNVtwMYTeEEJd8e
	uTw6znLzQygG4BIRj0cOZmopCug5nBe09YoFcduIH1KnKwsllVMOljPG
X-Gm-Gg: Acq92OG30K6BzoksEybYGQWEAXamyTw6Y3JO2e11zIP0GLY+gvhWSDORczN0yw3D3pV
	ej6+dUxFKixw05snDOW3AAKPalrUtaQ7dnovq+hb+rd/GXnBiAXE1xMZeUTG//8uEoZMLXEwdAJ
	LVj/NDNNFvL9FQhhUum7YBXDmRkQwWPnXdo0hyqiGWYniBEnNf3OC9sxQaPzeUFoXFvYdmcSXkG
	Dlz3fWahsAKFS7WuN6DDnWFyzMUsp4JOEV95nabQnhNjmyr1wkFNfR0o6W88TFDFV211IOim7G2
	UzUMKwyFPKWdM6cfnEMY6whk/1+qzJZFURbIFOYLLOvhuzFZ0pNBsQRYXw4uqbo4e93XvUAQ8Kz
	szOPh7iYye728Q9iajRSEWoL+2qqbUQUiHGRZV0lni4p6g0QaNXdCc9Ls8DnTLU14C7u8ba3pEy
	+10BYo09gShOqCdeBLLrhmptgELgM5NHsiOlaL06gUKHXsc5nAmUgeahy1u+K7Xpg/7kwvHb/XP
	RFjlGWdpkzDGg==
X-Received: by 2002:a05:600c:30d3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-4903605d86bmr12514805e9.9.1779350351689;
        Thu, 21 May 2026 00:59:11 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490387d16basm5521255e9.35.2026.05.21.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:59:09 -0700 (PDT)
Date: Thu, 21 May 2026 09:59:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
Message-ID: <ag67FStKnQcvNOrP@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4bqtknoba4e2ooc"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>


--o4bqtknoba4e2ooc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Mathias, Greg,

can you ack this so I can pick it up into the Tegra tree for simple
dependency resolution?

Thanks,
Thierry

--o4bqtknoba4e2ooc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOu0oACgkQ3SOs138+
s6HRkRAAqo5/UZ1fUVfF67PnLxU9m4v7JcLF4Ytf/Z7v087AEjfB1FXekO/SfEUl
dvex3+uqG9CIaSIQtQ8rxWgfEyOZeFirJloIENzJtaXACdsld465AHpQKBNbI5xU
/euNFiOwGTIgOHGhhxAIurS7F5Ag0WgWOTDN2uBlYGiDeuZShkW3Ek3M1WHSF2ey
Ai6uDC6tf03sgZla9uXS+eOZHkVaTx9pRDE1oxxHHLMtwgfkkl9BEHKxJ4ZqTYk8
6G5Bdz88LVtn4VWK2v/B+E6LiY5FJWuS2bM0PeRI2KpkB3F1jUy0rnC3OjdcMBjE
zyezSJsdMXkgODfA1zpIjGaAWjJ/wkU3ptsQ2EHq2+uTAji5OBUP/fquL+uOI+xH
WIHngd8r7BaBvygQpvVPl3YAC26qyRDmRqptWTXY/uISmcwmRZ6BaQTBsx1WOPmM
mFdZE0rVwRSfMws0GpPu6Atz++gerVHz/2EAFKPrntor6zUjSTbF3B42XCtIwpyO
T1Wmpfdvpt02fe1SjJvhkFCHzCv2sHvUqshC79KoN0gavq9732DOpJdn8aN8YTfe
GK4ekoKpjRZr5MUhTWGmRL0wrDNysBgOur97daSMrtrJNs+s8wlXA+9CP9nyICzs
2bbPfHWWQ78FiSSH8IOW/xAAFxM7aEh2UcHuajcX9pBLFwOnveo=
=ByYw
-----END PGP SIGNATURE-----

--o4bqtknoba4e2ooc--

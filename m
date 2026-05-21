Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359153537D2
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350475; cv=none; b=i9XfcYl7R+vUFT1OuBTYYTPwapO/+umlFej4JptmLOvnRXAjbhaY9b5oyAGhLVeC3y5ByH0hgL5HqyR7WPrZp17cC6fzXM3S63iehQlVfkuyA3+qu3m+JyagRbvdulRJNhMv7cS4dd8Hg9HZ5Qzpvavz1WvdWpFtKeUsijHfI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350475; c=relaxed/simple;
	bh=jyOUkIh5U4Jq5jhU7z2i3GFpsJ91ALGPm6dGho+irzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo+v6ibhMfZZTjYonEgSY1nDiXRdm+qxle236jcnXqlDz7U98th2DmntwrgjE3MWu3woIavwwDE08MpAKl/NlF1H2XhlVNTlJJawztNyTsmUDDYmIVEd/oCkUqBpW55VVN5D5AzU2Iiy8grDGDlj9qJ6TqWpCH0kF5Y7S7sB1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVVZVySJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVVZVySJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so2836237f8f.0
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350473; x=1779955273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAGm6nF0wdUN0d2423OYPWZUGqBbg4/Jc7nYqxEaHM8=;
        b=aVVZVySJmrn+BiIUydUWCsvJnn6a2TM2YIuYb+LCOieUVpvOeb0wc/HgC4X+OOfb1l
         4X7TvEc8NUgKRZo0/clcD4HSJqeHKAVzXEYEnBEGIQD8xVukvmQiBdZYzynxEi/pe5io
         dkLIryFeUlDfay5yyqvkWMXfgaOFGUgnaMx41QN5ELuUSX4cah4ZRJkmD7I+RQTcpJz6
         QXuwfYQ2viteGe7II2zP4PLcX6IYIyfbZCdcDa4AvCn9iDSzgaFloCgsYd6XLFLMYhoO
         KZ1aQpB8kMYHpES4DrfitPYK/VocyYbb92atSwL/dHiHtSxBZadQ5T8qRHjtHe0coGmU
         4xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350473; x=1779955273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAGm6nF0wdUN0d2423OYPWZUGqBbg4/Jc7nYqxEaHM8=;
        b=qqE2HU/+AlgtOnqJ7+FZFSyBGDZqQ9IRmRD8cJewo1U9d81wPWNrbx9GE3nWnAzjB0
         OfZBfxbnvNELqKB9JQrd7zJzXZNqdF7X79IncZpwbN6+E0nXWXlyGMWGvZbpFuW5yV5W
         0SsgVbov/5fMHtrNVdYOZ/Hr6yHcC+r9mdtLgS8L0KA/eV1HkIfoKjg0cFM68oQrb4jw
         UGfwehbiMXzmWxjPkahj0oOFxnade1daCLpAzC/3fNJYqc3E9U+9z90Zz1YuTK+ky+9n
         o7PIfkDDiQphRmopGJzEEqRQVy0ly4m35nf1kBq4anBQU4x9NRUIxkX7DIFIrgvEQVmg
         pVfg==
X-Forwarded-Encrypted: i=1; AFNElJ9PkcfQAgOzDBYIK4ebWozTmJNqP7Bovdk6par7aY0UW3nzTPdbvn4n8HuKNl7ipU7ITsFrfwvW7z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IRtxMiXcLquHKLByfxMcj9F+G/mkp1igalv58spZevfuWNlV
	qJo45p/cmgxK5vzJKl9Ztom+n2O8oAbfohfhHyGN1a8DLYdRsL/7UwYs
X-Gm-Gg: Acq92OEDMBAN4oxU81gbuxQWqRHSsDmfiNGrcbwsgG/V8iT0B5NRSZt3mWB8/unmZT7
	UVKdEYDdWezElUq1IiXhOUONrJgNPZYZAsjK0WecgoAacZNSus7dhIm5ek3w0WhQXIWqBN0Swk8
	WYdV8vKq6S5PpKfeBKjpYfR2xQRma6Ge2UIzeQOS+MZhIpv4OFediCwu6jmzUkoghmNh1xFewzR
	SkKUQRGpJkJGM254NgL6nNqqdpqwinSPPpPQP6z1tQQQxSCsO/sHfHLuiLX70U1TqQ5p9s9+QV4
	CQRqrZl32TUZZkFEvduDPjjRG0+Q144vnG8NL0W3AQByQzQGJTokzHxCKNeYah8qB2LLxHqe7UP
	S3/B0ugmpq5Y9oYfWBsWAn+oRb/bXqfY1AcnZeEwczB0pke8fClzrFy8PeBr7zpDVJMfJg7YhPB
	sjux6rGb1zBI5X9VkA42RQMQ01WfS6o/zaaYgYkyXC4jCb1+Fco7TzjvWw5S1VztLpmR3jtl/7F
	EqAGhYx6M1h3AoutU5hWdSE
X-Received: by 2002:a05:6000:4027:b0:45e:a0ab:8bc9 with SMTP id ffacd0b85a97d-45ea3dead2amr2513624f8f.41.1779350445635;
        Thu, 21 May 2026 01:00:45 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7dd9e6sm857662f8f.16.2026.05.21.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:00:44 -0700 (PDT)
Date: Thu, 21 May 2026 10:00:41 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Dmitry Osipenko <digetx@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
Message-ID: <ag67dmFtSDBC6aPK@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5oal4jl4ykfwr5c4"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>


--5oal4jl4ykfwr5c4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:53PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h  | 2 ++
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Danilo, Lyude, Maarten,

would any of you mind giving an Acked-by so I can pick this up into the
Tegra tree with the rest of the series?

Thanks,
Thierry

--5oal4jl4ykfwr5c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOu6kACgkQ3SOs138+
s6FK8BAAgs0A7wFYJOVZxTTW6MNa4zXSjm64uXobpTYaWzKll6wOHDvn6C9dcp/v
MLtSLfP1p1SW/dO74lgYcFcwNaDIZdDsJZmNba+3Jf6PpFLkFdvor5IxklQDCq7p
CTff6BCXl8nTZkHm57wdzn9MMiduUUlKEc1foNpP34dKfb148QjLYdxi/2hFY/ap
VNo3Lr54eMkr3RXicgdgDHq5TXk2gKfSdy+Tve1QiUcemkc36olxR3tcgVSLxPJC
Q66EiKj9g3bjK+fEzB7hA/GeAQOfpuUIObaCdcASbPeCBTyZJY23WbYAF5XMMRDs
LjCs2r/E0EtZLwKY0NGBEZjwzWxF8PddUoqi3TngTTfv/EJ4qx3QzqvAf2DIVKsA
xJgxWd1rDD2HclOQ4GojKyO7CYLt4Xa8hWXPt4V7ajU03l8bOCvKOBNmg6hRD5jp
vHxVRmM/KOteKe7c9VJCMmxmo1oi9lE3e6BCB/VAGm7tzXHK9/43ug3tlh4A4Yk/
ad3eKm3kJxNa4FvJor3dadP6+6C0HUwZkk40TGgkYubsdPfR2kyGI3YZlr1J7cBI
jdRqcYoo/S+HmsreQgBpPXcTUhKqLsTU9/eqQ7V+9SItN6mvX8pPWmUaf+UexFht
1fkm9VtVD/H5bQ0QeOiRpJMXOe/ozNGH0hUKOEywfy7W8syQACc=
=YTdM
-----END PGP SIGNATURE-----

--5oal4jl4ykfwr5c4--

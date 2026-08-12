Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A540F8E3
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527706; cv=none; b=JAv3+gbCU8USizZZNULct3hNdMc1vdBHlQNgGSRC5A9p2Ibj/U3+r1stS1sHfON2Ce/KJq5ArocwVn5ZvvvSAyVCLpvyZPNxD8Hxnu/ltRjvs7/tUKbNA8Z3nG5PA1eXGA/SSEpNi0OvMekDCX38Ys8u0cfcpfkPOcToi9t5iYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527706; c=relaxed/simple;
	bh=XaKUIdZO2DCDFVav7621HKbSJtQG99IRFpmyYJN2OgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at7y2Zj6PHzWw9aRYQRroN4EAZB5gaqeCShMRFN2G72BegJ9r58HFChWDmkMy6VCire/f4B2Dc+PwPUD6D3T5ndwS4qf1esU2ao50LPFvK5l6hvyPmiEUA8V5DbXNv3Ydz+UzLT0ehkEpgCOhsW2nbscLGjBLmuFsS8Q7FF0K8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dtA51W+R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dtA51W+R"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so6563875e9.1
        for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2026 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786527702; x=1787132502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxNosE7yHoDF9GtVXHnGVn0+pksROVpd1JFq4JpMO38=;
        b=dtA51W+RNOLwLPUU6x62B3iUUApgaDlKx8t6v5FdW+JUTAGv84csKCPUpjjK6issne
         lkS+xpvEDGTc1cBCrBZaZZXDc26lNooPx5Lsh+/ofK+Uk5O1Zusw8/q8HiHuAdC7sB5G
         IyWwCX4P6qRPIW5G9S+zCDI+X+vVoNOx6qxdV1ivOIACLp4VcIpnx7NfdNFNid1nXS6s
         pMmjM+PX79w42Jj+T6YCvEB0kQ9HNBwag6WbO9H6EW9MLnSmidsOz3HNaW76Sqy7GXJt
         5QZ4LLBFObAC+6/OZLKtKliOgjLUzZHOzFRWShGDX7E+grbiPWAvUiCJWyxrm6DvM75f
         Vwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527702; x=1787132502;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxNosE7yHoDF9GtVXHnGVn0+pksROVpd1JFq4JpMO38=;
        b=DJTn+anib4lTWHFtRKfQULmjczqmpWLWWcQnky+Sv+MMSdO/RIx9gKeuJ8VV/fSmQ7
         A8j1iri0x9X05ZLe+VmrqNEcNSrv4CT4jUnSoB6iJ1Do9MVOClZ6Xk1+vCHD68jJkSYg
         KkkRhwkh1qA7jtW5XWwXnPYAZCWIn1NPe4Ly783Mh7JOEyR6Y6ar1FJkwa41eQJ66rxc
         MsZxZJOD1l2SvgiUyxpxNi6jwkATgtRh2nqOXpFJIDbNRnMxpDBgL1gv+u2XE4LXw0Cx
         OcPFzuQ/Vjthzdu8NcTDNLRMfdPLEJQ5DJ/Nr75uJzo7Ysfvyd3NhuCJeCBd9G2lGB5u
         fHLA==
X-Forwarded-Encrypted: i=1; AHgh+RohnWaJjw1bO1ggYmf8nbJ110LMTY7okKtl1y4V2fOBhxBE6kUUaJJrIfpCGWb/kiUDDYAHF9eWjlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6r0J6GFcWkb8aX9de+OWH/ib8IL7G2PjtuYhFXqZGpPRq9FA
	qPA2SfCl9rFN130UNEEXKws4wgGf1ENtYnymdUCMuiO/b0Dq9ckZ9dq4+xWX9flSx7c=
X-Gm-Gg: AR+sD11cDi6e5VsFz/GnWCtE9IdKRpeaIiVv4kqZvJcq6Q9eZnIn/hA3ieAREWp+Dr6
	xFykzBbp8VvKhlW8vVK9i7rgjkpUAysgeAvXNGU5m6BPRr8PEfcJNEBntUaUzQsHkKRjrXHIVcV
	ui52t302qlbErT3wVkj4sn2+iBaSEZUrl75r8G4j/GPM7Bh1NqRJw5XbzYM1Atak5C8bT5oWilr
	WGkD3KchIn80yhsOuSV52cvtIXWcZER7IxcwkTJ7XQnqZ3J+OvSGQg1xs6V/A8NDiXFH2z/Ik4x
	INpFqcVL2onfIFR3kvDqkVn06srZzsprASdD7cqq3ijDbAt6cHgY4nYqdSL7PYiGXkxvNYf5FRE
	LdssARGXL0vXWP7KyX5LaLDQUiUc020y6pKKKyhcLDzM9X1pNnJXzPdzQ+/QGJO0/6Y0yp5sNvY
	I/luF3gOWmKpR3ePiBxA3WDlPiD80ynDx4BeteeZ0y+XfXew7NsQ0uVvfY0vhbrgo5Bw==
X-Received: by 2002:a05:600c:4690:b0:499:728c:4704 with SMTP id 5b1f17b1804b1-4997c0fe705mr38677725e9.12.1786527702586;
        Wed, 12 Aug 2026 02:41:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4997c9944ecsm34404005e9.14.2026.08.12.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:41:41 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:41:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <cassel@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, 
	Mark Miesfeld <mmiesfeld@appliedmicro.com>, Rupjyoti Sarmah <rsarmah@amcc.com>, 
	Prodyut Hazarika <phazarika@appliedmicro.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 0/4] ata: sata_dwc_460ex: cleanups
Message-ID: <anw-k62wK-GhkHSI@monoceros>
References: <20260712213728.824420-1-rosenp@gmail.com>
 <7c69e55c-1877-4bdd-aa18-9154acada32f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqe64owdcccwyybr"
Content-Disposition: inline
In-Reply-To: <7c69e55c-1877-4bdd-aa18-9154acada32f@kernel.org>


--vqe64owdcccwyybr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv4 0/4] ata: sata_dwc_460ex: cleanups
MIME-Version: 1.0

Hello,

On Mon, Jul 13, 2026 at 04:31:53PM +0900, Damien Le Moal wrote:
> On 7/13/26 06:37, Rosen Penev wrote:
> > Fix various issues flagged by Sashiko against the original submission o=
f this driver.
> >=20
> > v4: remove interrupt fix
> > v3: Shrink series to Fixes on the initial commit.
> > v2: sashiko fixes.
> >=20
> > Rosen Penev (4):
> >   ata: sata_dwc_460ex: use platform_get_irq()
> >   ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
> >     registered
> >   ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending
> >     interrupts
> >   ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion
> >     bit-scanning
> >=20
> >  drivers/ata/sata_dwc_460ex.c | 38 ++++++++++++------------------------
> >  1 file changed, 12 insertions(+), 26 deletions(-)
>=20
> I applied this to for-7.2-fixes, but I reversed the first 2 patches.
> Thanks!
>=20
> (if you have time, please send further cleanups to address the other issu=
es
> that sashiko signaled).

I think the analysis for the fourth patch is wrong (or incomplete), the
original code was (a bit simplified):

        unsigned char tag;
        unsigned int tag_mask;
        ...
        tag_mask =3D ...;
        ...
        tag =3D 0;
        while (tag_mask) {
                while (!(tag_mask & 0x1)) {
                        tag++;
                        tag_mask <<=3D 1;
                }

                tag_mask &=3D ~0x1;
                ...
        }

Given that tag_mask is shifted left (and not right) the inner while loop
yields an endless loop whenever tag_mask's least significant bit isn't
set initially. Given the outer loop this results in a hang if tag_mask
!=3D 1. So the issue doesn't only trigger for tag_mask =3D 0x80000000.

Either this never worked, or the problem doesn't trigger reaching that
code with tag_mask !=3D 1 easily. And I also wonder if the change's
urgency was considered carefully enough to justify a commit in -rc4 to
fix a bug that is already roughly 16 years old.

And similar for the 3 parents of that change
(c2130f6553f4a5cbdc259de069600117a995f197):

For 4bbc16a353a98023e5ddfca7c1fc0e49971cf4d0 I wonder: Does
ata_host_activate() already need the irqs enabled? If yes, the commit
is wrong.

For a4af122106f73ea510bb35a9ea1dedd980fc0db7 I think it's bold to claim
"Also fix unused variable when CONFIG_SATA_DWC_OLD_DMA is disabled."
given that the unused variable warning (I guess about np) was only
introduced during development of this patch.

For 66c4e310ad71f41e41736d33dd8a1fb5eaaec7f3 it disturbs me that the
commit log has: "If INTPR uses standard Write-1-to-Clear semantics,
[...]". Without that the justification of the patch goes away, nobody
checked that?

All four commits have an Assisted-by tag, and I have the impression that
nobody involved in these commits has the hardware or even the hardware
documentation. But maybe I'm just to picky about changes that enter the
mainline in the stabilization phase. =F0=9F=A4=B7

Best regards
Uwe

--vqe64owdcccwyybr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp8P9AACgkQj4D7WH0S
/k6Xdwf8CNCxVpd6AXAmUdbCpzWXDN15EM97qTSDUG2qItEkGWbDLLwPiGYeSW1l
rFWsA31M09Xtn5VMVSpH21izjJY6W1eI+zDPGAUPvxe5jehm7ACznW9LPI9eDcgc
rznNvFwqp9rdY1P4yRjADxq46H9kQaPhgRfZSr216R0FgI8xt9KA2cmhsG+Lcijq
BxV4Dj+wDA46S/v9lmBD0PbB2CmrM0ghBIi0cRuCSePFpBITm4Y5zpFV8j8B4qa7
ufUAMLh1g4UNStQUvCcDMpxgoFgQozPbc7z4N/jtOlo6wwAKQo2Sghfx06meZfC5
TJlVZTVAm5AXbCcXGV0LdDiKtJBO9Q==
=W1WM
-----END PGP SIGNATURE-----

--vqe64owdcccwyybr--

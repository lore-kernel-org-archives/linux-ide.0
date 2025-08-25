Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958772F99BD;
	Mon, 25 Aug 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140402; cv=none; b=SDJIYmFE2PduNHARNJG3k9SodYDID3p50DmKFt1FW+Hj/9nstFmiLO/JOZd08varq/Pv/x0Nv9VCrrXiB8NygPJMpuVH2g1eSNJPhy0dA4wMif/OXCeyUBTfVksuYWhk4csQaYOQlFCyj1hfJJy/gS4tLwFW47yoc+Mreh6VRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140402; c=relaxed/simple;
	bh=DBZZH1WenYUwycMC8q+NYa5wSZGMXVsXjxe49GrZDco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJanbqz8YM1ZIe5khAkASQT52ojN8Tmtx1aPKLYAz1MJUaxAA6ML4jB9pj9ySXfjxjDKJCVgf0xi0ss0hhoQnyWC0Ea3MChqS6PjZ0blgKxkFgX/I4PU/PrAbltbSq0PyIwPmQbjkA0irJStOztuzraRT57WMZ/vddl3QgKndcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR+g7xlk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR+g7xlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C635BC4CEED;
	Mon, 25 Aug 2025 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756140402;
	bh=DBZZH1WenYUwycMC8q+NYa5wSZGMXVsXjxe49GrZDco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MR+g7xlkMPnYmSsevn4I3f8j5nAwh/8gSqKlp8+tUm28k0UUssP82NeIYEeVXRc2U
	 2eJcu+J/eoM9MGGWfQb2JI8QHWIR803z5gr/2RDKWRI13gZAEjN4zewNolOcF6kQN6
	 0PDtT/NyF35R+EI9rEs2yoze3YbXw6LZa/1TpJWfR4/r9hNz1zOzs2pgGl+DPRO/i3
	 +Ygcw4mnIRhGFfqL3lcS3F4TmJl5v0nMefZGJTT6cOym87CLCsoDM7Qr5muo7UEXuF
	 HelipDk8rF676BOzIHozVAOwffppozPZR0wHbuoQWRPwXZtkuAo9o5M2hB1y9QhNAP
	 xRHTbAvC+R4BA==
Date: Mon, 25 Aug 2025 17:46:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org
Subject: Re: [PATCH] dt-bindings: ata: sun4i-a10: Add a reference to
 ahci-common.yaml
Message-ID: <20250825-aptly-slicer-41ae905f49bb@spud>
References: <20250822181749.94232-1-festevam@gmail.com>
 <20250823-bulgur-query-612ab1ddb4f0@spud>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="piQ8LdqJByd9t5vR"
Content-Disposition: inline
In-Reply-To: <20250823-bulgur-query-612ab1ddb4f0@spud>


--piQ8LdqJByd9t5vR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 02:54:40PM +0100, Conor Dooley wrote:
> On Fri, Aug 22, 2025 at 03:17:49PM -0300, Fabio Estevam wrote:
> > The 'target-supply' property is already documented in ahci-common.yaml.
> >=20
> > Instead of documenting it locally, add a reference to ahci-common.yaml.
> >=20
> > Also change to 'unevaluatedProperties: false' to allow the properties
> > from ahci-common.yaml to be evaluated.
>=20
> Are the other properties in ahci-common.yaml valid for this device?

Given the imx patch, are you still pursuing this change?

>=20
> >=20
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> >  .../devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-=
ahci.yaml b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.=
yaml
> > index 2011bd03cdcd..8826aed4ec03 100644
> > --- a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.ya=
ml
> > +++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.ya=
ml
> > @@ -10,6 +10,9 @@ maintainers:
> >    - Chen-Yu Tsai <wens@csie.org>
> >    - Maxime Ripard <mripard@kernel.org>
> > =20
> > +allOf:
> > +  - $ref: ahci-common.yaml#
> > +
> >  properties:
> >    compatible:
> >      const: allwinner,sun4i-a10-ahci
> > @@ -25,16 +28,13 @@ properties:
> >    interrupts:
> >      maxItems: 1
> > =20
> > -  target-supply:
> > -    description: Regulator for SATA target power
> > -
> >  required:
> >    - compatible
> >    - reg
> >    - clocks
> >    - interrupts
> > =20
> > -additionalProperties: false
> > +unevaluatedProperties: false
> > =20
> >  examples:
> >    - |
> > --=20
> > 2.34.1
> >=20



--piQ8LdqJByd9t5vR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyTbQAKCRB4tDGHoIJi
0k00AQD9CGe9+fXfd7rPfuoRsZlYfU80A5utuNJBEPwbM3Kl5QD+IooEQyvi54mV
BJJsuE5NqIze9wDF1x9Lt2Hh394vpQQ=
=0+KC
-----END PGP SIGNATURE-----

--piQ8LdqJByd9t5vR--

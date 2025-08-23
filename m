Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F48393DFC;
	Sat, 23 Aug 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957285; cv=none; b=hIkxTxEMZA4WoLInCgUn94EgZP4dnHKGbLzyua+lG2aaAN6/77RmUkqawcq6V6t7LYOh2xCeGKDpbiR9b505gBFMUxl/v8r2SlAM1QQq4FSkfZ8vgR5Hf+cZxQbP7jLp7vGUUTmFZXvW6UsYz5Vu3QuwUXocT8PScnHHGRj9asY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957285; c=relaxed/simple;
	bh=9sWMAGuimLF1y0uU/4Evf1FLKzW73wWW0iGUJTFPi1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSvuN7xYHARJRuwM7oZiNLtHxFdUt9nvyQgxbPbettSfS+3CD4XVbPdrFbPHpJ15UZP4HNdIO2Zrr8PHEHfov/61mmEwdRd45Ac1B+K1PqOX0jSrOoADrn58WOFApEoOBkKiH6Xn2NZ0IyZFysI0HXqFCyQlw2Pl4jIU88XAtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enMyG7ZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enMyG7ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA9FC4CEE7;
	Sat, 23 Aug 2025 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755957284;
	bh=9sWMAGuimLF1y0uU/4Evf1FLKzW73wWW0iGUJTFPi1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enMyG7ZOj81Z/919ekd2qZB1R29y+10NV1ixQ7wBh086z8aClwnYQCKd8cpuWio5f
	 s5u1SoZqlHEmqj27zgaidTMzuSBiQ6XLv9+eRj7Ba86XQJAAmeBxLJdwrwuwA8z9C0
	 9SPOS+G7CevqKPyFZjrSDTsVlyg1Ib3KNRbeUOaczfLnTlJxiti0+n+SFqQnJpd18O
	 BIMw1ah8AmMXf5vBUN6XMadq1Pfb5uPwc5Xe3Y5nsHQr4ErMPdkze46JP+yKRSCf6N
	 FXKDTCo+pM7nPfMfUkLpGXd9z/dkw6cbglBaOn25Qk1M7LncHXx8qhQHlV0UGR5lnW
	 H426vyeueZfEg==
Date: Sat, 23 Aug 2025 14:54:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org
Subject: Re: [PATCH] dt-bindings: ata: sun4i-a10: Add a reference to
 ahci-common.yaml
Message-ID: <20250823-bulgur-query-612ab1ddb4f0@spud>
References: <20250822181749.94232-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JHjlY2Fu6iK+z0xt"
Content-Disposition: inline
In-Reply-To: <20250822181749.94232-1-festevam@gmail.com>


--JHjlY2Fu6iK+z0xt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 03:17:49PM -0300, Fabio Estevam wrote:
> The 'target-supply' property is already documented in ahci-common.yaml.
>=20
> Instead of documenting it locally, add a reference to ahci-common.yaml.
>=20
> Also change to 'unevaluatedProperties: false' to allow the properties
> from ahci-common.yaml to be evaluated.

Are the other properties in ahci-common.yaml valid for this device?

>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ah=
ci.yaml b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.ya=
ml
> index 2011bd03cdcd..8826aed4ec03 100644
> --- a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
> @@ -10,6 +10,9 @@ maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Maxime Ripard <mripard@kernel.org>
> =20
> +allOf:
> +  - $ref: ahci-common.yaml#
> +
>  properties:
>    compatible:
>      const: allwinner,sun4i-a10-ahci
> @@ -25,16 +28,13 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> -  target-supply:
> -    description: Regulator for SATA target power
> -
>  required:
>    - compatible
>    - reg
>    - clocks
>    - interrupts
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.34.1
>=20

--JHjlY2Fu6iK+z0xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKnIIAAKCRB4tDGHoIJi
0kYjAP9nDjH79aFqxI050nzaqA/8J2u1xqiyqCfKxHlq0u+oKwEA/979WQc455LN
pgPqXQDCpOAwIJFU4NBn8sCAHwVGWwY=
=NgLt
-----END PGP SIGNATURE-----

--JHjlY2Fu6iK+z0xt--
